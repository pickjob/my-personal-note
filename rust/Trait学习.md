# 重要Trait学习
```rust
// std::sting::ToString
pub trait ToString {
    fn to_string(&self) -> String;
}
// std::fmt::Display
pub trait Display {
    fn fmt(&self, f: &mut Formatter) -> Result<(), Error>;
}
// std::fmt::Debug
pub trait Debug {
    fn fmt(&self, f: &mut Formatter) -> Result<(), Error>;
}
// std::ops::Drop
pub trait Drop {
    // Stuct: Outer -> Inner
    // Variable: second -> first
    fn drop(&mut self);
}
// std::ops::Deref
pub trait Deref {
    type Target: ?Sized;
    fn deref(&self) -> &Self::Target;
}
// std::ops::DerefMut
pub trait DerefMut: Deref {
    fn deref_mut(&mut self) -> &mut Self::Target;
}
// std::ops::FnOnce
pub trait FnOnce<Args> {
    type Output;
    extern "rust-call" fn call_once(self, args: Args) -> Self::Output;
}
// std::ops::FnMut
pub trait FnMut<Args>: FnOnce<Args> {
    extern "rust-call" fn call_once(self, args: Args) -> Self::Output;
}
// std::ops::Fn
pub trait Fn<Args>: FnMut<Args> {
    extern "rust-call" fn call_once(self, args: Args) -> Self::Output;
}
// std::default::Default
pub trait Default {
    fn default() -> Self;
}
// std::clone::Clone
pub trait Clone {
    fn clone(&self) -> Self;
    fn clone_from(&mut self, source: &Self) { ... }
}
// std::convert::AsRef
pub trait AsRef<T> where
    T: ?Sized, {
    fn as_ref(&self) -> &T;
}
// std::convert::AsMut
pub trait AsMut<T> where
    T: ?Sized, {
    fn as_mut(&mut self) -> &mut T;
}
// std::convert::From
pub trait From<T> {
    fn from(T) -> Self;
}
// std::convert::Into
pub trait Into<T> {
    fn into(self) -> T;
}
// std::borrow::Borrow
pub trait Borrow<Borrowed> where
    Borrowed: ?Sized, {
    fn borrow(&self) -> &Borrowed;
}
// std::borrow::BorrowMut
pub trait BorrowMut<Borrowed>: Borrow<Borrowed> where
    Borrowed: ?Sized, {
    fn borrow_mut(&mut self) -> &mut Borrowed;
}
// std::borrow::ToOwned
pub trait ToOwned {
    type Owned: Borrow<Self>;
    fn to_owned(&self) -> Self::Owned;
    fn clone_into(&self, target: &mut Self::Owned) { ... }
}
```