---
--- resource.lua
---
--- Copyright (C) 2018 Xrysnow. All rights reserved.
---


--region 资源控制函数


---设置当前激活的资源池类型
---@param pool_type string @'stage', 'global' or 'none'
function SetResourceStatus(pool_type)
end

---RemoveResource(pool, type, name)
---若只有一个参数，则删除一个池中的所有资源。否则删除对应池中的某个资源。参数可选global或stage。
---若资源仍在使用之中，将继续保持装载直到相关的对象被释放。
function RemoveResource(pool, type, name)
end

---获得一个资源的类别，通常用于检测资源是否存在。
---    细节
---        方法会根据名称先在全局资源池中寻找，若有则返回global。
---        若全局资源表中没有找到资源，则在关卡资源池中找，若有则返回stage。
---        若不存在资源，则返回nil。
function CheckRes(type, name)
end

---枚举资源池中某种类型的资源，依次返回全局资源池、关卡资源池中该类型的所有资源的名称。
function EnumRes(type)
end

---获取纹理的宽度和高度。
---@param name string
---@return number,number
function GetTextureSize(name)
end

---从文件载入纹理，支持多种格式，推荐png
---@param texname string
---@param filename string
---@param mipmap boolean @是否使用纹理链
function LoadTexture(texname, filename, mipmap)
end

---LoadImage(name, tex_name, x, y, w, h, a, b, rect)
---在纹理中创建图像
---x,y：图像在纹理上左上角的坐标（纹理左上角为（0,0），向下向右为正方向）
---w,h：图像的大小
---a,b,rect：横向、纵向碰撞判定和判定形状。
---    细节
---        当把一个图像赋予对象的img字段时，它的a、b、rect属性会自动被赋值到对象上。
---@param name string
---@param tex_name string
---@param x number
---@param y number
---@param w number
---@param h number
---@param a number
---@param b number
---@param rect boolean
---@return void
function LoadImage(name, tex_name, x, y, w, h, a, b, rect)
end

---SetImageState(name,blend_mode,color)
---SetImageState(name,blend_mode,color1,color2,color3,color4)
---设置图像状态，可选一个颜色参数用于设置所有顶点或者给出4个颜色设置所有顶点。
---name：图像资源名
---blend_mode：混合模式
---    混合选项可选
--->""          默认值，=mul+alpha
--->"mul+add"   顶点颜色使用乘法，目标混合使用加法
--->"mul+alpha" (默认)顶点颜色使用乘法，目标混合使用alpha混合
--->"mul+sub"   顶点颜色使用乘法，结果=图像上的颜色-屏幕上的颜色
--->"mul+rev"   顶点颜色使用乘法，结果=屏幕上的颜色-图像上的颜色
--->"add+add"   顶点颜色使用加法，目标混合使用加法
--->"add+alpha" 顶点颜色使用加法，目标混合使用alpha混合
--->"add+sub"   顶点颜色使用加法，结果=图像上的颜色-屏幕上的颜色
--->"add+rev"   顶点颜色使用加法，结果=屏幕上的颜色-图像上的颜色
---color：混合颜色
---@param name string
---@param blend_mode string
---@param color lstgColor
---@return void
function SetImageState(name, blend_mode, color)
end

---SetImageCenter(name,x,y)
---设置图像中心
---name：图像资源名
---x,y：相对于图像左上角的坐标
---@param name string
---@param x number
---@param y number
---@return void
function SetImageCenter(name, x, y)
end

---LoadAnimation(name, tex_name, x, y, w, h, n, m, intv, a, b, rect)
---装载动画
---a,b,rect含义同Image
---x,y：第一帧的左上角位置
---w,h：一帧的大小
---n,m：纵向横向的分割数，以列优先顺序排列
---intv：帧间隔
---动画总是循环播放的
function LoadAnimation(name, tex_name, x, y, w, h, n, m, intv, a, b, rect)
end

---含义类似于SetImageState。
function SetAnimationState(name, blend_mode, vertex_color1, vertex_color2, vertex_color3, vertex_color4)
end

---含义类似于SetImageCenter。
function SetAnimationCenter(name, x, y)
end

---LoadPS(name, def_file, img_name, a, b, rect)
---装载粒子系统
---def_file：定义文件
---img_name：粒子图片
---使用HGE所用的粒子文件结构
function LoadPS(name, def_file, img_name, a, b, rect)
end

---装载纹理字体
---name：名称
---def_file：定义文件
---bind_tex：为f2d纹理字体所用，指示绑定的纹理的完整路径
---mipmap：是否创建纹理链，默认创建
---    细节
---        luastg+支持HGE的纹理字体和fancy2d的纹理字体（xml格式）。
---        对于hge字体，将根据定义文件在字体同级目录下寻找纹理文件，对于f2d字体，将使用bind_tex参数寻找纹理。
---@param name string
---@param def_file string
---@param bind_tex string
---@param mipmap boolean
---@return void
function LoadFont(name, def_file, bind_tex, mipmap)
end
---装载纹理字体
---@param name string
---@param def_file string
---@param mipmap string
---@overload fun(string,string,string,boolean):void
---@return void
function LoadFont(name, def_file, mipmap)
end

---设置字体的混合模式、颜色。具体混合选项见SetImageState。
function SetFontState(name, blend_mode, color)
end

---该方法用于设置HGE的纹理字体，luastg+不支持此方法。
---    细节
---        大部分现有代码中没有使用该方法，可以无视。
function SetFontState2(...)
end

---该方法用于加载TTF字体
---name：资源名称
---path：加载路径
---width,height：字形大小，建议设为相同值
---    细节
---        LoadTTF方法相比luastg有巨大不同。由于使用内置的字体渲染引擎，当前实现下不需要将字体解压并导入系统。
---        但是相对的、无法使用诸如加粗、倾斜等效果。同时参数被缩减到4个。
---        此外，若无法在path所在位置加载字体文件，
function LoadTTF(name, path, width, height)
end

---该函数不再起效。将于日后版本移除。
function RegTTF(...)
end

---装载音效。仅支持wav或ogg，推荐使用wav格式。
---    细节
---        音效将被装载进入内存。请勿使用较长的音频文件做音效。
---        对于wav格式，由于受限于目前的实现，故不支持非标准的、带压缩的格式。（如AU导出时若带有metadata将导致无法解析）
function LoadSound(name, path)
end

---LoadMusic(name,path,loop_end,loop_duration)
---加载音乐
---name：资源名
---path：文件路径
---loop_end：循环结束（秒）
---loop_duration：循环时长（秒）
---仅支持wav或ogg，推荐使用ogg格式。
---    细节
---        音乐将以流的形式装载进入内存，不会一次性完整解码放入内存。故不推荐使用wav格式，请使用ogg作为音乐格式。
---        通过描述循环节可以设置音乐的循环片段。当音乐位置播放到end时会衔接到start。这一步在解码器中进行，以保证完美衔接。
function LoadMusic(name, path, loop_end, loop_duration)
end

---载入FX文件(Shader特效)
function LoadFX(name, path)
end

---创建一个名为name的RenderTarget
---将被放置于Texture池中，这意味着可以像纹理那样被使用
function CreateRenderTarget(name)
end

---IsRenderTarget(name)
---检查一个纹理是否为RenderTarget
function IsRenderTarget(name)
end

---SetImageScale(scale)
---设置缩放
function SetImageScale(scale)
end

--endregion
