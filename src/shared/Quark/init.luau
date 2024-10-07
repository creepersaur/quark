local Quark = {}

local Reactive = require(script.Reactive)
Quark.State = Reactive.State
Quark.Signal = Reactive.Signal

local New = require(script.Components.New)
Quark.New = New.New

local Animations = require(script.Animations)
Quark.Animations = Animations

local StyleSheet = require(script.Styles)
Quark.StyleSheet = StyleSheet.new
Quark.GetStyle = StyleSheet.GetStyle
Quark.Class = StyleSheet.Class

local Cleanup = require(script.Components.Cleanup)
Quark.Cleanup = Cleanup[1]
Cleanup[2](New.Created, Animations._Created)

export type Quark = typeof(Quark)
return Quark