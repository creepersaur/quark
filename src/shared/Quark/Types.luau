local ReplicatedStorage = game:GetService "ReplicatedStorage"

local all_instances = require(ReplicatedStorage.Shared.Quark.Components.all_instances)
local quicklist = require(script.Parent.quicklist)
type StateMethods<T> = {
	__call: (self: State<T>, T?) -> T,
	__index: StateMethods<T>,
}

export type State<T> = typeof(setmetatable(
	{} :: {
		value: T,
		setLambda: (T) -> () -> (),
		connect: ((T) -> ()) -> Signal<T>,
		connections: { (value: any) -> () },
		_is_state: true,
	},
	{} :: StateMethods<T>
))

export type Signal<T = unknown> = {
	id: string,
	state_object: State<T> | { State<T> },
	_is_signal: true,
	Disconnect: (self: Signal<T>) -> (),
}

export type Style = {
	Properties: { [string]: { [string]: any } },
	ApplyRecursive: (self: Style, obj: any) -> (),
	ApplySingle: (self: Style, obj: any) -> (),
	Push: (self: Style, name: string) -> (Properties: { [string]: any }) -> (),
}

export type New<T> = {
	PushChildren: ({ New<T> }) -> New<T>,
	Push: (child: New<T>) -> New<T>,
	PushClass: (class: string) -> New<T>,
} & T & (properties: { [string]: any }) -> New<T> & T

export type Spring<T> = {
	Start: CanBeState<T>,
	Value: State<T?>,
	Alpha: State<number>,
	Velocity: State<number>,
	Target: CanBeState<T>,
	Elasticity: number,
	Stiffness: number,
	Connections: { (T) -> () },
	PlayConnection: RBXScriptConnection?,
	_is_spring: true,

	Play: (self: Spring<T>) -> Spring<T>,
	Restart: (self: Spring<T>) -> Spring<T>,
	Pause: (self: Spring<T>) -> Spring<T>,
	Cancel: (self: Spring<T>) -> Spring<T>,
	DisconnectAll: (self: Spring<T>) -> Spring<T>,
	SetValue: (self: Spring<T>, value: T) -> Spring<T>,
	Update: (self: Spring<T>, dt: number) -> Spring<T>,
	BindToRenderStep: (self: Spring<T>) -> RBXScriptConnection,
	BindToUpdate: (self: Spring<T>, func: (value: T) -> ()) -> Spring<T>,
	BindAndPlay: (self: Spring<T>, func: (value: T) -> ()) -> Spring<T>,
	BindToProperty: (self: Spring<T>, Object: Instance | { [string]: unknown }, Property: string) -> Spring<T>,
}

export type Tween<T> = {
	Start: CanBeState<T>,
	Value: State<T?>,
	Target: CanBeState<T>,
	Timer: number,
	Info: TweenInfo,
	Repeated: number,
	Reversed: boolean,
	Completed: boolean,
	FixedStart: boolean,
	Connections: { (T) -> () },
	PlayConnection: RBXScriptConnection?,
	_is_tween: true,

	Play: (self: Tween<T>) -> Tween<T>,
	Restart: (self: Tween<T>) -> Tween<T>,
	Pause: (self: Tween<T>) -> Tween<T>,
	Cancel: (self: Tween<T>) -> Tween<T>,
	DisconnectAll: (self: Tween<T>) -> Tween<T>,
	SetValue: (self: Tween<T>, value: T) -> Tween<T>,
	Update: (self: Tween<T>, dt: number) -> Tween<T>,
	BindToRenderStep: (self: Tween<T>) -> RBXScriptConnection,
	BindToUpdate: (self: Tween<T>, func: (value: T) -> ()) -> Tween<T>,
	BindAndPlay: (self: Tween<T>, func: (value: T) -> ()) -> Tween<T>,
	BindToProperty: (self: Tween<T>, Object: Instance | { [string]: unknown }, Property: string) -> Tween<T>,
}

export type Entries = (
	n: number | { unknown },
	func: (i: number, v: any?) -> State<Instance | New<any>>
) -> { State<Instance | New<any>> }

export type CanBeState<T> = T | State<T>

export type Quark = {
	State: <T>(default: T? | (use: <R>(State<R>) -> R) -> T?, strict: boolean?) -> State<T>,
	Signal: <T>(state: | { State<T> }, func: (value: T, old: T) -> ()) -> Signal<T>,
	StyleSheet: (name: string) -> (Styles: { [string]: { [string]: any } }) -> Style,
	CanBeState: CanBeState<any>,
	Spring: Spring<any>,
	Tween: Tween<any>,
	Entries: Entries,
	QuickList: <T>({ T } | quicklist.QuickList<T>) -> quicklist.QuickList<T>,
	Class: (name: string) -> string,
	New: <T>(ClassName: Instance | all_instances.ALL_INSTANCES | string) -> New<T> & T,
	Animations: {
		Spring: <T>(
			start: CanBeState<T>,
			target: CanBeState<T>,
			elasticity: number?,
			stiffness: number?
		) -> Spring<T>,
		Tween: <T>(start: CanBeState<T>, target: CanBeState<T>, Info: TweenInfo, fixedStart: boolean?) -> Tween<T>,
	},
	GetStyle: (name: string) -> { [string]: any },
	Cleanup: () -> (),
	Scope: () -> Quark,
}

-- Quark.StyleSheet = StyleSheet.new
-- Quark.GetStyle = StyleSheet.GetStyle
-- Quark.Class = StyleSheet.Class

-- name: string)
-- 	return function(Styles: { [string]: { [string]: any } }): Types.Style

return {}
