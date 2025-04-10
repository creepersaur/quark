# Installation

You can install Quark by three methods

- [Github Releases](https://github.com/creepersaur/quark/releases/latest) (Quark.rbxm)
- [Roblox Marketplace](https://create.roblox.com/store/asset/105183088809550/Quark) (Toolbox)
- [Wally](https://wally.run/package/creepersaur/quark) (Package Manager)
- Building from source (Rojo)

If one isn't working, try the other installation methods.

-# Sometimes Roblox moderation falsely reports an asset. This is a Roblox bug if I'm sure. Use the Github release.

---

## Github Releases

1. Go to the releases page on the github. And click the latest release version. Or use the link from the top.

-# (In this image it's *v0.0.13*)
![releases_image](assets/screenshots/zen_7DFoYxFaUe.png)

2. Go to the latest release and download the `Quark.rbxm` file.

![alt text](assets/screenshots/zen_A20lUf5EGG.png)

3. Right click on `ReplicatedStorage` in the Explorer and go to insert > insert from file.

![alt text](assets/screenshots/tfVMEtzAD8.png)

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
