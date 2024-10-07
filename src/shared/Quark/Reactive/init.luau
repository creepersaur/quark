local Reactive = {}

export type State<T> = {
	value: T,
	setLambda: (T) -> (),
	connect: ((T) -> ()) -> (),
	connections: { (value: any) -> () },
}

function Reactive.State<T>(default: T, strict: boolean?): State<T>
	local self = setmetatable({
		value = default,
		strict = strict or false,
		connections = {},
		_is_state = true,
	}, {
		__call = function(self, new_value)
			if new_value then
				if self.strict and typeof(default) ~= typeof(new_value) then
					error(`State does not accept type: '{typeof(new_value)}' [Strict type is enabled!]`)
				end
				self.value = new_value

				for _, v in self.connections do
					v(self.value)
				end
			end

			return self.value
		end,
	}) :: any

	function self.setLambda(value: T)
		return function()
			self(value)
		end
	end

    function self.connect(func): Signal
        return Reactive.Signal(self, func)
    end

	return self
end

export type Signal = {
	Disconnect: () -> (),
}

function Reactive.Signal<T>(state: State<T> | { State<T> }, func: (value: any) -> ()): Signal
	local self = {
		id = "signal_" .. math.random(0, 1000000),
	}

	local state_object: any = state

	if state_object._is_state then
		state_object.connections[self.id] = func
		function self:Disconnect()
			if state_object.connections[self.id] then
                state_object.connections[self.id] = nil
			end
		end
	else
		for _, state in state_object do
			state.connections[self.id] = func
		end

		function self:Disconnect()
			for _, state in state_object do
				if state.connections[self.id] then
					state.connections[self.id] = nil
				end
			end
		end
	end

	return self
end

return Reactive
