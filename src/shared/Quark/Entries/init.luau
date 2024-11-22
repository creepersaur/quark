local Types = require(script.Parent.Types)
local Entries = {
	Created = {}
}

function Entries.new(n: number | {unknown}, func: (i: number, v: unknown?) -> Instance | Types.New): {Instance | Types.New}
	local children = {}
	
	if typeof(n) == "number" then
		for i = 1, n do
			local object = func(i)
			table.insert(children, object)
			table.insert(Entries.Created, object)
		end
	elseif typeof(n) == "table" then
		for i,v in n do
			local object = func(i,v)
			table.insert(children, object)
			table.insert(Entries.Created, object)
		end
	end

	return children
end

return Entries