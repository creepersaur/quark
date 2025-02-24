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
	local self = {
		Scope = Quark.Scope(),
		Children = {},
		Object = Quark.New "Frame",
	}

	if typeof(n) == "table" then
		for i, v in n do
			local x = func(self.Scope, i, v)
			if x then
				self.Object:Push(x)
			end
		end
	elseif typeof(n) == "number" then
		for i = 1, n do
			local x = func(self.Scope, i)
			if x then
				self.Object:Push(x)
			end
		end
	else
		error "First argument of `Quark.Entries()` must be a table or a number."
	end

	local children = {}
	return children
end

return Entries :: {
	Reactive: any,
	Created: any,
	new: Types.Entries,
}
