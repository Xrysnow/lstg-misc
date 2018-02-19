---
--- import.lua
---
--- Copyright (C) 2018 Xrysnow. All rights reserved.
---


local MOD_PATH = MOD_PATH or ''

function ListFiles(rootpath, pathes)
    pathes = pathes or {}
    for entry in lfs.dir(rootpath) do
        if entry ~= '.' and entry ~= '..' then
            local path = rootpath .. '\\' .. entry
            local attr = lfs.attributes(path)
            assert(type(attr) == 'table')

            if attr.mode == 'directory' then
                --recursion
                --ListFiles(path, pathes)
            else
                table.insert(pathes, path)
            end
        end
    end
    return pathes
end

function GetExtension(str)
    return str:match(".+%.(%w+)$")
end

function ListScripts(rootpath)
    local fs  = ListFiles(rootpath)
    local ret = {}
    for i, v in pairs(fs) do
        if GetExtension(v) == 'lua' then
            table.insert(ret, string.sub(v, 1))
        end
    end
    return ret
end

local _IN_FROM   = false
local _FROM_PATH = ''

---Specify path for 'import' based on root path.
---@param path string
---@return void
function from(path)
    if not _IN_FROM then
        _FROM_PATH = MOD_PATH .. path
        if path == '' then
            _FROM_PATH = string.sub(_FROM_PATH, 1, -2)
        elseif path == '.' then
            --use current path
            local p    = debug.getinfo(2, "S").source
            _FROM_PATH = string.match(p, "^(.*)\\")
        end
        _IN_FROM = true
    else
        error('Incomplete "from ... import".')
    end
end

local default_init = '__init__'

---Import a module based on current path, 'from' path or root path.
---@param module string
---@return void
function import(module)
    module = string.gsub(module, '\\\\', '\\')
    if not _IN_FROM then
        --search current path
        local p = debug.getinfo(2, "S").source
        p       = string.match(p, "^.*\\") .. module .. '.lua'
        if FileExist(p) then
            Include(p)
            return
        end
        --search root path
        Include(MOD_PATH .. module .. '\\' .. default_init .. '.lua')
    else
        _IN_FROM = false
        if module == '*' then
            --import all
            local fs = ListScripts(_FROM_PATH)
            for i, v in pairs(fs) do
                Include(v)
            end
        else
            Include(_FROM_PATH .. '\\' .. module .. '.lua')
        end
    end
end

