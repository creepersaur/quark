local State = require(script.Parent.State).new
local Types = require(script.Parent.Parent.Types)
local Entries: any = {
	Created = {},
}

function Entries.new(n, func)
	local current_scope = Entries.Quark.Scope()
	
	-- Makes children in a scope (using number + function or list + function)
	-- You can edit the children
	-- Putting it inside the `children` of another New makes them add into the New
	-- Adding a child using `Push` or `PushChildren` will add them to the list
	-- Removing a child using `Remove(number)` or `Remove(object)` will delete from list and destroy the object.



	local children = {}
	return children
end

return Entries :: {
	Scope: any,
	Created: any,
	new : Types.Entries,
}
