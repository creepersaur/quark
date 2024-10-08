local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Button = require(script.Button)
local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New

-- The Story
return function(Parent)
	-- Main frame to contain all the buttons
	local Frame = New "Frame" {
		Parent = Parent,
		Position = UDim2.fromOffset(20, 20),
		Size = UDim2.fromOffset(500, 200),
		BackgroundTransparency = 1,

		-- Children (list layout)
		children = {
			New "UIListLayout" {
				Padding = UDim.new(0, 10),
			},
		},
	}

	-- Push children to the Frame (table)
	Frame:PushChildren {
        Button("Continue", "Continue the game"),
        Button("New Game", "Start a new Adventure"),
        Button("Quit", "Commit die!"),
    }
    
	-- CLEANUP
	return Quark.Cleanup
end
