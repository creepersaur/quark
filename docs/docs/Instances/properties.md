[header: Instances]

# Properties

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

## Function Properties

Setting a property to a function will run the function and set the property to the returned value.

```luau
New "TextLabel" {
	Text = function()
		return "Hello"
	end,
}
```

In the above example, the `Text` becomes `"Hello"`. Useful in cases where you have to write code for a property, but don't want to create variables that take up space in the whole scope.

---

## Using Quark Objects as Properties

If you create a `State` or `Animation` object, you can reference those as the values and it'll set the property on update.

---

<!NextPage|Properties and Methods>(#New/custom_properties)
