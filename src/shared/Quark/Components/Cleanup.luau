local Created = {}

local Cleanup = function()
	for _, list in Created do
		for _, v in list do
			if typeof(v) == "Instance" then
				v:Destroy()
			elseif typeof(v) == "table" then
				if v._is_spring then
					v:DisconnectAll()
				elseif v._is_signal then
					v:Disconnect()
				end
			else
				v:Disconnect()
			end
		end
	end
end

local SetCreated = function(...)
	for _, v in { ... } do
		table.insert(Created, v)
	end
end

return {
	Cleanup,
	SetCreated,
}
