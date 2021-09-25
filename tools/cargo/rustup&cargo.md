```sh
rustup target add x86_64-pc-windows-gnu
rustup [self] update

# new project
cargo new [--bin] project_name
cargo new --lib project_name

# build
cargo build
cargo build --release
cargo build --target x86_64-pc-windows-gnu

# run
cargo run
cargo run --example example_name

# updates all dependencies
cargo update

# Display a tree visualization of a dependency graph
cargo tree

# target:
#       x86_64-pc-windows-msvc
#       x86_64-pc-windows-gnu
#       x86_64-unknown-linux-gnu
```
