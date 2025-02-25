local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Quark = require(ReplicatedStorage.Shared.Quark)
local ToolTip = require(script.Parent.ToolTip)

return function(Scope: Quark.Scope, text: string?, tip_text: string?, wait_time: number?)
	local Tween = Scope.Animations.Tween
	local New = Scope.New
	local Spring = Scope.Animations.Spring
	local State = Scope.State
	
	-- Create a `Hovering` state which tells the UI wether the button is hovered.
	local Hovering = State(0)

	-- This spring controls the `BackgroundColor3`. It has a computed state as a target.
	local BG_ColorSpeed = Tween(0.1, 0.5, TweenInfo.new(1), true)
	local BG_ColorSpring = Spring(
		Color3.new(1, 0.3, 0.3),
		Scope.State(function(use)
			return use(Hovering) == 1 and Color3.new(1) or Color3.new(0.5)
		end),
		BG_ColorSpeed.Value,
		0.2
	)

	-- This spring controls the `BackgroundColor3`. It has a computed state as a target.
	local BG_SizeSpring = Spring(
		UDim2.fromScale(0, 0),
		State(function(use)
			return use(Hovering) == 1 and UDim2.fromScale(1.3, 1) or UDim2.fromScale(1, 1)
		end),
		0.9,
		0.2
	)

	local Tip = ToolTip(Scope, tip_text, Hovering)
	local Button: TextButton = New "TextButton" {
		AutoButtonColor = false,
		Text = "",
		Size = BG_SizeSpring,
		BackgroundColor3 = BG_ColorSpring,
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = Tween(0, 13, TweenInfo.new(0.3)):Play(),

		MouseEnter = Hovering.setLambda(1),
		MouseLeave = Hovering.setLambda(0),
		MouseButton1Down = Hovering.setLambda(0),
		MouseButton1Up = Hovering.setLambda(1),
		Activated = function()
			BG_ColorSpeed:Restart()

			BG_ColorSpring.Value(Color3.new(1, 1, 1))
			print("Button Clicked:", text)
		end,

		-- Create children (UI Corner / Styling)
		children = {
			New "UICorner" {
				CornerRadius = UDim.new(0, 10),
			},
		},
	}

	task.delay(wait_time or 0, function()
		BG_ColorSpeed:Play()
		BG_ColorSpring:Play()
		BG_SizeSpring:Play()

		
		Button.Text = text or "Button"
	end)

	-- Create a Main Frame, this will store the button and the tooltip
	-- We return it also to use it in the other script.
	return New "Frame" {
		Size = UDim2.fromOffset(100, 50),
		BackgroundTransparency = 1,

		children = {
			Tip,
			Button
		}
	}
end
