local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New

return function(tool_text: string?)
    local text = tool_text or "ToolTip"
    local Visible = Quark.State(0)

	local Tip = New 'TextLabel' {
        Text = "",
        TextSize = 10,
        Size = UDim2.fromOffset(100, 25),
        TextColor3 = Color3.new(1,1,1),
        BackgroundColor3 = Color3.new(),
        BackgroundTransparency = 0.5,
        AnchorPoint = Vector2.new(0, 0.5),

        children = {
            New "UICorner" {
                CornerRadius = UDim.new(0, 5)
            }
        }
    }

    Visible.connect(function(value)
        if value == 1 then
            Tip.Text = text
        else
            Tip.Text = ""
        end
    end)

	Quark.Animations.Spring(0, Visible, 0.1, 0.6):BindAndPlay(function(value: number)
		Tip.Size = UDim2.fromScale(1 + (0.05 * #text), value / 2)
		Tip.Position = UDim2.fromScale(value * 1.1, 0.5)
	end)

	return Tip, Visible
end
