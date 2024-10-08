local Signal = require(script.Parent.Signal)
local module = {
	Created = {}
}

export type State<T> = {
	value: T,
	setLambda: (T) -> (),
	connect: ((T) -> ()) -> (),
	connections: { (value: any) -> () },
}

type Signal = {
	Disconnect: (any) -> (),
}

function module.new<T>(default: T, strict: boolean?): State<T>
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

	function self.connect(func): Signal.Signal
		local connection = Signal.new(self, func)
		table.insert(module.Created, connection)
		return connection
	end

	return self
end

return module