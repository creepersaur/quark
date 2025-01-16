local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New
local Entries = Quark.Entries

return function(parent: Instance)
	New "Frame" {
		Parent = parent,
		children = Entries(10, function(i: number)
			return New "TextLabel" {
				Position = UDim2.fromOffset(0, 50 * i - 50),
				Size = UDim2.fromOffset(200, 50),
				Text = `Label: {i}`
			}
		end)
	}

	return Quark.Cleanup
end
