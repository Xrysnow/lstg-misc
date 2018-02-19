---
--- debug.lua
---
--- Copyright (C) 2018 Xrysnow. All rights reserved.
---

ldbg      = ldbg or {}
local tex = {
    bg      = 'ldbg.bg',
    keyup   = 'ldbg.keyup',
    keydown = 'ldbg.keydown',
}
CopyImage(tex.bg, 'white')
_LoadImageFromFile(tex.keyup, ASSETS.tex.pixel, true, 0, 0, true, 0)
CopyImage(tex.keydown, tex.keyup)

SetImageState(tex.bg, '', Color(255, 0, 0, 0))
SetImageState(tex.keyup, '', Color(255, 63, 63, 63))
SetImageState(tex.keydown, '', Color(255, 255, 255, 0))

function ldbg.GetFPS()
    return GetFPS()
end

function ldbg.GetFTime()
    return _FrameTime or -1
end

function ldbg.GetRTime()
    return _RenderTime or -1
end

function ldbg.GetLMem()
    return collectgarbage('count') / 1024
end

function ldbg.ClearBG()
    SetViewMode('ui')
    RenderRect(tex.bg, -screen.dx / 2, 0, 0, screen.height)
    RenderRect(tex.bg, screen.width, screen.width + screen.dx / 2, 0, screen.height)
end

---@type file
local logfile
---@type string[]
local lines = {}

function ldbg.GetLog()
    logfile    = logfile or io.open('log.txt')
    local line = logfile:read()
    while line do
        table.insert(lines, line)
        line = logfile:read()
    end
    return lines
end

function ldbg.SimpleText(s, x, y, scale)
    scale = scale or 0.5
    RenderText('asc2', s, x, y, scale, 0)
end

LoadTTF('ldbg.log', FONT_WQY, 12)
local logcolor = Color(255, 255, 255, 255)

function ldbg.RenderLog()
    SetViewMode('ui')
    local yy = 6
    for i = #lines, 1, -1 do
        local line = lines[i]
        if string.sub(line, 1, 6) == '[INFO]' then
            line = line:sub(8)
        end
        RenderTTF('ldbg.log', line, -screen.dx / 2, 0, yy, yy + 12, logcolor, 'left', 'bottom')
        yy = yy + 6
        if yy > screen.height then
            break
        end
    end
end

LoadFont('ldbg.number', FONT_ASCII2)

function ldbg.RenderFPS(x, y, scale)
    RenderText('ldbg.number', string.format('FPS:%.3f', ldbg.GetFPS()), x, y, scale, 0)
end

function ldbg.RenderMousePosition(x, y, scale)
    local xx, yy = MousePosition()
    RenderText(
            'ldbg.number',
            string.format('X=%d,Y=%d', xx, yy),
            x, y, scale, 0)
end

local keychars = {
    up      = { '^', 60, 12 },
    down    = { 'v', 60, 60 },
    left    = { '<', 36, 36 },
    right   = { '>', 84, 36 },
    slow    = { 'S', 12, 12 },
    shoot   = { 'z', 12, 60 },
    spell   = { 'x', 36, 84 },
    special = { 'c', 84, 84 },
}

function ldbg.RenderKeyState(x, y, scale)
    for k, v in pairs(keychars) do
        local img = 'ldbg.keyup'
        if KeyState[k] then
            img = 'ldbg.keydown'
        end
        Render(img, x + v[2], y - v[3], 0, 24, 24)
        RenderText('ldbg.number', v[1], x + v[2] - 4, y - v[3] + 4, scale, 5)
    end
end

---@class LDEBUG
LDEBUG = xclass(object)

function LDEBUG:init(params)
    table.deploy(self, params, {
        showlog = true,
        showfps = true,
        layer   = LAYER_BG - 1,
        bound   = false,
        group   = GROUP_GHOST,
    })
    self.fpschart = LineChart(
            { x      = screen.width + 56,
              y      = screen.height - 60,
              gridnx = 1, gridny = 1,
              w      = 80, h = 56,
              ymin   = 55, ymax = 61,
              size   = 60,
            })
    self.fpschart:AddConst(60, Color(255, 0, 127, 0))
    self.tfchart = LineChart(
            { x      = screen.width + 56,
              y      = screen.height - 130,
              gridnx = 1, gridny = 1,
              w      = 80, h = 56,
              ymin   = 0, ymax = 20,
              size   = 60,
            })
    self.tfchart:AddConst(16.7, Color(255, 127, 0, 0))
    self.trchart = LineChart(
            { x      = screen.width + 56,
              y      = screen.height - 200,
              gridnx = 1, gridny = 1,
              w      = 80, h = 56,
              ymin   = 0, ymax = 20,
              size   = 60,
            })
    self.trchart:AddConst(16.7, Color(255, 127, 0, 0))
end

function LDEBUG:frame()
    ldbg.GetLog()
    self.fpschart:AddPoint(ldbg.GetFPS())
    self.tfchart:AddPoint(ldbg.GetFTime())
    self.trchart:AddPoint(ldbg.GetRTime())
end

function LDEBUG:render()
    ldbg.ClearBG()
    ldbg.RenderLog()
    local xx = screen.width
    local yy = screen.height
    ldbg.SimpleText('Mouse:', xx, yy)
    yy = yy - 10
    ldbg.RenderMousePosition(xx, yy, 0.5)
    yy = yy - 10
    ldbg.SimpleText(string.format('FPS:%.3f', ldbg.GetFPS()), xx, yy)
    ldbg.SimpleText('60', xx, yy - 16)
    ldbg.SimpleText('55', xx, yy - 60)

    yy = yy - 70
    ldbg.SimpleText(string.format('Tf:%.2fms', ldbg.GetFTime()), xx, yy)
    ldbg.SimpleText('17', xx, yy - 16)
    ldbg.SimpleText(' 0', xx, yy - 60)

    yy = yy - 70
    ldbg.SimpleText(string.format('Tr:%.2fms', ldbg.GetRTime()), xx, yy)
    ldbg.SimpleText('17', xx, yy - 16)
    ldbg.SimpleText(' 0', xx, yy - 60)

    yy = yy - 70
    ldbg.SimpleText(string.format('LMem:%.2fMB', ldbg.GetLMem()), xx, yy)
    yy = yy - 10
    ldbg.SimpleText(string.format('Mem:%.2fMB',
                                  system.GetWorkingSetSize()), xx, yy)

    ldbg.RenderKeyState(xx + 11, 96, 0.5)
end

