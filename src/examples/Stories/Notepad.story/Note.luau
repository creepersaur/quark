local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Quark = require(ReplicatedStorage.Shared.Quark)

return function(Scope: Quark.Scope, text: string?)
	local New = Scope.New
	local Spring = Scope.Animations.Spring
	local Hook = Scope.Hook

	local Main = New "Frame" {
		Size = UDim2.new(1, -10, 0, 50),
		BackgroundTransparency = 1,
	}

	local Hovering = Scope.State(0)
    local hover_spring: Quark.Spring<any> = nil

	local Note = New "TextButton" {
		Text = "",
        AutoButtonColor = false,
		Size = UDim2.fromScale(0, 0),
		BackgroundTransparency = 0.9,
		AnchorPoint = Vector2.one * 0.5,
		Position = UDim2.fromScale(0.5, 0.5),
		Parent = Main,

        Hook("MouseEnter", Hovering.setLambda(1)),
        Hook("MouseLeave", Hovering.setLambda(0)),
        
        Hook("MouseButton1Down", function(self)
			self.BackgroundColor3 = Color3.new(1,0.1,0.2)
			Hovering(0)
		end),
        Hook("MouseButton1Up", Hovering.setLambda(1)),

        Hook("MouseButton1Click", function(self)
            Main.Object:Destroy()
            hover_spring:DisconnectAll()
        end),
        
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
		local InitAnim = Spring(0, 1, 0.5, 0.4)
        InitAnim:BindAndPlay(function(value: number)
			Note.Size = UDim2.fromScale(1, value)
		end)

        task.wait(0.2)
        InitAnim:DisconnectAll()

        hover_spring = Spring(0, Hovering, 0.5, 0.5):BindAndPlay(function(value)
            Note.Size = UDim2.fromScale(1 + value/15, 1 + value/10)
            Note.BackgroundTransparency = 0.9 - value / 10
        end)
	end)()

	return Main
end
