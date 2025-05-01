local ReplicatedStorage = game:GetService "ReplicatedStorage"
local TweenService = game:GetService "TweenService"

local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New
local Hook = Quark.Hook

return function(parent)
	local START = UDim2.fromOffset(0, 50)
	local TARGET = UDim2.new(0.15, 0, 0, 50)
	local info = TweenInfo.new(
		1, -- TIME
		Enum.EasingStyle.Bounce
	)

	local T = Quark.Animations.Tween(START, Quark.State(TARGET), info)

	-- Tip text
	New "TextLabel" {
		Text = "Custom Quark Tweens will update when the target state updates. (They use TweenInfo)",
		TextColor3 = Color3.new(1, 1, 1),
		Size = UDim2.new(1, 0, 0, 20),
		BackgroundTransparency = 0.5,
		BackgroundColor3 = Color3.new(),
		TextXAlignment = "Left",
		Parent = parent,
	}

	New "TextButton" {
		Text = "Quark Tween",
		Parent = parent,
		Size = T:Play(),
		Position = UDim2.fromOffset(0, 25),
		BackgroundColor3 = Color3.new(0.4, 1, 0.57),

		Hook("MouseEnter", T.Target.setLambda(UDim2.new(0.2, 0, 0, 50))),
		Hook("MouseLeave", T.Target.setLambda(UDim2.new(0.15, 0, 0, 50))),
	}

	local Tween = TweenService:Create(
		New "TextButton"({
			Text = "TweenService",
			Parent = parent,
			Position = UDim2.fromOffset(0, 85),
			Size = START,
			BackgroundColor3 = Color3.new(0.4, 0.57, 1),
		}).Object,
		info,
		{
			Size = TARGET,
		}
	)
	Tween:Play()

	return function()
		Quark.Cleanup()
		Tween:Destroy()
	end
end
