##### New

# Properties and Methods

We've learned from the previous tutorial how to make instances using the `New` object. You can actually call the New object as many times as you want and supply a table as the first argument.

This table serves as a dictionary of all properties and values we want to assign.

For example:

```luau
local x = New("Instance")

x({
	PROPERTY = value
})
```

Although that gets annoying syntactically. A simpler approach is to directly write the table and string without the extra parenthesis:

```luau
local x = New "Instance" {
	PROPERTY = value
}
```

> <note>
>
> Calling an object multiple times with a table will set the properties again and again.
>
> *(This does not apply to the `children` custom property).*
> </note>

```luau
local x = New "Part" {
	Parent = workspace,
	Size = Vector3.new(2, 1, 4)
}

-- Calling `x` again to set properties
x {
	Position = Vector3.new(0, 5, 0)
}
```

---

## Types of Properties

Properties can be of different types

- **Instance properties** (belonging to the instance)
- **Methods** (shorthand event connection syntax)
- **Custom Properties** (those belonging to Quark)

---

## Instance properties

If you have any Instance, then the base properties that you regularly use for that object always apply:

```luau
New "TextLabel" {
	Parent = ...,   -- Parent is a property of all instances
	Text = "Hello", -- Text is a property of TextLabel
}
```

---

## Methods

Usually, an event connection consists of

```luau
Instance.Event:Connect(function(...))
```

But that gets long fast. Quark handles this by automatically calling `:Connect` on the event and passing in the function. All you need is the event name and function you want to connect.

```luau
New "TextButton" {
	-- Activated fires when you click
	Activated = function(self, ...)
		print("The button was clicked")
	end,
}
```

Wait! The **function parameters** look different. What's this `self` parameter?

The self parameter is always defined as the first argument. This is the `New` object itself. To avoid having to predefine the `New` object, we just reference it as the first parameter.

```luau
-- The button will get deleted when you click
New "TextButton" {
	Size = UDim2.fromOffset(200, 50),
	
	Activated = function(self)
		self:Destroy()
	end,
}
```

All parameters returned by the Event are in the `...`. Just use them normally after defining self:

```luau
New "Frame" {
	InputBegan = function(self, input: InputObject)
		print(input.KeyCode.Name .. " was pressed.")
	end,
}
```

We'll talk about custom properties in the next page.

---

## Using Quark Objects as Properties

We can use Quark's objects as properties.

`State` and `Animation` objects will automatically set the properties values when they update. In other words

- When a `State` updates, the property attached will update to the value.
- When an animation object updates (each frame), the property updates to the current value.

---

<!NextPage|Properties and Methods>(#New/custom_properties)
