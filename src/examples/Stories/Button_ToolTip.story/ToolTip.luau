-- elements created by functions can take parameters
-- Visible is a state that that tells the tooltip to show
return function(Scope, tool_text: string?, Hovering)
	local New = Scope.New
	local Spring = Scope.Animations.Spring
	local text = tool_text or "ToolTip"

	local Visible = Scope.State(function(use)
		if use(Hovering) == 1 then
			for i = 1, 30 do
				task.wait()
				if Hovering() == 0 then
					return 0
				end
			end
			if Hovering() == 1 then
				return 1
			end
		end

		return 0
	end)

	Visible(0)

	local Tip = New "TextLabel" {
		Text = "",
		TextSize = 10,
		Size = UDim2.fromOffset(100, 25),
		TextColor3 = Color3.new(1, 1, 1),
		BackgroundColor3 = Color3.new(),
		BackgroundTransparency = 0.5,
		AnchorPoint = Vector2.new(0, 0.5),

		children = New "UICorner" {
			CornerRadius = UDim.new(0, 5),
		},
	}

	Visible.connect(function(value)
		if value == 1 then
			Tip.Text = text
		else
			Tip.Text = ""
		end
	end)

	Spring(0, Visible, 0.9, 0.1):BindAndPlay(function(value: number)
		Tip.Size = UDim2.fromScale(1 + (0.05 * #text), value / 2)
		Tip.Position = UDim2.fromScale(value * 1.1, 0.5)
	end)

	return Tip
end
