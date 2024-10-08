local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Quark = require(ReplicatedStorage.Shared.Quark)
local New = Quark.New

local NewNote = require(script.NewNote)
local NoteHolder = require(script.NoteHolder)

-- Slightly more advanced, I suggest you look into `Button_ToolTip.story` first.

local controls = {
	Title = "Hello World",
}
local story = function(props)
	local Background = New "Frame" {
		Size = UDim2.new(0, 200, 1, 0),
		BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),

		Parent = props.target,
		children = {
			New "UIListLayout" {
				Padding = UDim.new(0, 10),
			},
			New "UIPadding" {
				PaddingLeft = UDim.new(0, 10),
				PaddingRight = UDim.new(0, 10),
				PaddingTop = UDim.new(0, 10),
				PaddingBottom = UDim.new(0, 10),
			},
		},
	}

	local NewNoteButton = NewNote()
	local NoteHolder, AddNote = NoteHolder()

	Background:PushChildren {
		NewNoteButton,
		NoteHolder,
	}

    props.subscribe(function(values, infos)
        controls.Title = infos.Title.__new
    end)
	NewNoteButton.TextButton.MouseButton1Click:Connect(function()
		AddNote(controls.Title .. ` | {#NoteHolder.Children - 1}`)
	end)

	return Quark.Cleanup
end

return {
    controls = controls,
    render = story,
}
