local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New

return function(parent: Instance)
    local Hovering = Quark.State("Hover over me")
	New "TextLabel" {
		Size = UDim2.fromOffset(150, 50),
        BackgroundColor3 = Color3.new(1,1,1),
		Text = Hovering,
		Parent = parent,
	} {
		MouseEnter = Hovering.setLambda "OMG HI!",
		MouseLeave = Hovering.setLambda "Hover over me",
	}

    return Quark.Cleanup
end
