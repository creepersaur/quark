local State = require(script.State)
local Signal = require(script.Signal)
local Entries = require(script.Entries)
local Reactive = {
	Created = {},
}

State.Created = Reactive.Created
Signal.Created = Reactive.Created
Entries.Created = Reactive.Created
Entries.Reactive = Reactive

Reactive.State = State.new
Reactive.Signal = Signal.new
Reactive.Entries = Entries.new

return Reactive::any
