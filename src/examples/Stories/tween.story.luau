local ReplicatedStorage = game:GetService "ReplicatedStorage"
local TweenService = game:GetService "TweenService"

local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New

return function(parent)
	local START = UDim2.fromOffset(0, 50)
	local TARGET = UDim2.new(0.15, 0, 0, 50)
	local info = TweenInfo.new(
		1, -- TIME
		Enum.EasingStyle.Elastic
	)

	local T = Quark.Animations.Tween(START, Quark.State(TARGET), info)

	New "TextButton" {
		Text = "Quark Tween",
		Parent = parent,
		Size = T:Play(),

		MouseEnter = T.Target.setLambda(UDim2.new(0.2, 0, 0, 50)),
		MouseLeave = T.Target.setLambda(UDim2.new(0.15, 0, 0, 50)),
	}

	local Tween = TweenService:Create(
		New "TextButton"({
			Text = "TweenService",
			Parent = parent,
			Position = UDim2.fromOffset(0, 60),
			Size = START,
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
