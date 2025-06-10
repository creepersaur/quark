[header: Reactivity]

# Signal

Signals are used to connect to updates or changes in a `State`. They too are quark objects.

```luau
local Signal = Quark.Signal
```

---

## Creating a Signal

Create a signal by calling it with the state you want to connect to, and the callback function. The function will be run each time the value updates.

```luau
Signal( state, callback_function )
```

---

## Connecting to Updates

You can connect to a state's value change by using the following methods:

<div class="tab_holder" title="Creating a `Signal` by passing a state and callback." code_only>

<tab active='yes' hide>

```luau
local Signal = Quark.Signal
local myState = State("hello world")

local mySignal = Signal(myState, function(newValue, oldValue)
    print("New value of the state is:" .. newValue)
end)

myState("foobar")
-- the signal would print "New value of the state is: foobar"
```

</tab>

</div>

<div class="tab_holder" title="Calling the `.connect()` method of the State." code_only>

<tab name="short" active='yes' hide>

```luau
local myState = State("hello world")

local mySignal = myState.connect(function(newValue, oldValue)
    print("New value of the state is:" .. newValue)
end)

myState("foobar")
-- the signal would print "New value of the state is: foobar"
```

</tab>

</div>

As you can see, the bottom method is more concise. You can still use the above method for more clarity if necessary.

---

## Disconnecting from a State

To disconnect from a State's updates, you can call the `:Disconnect()` method on it.

```luau
mySignal:Disconnect()
```

---

## Connecting Multiple Signals to a State

States can have many connections all at once. You can create multiple signals, or call `.connect()` more than once for each state. Good if you want to connect different functions to the same state.

```luau
local s1 = myState.connect(function)
local s2 = myState.connect(function)
```

---

## Connecting Multiple States to a Signal

Signals as of writing cannot have multiple states attached to them. (This may be changed in the future, remind me.)

However you **can** connect the same callback to multiple state updates like so:

```luau
function callback(new, old)
    print('value of state changed from:' .. old .. ' to ' .. new)
end

state_one.connect(callback)
state_two.connect(callback)
```

**HOWEVER**, the `new` and `old` parameters of the function will be those of the state that changed.

So if `state_one` changes from `0` to `1`, then

```luau
old = 0, new = 1
```

If `state_two` changes from "hello" to "world", then

```luau
old = "hello", new = "world"
```

Keep that in mind when connecting 2 states to the same callback.

<!NextPage|Scope>(?Environment/scope)
