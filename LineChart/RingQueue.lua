---
--- RingBuffer.lua
---
--- Copyright (C) 2018 Xrysnow. All rights reserved.
---

---@class RingQueue
RingQueue = {}

local function _RingQueue(size)
    ---@type RingBuffer
    local ret = {}
    ret.cur   = 0
    ret.size  = size
    ret[-1]   = 0
    ret.put   = RingQueue.put
    ret.get   = RingQueue.get
    return ret
end

local mt = { __call = function(t, size)
    return _RingQueue(size)
end }
setmetatable(RingQueue, mt)

function RingQueue:put(v)
    self.cur       = self.cur % self.size + 1
    self[self.cur] = v
    self[-1]       = #self
end

---Example: for i=1,#rq do print(rq:get(i)) end
---@param i number
function RingQueue:get(i)
    return self[(self.cur + i - 1) % self[-1] + 1]
end

