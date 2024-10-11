local State = require(script.State)
local Signal = require(script.Signal)
local Reactive = {
	Created = {}
}

State.Created = Reactive.Created
Signal.Created = Reactive.Created

Reactive.State = State.new

Reactive.Signal = Signal.new

return Reactive
