function new()
	local Quark = {
		_CreatedScopes = {},
		Scope = function(): Scope
			return nil::any
		end
	}

	--[[ REACTIVE ]]
	local Reactive = require(script.Parent.Reactive)()
	Reactive.Quark = Quark

	Quark.State = Reactive.State
	Quark.Signal = Reactive.Signal
	Quark.Entries = Reactive.Entries

	--[[ NEW ]]
	local New = require(script.Parent.Components.New)()
	Quark.New = New.New
	Quark.Hook = New.Hook

	--[[ ANIMATIONS ]]
	local Animations = require(script.Parent.Animations)()
	Quark.Animations = Animations

	--[[ Styles ]]
	local Styles = require(script.Parent.Styles)()

	local StyleSheet = Styles.StyleSheet
	Quark.StyleSheet = StyleSheet.new
	Quark.GetStyle = StyleSheet.GetStyle
	Quark.Class = StyleSheet.Class

	--[[ CLEANUP ]]
	local Cleanup = require(script.Parent.Components.Cleanup)()
	Quark.Cleanup = Cleanup[1]
	Quark.OnCleanup = Cleanup[4]
	Cleanup[2](New.Created, Animations._Created, Reactive.Created, Styles.Created)
	Cleanup[3](Quark._CreatedScopes)

	--[[ STORY ]]
	local CreateStory = require(script.Parent.Components.CreateStory)()
	Quark.CreateStory = CreateStory.CreateStory
	CreateStory.Quark = Quark

	return Quark::Quark
end

--[[ TYPES ]]
local Types = require(script.Parent.Types)

export type State<T> = Types.State<T>
export type Signal<T = unknown> = Types.Signal<T>
export type Style = Types.Style
export type CanBeState<T> = Types.CanBeState<T>
export type Spring<T> = Types.Spring<T>
export type New<T> = Types.New<T>
export type Entries = Types.Entries

export type Quark = Types.Quark & typeof(new())
export type Scope = Quark

return new