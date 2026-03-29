[header: Instances]

# Premade Instances

If you have any UI or Instances that already exist and want to use them with Quark, you have two options:
- You can refer to [GUI to Quark Plugin](?GettingStarted/gui_to_quark_plugin) to convert your existing GUIs to Quark
- You can use `New(Instance)` to wrap an existing instance inside a `New` object.

```luau
local New = Quark.New
local PremadeFrame = script.Parent.Frame

local Wrapped = New(PremadeFrame)
```

calling `:Cleanup()` on the wrapped New will Destroy the PremadeFrame and disconnect any Quark-connections.

> <note>
>
> Note that most of the time you won't use this and it is unnecessary.
>
> </note>

Calling the wrapped New with a table will let you set properties of the instance.

```luau
local object = New(PremadeFrame) {
	BackgroundColor3 = Color3.new(1),
	
	children = New "UIPadding"
}
-- CHILDREN ARE ONLY ADDED, NOT SET.
```

---

<!NextPage|Events>(?Reactivity/events)
