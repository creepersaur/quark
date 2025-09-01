[header: Animations]

# Tween

Quark has a custom `Tween` object which is a reactive animation handler for values. It is somewhat similar to [Springs](?Animations/spring) and I suggest checking those out first. It **does NOT use TweenService** and is handled manually by Quark.

```luau
local Tween = Quark.Animations.Tween
```

Tweens support all features inside of `TweenInfo`, such as repeating, boomerang, easing styles and directions, etc.

Tweens can be created by calling the `Tween()` method and passing in the following arguments:

```luau
-- Type showcase
-- (you only have to write the values)
Tween(
	start: Types.CanBeState<T>,  -- (Default = 0)
	target: Types.CanBeState<T>, -- (Default = 1)
	tween_info: TweenInfo,
	fixed_start: boolean?
)
```
> <note>
>
> CanBeState\<T> refers to almost any scalable property.

---

## Using Tweens as properties

Set a property to a tween to bind the property to the tween. When the tween updates, the property will be set accordingly.

(Multiple properties and objects can use the same tween reference, you only have to Play() it once.)

```luau
local size_tween = Tween(
	UDim2.new(0, 0, 0, 0),
	UDim2.new(0, 0, 100, 100),
	TweenInfo.new(1, Enum.EasingStyle.Exponential)
)

-- Use the tween
New "Frame" {
	Size = tween:Play()
}
```
> <danger>
>
> REMEMBER TO CALL `:Play()` ON THE TWEEN.
>
> It will only run after Play is called on it. (Play returns the tween itself, so you can chain it.)

---

## Current Value of tween

A tween's value is a state. You can also set this state yourself. (It will continue running after setting obviously but good for sudden jolts or if it's binded to a property.)

### Update the Value

```luau
tween.Value(value)
```
```luau
tween:SetValue(value)
```

---

## Fixed Start

> fixed_start: boolean?

When creating a tween, there is a feature called `FixedStart` which lets the spring restart from it's original starting point instead of tweening directly to the next target.

It is not required and may never need to be used, but restarting from a given starting point is a feature nonetheless.

---

## Using States with Tweens

Tweens are **reactive** in nature. That is to say they will automatically change their target if it is a `State`.

```luau
local my_target = State(UDim2.fromScale(0, 0))

local tween = Tween(
	UDim2.fromScale(0, 0),
	my_target,
	TweenInfo.new(1, Enum.EasingStyle.Exponential)
)
```

Whenever my_target changes, the tween will switch directions and go towards it.
This is especially useful for having smooth/bouncy animations for your UI.

Just change the value of the state and it animates the tween.

---

# Example

If I wanted a button that gets bigger vertically when hovered I could do this:

```luau
-- We'll use hooks to get hover states.
local Hook = Quark.Hook
local TargetSize = State(UDim2.fromScale(0.5, 0.2))

New "TextButton" {
	Parent = script.Parent.Parent,
	
	Size = Tween(
		TargetSize(),  -- Get current fixed value of the state UDim2(0.5, 0.2)
		TargetSize     -- Use a reference to the state for auto update
		TweenInfo.new(0.5, Enum.EasingStyle.Quad)
	):Play()

	Hook("MouseEnter", TargetSize.setLambda(UDim2.fromScale(0.5, 0.3))),
	Hook("MouseLeave", TargetSize.setLambda(TargetSize()))
	-- Get current original fixed value of state ^^^
}
```

---

# Tween Methods

## :Play()

Play/Start the tween. Will infinitely update each frame until stopped/paused or cleaned up.

## :Pause()

Pause the tween. Stop it temporarily until `Play()` is called again. (Good if you wanted to set the tween's `Value` directly without it updating.)

## :Cancel()

Stop the tween forever and resets it back to the Start value.

## :Restart()

Restart the tween from the start. (If the start is a State then it will use the state's current value.)

## :BindToUpdate(f)

The function passed in will run each time the tween updates (each frame).
The function takes in a value parameter which returns the current value of the tween.

```luau
tween:BindToUpdate(function(value)
	print("Current value:", value)
end)
```

## :BindAndPlay(f)

Same thing as `BindToUpdate()` but it also Plays the Tween.

## :DisconnectAll()

Disconnects all properties and connections to the Tween.

---

<!NextPage|Loop>(?Animations/loop)
