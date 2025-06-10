[header: Instances]

# Custom Properties

Quark has custom properties (lowercase) which are not in normal instances.

| Property | Description                                            |
| -------- | ------------------------------------------------------ |
| `children` | Table of New objects to parent (append) as children.            |
| `class`    | Space-separated string of class names for Stylesheets. |
| `style` | Stylesheet object to link the styles. |

---

## <hidden>children</hidden>

- ### `children` <#table <‎Instances>|crimson>

Add new children to an object. Does not remove previous ones when calling multiple times.

You can also set it to a `New` object.

```luau
local label = New "TextLabel" {
	children = {
		New "UICorner",
		New "UIAspectRatioConstraint"
	}
}

label {
	children = New "UIStroke"
}
```

---

## <hidden>class</hidden>

- ### `class` <#string|dodgerblue>

Set the class of an object. Used with Stylesheets.
One can have multiple classes by adding spaces in the `class` string.

-# The example below implies that you have Big and Red styles

```luau
New "TextButton" {
	class = "Big Red"
}
```

---

## <hidden>style</hidden>

- ### `style` <#Stylesheet|rgb(55, 143, 102)>

Set the stylesheet to be used by objects. Must be a stylesheet object.
`class` implies that `style` is set.

```luau
local my_style = StyleSheet "Name" { ... }

New "TextButton" {
	style = my_style,
	class = 'some_class' -- `class` IS OPTIONAL
}
```

---

<!NextPage|Premade Instances>(?Instances/premade_instances)
