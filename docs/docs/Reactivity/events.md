[header: Reactivity]

# Events

Using the `Hook` function, you can bind `RBXScriptSignal` connections to an object.

```luau
local Hook = Quark.Hook
```

In other words, connect to an event using `Hook` followed by the name of the event, and the callback function you want to connect to it.

```luau
New "TextButton" {
	Text = "Hello",

	Hook("Activated", function(self)
		print("I was clicked!")
	end)
}
```

-# When the button is pressed it will print "I was clicked!"

---

## Event Properties

You can see the `self` keyword in the function parameters in the example above. This is useful in cases where you want to alter the `New` object without having to make a separate variable for it.

Just like when you normally connect to an event:

```luau
Frame.InputBegan:Connect(function(...)
	print(Frame.Name)
end)
```

The same can be done using:

```luau
Hook("InputBegan", function(self, ...)
	print(self.Name)
end)
```

---

<details>

<summary>Quark events (pre v0.0.15)</summary>

In versions before `v0.0.15`, one was able to simply set a property to a function to connect the event:

```luau
New "TextButton" {
	Activated = function(self)

	end
}
```

This has been discontinued due to *Function Properties*.

</details>

---

<!NextPage|State>(#Reactivity/state)
