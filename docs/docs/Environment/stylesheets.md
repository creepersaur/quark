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
