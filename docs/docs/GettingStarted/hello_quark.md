# Hello Quark

First thing to do is to create an instance.
The instance can be anything, but we'll choose a `TextLabel`

1. Make a `ScreenGui` inside of StarterGui.
2. Add a `LocalScript` inside it.
3. Put this code in the LocalScript:

```luau
local Quark = require(game.ReplicatedStorage.Quark)
local New = Quark.New

New "TextLabel" {
	Parent = script.Parent,
	Size = UDim2.fromOffset(200, 50),
	Text = "Hello Quark!"
}
```

If everything works correctly, you should see a TextLabel appear when you play the game.

<div align="center">

![_](assets/screenshots/RobloxStudioBeta_WC40odTHXy.png)
![_](assets/screenshots/RobloxStudioBeta_1tlafwX2br.png)

</div>

---

<!NextPage|What is New?>(#New/whats_new)
