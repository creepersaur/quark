local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New
local OnEvent = Quark.OnEvent

return function(parent: Instance)
	-- This state controls text.
	-- Text will auto-update when set to this state.
	local Hovering = Quark.State "Hover over me"

	-- Tip text
	New "TextLabel" {
		Text = "Set a `State` as a property and it will update when the State changes.",
		TextColor3 = Color3.new(1, 1, 1),
		Size = UDim2.new(1, 0, 0, 20),
		BackgroundTransparency = 0.5,
		BackgroundColor3 = Color3.new(),
		TextXAlignment = "Left",
		Parent = parent,
	}

	New "TextLabel" {
		Text = "Use `setLambda(value)` to return a lambda function for value setting.",
		Position = UDim2.fromOffset(0, 20),
		TextColor3 = Color3.new(1, 1, 1),
		Size = UDim2.new(1, 0, 0, 20),
		BackgroundTransparency = 0.5,
		BackgroundColor3 = Color3.new(),
		TextXAlignment = "Left",
		Parent = parent,
	}

	New "TextLabel" {
		Size = UDim2.fromOffset(150, 50),
		Position = UDim2.fromOffset(0, 45),
		BackgroundColor3 = Color3.new(1, 1, 1),
		Text = Hovering,
		Parent = parent,

		-- `setLambda()` returns a function which updates Hovering.
		-- It also takes the new value.
		[OnEvent "MouseEnter"] = Hovering.setLambda "OMG HI!",
		[OnEvent "MouseLeave"] = Hovering.setLambda "Hover over me",
	}

	return Quark.Cleanup
end
