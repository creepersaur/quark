local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New

return Quark.CreateStory(function()
	local baseSCOPE = Quark.Scope()
	local ScopeA = baseSCOPE.Scope()
	local ScopeB = baseSCOPE.Scope()

	print(Quark._CreatedScopes)

	return New "Frame" {
		children = {
			ScopeA.New "TextButton" {
				Size = UDim2.fromOffset(50, 50),
				BackgroundColor3 = Color3.new(1),

				ScopeA.Hook("Activated", ScopeA.Cleanup)
			},

			ScopeB.New "Frame" {
				Position = UDim2.fromOffset(100, 0),
				BackgroundColor3 = Color3.new(0, 0, 1)
			}
		}
	}
end)