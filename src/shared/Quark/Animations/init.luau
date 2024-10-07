local Animations = {}

Animations._Created = {}

local Spring = require(script.Spring)
Spring.Created = Animations._Created
Animations.Spring = Spring.new

local ValueMath = require(script.ValueMath)
Animations.ValueMath = ValueMath

return Animations