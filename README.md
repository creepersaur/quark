<div align="center" style="padding-bottom: 30px">

<img width="400" alt="Quark_creepersaur" src="https://github.com/user-attachments/assets/02d6c90d-dcde-4ccd-be88-a5daa9b53058" />

_A simple and easy to use reactive UI library for Roblox._

</div>

It's great for making UI quickly and easily. Still in development, bugs may occur. Especially useful in Stories/Storybooks, with UI Labs. Feel free to make a Github Issue on it for bugs/improvements.

## Installation

You can get Quark from the `Quark.rbxm` file in the [Github Releases](https://github.com/creepersaur/Quark/releases/latest).
It's adviced to put the Quark module in ReplicatedStorage.

# [Documentation](https://creepersaur.github.io/quark)

Check out the documentation ^^^ for more info. It also serves as a tutorial for beginners.

# Examples

Examples for stories are given in the [examples](./src/examples/) folder. For smaller examples and info, check Documentation above.

## New:

```lua
local New = Quark.New

New "Frame" {
    -- Set properties
    Parent = script.parent,
    Size = UDim2.fromOffset(100, 100),
    BackgroundColor3 = Color3.new(1,0,0),

    -- Set children
    children = {
        New "TextButton" {
            Size = UDim2.fromOffset(75, 30)
        }
    }
}
-- EVENTS
{
    -- Events are function callbacks
    MouseEnter = function(self, ...)
        
    end,
}
```

## States:

```lua
local State = Quark.State
local Counter = State(0) -- initialize

Counter( Counter() + 1 ) -- increment
print(Counter()) -- print counter value
```
