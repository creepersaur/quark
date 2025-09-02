# Stories

For all those who don't know what a story is:

> Stories are ModuleScripts that ends with `.story` in their name.

They're really good for prototyping UI elements and quickly creating reactive UI. **You don't have to play the game to test UI**.

For showing stories, you need to have a storybook plugin.
My Favorite is [UI Labs](https://pepeeltoro41.github.io/ui-labs/).

![UI labs screenshot](assets/screenshots/ui_labs.png)

---

## Creating Basic stories

Make a `test.story` ModuleScript in StarterGui. This should show up in your story plugin on the left (usually).

A story is a function, which has a `parent` parameter. It also takes a cleanup function to destroy all the UI elements that were made when closing the story.
This is how stories generally look:

```luau
return function(parent: Instance)
    -- UI STUFF HERE

    return function()
        -- CLEANUP
    end
end
```

---

# Stories with Quark

Use Quark to create a story and set the `Parent` property to the parent parameter.

## Using `CreateStory()`

Automatically stories using the `CreateStory()` function and pass in a function as a parameter. The return-value of the function will be parented to the target. (The function also takes the target parameter if required).

∵ Cleanup is automatically returned when using CreateStory.

**MAKE SURE TO RETURN THE VALUE OF THE METHOD.**

```luau
local Quark = require(game.ReplicatedStorage.Quark)
local New = Quark.New

return Quark.CreateStory(function(_target)
	return New "Frame" {
		Color = Color3.new(1, 0, 0)
	}
end)
```

---

## Using General stories

You will have to manually parent the instances to the target and also manually return cleanup or a function that deletes ex-Quark connections and cleans up at the same time.

```luau
local Quark = require(game.ReplicatedStorage.Quark)
local New = Quark.New

return function(target: Instance)
    New "Frame" {
        Parent = target,
        Color = Color3.new(1, 0, 0)
    }

    -- Cleanup everything that was made
    return Quark.Cleanup
end
```

---

# Examples

There are many examples given in the [examples](https://github.com/creepersaur/quark/tree/master/src/examples/Stories) folder on the repo.

---

<!NextPage|Advanced Stories>(?Stories/advanced_stories)
