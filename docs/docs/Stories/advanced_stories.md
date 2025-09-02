# Advanced Stories

Advanced stories are used for parameters and custom features that UI Labs (or plugin of choice) might give.

This all depends on the plugin, but I suggest reading up on how to make stuff like this on UILabs' [Documentation](https://pepeeltoro41.github.io/ui-labs/docs/stories/advanced/generic.html). (Quark uses what UI Labs calls generic stories.)

Here's just a simple advanced story:

```lua
return {
    controls = nil, -- Add controls
    render = function(props) -- the main story function (like before)
        local parent = props.target -- the parent is now `props.target`

        -- UI stuff

        return Quark.Cleanup -- CLEANUP
    end
}
```

As of now Quark doesn't have a method to automatically make an advanced story. But there are examples in the [examples](https://github.com/creepersaur/quark/tree/master/src/examples/Stories) folder in the repo.
