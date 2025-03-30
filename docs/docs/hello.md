# Animations / Springs

As a UI designer, it's important to make your UI reactive, in the sense that it feels nice when the user interacts with it.

To account for how annoying it is to create `Tween`s in Roblox, Quark has it's own `Spring` object. This is basically a tween, that has 2 extra properties, `Elasticity` and `Stiffness`.

```lua
local Spring = Quark.Animations.Spring
```

Creating a spring:
-# It's a function, these are just parameters:

```lua
local Spring = Quark.Animations.Spring
local my_spring = Spring(
    start: T,
    target: T,
    elasticity: number,
    stiffness: number
)
```

- Springs can be started using `Play()` or `Restart()`, `BindAndPlay(func)`, `PlayAsProperty(object, property)`.
- Springs can be stopped using `Pause()`, `Cancel()` or `DisconnectAll()`.
- Springs can be Binded to using `BindToUpdate(func)`, `BindAndPlay(func)`,

## Using Springs as Properties

Set the property of an object to a spring, and it'll update when the spring updates (Every RenderStepped).
You must `:Play()` the spring for it to function. `:Play()` returns the spring so you can just do the following:

```lua
local New = Quark.New
local Spring = Quark.Animations.Spring

local my_spring = Spring(
    Color3.new(0,0,0), -- Transition from Black -> Red,
    Color3.new(1,0,0),
    0.1, -- Elasticity
    0.7  -- Stiffness
)

New "TextLabel" {
    -- Default properties hidden for clarity...
    BackgroundColor3 = my_spring:Play()
}
```

## Binding a Function to a Spring

Just use `BindToUpdate()` or `BindAndPlay()`. The latter also plays the spring before binding.

```lua
local Spring = Quark.Animations.Spring(
    --[[ Spring Properties Hidden for clarity]]
)

Spring:BindToUpdate(function(value)
    -- Each Frame
end)
Spring:Play() -- Start the spring
```

## Using a State in a Spring

You can set the target of a spring to a State, and the spring will automatically update and go towards the new target when the state is changed.

Here's code for a button that changes size when you hover:

```lua
local my_size = Quark.State(UDim2.fromScale(0.5, 1))

New "TextButton" {
    -- Default properties hidden for clarity...
    Size = Spring(
        my_size(), -- Call the state to get the fixed value,
        my_size, -- Don't call this, so it updates
        0.1, 0.7
    ):Play()
}
-- Events
{
    MouseEnter = my_size.setLambda(1),
    MouseLeave = my_size.setLambda(0.5),
}
```
