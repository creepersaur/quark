local Scope = {}

function Scope.new(created)
	local base = require(script.Parent.Parent.QuarkBase)()
	
	base.Scope = Scope.new

	table.insert(created, base)

	return base
end

return Scope