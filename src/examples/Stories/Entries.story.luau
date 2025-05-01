local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New
local Entries = Quark.Entries
local OnEvent = Quark.OnEvent

return function(parent: Instance)
	local E = Entries(10, function(Scope, i: number)
		return Scope.New "TextLabel" {
			Position = UDim2.fromOffset(0, 20 * i + 50),
			Size = UDim2.fromOffset(100, 20),
			Text = `Label: {i}`,
			BackgroundColor3 = Color3.new(1, 0.5, 0.2),
		}
	end)

	New "Frame" {
		Parent = parent,
		children = {
			New "TextButton" {
				Text = "Click me!",
				Size = UDim2.fromOffset(200, 50),
				[OnEvent "Activated"] = E.Push,
				BackgroundColor3 = Color3.new(0.196078, 0.705882, 1.000000),
			},
			E,
		},
	}

	return Quark.Cleanup
end
