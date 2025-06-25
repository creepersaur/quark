[header: Instances]

# Creating Instances

Consider `New` objects as the instances your UI is made of.
They wrap actual Instances in an Object Oriented fashion.
Pass the ClassName of the Instance to create in the `New()` function.

```luau
local New = Quark.New

-- Make a TextButton
local x = New "TextButton"

-- Change properties and call methods
x.Text = "Hello world"
x:Destroy()
```

> If you want to pass in the **actual instance** to a method, use the `.Object` property.

> <note>
>
> All UI objects have default properties applied to them to show them correctly. (e.g. Size changes and removing the border).
> </note>

---

## Adding Children

You can add children by calling these methods:

- `Push()`
- `PushChildren()`
- `children` custom property

```luau
-- push a single object as a child.
x:Push(New "UICorner")

-- push multiple objects (a table of objects).
x:PushChildren({
	New "UICorner",
	New "UIAspectRatioConstraint",
	...
})
```

This is the **best way** to add children into a New object. Most UI is in the form of tree-like structures.

```luau
New "Frame" {
	Property = value,

	children = {
		New "TextLabel",
		New "UICorner",
	}
}
```

---

## Connecting to Events

Learn more about connecting to instance events and `RBXScriptSignals` on the [Events](?Reactivity/events) page. Read it later though.

---

## Types

##### (Optional)

You can use the built-in `New<Instance>` type or type-casting to get Instance method/property autocomplete.

<details>
<summary> Method 1 </summary>

```luau
-- Load the type from the Quark Module
type New<T> = Quark.New<T>

local x: New<Frame> = New "Frame" {
	...
}
```

</details>

<details>
<summary> Method 2 </summary>

Cast the type of the name:

```luau
--! NOT RECOMMENDED, MAY NOT WORK.
-- (Editor may warn you about type casting.)
local x = New ("Frame" :: Frame) {
	...
}
```

</details>

> <note>
>
> Instance/Property autocomplete exist for the `New()` function.
>
> ![_](assets/screenshots/PropertyAutocomplete.png)
> </note>

---

<!NextPage|Properties>(?Instances/properties)
