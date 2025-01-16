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

	-- Scope to hold all the buttons
	local ButtonScope = Quark.Scope()

	-- Push children to the Frame (table)
	Frame:PushChildren {
        Button(ButtonScope, "Continue", "Continue the game"),
        Button(ButtonScope, "New Game", "Start a new Adventure"),
        Button(ButtonScope, "Quit", "Commit die!"),
    }
    
	-- CLEANUP
	return Quark.Cleanup
end
