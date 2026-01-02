return function()
	local Created = {}
	local Scopes = {}
	local CleanupQueued = {
		PostCleanup = {},
		PreCleanup = {},
	}

	local function Cleanup()
		for _, v in CleanupQueued.PreCleanup do
			task.spawn(v)
		end

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
			table.clear(list)
		end

		for _, v in Scopes do
			v.Cleanup()
		end
		table.clear(Scopes)

		for _, v in CleanupQueued.PostCleanup do
			task.spawn(v)
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

	local function OnCleanup(func: () -> (), runBeforeCleanup: boolean?)
		assert(
			type(func) == "function",
			"OnCleanup only takes function as the first argument. Got `" .. typeof(func) .. "`."
		)

		if runBeforeCleanup then
			table.insert(CleanupQueued.PreCleanup, func)
		else
			table.insert(CleanupQueued.PostCleanup, func)
		end
	end

	return {
		Cleanup,
		SetCreated,
		SetScopes,
		OnCleanup,
	}
end
