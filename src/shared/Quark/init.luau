local Quark = {}

--[[ REACTIVE ]]
local Reactive = require(script.Reactive)
Quark.State = Reactive.State
Quark.Signal = Reactive.Signal
Quark.Entries = Reactive.Entries

--[[ NEW ]]
local New = require(script.Components.New)
Quark.New = New.New

--[[ ANIMATIONS ]]
local Animations = require(script.Animations)
Quark.Animations = Animations

--[[ Styles ]]
local Styles = require(script.Styles)
local StyleSheet = Styles.StyleSheet
Quark.StyleSheet = StyleSheet.new
Quark.GetStyle = StyleSheet.GetStyle
Quark.Class = StyleSheet.Class

--[[ CLEANUP ]]
local Cleanup = require(script.Components.Cleanup)
Quark.Cleanup = Cleanup[1]
Cleanup[2](New.Created, Animations._Created, Reactive.Created, Styles.Created)

--[[ QUICKLIST ]]
local QuickList = require(script.quicklist)
Quark.QuickList = QuickList

--[[ TYPES ]]
local Types = require(script.Types)
Quark.Types = script.Types

export type Quark = Types.Quark
export type State<T> = Types.State<T>
export type Signal<T = unknown> = Types.Signal<T>
export type Style = Types.Style
export type CanBeState<T> = Types.CanBeState<T>
export type Spring<T> = Types.Spring<T>
export type New = Types.New & Instance
export type Entries = Types.Entries
export type QuickList = QuickList.QuickList

return Quark
