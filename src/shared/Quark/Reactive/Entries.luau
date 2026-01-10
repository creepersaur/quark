local quicklist = require(script.Parent.Parent.quicklist)
local Types = require(script.Parent.Parent.Types)

return function()
	local Entries: any = {
		Created = {},
	}

	function Entries.new(n, func)
		local Quark = Entries.Reactive.Quark
		local Children = quicklist()
		local entry = {
			Scope = Quark.Scope(),
			Children = Children,
			Object = Quark.New("Frame")({
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
			}),
			_is_entries = true,
		}

		-- Make the initial objects
		if type(n) == "table" then
			for i, v in n do
				local x = func(entry.Scope, i, v)
				if type(x) == "table" and x._is_new then
					Children.append(x)
					entry.Object:Push(x)
				elseif x then
					error("Entries function return value must be a `New` or nil.")
				end
			end
		elseif type(n) == "number" then
			for i = 1, n do
				local x = func(entry.Scope, i)
				if x then
					Children.append(x)
					entry.Object:Push(x)
				end
			end
		else
			error("First argument of `Quark.Entries()` must be a `table` or a number.")
		end

		local self
		self = setmetatable(entry, {
			__call = function(_, ...)
				entry.Object(...)
				return self
			end,
			__index = function(_, k)
				return rawget(entry, k) or entry.Object[k]
			end,
		})

		-- Add new objects

		function entry:Push(obj)
			if (not obj) or type(obj) ~= "table" then
				obj = func(entry.Scope, #Children + 1)
			end

			entry.Object:Push(obj)
			Children.append(obj)

			return self
		end

		function entry:PushChildren(n: number | { any })
			local len = #Children
			if type(n) == "table" then
				for i, v in n do
					local x = func(entry.Scope, i + len, v)
					if x then
						Children.append(x)
						entry.Object:Push(x)
					end
				end
			elseif type(n) == "number" then
				for i = 1, n do
					local x = func(entry.Scope, i + len)
					if x then
						Children.append(x)
						entry.Object:Push(x)
					end
				end
			else
				error("First argument of `Entries:PushChildren()` must be a table or a number.")
			end

			return self
		end

		-- Remove objects

		function entry:Remove(obj)
			Children.retain(function(i: number, v)
				if type(obj) == "table" then
					return obj.__id ~= v.__id
				elseif type(obj) == "number" then
					return i ~= obj
				else
					error("Entries:Remove() takes a `New`, or a number.")
				end
			end)

			return self
		end

		return self
	end

	return Entries :: {
		Reactive: any,
		Created: any,
		new: Types.Entries,
	}
end
