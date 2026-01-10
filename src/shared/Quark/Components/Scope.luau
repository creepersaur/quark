local Scope = {}

function Scope.new(created)
	local base = require(script.Parent.Parent.QuarkBase)()
	
	base.Scope = function()
		return Scope.new(base)
	end

	table.insert(created, base)

	return base
end

return Scope