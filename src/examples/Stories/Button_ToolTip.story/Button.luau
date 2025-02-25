local ToolTip = require(script.Parent.ToolTip)

return function(Scope, text: string?, tip_text: string?)
	local New = Scope.New
	local Spring = Scope.Animations.Spring

	-- Create a Main Frame, this will store the button and the tooltip (So that they )
	local Main = New "Frame" {
		Size = UDim2.fromOffset(100, 50),
		BackgroundTransparency = 1,
	}

	-- Create a `Hovering` state which tells the UI wether the button is hovered.
	local Hovering = Scope.State(0)

	local Tip = ToolTip(Scope, tip_text, Hovering)
	local Button: TextButton = New "TextButton" {
		AutoButtonColor = false,
		Size = UDim2.fromOffset(100, 50),
		BackgroundColor3 = Color3.new(1, 1, 1),
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 13,
		Text = text or "Button",

		MouseEnter = Hovering.setLambda(1),
		MouseLeave = Hovering.setLambda(0),
		MouseButton1Down = Hovering.setLambda(0),
		MouseButton1Up = Hovering.setLambda(1),
		Activated = function()
			print("Button Clicked:", text)
		end,

		-- Create children (UI Corner / Styling)
		children = {
			New "UICorner" {
				CornerRadius = UDim.new(0, 10),
			},
		},
	}

	-- Pushing the tip (first) and button (second) to Main
	-- (PushChildren takes a table)
	Main:PushChildren {
		Tip,
		Button,
	}

	-- spring to control color + size
	-- these springs are `number` springs, since we want to use one spring for both the color and size
	Spring(0, Hovering, 0.9, 0.2):BindAndPlay(function(value: number)
		Button.BackgroundColor3 = Color3.new(0.5):Lerp(Color3.new(1), value)
		Button.Size = UDim2.fromScale(1 + value / 4, 1)
	end)

	return Main
end
