local Created = {}
local Scopes = {}

local Cleanup = function()
	for _, list in Created do
		for _, v in list do
			if typeof(v) == "Instance" then
				v:Destroy()
			elseif type(v) == "table" then
				if v._is_spring or v._is_tween or v._is_loop then
					v:DisconnectAll()
				elseif v._is_signal then
					v:Disconnect()
				elseif v._is_new then
					v:Cleanup()
				end
			else
				pcall(function()
					v:Disconnect()
				end)
			end
		end
	end

	for _, v in Scopes do
		v.Cleanup()
	end
end

local SetCreated = function(...)
	table.clear(Created)
	for _, v in { ... } do
		table.insert(Created, v)
	end
end

local SetScopes = function(ScopeList)
	Scopes = ScopeList
end

return {
	Cleanup,
	SetCreated,
	SetScopes,
}
