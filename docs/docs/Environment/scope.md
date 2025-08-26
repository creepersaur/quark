[header: Environment]

# Scopes

A `Scope` in Quark is an **isolated environment** that allows you to create and manage elements with their own memory. Scopes help organize parts of your UI, especially when working across multiple scripts or modules.

```luau
local Scope = Quark.Scope()
```

Think of scopes as branches in a tree — each can have child scopes, and cleaning up a parent scope will automatically clean up all its children. This makes cleanup simple and consistent across your project.

![Branches](assets/screenshots/branches.png)

---

## The Main Scope

All scopes start with the `MAIN` scope. This is just Quark itself.

```luau
-- `Quark` is the MAIN scope
local Quark = require("path to Quark")
```

---

## Creating Scopes

Create scopes using the `Scope()` function.

```luau
local Quark = require("path to Quark")
local Scope1 = Quark.Scope()
local Scope2 = Quark.Scope()
```

Scope1 and Scope2 are independent children of the main scope. Cleaning up the main `Quark` scope will remove both.

---

## Secondary Scopes

Call the `Scope()` function on a pre-existing scope to create a secondary scope, and so on.

```luau
local Scope1 = Quark.Scope()
local Scope2 = Quark.Scope()

-- Creating secondary scopes:
local Sec1 = Scope1.Scope()
local Sec2 = Scope1.Scope()
```

`Sec1` and `Sec2` are both secondary scopes of `Scope1`. When Scope1 is cleaned up, they will get cleaned up too. However, Scope2 and its descendants will not get cleaned up.

You can have any number of scope descendants.

---

## Cleaning Up (Deleting) Scopes

Calling the `Cleanup()` function on a Scope, or Quark itself (the main scope) clears all instances created by Quark and disconnects Quark-managed connections.

```luau
MyScope.Cleanup()
```

If you wanted to clean up Quark entirely (e.g., when using storybook plugins) use:

```luau
Quark.Cleanup()
```

> <warning>
>
> **Any ex-Quark connections or objects will not be disconnected / deleted.**
>
> Especially important to know when creating UI using storybook plugins as they do not disconnect or destroy all created instances unless explicitly deleted.
>
> Please read the next topic "**Connecting to Cleanup**" to help solve this issue.
> </warning>

---

## Connecting to Cleanup

Quark and Scopes have an `OnCleanup` method which allows you to bind a function(s) to either run before, or after cleanup has taken place.

```luau
Quark.OnCleanup(function, runBeforeCleanup: boolean?)
```

If `runBeforeCleanup` is set to *true*, then the function will be queued for before Cleanup (before all Quark connections/instances/etc. are deleted). Otherwise it will run after all of them have been deleted.

This is good for Stories/Storybooks since they will not disconnect or destroy any ex-Quark objects. You will have to manually Destroy/Disconnect them in the function.

```luau
-- true => runBeforeCleanup
Quark.OnCleanup(function()
	print("Quark will clean up after this function.")
end, true)

-- nil / false => runAfterCleanup
Quark.OnCleanup(function()
	print("Quark has been cleaned up")
end)
```

---

# Example

If I were to create 5 buttons which may need to be deleted later, or are made in a separate script, I would use a `Scope` that contains everything related to them.

### Main Script

```luau
local Quark = require("path to Quark")
local ButtonsModule = require(script.ButtonsModule)

local ButtonScope = Quark.Scope()
ButtonsModule.CreateButtons(ButtonScope)
```

### ButtonsModule

```luau
local ButtonsModule = {}

function ButtonsModule.CreateButtons(Scope)
	local New = Scope.New

	for i = 1, 5 do
		New "TextButton" { ... }
	end
end

return ButtonsModule
```

---

# Types

Scopes are typed as `Quark.Scope` or `Quark.Quark` (They're the same mostly).

However, in separate scripts or modules you won't have access to the original Quark module's types (no way to pass them in).
You *can* require the Quark module in this case, just for type inference:

```luau
-- Just for typing, doesn't affect scope hierarchy
local _Q = require("path to Quark")

function Something(Scope: _Q.Scope)
	-- Now you'll have type autocomplete
end
```

---

<!NextPage|Stylesheets>(?Environment/stylesheets)
