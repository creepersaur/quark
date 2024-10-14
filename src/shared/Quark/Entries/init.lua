local Types = require(script.Parent.Types)
local Entries = {
	Created = {}
}

function Entries.new(n: number, func: (i: number) -> Instance | Types.New)
	local children = {}
	
	for i = 1, n do
		local object = func(i)
		table.insert(children, object)
		table.insert(Entries.Created, object)
	end

	return children
end

return Entries