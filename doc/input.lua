---
--- input.lua
---
--- Copyright (C) 2018 Xrysnow. All rights reserved.
---


--region 输入控制函数


---当前，手柄输入被映射到0x92和0xFE（共2个手柄、32个按键）的位置上。
---其中，X轴Y轴的位置被映射到前4个按键上，对应上下左右。


---立即更新输入状态
function UpdateInput()
end

---给出虚拟键代码检测是否按下
---    VK_CODE的具体含义请查阅MSDN
---@param vk_code number
---@return boolean
function GetKeyState(vk_code)
end

---返回最后一次输入的按键的虚拟键代码
---@return number
function GetLastKey()
end

---返回上一次输入的字符
---@return string
function GetLastChar()
end

---获取鼠标的位置，以窗口左下角为原点
function GetMousePosition()
end

---检查鼠标按键是否按下
---@param button number @可取0、1、2，分别对应鼠标左键、中键、右键
---@return boolean
function GetMouseState(button)
end

--endregion
