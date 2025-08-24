local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New

return Quark.CreateStory(function()
	local A = Quark.Scope()
	local B = Quark.Scope()

	return New "Frame" {
		children = {
			A.New "TextButton" {
				BackgroundColor3 = Color3.new(1)
			},
			B.New "TextButton" {
				BackgroundColor3 = Color3.new(0,0,1)
			}
		}
	}
end)
