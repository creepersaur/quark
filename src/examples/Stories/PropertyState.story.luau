local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New

return function(parent: Instance)
	-- This state controls text.
	-- Text will auto-update when set to this state.
    local Hovering = Quark.State("Hover over me")

	New "TextLabel" {
		Size = UDim2.fromOffset(150, 50),
        BackgroundColor3 = Color3.new(1,1,1),
		Text = Hovering,
		Parent = parent,
	
		-- `setLambda()` returns a function which updates Hovering.
		-- It also takes the new value.
		MouseEnter = Hovering.setLambda "OMG HI!",
		MouseLeave = Hovering.setLambda "Hover over me",
	}

    return Quark.Cleanup
end
