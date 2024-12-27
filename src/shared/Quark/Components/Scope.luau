local Scope = {
	QuarkModule = nil,
	ScopeList = {}
}

function Scope.new()
	local Scoped = table.clone(Scope.QuarkModule)
	table.insert(Scoped, Scope.ScopeList)

	return Scoped
end

return Scope