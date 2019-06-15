# Rust学习
- toolchain
  ```bash
  # rustup
  curl https://sh.rustup.rs -sSf | sh
  rustup component add rls rust-analysis rust-src rustfmt
  rustup update
  rustup self uninstall
  # cargo
  cargo new project_name --bin/--lib
  cargo build --release
  cargo run / clean / update / init
  ```