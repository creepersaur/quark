local quicklist = require(script.Parent.Parent.quicklist)
local Types = require(script.Parent.Parent.Types)
local Entries: any = {
	Created = {},
}

function Entries.new(n, func)
	-- Makes children in a scope (using number + function or list + function)
	-- You can edit the children
	-- Putting it inside the `children` of another New makes them add into the New
	-- Adding a child using `Push` or `PushChildren` will add them to the list
	-- Removing a child using `Remove(number)` or `Remove(object)` will delete from list and destroy the object.

	local Quark = Entries.Reactive.Quark
	local Children = quicklist()
	local entry = {
		Scope = Quark.Scope(),
		Children = Children,
		Object = Quark.New "Frame",
		_is_entries = true,
	}

	-- Make the initial objects

	if typeof(n) == "table" then
		for i, v in n do
			local x = func(entry.Scope, i, v)
			if x then
				Children.append(x)
				entry.Object:Push(x)
			end
		end
	elseif typeof(n) == "number" then
		for i = 1, n do
			local x = func(entry.Scope, i)
			if x then
				Children.append(x)
				entry.Object:Push(x)
			end
		end
	else
		error "First argument of `Quark.Entries()` must be a table or a number."
	end

	-- Add new objects

	function entry:Push()
		local obj = func(entry.Scope, #Children + 1)
		entry.Object:Push(obj)
		Children.append(obj)
	end

	function entry:PushChildren(n: number | {any})
		local len = #Children
		if typeof(n) == "table" then
			for i, v in n do
				local x = func(entry.Scope, i + len, v)
				if x then
					Children.append(x)
					entry.Object:Push(x)
				end
			end
		elseif typeof(n) == "number" then
			for i = 1, n do
				local x = func(entry.Scope, i + len)
				if x then
					Children.append(x)
					entry.Object:Push(x)
				end
			end
		else
			error "First argument of `Entries:PushChildren()` must be a table or a number."
		end
	end

	-- Remove objects

	function entry:Remove(obj)
		Children.retain(function(i: number, v)
			return obj.__id ~= v.__id
		end)
	end

	return entry
end

return Entries :: {
	Reactive: any,
	Created: any,
	new: Types.Entries,
}
