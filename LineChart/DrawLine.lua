---
--- DrawLine.lua
---
--- Copyright (C) 2018 Xrysnow. All rights reserved.
---


_LoadImageFromFile('draw.pixel', ASSETS.tex.pixel, true, 0, 0, true, 0)
local line_color = Color(255, 255, 255, 255)

function DrawLine(x1, y1, x2, y2, width, color)
    width = width or 0.5
    color = color or line_color
    SetImageState('draw.pixel', '', color)
    local l = hypot(x1 - x2, y1 - y2)
    local r = atan2(y1 - y2, x1 - x2)
    Render('draw.pixel', (x1 + x2) / 2, (y1 + y2) / 2, r, l, width)
end

