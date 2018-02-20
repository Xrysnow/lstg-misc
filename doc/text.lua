---
--- text.lua
---
--- Copyright (C) 2018 Xrysnow. All rights reserved.
---


---使用纹理字体渲染一段文字
---name: 纹理名称，text: 字符串，x、y: 坐标，align: 对齐模式。
---该函数受全局图像缩放系数影响。
---  细节
---    对齐模式指定渲染中心，对齐模式可取值：
--->左上  0 + 0  0
--->左中  0 + 4  4
--->左下  0 + 8  8
--->中上  1 + 0  1
--->中中  1 + 4  5
--->中下  1 + 8  9
--->右上  2 + 0  2
--->右中  2 + 4  6
--->右下  2 + 8  10
---    由于使用了新的布局机制，在渲染HGE字体时在横向上会有少许误差，请手动调整。
function RenderText(name, text, x, y, scale, align)
end


---设置TTF字体状态
---@param name string
---@param color lstgColor
---@param scale number
---@param fmt number
---@param border_size number
---@param border_color lstgColor
---@param blend_mode string
---@return void
function SetTTFState(name, color, scale, fmt, border_size, border_color, blend_mode)
end


---渲染TTF字体。
---该函数受全局图像缩放系数影响。
---  细节
--->暂时不支持渲染格式设置。
--->接口已统一到屏幕坐标系，不需要在代码中进行转换。
---@param name string
---@param text string
---@param left number
---@param right number
---@param bottom number
---@param top number
---@param fmt number
---@param blend_color lstgColor
---@param scale number
---@return void
function RenderTTF(name, text, left, right, bottom, top, fmt, blend_color, scale)
end
