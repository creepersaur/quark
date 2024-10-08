local State = require(script.State)
local Signal = require(script.Signal)
local Reactive = {
	Created = {}
}

State.Created = Reactive.Created
Signal.Created = Reactive.Created

export type State<T> = State.State<T>
Reactive.State = State.new

export type Signal = Signal.Signal
Reactive.Signal = Signal.new

return Reactive
