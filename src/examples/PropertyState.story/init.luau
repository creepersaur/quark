local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Quark = require(ReplicatedStorage.Shared.Quark)
local Spring = Quark.Animations.Spring
local New = Quark.New

return function(parent: Instance)
    local Hovering = Quark.State(UDim2.fromOffset(100, 50))

    local x = New "TextLabel" {
        Size = UDim2.fromOffset(100, 50),
        Parent = parent
    }
    
    x {
        Size = Spring(Hovering(), Hovering, 0.5, 0.9),
        MouseEnter = Hovering.setLambda(UDim2.fromOffset(150, 50)),
        MouseLeave = Hovering.setLambda(UDim2.fromOffset(100, 50)),
    }

    return Quark.Cleanup
end
