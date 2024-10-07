local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Note = require(script.Parent.Note)
local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New

return function()
    local Main = New "Frame" {
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.new(),
        BackgroundTransparency = 0.85,
        BorderSizePixel = 0,

        children = {
            New "UIListLayout" {
                Padding = UDim.new(0, 10),
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
            },
            New "UIPadding" {
                PaddingTop = UDim.new(0, 5)
            }
        }
    }

    local function AddNote(text: string?)
        local note = Note(text)
        Main:Push(note)
    end

    return Main, AddNote
end
