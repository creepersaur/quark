return function()
	local Types = require(script.Parent.Parent.Types)
	local module = {
		Quark = nil,
	}

	-- takes in a function which returns an Instance (or state)
	-- returns a function that returns a Cleanup function
	function module.CreateStory(
		StoryFunc: (Target: Instance) -> Instance | Types.New<any> | { Instance | Types.New<any> }
	): (Instance) -> ()
		return function(target: Instance)
			local return_value = StoryFunc(target)

			if type(return_value) == "table" then
				if return_value._is_new then
					return_value.Parent = target
				else
					for _, v in return_value do
						if typeof(v) == "Instance" or typeof(v) == "table" then
							(v :: any).Parent = target
						end
					end
				end
			elseif typeof(return_value) == "Instance" then
				return_value.Parent = target
			end

			return module.Quark.Cleanup
		end
	end

	return module
end
