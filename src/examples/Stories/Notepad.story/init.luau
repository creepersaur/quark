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
	-- Tip text
	New "TextLabel" {
		Text = "Click `New Note` to add a note. Set the text using the Story Controls.",
		TextColor3 = Color3.new(1, 1, 1),
		Size = UDim2.new(1, 0, 0, 20),
		BackgroundTransparency = 0.5,
		BackgroundColor3 = Color3.new(),
		TextXAlignment = "Left",
		Parent = props.target,
	}

	local Background = New "Frame" {
		Size = UDim2.new(0, 200, 1, 0),
		BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
		Position = UDim2.fromOffset(0, 25),

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

	local NoteScope = Quark.Scope()
	local NewNoteButton = NewNote(NoteScope)
	local NoteHolder, AddNote = NoteHolder(NoteScope)

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
