local ReplicatedStorage = game:GetService "ReplicatedStorage"

local ToolTip = require(script.Parent.ToolTip)
local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New

return function(text: string?, tip_text: string?)
    local Main = New "Frame" {
        Size = UDim2.fromOffset(100, 50),
        BackgroundTransparency = 1
    }

	local Tip, visible = ToolTip(tip_text)
    local Button: TextButton = New "TextButton" {
        AutoButtonColor = false,
        Size = UDim2.fromOffset(100, 50),
        BackgroundColor3 = Color3.new(1,1,1),
        TextColor3 = Color3.new(1,1,1),
        TextSize = 12,
        Text = text or "Button",

        MouseEnter = visible.setLambda(1),
        MouseLeave = visible.setLambda(0),
        
        MouseButton1Down = visible.setLambda(0),
        MouseButton1Up = visible.setLambda(1),

        children = {
            New "UICorner" {
                CornerRadius = UDim.new(0, 10)
            }
        }
    }

    Main:PushChildren {
        Tip,
        Button
    }

	Quark.Animations.Spring(0, visible, 0.2, 0.6):BindAndPlay(function(value: number)
        -- print(value)
		Button.BackgroundColor3 = Color3.new(0.5):Lerp(Color3.new(1), value)
		Button.Size = UDim2.fromScale(1 + value / 4, 1)
	end)

	Quark.Animations.Spring(0, visible, 0.5, 0.3):BindAndPlay(function(value: number)
		Button.TextSize = 12 + math.floor(5 * value ^ 2)
	end)
    
    return Main
end