local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New
local State = Quark.State

return function(parent)
	local Counter = State(0)

	New "TextButton" {
		Parent = parent,
		Size = UDim2.fromOffset(200, 50),

		-- Computeds are states that `use` other states.
		-- Automatically update when the `used` state updates.
		Text = State(function(use)
			return `Counter: {use(Counter)}`
		end),

		-- Click event increments counter
		MouseButton1Click = function()
			Counter(Counter() + 1)
		end
	}

	return Quark.Cleanup
end
