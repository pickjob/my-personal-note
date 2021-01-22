# 重要Enum学习
```rust
// std::result::Result
pub enum Result<T, E> {
   Ok(T),
   Err(E),
}
// std::option::Option
pub enum Option<T> {
    None,
    Some(T),
}


// 用法
if let Ok(val) = result {
    ...
}
match result {
    Ok(val) => ...,
    Err(err) => ...,
}
```