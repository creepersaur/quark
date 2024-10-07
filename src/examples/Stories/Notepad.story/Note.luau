local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New

return function(text: string?)
	local Main = New "Frame" {
		Size = UDim2.new(1, -10, 0, 50),
		BackgroundTransparency = 1,
	}

	local Hovering = Quark.State(0)
    local hover_spring = nil

	local Note = New "TextButton" {
		Text = "",
        AutoButtonColor = false,
		Size = UDim2.fromScale(0, 0),
		BackgroundTransparency = 0.9,
		AnchorPoint = Vector2.one * 0.5,
		Position = UDim2.fromScale(0.5, 0.5),
		Parent = Main,

        MouseEnter = Hovering.setLambda(1),
        MouseLeave = Hovering.setLambda(0),
        
        MouseButton1Down = function(self)
			self.BackgroundColor3 = Color3.new(1,0.1,0.2)
			Hovering(0)
		end,
        MouseButton1Up = Hovering.setLambda(1),

        MouseButton1Click = function(self)
            Main.Object:Destroy()
            hover_spring:DisconnectAll()
        end,
        
        children = {
            New "TextLabel" {
				Text = text or "Note Title",
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                TextSize = 10,
                TextColor3 = Color3.new(1,1,1),

                children = {
                    New "UIPadding" {
                        PaddingTop = UDim.new(0, 10)
                    }
                }
            }
        }
	}

	coroutine.wrap(function()
		local InitAnim = Quark.Animations.Spring(0, 1, 0.2, 0.6)
        InitAnim:BindAndPlay(function(value: number)
			Note.Size = UDim2.fromScale(1, value)
		end)

        task.wait(0.5)
        InitAnim:DisconnectAll()

        hover_spring = Quark.Animations.Spring(0, Hovering):BindAndPlay(function(value)
            Note.Size = UDim2.fromScale(1 + value/10, 1 + value/10)
            Note.BackgroundTransparency = 0.9 - value / 10
        end)
	end)()

	return Main
end
