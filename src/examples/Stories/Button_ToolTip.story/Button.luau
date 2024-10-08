local ReplicatedStorage = game:GetService "ReplicatedStorage"

local ToolTip = require(script.Parent.ToolTip)
local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New

return function(text: string?, tip_text: string?)
	-- Create a Main Frame, this will store the button and the tooltip (So that they )
    local Main = New "Frame" {
        Size = UDim2.fromOffset(100, 50),
        BackgroundTransparency = 1
    }

	-- Create a `Hovering` state which tells the UI wether the button is hovered.
    local Hovering = Quark.State(0)

	local Tip = ToolTip(tip_text, Hovering)
    local Button: TextButton = New "TextButton" {
		-- Startup Properties
        AutoButtonColor = false,
        Size = UDim2.fromOffset(100, 50),
        BackgroundColor3 = Color3.new(1,1,1),
        TextColor3 = Color3.new(1,1,1),
        TextSize = 12,
        Text = text or "Button",
	}
	-- EVENTS
	{
		MouseEnter = Hovering.setLambda(1),
        MouseLeave = Hovering.setLambda(0),
        
        MouseButton1Down = Hovering.setLambda(0),
        MouseButton1Up = Hovering.setLambda(1),
	}
	-- CHILDREN
	{
		-- Create children (UI Corner / Styling)
        children = {
            New "UICorner" {
                CornerRadius = UDim.new(0, 10)
            }
        }
    }

	-- Pushing the tip (first) and button (second) to Main
	-- (PushChildren takes a table)
    Main:PushChildren {
        Tip,
        Button
    }

	-- spring to control color + size
	-- these springs are `number` springs, since we want to use one spring for both the color and size
	Quark.Animations.Spring(0, Hovering, 0.2, 0.6):BindAndPlay(function(value: number)
		Button.BackgroundColor3 = Color3.new(0.5):Lerp(Color3.new(1), value)
		Button.Size = UDim2.fromScale(1 + value / 4, 1)
	end)

	-- A different spring to control text size
	Quark.Animations.Spring(0, Hovering, 0.5, 0.3):BindAndPlay(function(value: number)
		Button.TextSize = 12 + math.floor(5 * value ^ 2)
	end)
    
    return Main
end