---
--- constructor.lua
---
--- Copyright (C) 2018 Xrysnow. All rights reserved.
---


--region 对象构造函数

---@param
---@class lstgColor @颜色类 可进行如下操作: ARGB() | __eq | __add | __sub | __mul | __tostring
lstgColor = {}

---返回颜色的a,r,g,b分量
---@return number,number,number,number
function lstgColor:ARGB()
    return 0, 0, 0, 0
end

---创建并返回颜色类
---@param a number
---@param r number
---@param g number
---@param b number
---@return lstgColor
---@overload fun(argb:number):lstgColor
function Color(a, r, g, b)
    lstgColor = {
        __index    = {
            ARGB = function()
            end
        },
        __eq       = function()
        end,
        __add      = function()
        end,
        __sub      = function()
        end,
        __mul      = function()
        end,
        __tostring = function()
        end
    }
    userdata  = { __metatable = lstgColor }
    return userdata
end

---创建并返回随机数发生器
function Rand()
    lstgRand = {
        __index    = {
            Seed    = 0,
            GetSeed = 0,
            Int     = 0,
            Float   = 0,
            Sign    = 0
        },
        __tostring = function()
        end
    }
    userdata = { __metatable = lstgRand }
    return userdata
end

---创建并返回曲线激光类
---@return BentLaserData
function BentLaserData()
    lstgBentLaserData = {
        __index    = {
            Update         = function()
            end,
            Release        = function()
            end,
            Render         = function()
            end, --Render(const char* tex_name, BlendMode blend, fcyColor c, float tex_left, float tex_top, float tex_width, float tex_height, float scale)
            CollisionCheck = function()
            end,
            BoundCheck     = function()
            end
        },
        __tostring = function()
        end,
        __gc       = function()
        end
    }
    userdata          = { __metatable = lstgBentLaserData }
    return userdata
end

--endregion
