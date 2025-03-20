local all_properties = require(script.Parent.Components.all_properties)
local all_instances = require(script.Parent.Components.all_instances)
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
		compString: (fmt_string: string) -> State<T>
	},
	{} :: StateMethods<T>
))

export type Signal<T> = {
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
	PushChildren: (self: New<T>, { New<T> }) -> New<T>,
	Push: (self: New<T>, child: New<T>?) -> New<T>,
	PushClass: (self: New<T>, class: string) -> New<T>,
} & T & (properties: { [string]: any } & all_properties.ALL_PROPERTIES<New<T>>) -> New<T> & T

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

export type Loop = {
	Value: State<number>,
	Connections: { (any) -> () },
	PlayConnection: RBXScriptConnection?,
	_is_loop: true,

	Play: (self: Loop) -> Loop,
	Restart: (self: Loop) -> Loop,
	Pause: (self: Loop) -> Loop,
	Cancel: (self: Loop) -> Loop,
	DisconnectAll: (self: Loop) -> Loop,
	Update: (self: Loop, dt: number) -> Loop,
	BindToRenderStep: (self: Loop) -> RBXScriptConnection,
	BindToUpdate: (self: Loop, func: (dt: number) -> ()) -> Loop,
	BindAndPlay: (self: Loop, func: (dt: number) -> ()) -> Loop,
	BindToProperty: (self: Loop, Object: Instance | { [string]: unknown }, Property: string) -> Loop,
}

export type Entries = typeof(setmetatable( {} :: {
	Object: New<Frame>,
	Scope: Quark,
	Children: {New<Instance> | Instance},
	_is_entries: true,

	Push: () -> Entries,
	PushChildren: (n: number | {any}) -> Entries,
	Remove: (n: number | New<Instance> | Instance) -> Entries,
}, {} :: {
	__call: (...any) -> New<Frame>,
	__index: (...any) -> any
})) & New<Frame>

export type CanBeState<T> = T | State<T>

export type Quark = {
	State: <T>(default: T? | (use: <R>(State<R>) -> R) -> T?, strict: boolean?) -> State<T>,
	Signal: <T>(state: | { State<T> }, func: (value: T, old: T) -> ()) -> Signal<T>,
	StyleSheet: (name: string) -> (Styles: { [string]: { [string]: any } }) -> Style,
	CanBeState: CanBeState<any>,
	Spring: Spring<any>,
	Tween: Tween<any>,
	Loop: Loop,
	Entries: <I, V>(n: number|{[I]: V}, func: (Scope: Quark, i: number|I, v: V) -> New<any>|Instance?) -> Entries,
	QuickList: <T>({ T } | quicklist.QuickList<T>) -> quicklist.QuickList<T>,
	Class: (name: string) -> string,
	New: <T>(ClassName: Instance | all_instances.ALL_INSTANCES) -> New<T> & T & Instance,
	Animations: {
		Spring: <T>(
			start: CanBeState<T>,
			target: CanBeState<T>,
			elasticity: number?,
			stiffness: number?
		) -> Spring<T>,
		Tween: <T>(start: CanBeState<T>, target: CanBeState<T>, Info: TweenInfo, fixedStart: boolean?) -> Tween<T>,
		Loop: () -> Loop,
	},
	GetStyle: (name: string) -> { [string]: any },
	Cleanup: () -> (),
	Scope: () -> Quark,
}

return {}
