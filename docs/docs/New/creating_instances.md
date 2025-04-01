##### New

# Creating Instances

The `New()` function of Quark allows you to pass in the name or Instance and returns a `New` object.

```luau
-- You don't have to wrap strings in parenthesis
New "TextLabel"
```

`New` objects are what most of your UI will consist of. Consider them the instances that you'd regularly make UI out of.

> <note>
>
>Some methods, functions, etc. require you to have an `Instance` object directly. Passing in a `New` object wont work in those cases.
>
>If you want the **actual Instance** that the New object wraps around you can use `.Object` property to get the object.
> </note>

They act almost the same as normal Instances. You can get properties and call methods on them:

```luau
local Quark = require(game.ReplicatedStorage.Quark)
local New = Quark.New

-- Make a TextButton
local x = New "TextButton"

-- Change properties and call methods
x.Text = "Hello world"
x:Destroy()
```

> <warning>
>
> **NOTE:** All UI objects are sized `{0,0,0,0}` by default. They will **not be shown** unless you set their size explicitly.
> </warning>

---

## Adding Children

You can add children by calling these methods:

- `Push()`

Used to push a single object as a child.

```luau
x:Push(New "UICorner")
```

- `PushChildren()`

Used to push multiple objects (a table of objects) as children.

```luau
x:PushChildren({
	New "UICorner",
	New "UIAspectRatioConstraint",
	...
})
```

- `children` custom property

This is the **best way** to add children into a New object. You can use it for making tree-like structures which store all the UI in an ordered manner. It also supports *dictionaries/arrays/and single new objects*.

```luau
New "Frame" {
	children = {
		New "TextLabel",
		New "UICorner",
	}
}
```

---

## Types

##### (Optional)

If you want some type checking on `New`, it's basically `New<Instance>` by default. All properties/methods of Instance are shown. If you want to change this, you can do

```luau
type New<T> = Quark.New<T>

local x: New<Frame> = New "Frame" {
	...
}
```

Which will give you type checking for `Frame`. (Type checking may be bugged sometimes but usually you don't have to use it.)

All Instance names and properties of every instance are in the autocomplete for `New`. So you can see all the different properties and events. This makes it faster to write.

---

<!NextPage|Properties and Methods>(#New/properties_and_methods)
