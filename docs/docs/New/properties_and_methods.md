# Properties and Methods

Call a `New` object using a table to set properties and method callbacks that exist on the object you're creating.

You can call it as many times as you want to set them. (`children` custom property will only append the children though.)

```luau
local MyLabel = New "ImageLabel" {
	Parent = script.Parent,
	Size = UDim2.fromOffset(200, 200)
}

MyLabel {
	Position = UDim2.new(0.5, 0, 0.5, 0)
}
```

---

## Methods

Usually, an event connection consists of

```luau
Instance.Event:Connect(function(...))
```

You can give the Event name as the key, and callback function as value.

The default connection parameters come after `self` which is a reference to the `New` object.

```luau
New "TextButton" {
	Activated = function(self, ...)
		print("The button was clicked")
	end,

	InputBegan = function(self, input: InputObject)
		print(input.KeyCode.Name .. " was pressed.")
	end,
}
```

---

## Using Quark Objects as Properties

If you create a `State` or `Animation` object, you can reference those as the values and it'll set the property on update.

---

<!NextPage|Properties and Methods>(#New/custom_properties)
