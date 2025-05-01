local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New

Quark.StyleSheet "Hello" {
	TextLabel = {
		BackgroundColor3 = Color3.new(0.2, 0.5, 1),
		Text = "Instance: TextLabel",
	},
	[Quark.Class "BIG"] = {
		TextSize = 30,
		BackgroundColor3 = Color3.new(1, 1, 1),
		Text = "class: BIG",
	},
}

return function(parent: Instance)
	-- Tip text
	New "TextLabel" {
		Text = "Create stylesheets for reusing different styles for classes or Instances.",
		TextColor3 = Color3.new(1, 1, 1),
		Size = UDim2.new(1, 0, 0, 20),
		BackgroundTransparency = 0.5,
		BackgroundColor3 = Color3.new(),
		TextXAlignment = "Left",
		Parent = parent,
	}

	New "TextLabel" {
		Text = "You can then set the `class` properties of objects.",
		TextColor3 = Color3.new(1, 1, 1),
		Size = UDim2.new(1, 0, 0, 20),
		BackgroundTransparency = 0.5,
		Position = UDim2.fromOffset(0, 20),
		BackgroundColor3 = Color3.new(),
		TextXAlignment = "Left",
		Parent = parent,
	}

	local x = New "Frame" {
		Parent = parent,
		Position = UDim2.fromOffset(0, 45),

		children = {
			New "TextLabel" {
				Size = UDim2.fromOffset(100, 50),
			},
			New "TextLabel" {
				Position = UDim2.fromOffset(0, 55),
				Size = UDim2.fromOffset(200, 50),
				class = "BIG strong",
			},
		},
	}

	-- You can get styles using their names
	-- (Or just use the StyleSheet() return value)
	Quark.GetStyle("Hello"):ApplyRecursive(x)

	return Quark.Cleanup
end
