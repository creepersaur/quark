##### New

# Creating Instances

The `New()` function of Quark allows you to pass in the name or Instance and returns a `New` object.

```luau
-- You don't have to wrap strings in parenthesis
New "TextLabel"
```

`New` objects are what most of your UI will consist of. Consider them the instances that you'd regularly make UI out of.

>Some methods, functions, etc. require you to have an `Instance` object directly. Passing in a `New` object wont work in those cases.
>
>If you want the **actual Instance** that the New object wraps around you can use `.Object` to get the object.

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

One may also use the `children` custom property to add children (Which is the best way to add children.)

---

<!NextPage|Properties and Methods>(#New/properties_and_methods)
