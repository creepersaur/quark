local Types = require(script.Parent.Parent.Types)

return function()
	local module = {
		Created = {},
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

	function module.new<T>(state: | { Types.State<T> }, func: (value: T, old: T) -> ()): Types.Signal<T>
		local self = setmetatable({
			id = "signal_" .. game:GetService("HttpService"):GenerateGUID(false),
			state_object = state,
			_is_signal = true,
		}, Signal)

		local state_object = state

		if state_object._is_state then
			state_object.connections[self.id] = func
		else
			for _, state in state_object do
				state.connections[self.id] = func
			end
		end

		table.insert(module.Created, self)

		return self
	end

	return module
end
