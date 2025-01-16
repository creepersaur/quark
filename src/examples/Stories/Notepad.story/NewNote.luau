return function(Scope)
	local New = Scope.New
    local Main = New "Frame" {
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundTransparency = 1
    }

    local Button = New "TextButton" {
        Text = "New Note",
        BackgroundTransparency = 0.9,
        TextColor3 = Color3.new(1,1,1),
        Size = UDim2.fromScale(1, 1)
    }

    Main:PushChildren {
        Button
    }
    return Main
end
