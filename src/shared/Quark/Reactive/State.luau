local Types = require(script.Parent.Parent.Types)
local Signal = require(script.Parent.Signal)
local module = {
	Created = {},
}

function module.new<T>(default: T? | (use: <R>(Types.State<R>) -> R) -> T?, strict: boolean?): Types.State<T>
	local self = setmetatable({
		value = default,
		strict = strict or false,
		connections = {},
		_is_state = true,
	}, {
		__call = function(self, new_value: T, force: boolean?)
			if force or new_value ~= nil then
				if self.strict and typeof(default) ~= typeof(new_value) then
					error(`State does not accept type: '{typeof(new_value)}' [Strict type is enabled!]`)
				end

				local old_value = self.value
				self.value = new_value
				for _, v in self.connections do
					v(self.value, old_value)
				end
			end

			return self.value
		end,
	}) :: any

	function self.setLambda(value: T, force: boolean?)
		return function()
			self(value, force)
		end
	end

	function self.connect(func): Types.Signal<T>
		local connection = Signal.new(self, func)
		table.insert(module.Created, connection)
		return connection
	end

	function self.compString(fmt_string: string, ...)
		local vargs = {...}
		return module.new(function(use: Types.State<any>)
			return fmt_string:format(use(self), table.unpack(vargs))
		end)
	end

	if type(default) == "function" then
		coroutine.wrap(function()
			self.value = default(function(dependency: Types.State<any>)
				table.insert(
					module.Created,
					dependency.connect(function(new)
						coroutine.wrap(function()
							self(default(function(d)
								return d()
							end))
						end)()
					end)
				)
				return dependency()
			end)
		end)()
	end

	return self
end

return module
