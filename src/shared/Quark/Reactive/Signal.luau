local module = {}

type State<T> = {
	value: T,
	setLambda: (T) -> (),
	connect: ((T) -> ()) -> (),
	connections: { (value: any) -> () },
}

export type Signal = {
	Disconnect: (any) -> (),
}

local Signal = {}
Signal.__index = Signal

function Signal:Disconnect()
	if self.state_object[1] then
		for _, state in self.state_object do
			if state.connections[self.id] then
				state.connections[self.id] = nil
			end
		end
	else
		if self.state_object.connections[self.id] then
			self.state_object.connections[self.id] = nil
		end
	end
end

function module.new<T>(state:  | { State<T> }, func: (value: any) -> ()): Signal
	local self = setmetatable({
		id = "signal_" .. math.random(0, 1000000),
		state_object = state,
		_is_signal = true,
	}, Signal)

	local state_object = state :: any

	if state_object._is_state then
		state_object.connections[self.id] = func
	else
		for _, state in state_object do
			state.connections[self.id] = func
		end
	end

	return self
end

return module