local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Button = require(script.Button)
local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New

return function(Parent)
	local Frame = New "Frame" {
		Position = UDim2.fromOffset(20, 20),
		Size = UDim2.fromOffset(500, 200),
		BackgroundTransparency = 1,

		Parent = Parent,
		children = {
			New "UIListLayout" {
				Padding = UDim.new(0, 10),
			},
		},
	}

	Frame:PushChildren {
        Button("Continue", "Continue the game"),
        Button("New Game", "Start a new Adventure"),
        Button("Quit", "Commit die!"),
    }
    
	return function()
		Quark.Cleanup()
	end
end
