local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New
local State = Quark.State
local OnEvent = Quark.OnEvent

return function(parent)
	local Counter = State(0)

	-- Tip text
	New "TextLabel" {
		Text = "Click the buttons. These update automatically using the State.",
		TextColor3 = Color3.new(1, 1, 1),
		Size = UDim2.new(1, 0, 0, 20),
		BackgroundTransparency = 0.5,
		BackgroundColor3 = Color3.new(),
		TextXAlignment = "Left",
		Parent = parent,
	}

	New "TextButton" {
		Parent = parent,
		Size = UDim2.fromOffset(200, 50),
		Position = UDim2.fromOffset(0, 25),

		-- Computeds are states that `use` other states.
		-- Automatically update when the `used` state updates.
		Text = State(function(use)
			return `Counter: {use(Counter)}`
		end),

		-- Click event increments counter
		[OnEvent "MouseButton1Click"] = function()
			Counter(Counter() + 1)
		end,
	}

	New "TextButton" {
		Parent = parent,
		Size = UDim2.fromOffset(200, 50),
		Position = UDim2.fromOffset(0, 85),

		-- Same thing as the computed, just only for string formats.
		-- it replaces `%s` with the value of the Counter.
		-- all other arguments after the first translate to extra `string.format` arguments.
		Text = Counter.compString "[computed state] Counter: %s",

		-- Click event increments counter
		[OnEvent "MouseButton1Click"] = function()
			Counter(Counter() + 1)
		end,
	}

	return Quark.Cleanup
end
