---
--- xclass
---
--- Copyright (C) 2018 Xrysnow. All rights reserved.
---


---Extends [Class] function so that you can use ClassName(...) to create an instance of lstg object.
---Example: `classname = xclass(object)`
---@param base table
---@param define table
---@return object
function xclass(base, define)
    local ret = Class(base, define)
    local mt  = { __call = function(t, ...)
        return New(ret, ...)
    end }
    return setmetatable(ret, mt)
end

