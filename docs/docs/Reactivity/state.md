[header: Reactivity]

# State

States are variable wrappers that allow you to update, reset, connect to changes in their values. They can store **any value**.

```luau
local State = Quark.State
```

---

## Creating a State

Call the `State()` function to create a new state:

```luau
State(initial_value, is_strict)
```

> <DANGER>
>
> If `is_strict` is set to **true**, setting a State to a value of a different type will give an error. (Can be avoided by forcing)
> </DANGER>

```luau
local State = Quark.State
local Counter = State(0)

-- Counter is a state with value set to 0
```

---

## Retrieving a value from a State

Calling the State like a function will return the value associated with the state:

```luau
local Counter = State(50)

print( Counter() ) -- Prints `50`
```

One may also use `.Value` to get the current value of a state:

```luau
-- Don't try setting `.Value` directly, it won't update other things.
print(Counter.Value)
```

---

## Updating a State

You can call the state like a function, and pass in the new value.
The new value:

```luau
local Counter = State(0)   -- Counter is 0
Counter(100)  -- Counter is 100
```

The State will also return the new value associated with it.

```luau
print( Counter(123) )  -- Prints `123`
```

You can also use a State to change the State:

<div class="tab_holder" title="Incrementing a State" code_only>

```luau
local Counter = State(0)

Counter( Counter() + 10 ) -- Counter is now `10`
Counter( Counter() + 10 ) -- Counter is now `20`
Counter( Counter() + 10 ) -- Counter is now `30`
```

</div>

In the above example we use the counter's current value, and set it to **10 plus the current value**.

---

## Force updating a State

You can **NOT** set a State to be `nil` by default. If no value or a `nil` value is used as an argument, the state remains unchanged.

However, States have a second argument which allows them to be forcefully set. `force` also bypasses `strict` at the time of writing.

```luau
Counter(nil, true)
-- SECOND ARGUMENT IS `force`
```

`Counter` has now been set to nil. (Without `force` nothing would change.)

---

## Resetting a State

If you wish to reset a `State` to its initial value. You can call `.reset()` on it and the state will be set to it's original value.

```luau
local Counter = State(500)
Counter(3)

Counter.reset()
print(Counter()) -- prints 500
```

---

## Lambda Setters

For *Quality of Life* purposes, there's a `.setLambda()` function that returns a function wrapper for setting the value of the state.
Useful for having one-liner state setters.

<div class="tab_holder" title="Example" code_only>

<tab name="setLambda" active="yes">

```luau
local myState = State("Click me!")

New "TextButton" {
	Text = myState,
	
	Hook("Activated", myState.setLambda("You clicked me."))
}
```
</tab>

<tab name="Equivalent">

```luau
local myState = State("Click me!")

New "TextButton" {
	Text = myState,
	
	Hook("Activated", function()
		myState("You clicked me.")
	end)
}
```
</tab>

</div>

---

# Using States as Properties

Just put the state object as the value of a property in a `New`

```luau
local New = Quark.New
local State = Quark.State

local TextState = State("Hello")
local MyLabel = New "TextLabel" {
	Text = TextState
}
```

The property will automatically update upon setting the State.

<div class="tab_holder" title="Change property using State" code_only>

<tab name="short" active='yes'>

```luau
TextState("Goodbye!") -- Setting the value to `Goodbye!`
-- The text of the label changes instantly.

print(MyLabel.Text) -- prints `Goodbye!`
```
</tab>

<tab name = "Full Code">

```luau
local New = Quark.New
local State = Quark.State

local TextState = State("Hello")
local MyLabel = New "TextLabel" {
	Text = TextState
}

print(MyLabel.Text) -- prints `Hello`

TextState("Goodbye!") -- Setting the value to `Goodbye!`
print(MyLabel.Text) -- prints `Goodbye!`
```
</tab>

</div>

---

# Computed States

By putting a function inside a State, you can create a computed state:

```luau
local Computed = State(function(use)
	return "Value"
end)
```

The `use` function allows you to **connect to the updates** of another state. `use(State)` also returns the value of the state.

Where the `function()` gets ran whenever one of the **dependencies updates**. The State's value is set to the **return value** of the `function()`.

## Example:

Sometimes you want to update a state, based off of another state.
Say for example, I want to update my `TextState` whenever my `Counter` state changes.

To make it such that the TextState updates when Counter updates, we `use(Counter)` and add it to the dependencies.
<div class="tab_holder" code_only>
<tab name = "Compressed" active="yes">

```luau
local TextState = State(function(use)
	return "Counter: " .. use(Counter)
end)
```

</tab>

<tab name = "Full Code">

```luau
local Counter = State(0)

local TextState = State(function(use)
	return "Counter: " .. use(Counter)
end)

Counter(5)
print( TextState() ) -- Prints "Counter: 5"
```

</tab>
</div>

---

To connect to State updates, please check out Signals:

<!NextPage|Signal>(?Reactivity/signal)
