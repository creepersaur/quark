local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New
local Hook = Quark.Hook

return Quark.CreateStory(function(t)
	local Padding = UDim.new(0, 10)

	return New "Frame" {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.new(0.5, 0.5, 0.5),

		children = {
			New "UIPadding" {
				[{ "PaddingLeft", "PaddingRight", "PaddingTop", "PaddingBottom" }] = Padding,
			},
			Quark.Entries(5, function(Scope, i)
				return Scope.New "Frame" {
					Size = UDim2.fromScale(1, 1),
					BackgroundColor3 = function()
						return Color3.new(i / 5)
					end,

					Hook("MouseEnter", function(self: Quark.New<Frame>)
						self.BackgroundColor3 = Color3.new(1, 1, 1)
					end),
					
					Hook("MouseLeave", function(self: Quark.New<Frame>)
						self.BackgroundColor3 = Color3.new(0.7,0.7,0.7)
					end),

					children = {
						New "UIAspectRatioConstraint",
						New "UIStroke" {
							Color = Color3.new(1, 1, 1),
							Thickness = 2,
						},
					},
				}
			end) {
				BackgroundTransparency = 0.5,
				BackgroundColor3 = Color3.new(0),
				AutomaticSize = "X",
				Size = UDim2.new(1, 0, 0.02, 50),

				children = {
					New "UIPadding" {
						[{ "PaddingLeft", "PaddingRight", "PaddingTop", "PaddingBottom" }] = Padding,
					},
					New "UIListLayout" {
						FillDirection = "Horizontal",
						Padding = UDim.new(0, 10),
					},
				},
			},
		},
	}
end)
