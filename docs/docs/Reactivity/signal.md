[header: Reactivity]
Tab testing, `Signal.md` is incomplete!

<div class="tab_holder" code_only>
<tab name = "Python" active="yes">

```py
import random
print(random.randint(1, 5))
```

</tab>

<tab name = "Rust">

```rust
use rand::prelude::*;

fn main() {
 // Get an RNG:
 let mut rng = rand::rng();

 println!("Random value: {}", rng.random_range(1..=5));
}
```

</tab>
</div>

<div class="tab_holder">
<tab name="Tab1" active="yes">
Hello World
</tab>
<tab name="Tab2">
Foo Bar
</tab>
<tab name="Tab3">
You just opened Tab 3
</tab>
<tab name="Tab4">
This extremely cool:

```luau
print("hello world")
```

haha yes
</tab>
<tab name="lipsum">
Lorem ipsum dolor sit amet omg no way.
</tab>

</div>

<div class="tab_holder" title="sigma" code_only>

<tab name="luau" active="yes">

```lua
print("Hello world")
```

</tab>
<tab name="Roblox-TS">

```ts
console.log("Hello world");
```

</tab>

</div>

<div class="tab_holder" title="I can now name these things">
<tab hide name="luau" active="yes">
Hello World
</tab>
</div>

> Hello world
