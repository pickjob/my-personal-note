# futures学习
```rust
use futures::executor::block_on;
use futures::join;

let a = async { 1 };
let b = async { 2 };

block_on!(a())
assert_eq!(join!(a, b), (1, 2));
```