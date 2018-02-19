---
--- LineChart.lua
---
--- Copyright (C) 2018 Xrysnow. All rights reserved.
---


---@class LineChart
LineChart = xclass(object)

CopyImage('LineChart.line', 'white')
CopyImage('LineChart.grid', 'white')
CopyImage('LineChart.bg', 'white')

local dft_linecolor  = Color(255, 255, 255, 255)
local dft_gridcolor  = Color(255, 127, 127, 127)
local default_params = {
    size      = 100,
    w         = 100,
    h         = 100,
    ymin      = 0,
    ymax      = 100,
    bgcolor   = Color(0),
    linecolor = dft_linecolor,
    gridcolor = dft_gridcolor,
    gridnx    = 2,
    gridny    = 2,
    gridwidth = 0.5,
    linewidth = 0.5,
    bgimg     = 'LineChart.bg',
    layer     = LAYER_TOP,
    bound     = false,
}

function LineChart:init(params)
    self.AddPoint = LineChart.AddPoint
    self.AddConst = LineChart.AddConst
    self.Update   = LineChart.Update
    table.deploy(self, params, CommonParams(default_params))
    ---@type RingQueue[]
    self.points = {}
    self.const  = {}
    self:Update()
end

function LineChart:frame()
    self:Update()
end

function LineChart:render()
    SetViewMode('ui')
    --draw bg
    SetImageState(self.bgimg, '', self.bgcolor)
    RenderRect(
            self.bgimg,
            self.left,
            self.right,
            self.bottom,
            self.top)
    --draw grid
    for i = 1, self.gridnx do
        local x = self.gridx[i]
        DrawLine(x, self.bottom, x, self.top, self.gridwidth, self.gridcolor)
    end
    for i = 1, self.gridny do
        local y = self.gridy[i]
        DrawLine(self.left, y, self.right, y, self.gridwidth, self.gridcolor)
    end
    --draw const
    for i = 1, #self.const do
        local y = (self.const[i][1] - self.ymin) / (self.ymax - self.ymin)
        y       = math.lerp(self.bottom, self.top, y)
        DrawLine(self.left, y, self.right, y,
                 self.gridwidth,
                 self.const[i][2] or dft_linecolor)
    end
    --draw line
    local px, py = self.px, self.py
    for i = 1, #py do
        local pyi = py[i]
        for j = 1, #pyi - 1 do
            local x1, y1 = px[j], pyi[j]
            local x2, y2 = px[j + 1], pyi[j + 1]
            DrawLine(x1, y1, x2, y2, self.linewidth, self.linecolor)
        end
    end
end

function LineChart:AddPoint(v, i)
    i              = i or 1
    self.points[i] = self.points[i] or RingQueue(self.size)
    self.points[i]:put(v)
end

function LineChart:AddConst(v, color)
    table.insert(self.const, { v, color })
end

function LineChart:Update()
    self.left   = self.x - self.w / 2
    self.right  = self.x + self.w / 2
    self.bottom = self.y - self.h / 2
    self.top    = self.y + self.h / 2

    self.gridx  = {}
    self.gridy  = {}
    for i = 1, self.gridnx do
        local v = (i - 1) / self.gridnx
        table.insert(self.gridx, math.lerp(self.left, self.right, v))
    end
    for i = 1, self.gridny do
        local v = (i - 1) / self.gridny
        table.insert(self.gridy, math.lerp(self.bottom, self.top, v))
    end

    local px = {}
    for i = 1, self.size do
        local a = (i - 1) / self.size
        table.insert(px, math.lerp(self.left, self.right, a))
    end
    self.px  = px

    local py = {}
    for i = 1, #self.points do
        py[i]   = {}
        local p = self.points[i]
        for j = 1, #p do
            local ay = (p:get(j) - self.ymin) / (self.ymax - self.ymin)
            table.insert(py[i], math.lerp(
                    self.bottom, self.top,
                    math.clamp(ay, 0, 1)))
        end
    end
    self.py = py
end

