# 重要Enum学习
```rust
// std::result::Result
enum Result<T, E> {
   Ok(T),
   Err(E),
}
// std::option::Option
pub enum Option<T> {
    None,
    Some(T),
}
```