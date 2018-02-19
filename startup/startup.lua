---
--- __init__.lua
---
--- Copyright (C) 2018 Xrysnow. All rights reserved.
---


_mod_version     = 4096
MOD_PATH         = 'mod\\demo\\'
ASSETS_PATH      = MOD_PATH .. 'assets\\'

--modify it
local Modules    = {
    { MOD_PATH .. 'import.lua', 'Include' },
    { 'THlib.lua', 'Include' },
    { 'assets', 'import' },
    { '_editor_output.lua', 'Include' }
}

local _stage_New = stage.New

function DoFrame()
    SetTitle('LuaSTGPlus')
    if stage.next_stage then
        stage.current_stage       = stage.next_stage
        stage.next_stage          = nil
        stage.current_stage.timer = 0
        stage.current_stage:init()
    end
    task.Do(stage.current_stage)
    stage.current_stage:frame()
    stage.current_stage.timer = stage.current_stage.timer + 1
    if stage.next_stage and stage.current_stage then
        stage.current_stage:del()
        task.Clear(stage.current_stage)
        SetResourceStatus('stage')
		--move to original DoFrame, make sure you have given it
        DoFrame = __DoFrame
    end
end

stage_init = stage.New('init', true, true)
function stage_init:init()
    SetViewMode 'ui'
    SetResourceStatus('global')
    self.idx  = 1
    stage.New = function(n, a, b)
        if n == 'init' then
            return {}
        else
            return _stage_New(n, a, b)
        end
    end
end

function stage_init:frame()
    if self.timer < 5 then
        return
    end
    local m = Modules[self.idx]
    if m then
        _G[m[2]](m[1])
        self.idx = self.idx + 1
    else
        stage.New   = _stage_New
        stage_init  = self
        self.loaded = true
        for _, v in pairs(all_class) do
            v[1] = v.init
            v[2] = v.del
            v[3] = v.frame
            v[4] = v.render
            v[5] = v.colli
            v[6] = v.kill
        end
        stage.Set('none', 'menu')
        SystemLog('All loaded')
    end
    stage.preserve_res = true
end

--background image
LoadImageFromFile('start', ASSETS_PATH .. 'title\\sig1280.png')
function stage_init:render()
    Render('start', 320, 240, 0, 0.5)
end

