local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New

Quark.StyleSheet "Hello" {
    TextLabel = {
        BackgroundColor3 = Color3.new(0.2, 0.5, 1),
		Text = "class: Hello"
    },
    [Quark.Class "BIG"] = {
        TextSize = 30,
        BackgroundColor3 = Color3.new(1,1,1),
		Text = "class: BIG"
    }
}

return function(parent: Instance)
	local x = New "TextLabel" {
		Parent = parent,
        children = {
            New "TextLabel" {
                Size = UDim2.fromOffset(100, 50),
            },
            New "TextLabel" {
                Position = UDim2.fromOffset(0, 55),
                Size = UDim2.fromOffset(200, 50),
                class = "BIG strong"
            },
        }
    }

    Quark.GetStyle("Hello"):ApplyRecursive(x)

	return Quark.Cleanup
end
