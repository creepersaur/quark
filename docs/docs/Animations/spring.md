[header: Animations]

# Spring

Quark has a custom `Spring` object which is a reactive animation handler for values.

```luau
local Spring = Quark.Animations.Spring
```

Springs can be created by calling the `Spring()` method and passing in the following arguments:

```luau
-- Type showcase
-- (you only have to write the values)
Spring(
	start: Types.CanBeState<T>,  -- (Default = 0)
	target: Types.CanBeState<T>, -- (Default = 1)
	elasticity: number?,         -- (Default = 0.1)
	stiffness: number?           -- (Default = 0.7)
)
```
> <note>
>
> CanBeState\<T> refers to almost any scalable property.

---

## Using Springs as properties

Set a property to a spring to bind the property to the spring. When the spring updates, the property will be set accordingly.

(Multiple properties and objects can use the same spring reference, you only have to Play() it once.)

```luau
local size_spring = Spring(
	UDim2.new(0, 0, 0, 0),
	UDim2.new(0, 0, 100, 100),
)

-- Use the spring
New "Frame" {
	Size = size_spring:Play()
}
```
> <danger>
>
> REMEMBER TO CALL `:Play()` ON THE SPRING.
>
> It will only run after Play is called on it. (Play returns the Spring itself, so you can chain it.)

---

## Current Value of Spring

A spring's value is a state. You can also set this state yourself. (It will continue running after setting obviously but good for sudden jolts or if it's binded to a property.)

### Update the Value

```luau
my_spring.Value(value)
```
```luau
my_spring:SetValue(value)
```

---

## Using States with Springs

Springs are **reactive** in nature. That is to say they will automatically change their target if it is a `State`.

```luau
local my_target = State(UDim2.fromScale(0, 0))

local size_spring = Spring(
	UDim2.fromScale(0, 0),
	my_target
)
```

Whenever my_target changes, the spring will switch directions and go towards it.
This is especially useful for having smooth/bouncy animations for your UI.

Just change the value of the state and it animates the spring.

---

# Example

If I wanted a button that gets bigger vertically when hovered I could do this:

```luau
-- We'll use hooks to get hover states.
local Hook = Quark.Hook
local TargetSize = State(UDim2.fromScale(0.5, 0.2))

New "TextButton" {
	Parent = script.Parent.Parent,
	
	Size = Spring(
		TargetSize(),  -- Get current fixed value of the state UDim2(0.5, 0.2)
		TargetSize     -- Use a reference to the state for auto update
	):Play()

	Hook("MouseEnter", TargetSize.setLambda(UDim2.fromScale(0.5, 0.3))),
	Hook("MouseLeave", TargetSize.setLambda(TargetSize()))
	-- Get current original fixed value of state ^^^
}
```

---

# Spring Methods

## :Play()

Play/Start the spring. Will infinitely update each frame until stopped/paused or cleaned up.

## :Pause()

Pause the spring. Stop it temporarily until `Play()` is called again. (Good if you wanted to set the spring's `Value` directly without it updating.)

## :Cancel()

Stop the spring forever and resets it back to the Start value.

## :Restart()

Restart the spring from the start. (If the start is a State then it will use the state's current value.)

## :SetValue(x)

Sets the current value of the spring, and spring will continue to move
towards target.

## :BindToUpdate(f)

The function passed in will run each time the spring updates (each frame).
The function takes in a value parameter which returns the current value of the Spring.

```luau
spring:BindToUpdate(function(value)
	print("Current value:", value)
end)
```

## :BindAndPlay(f)

Same thing as `BindToUpdate()` but it also Plays the spring.

## :DisconnectAll()

Disconnects all properties and connections to the Spring.

---

<!NextPage|Tween>(?Animations/tween)
