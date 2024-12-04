local State = require(script.Parent.State).new
local Types = require(script.Parent.Parent.Types)
local Entries = {
	Created = {},
}

function Entries.new(n, func)
	local children: any = {}

	if typeof(n) == "number" then
		for i = 1, n do
			local object = State(func(i))
			object.connect(function(new, old)
				if new ~= old and (typeof(old) == "table" and old._is_new or typeof(old) == "Instance") then
					local obj = old
					if typeof(old) == "table" and obj._is_state then
						obj = old.Object
					end
					obj:Destroy()
				end
			end)

			table.insert(children, object)
			table.insert(Entries.Created, object)
		end
	elseif typeof(n) == "table" then
		for i, v in n do
			local object = State(func(i, v))
			object.connect(function(new, old)
				if new ~= old and (typeof(old) == "table" and old._is_new or typeof(old) == "Instance") then
					local obj = old
					if typeof(old) == "table" and obj._is_state then
						obj = old.Object
					end
					obj:Destroy()
				end
			end)

			table.insert(children, object)
			table.insert(Entries.Created, object)
		end
	end

	return children
end

return Entries :: {
	Created: any,
	new : Types.Entries,
}
