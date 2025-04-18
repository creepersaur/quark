<div align="center" style="padding-bottom: 30px">

<img width="400" alt="Quark_creepersaur" src="https://github.com/user-attachments/assets/02d6c90d-dcde-4ccd-be88-a5daa9b53058" />

</div>

_A simple and easy to use reactive UI library for Roblox._

It's great for making UI quickly and easily. Still in development, bugs may occur. Especially useful in Stories/Storybooks, with UI Labs. Feel free to make a Github Issue on it for bugs/improvements.

## Installation

You can get Quark from the [Roblox Creator Store](https://create.roblox.com/store/asset/105183088809550).
It's adviced to put the Quark module in ReplicatedStorage.

If you want the latest code update, just clone this repository. If you cloned this repo, you can use Rojo (or another linker) to build the place file (or use it without building).

If you want a more "stable" release, download the `Quark.rbxm` file from the [Releases](https://github.com/creepersaur/Quark/releases/latest). (Releases are more stable.)

# Documentation

Check out the [Docs](./docs/) for more info. It also serves as a tutorial for beginners.

1. [Getting Started](./docs/1.GettingStarted.md)
2. [New](./docs/2.New.md)
3. [Reactivity](./docs/3.Reactivity.md)
4. [Animations/Springs](./docs/4.Animations.Springs.md)
4. [Animations/Tweens](./docs/5.Animations.Tweens.md)
5. [StyleSheets](./docs/6.StyleSheets.md)
6. [Stories](./docs/7.Stories.md)
7. [Scopes](./docs/8.Scopes.md)
8. [Premade UI](./docs/9.PremadeUI.md)

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
