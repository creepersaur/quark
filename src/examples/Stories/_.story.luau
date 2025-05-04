local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New
local Hook = Quark.Hook
local State = Quark.State

return Quark.CreateStory(function()
	local bg_color = State(Color3.new(0.5, 0.5, 0.5))

	return New "Frame" {
		BackgroundColor3 = bg_color,
		
		Hook(
			"MouseEnter",
			bg_color.setLambda(Color3.new(0.75, 0.75, 0.75))
		),
		Hook(
			"MouseLeave",
			bg_color.setLambda(Color3.new(0.5, 0.5, 0.5))
		),
	}
end)
