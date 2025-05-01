local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New
local OnEvent = Quark.OnEvent

print(Quark.CreateStory)

return Quark.CreateStory(function(t)
	return New "TextLabel" {
		Size = UDim2.fromOffset(50, 50)
	}
end)