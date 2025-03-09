local Animations = {
	_Created = {}
}

local ValueMath = require(script.ValueMath)
Animations.ValueMath = ValueMath

local Spring = require(script.Spring)
Spring.Created = Animations._Created
Animations.Spring = Spring.new

local Tween = require(script.Tween)
Tween.Created = Animations._Created
Animations.Tween = Tween.new

local Loop = require(script.Loop)
Loop.Created = Animations._Created
Animations.Loop = Loop.new

return Animations