local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Button = require(script.Button)
local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New

-- The Story
return function(Parent)
	local ButtonData: { [string]: string } = {
		["Continue"] = "Continue the game",
		["New Game"] = "Start a new adventure",
		["Quit"] = "Commit die!",
	}
	local SpawnedButtons = 0

	-- Main frame to contain all the buttons
	New "Frame" {
		Parent = Parent,
		Position = UDim2.fromOffset(20, 20),
		Size = UDim2.fromOffset(500, 200),
		BackgroundTransparency = 1,

		-- Children (list layout)
		children = {
			New "UIListLayout" {
				Padding = UDim.new(0, 10),
				SortOrder = "LayoutOrder",
			},
			-- Tip text
			New "TextLabel" {
				Text = "Hover over the buttons. Wait a little to see the tooltip.",
				TextColor3 = Color3.new(1, 1, 1),
				Size = UDim2.new(1, 0, 0, 20),
				BackgroundTransparency = 0.5,
				BackgroundColor3 = Color3.new(),
				TextXAlignment = "Left",
			},

			-- Spawn buttons using Entries
			Quark.Entries(ButtonData, function(Scope, i, v)
				SpawnedButtons += 1
				return Button(Scope, i, v, (SpawnedButtons - 1) / 10)
			end):Push(New "UIListLayout" {
				Padding = UDim.new(0, 10),
				SortOrder = "LayoutOrder",
			}),
		},
	}

	-- CLEANUP
	return Quark.Cleanup
end
