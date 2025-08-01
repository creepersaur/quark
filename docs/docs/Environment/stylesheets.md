[header: Environment]

# Stylesheets

A stylesheet is an object which can be used to create reusable styles and properties for your UI.

```luau
local myStyle = Quark.Stylesheet(`name`)
```

Stylesheets give you a way to style your UI without having to write all of your code in a single file. They also let you re-use styles that have been made previously and give you extra *Quality of Life* features.

---

## Creating Stylesheets

You can create a stylesheet using `Stylesheet()` and passing in the name of your stylesheet. (Names help you get premade stylesheets in the same scope.)

You can then call the stylesheet with a table containing all the properties to set the styles.
-# (These can't be called multiple times as of now.)

<div class="tab_holder" title="Make all buttons red" code_only>

<tab active="yes" hide>

```luau
local myStyle = Quark.Stylesheet("main") {
	['TextButton'] = {
		BackgroundColor3 = Color3.new(1, 0, 0)
	}
}
```
</tab>

</div>

Passing in the ClassName of the object will set that style for all the objects of that class.

---

## Using Stylesheets

Stylesheets will get applied to an object when the Stylesheet object is passed into the Quark `style` custom property.

```luau
local myStyle = Quark.Stylesheet("CoolStyle") {
	Frame = {
		TextColor3 = Color3.new(0,0,0),
		BackgroundColor3 = Color3.new(1, 0.7, 0.3)
	}
}

-- THIS FRAME WILL GET STYLED ACCORDINGLY
local StyledFrame = New "Frame" {
	style = myStyle  -- passed in the `myStyle` variable
}
```

> <warning>
>
> When a style is applied to a UI object all children of the object will automatically have that style applied to them respectively. (You don't have to put the `style` property for each child.)
> </warning>

---

# Classes

Create a class using the `Class` method. These classes can then be accessed in the stylesheet.

```luau
local Class = Quark.Class
```
```luau
local myStyle = Quark.Stylesheet("main") {
	[Class "Red"] = {
		BackgroundColor3 = Color3.new(1, 0, 0),
	},

	[Class "Big"] = {
		Size = UDim2.new(0, 0, 200, 200),
		TextSize = 30
	}
}
```

Objects can have multiple classes attached to them. Just use the Quark `class` custom property:

```luau
local BigRedFrame = New "Frame" {
	Parent = script.Parent,
	
	style = myStyle
	class = "Big Red",
	-- class names should be separated by spaces.
}
```

You can also use `PushClass()` on a New object to add a class.

---

# Custom Style Properties

Stylesheets have custom properties, just like New objects have.
These are only available in Stylesheets as of now. (They may come to New in the future but that isn't planned.)

As of writing these properties are as listed below.
(Names separated by pipes are aliases/shortforms)

## corner_radius | corner

Setting this to a number will add a UICorner into the object and set it's CornerRadius = number.

Setting it to a `UDim` will set the CornerRadius = UDim.

## aspect_ratio | aspect

Adds a UIAspectRatioConstraint to the object and sets its AspectRatio = number.

## stroke | border

Adds a UIStroke object into the object. Takes in a dictionary table that has these optional values:

- `Thickness` (default=1)
- `Color` (default=black)
- `Transparency` (default=0)
- `ApplyStrokeMode` (default=Enum.ApplyStrokeMode.Contextual)

## padding

Adds a UIPadding object and sets the PaddingLeft/Right/Top/Bottom accordingly:

If it's a number, then all padding directions are set to offset of that number.

If it's a UDim, then all padding directions are set to the UDim.

If it's a dictionary table then:

- `left` | `PaddingLeft` ---> set to PaddingLeft
- `right` | `PaddingRight` ---> set to PaddingRight
- `top` | `PaddingTop` ---> set to PaddingTop
- `bottom` | `PaddingBottom` ---> set to PaddingBottom

---

<!NextPage|Spring>(?Animations/spring)
