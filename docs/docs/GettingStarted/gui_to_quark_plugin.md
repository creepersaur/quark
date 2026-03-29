[header: Getting Started]

# GUI to Quark Plugin

The **GUI to Quark** plugin is a Roblox Studio tool that converts existing Roblox GUI instances into Quark's declarative style code.

This makes it easy to migrate existing UI designs to Quark without manually rewriting everything.

---

## Installation

The plugin is available from the Roblox Creator Store:

- **[Roblox Creator Store](https://create.roblox.com/store/asset/102437671741293/GUI-to-Quark)**
- **[GitHub Repository](https://github.com/Kvil-git/Roblox-gui-to-quark-code-plugin/)**

Install it like any other Roblox Studio plugin from the Toolbox.

---

## Usage

1. Select a GUI instance (or multiple instances) in the Explorer
2. Open the plugin window
3. Click **"Convert to Quark"**
4. The generated Quark code is copied to your clipboard

---

## What Gets Converted

The plugin handles:

- **Properties** - Size, position, colors, transparency, etc.
- **Children** - Nested GUI elements are converted to nested Quark blocks
- **Basic styling** - Background colors, borders, and text properties

---

## Example

A Frame with a TextBox child gets converted to:

```luau
local Frame = New "Frame" {
    BackgroundColor3 = Color3.new(1, 1, 1),
    BorderColor3 = Color3.new(0, 0, 0),
    BorderSizePixel = 0,
    Size = UDim2.new(0, 100, 0, 100),
    Children = {
        New "TextBox" {
            Name = "TextBox",
            BackgroundColor3 = Color3.new(1, 1, 1),
            BorderColor3 = Color3.new(0, 0, 0),
            BorderSizePixel = 0,
            FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
            Size = UDim2.new(0, 200, 0, 50),
            TextColor3 = Color3.new(0, 0, 0),
            TextSize = 14,
        },
    },
}
```

---

## Limitations

- Complex scripts attached to GUIs need manual conversion
- Some Roblox-specific GUI features may require post-conversion tweaks

---

**Ready to write your first Quark UI from scratch?** Check out the next page:

<!NextPage|Hello Quark>(?GettingStarted/hello_quark)
