local Scope = {
	QuarkModule = nil,
	ScopeList = {}
}

local function deepClone(tbl)
	local copy = {}
	for k, v in pairs(tbl) do
		if type(v) == "table" then
			copy[k] = deepClone(v)
		else
			copy[k] = v
		end
	end
	return copy
end

function Scope.new()
	-- Avoid cyclic by cloning quark :(
	-- Require Quark again and add it to the scopes list
	local QuarkClone = script.Parent.Parent:Clone()
	local Scoped = require(QuarkClone)
	QuarkClone:Destroy()

	Scoped.ScopeDepth = Scope.QuarkModule.ScopeDepth + 1
	table.insert(Scope.ScopeList, Scoped)

	return Scoped
end

return Scope