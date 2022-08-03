# 
# Basic
# 
# new project
cargo new [--bin] project_name
cargo new --lib project_name
# target:
#       x86_64-pc-windows-msvc
#       x86_64-pc-windows-gnu
#       x86_64-unknown-linux-gnu
# build
cargo build
cargo build --release
cargo build --target x86_64-pc-windows-gnu
# run
cargo run
cargo run --example example_name --target target_nmae
# updates all dependencies
cargo update
# 
# cargo utils
# 
# Display a tree visualization of a dependency graph
cargo tree
# 
# cargo expand: show macro expansion
# 
cargo install cargo-expand
# Usage
cargo expand
# 
# cargo feature: manage dependency features
# 
cargo install cargo-feature 
# list crate all features
cargo feature crate_name
# enable crate feature
cargo feature crate_name feature
# disable crate feature
cargo feature crate_name ^feature

# 
# cargo utils
# 
#   update installed utils
cargo install cargo-update
cargo install-update -a

# rustup 命令
rustup target list
rustup target add x86_64-pc-windows-gnu
rustup target add x86_64-pc-windows-msvc
rustup [self] update
