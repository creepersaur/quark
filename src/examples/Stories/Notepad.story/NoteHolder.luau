local Note = require(script.Parent.Note)

return function(Scope)
	local New = Scope.New
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

	local NoteScope = Scope.Scope()
    local function AddNote(text: string?)
        local note = Note(NoteScope, text)
        Main:Push(note)
    end

    return Main, AddNote
end
