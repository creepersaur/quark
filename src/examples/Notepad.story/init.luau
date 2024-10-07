local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New

local NewNote = require(script.NewNote)
local NoteHolder = require(script.NoteHolder)

return function(parent: Instance)
    local Background = New "Frame" {
        Size = UDim2.new(0, 200, 1, 0),
        BackgroundColor3 = Color3.new(0.1,0.1,0.1),
        
        Parent = parent,
        children = {
            New "UIListLayout" {
                Padding = UDim.new(0, 10)
            },
            New "UIPadding" {
                PaddingLeft = UDim.new(0, 10),
                PaddingRight = UDim.new(0, 10),
                PaddingTop = UDim.new(0, 10),
                PaddingBottom = UDim.new(0, 10),
            }
        }
    }

    local NewNoteButton = NewNote()
    local NoteHolder, AddNote = NoteHolder()

    Background:PushChildren {
        NewNoteButton,
        NoteHolder
    }

    NewNoteButton.TextButton.MouseButton1Click:Connect(function()
        AddNote("Hello world")
    end)
    
    return function()
        Quark.Cleanup()
    end
end