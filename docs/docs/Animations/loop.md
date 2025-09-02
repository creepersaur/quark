[header: Animations]

# Loop

Loops are Quark connections that run each frame. You can bind functions to them and they'll run forever. (Until the loop is stopped or cleaned up).

```luau
local Loop = Quark.Animations.Loop
```

Loops can be created by calling the `Loop()` method and passing in the following arguments:

---

## Binding to a Loop

Call the `BindToUpdate` method and pass in a function that will get connected to each update (it will run each frame).

```luau
local my_loop = Loop():Play()

my_loop:BindToUpdate(function(deltaTime)
	-- This function runs each frame
	-- deltaTime is the time between each frame
end)
```
> <danger>
>
> REMEMBER TO CALL `:Play()` ON THE LOOP. (Or call `BindAndPlay` to do it automatically).
>
> It will only run after Play is called on it. (Play returns the Loop itself, so you can chain it.)

---

# Example

If I wanted some text that has a periodic sine wave movement up and down I could do:

```luau
local PositionState = State(UDim2.new(0, 30, 0, 30))
local start_time = os.clock()

-- Update the position state each frame
local frame_loop = Loop():BindAndPlay(function(dt)
	local t = os.clock() - start_time
	PositionState(UDim2.new(0, 30, math.sin(t * 5) * 0.05, 30))
end)

-- Use the PositionState
New "TextButton" {
	Parent = script.Parent.Parent,
	Position = PositionState,
}
```

---

# Loop Methods

## :Play()

Play/Start the loop. Will infinitely update each frame until stopped/paused or cleaned up.

## :Pause()

Pause the loop. Stop it temporarily until `Play()` is called again. (Good if you wanted to set the loop's `Value` directly without it updating.)

## :Cancel()

Stop the loop forever and resets it back to the Start value.

## :Restart()

Restart the loop from the start. (If the start is a State then it will use the state's current value.)

## :BindToUpdate(f)

The function passed in will run each time the loop updates (each frame).
The function takes in a deltaTime parameter which returns the time between the current and previous frame.

```luau
loop:BindToUpdate(function(dt: number)
	print("deltaTime:", dt)
end)
```

## :BindAndPlay(f)

Same thing as `BindToUpdate()` but it also Plays the loop.

## :DisconnectAll()

Disconnects all properties and connections to the loop.

---

<!NextPage|Basic Stories>(?Stories/basic_stories)
