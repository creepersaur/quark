# Installation

You can install Quark by three methods

- [Roblox Marketplace](https://create.roblox.com/store/asset/105183088809550/Quark) (Toolbox)
- [Github Releases](https://github.com/creepersaur/quark/releases/latest) (Quark.rbxm)
- [Wally](https://wally.run/package/creepersaur/quark) (Package Manager)
- Building from source (Rojo)

---

## Using Quark

After installing Quark, put the ModuleScript inside of `ReplicatedStorage`.

You can `require()` the module to use it .

```luau
local Quark = require(game.ReplicatedStorage.Quark)
```

---

## Building from Source

For those building from source, the source-code is in `src/shared/Quark`.

```luau
-- Quark is inside of `ReplicatedStorage/Shared`
local Quark = require(game.ReplicatedStorage.Shared.Quark)
```

---

<!NextPage|Hello Quark>(#GettingStarted/hello_quark)
