local QuarkBase = require(script.QuarkBase)
local Quark = QuarkBase()

local Scope = require(script.Components.Scope)
Quark.Scope = function()
	return Scope.new(Quark._CreatedScopes)
end

return (Quark :: any) :: QuarkBase.Quark