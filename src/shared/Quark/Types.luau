type StateMethods<T> = {
    __call: (self: State<T>, T?) -> T,
    __index: StateMethods<T>
}

export type State<T> = typeof(setmetatable({} :: {
    value: T,
    setLambda: (T) -> () -> (),
	connect: ((T) -> ()) -> Signal<T>,
	connections: { (value: any) -> () },
    _is_state: true
}, {} :: StateMethods<T>))

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

export type New = {
	PushChildren: ({ any }) -> (),
	Push: (child: any) -> (),
	PushClass: (class: string) -> (),
}

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
    AssignedProperties: {},
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
    BindToProperty: (self: Spring<T>, Object: Instance | { [string]: unknown }, Property: string) -> Spring<T>
}

export type CanBeState<T> = T | State<T>

return true