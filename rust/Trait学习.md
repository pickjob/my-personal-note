# 重要Trait学习
```rust
// Display: "{}"
// Debug: "{:?}" "{:#?}"
// std::fmt::Display
pub trait Display {
    fn fmt(&self, f: &mut Formatter) -> Result<(), Error>;
}
// std::fmt::Debug
pub trait Debug {
    fn fmt(&self, f: &mut Formatter) -> Result<(), Error>;
}

// 函数申明
//      FnOnce: 获得值 (T)
//      FnMut: 获得可变引用 (&mut T)
//      Fn: 获得引用 (&T)
//      where FnOnce(arg1: type1, ...) -> R
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

// 内存删除 drop(something)
// std::ops::Drop
pub trait Drop {
    // Stuct: Outer -> Inner
    // Variable: second -> first
    fn drop(&mut self);
}

// 解引用 *type
// std::ops::Deref
pub trait Deref {
    type Target: ?Sized;
    fn deref(&self) -> &Self::Target;
}
// std::ops::DerefMut
pub trait DerefMut: Deref {
    fn deref_mut(&mut self) -> &mut Self::Target;
}

// 默认构造
// std::default::Default
pub trait Default {
    fn default() -> Self;
}

// Clone 需显示调用
// Copy 赋值可以复制值
// #[derive(Debug, Copy, Clone)]
// std::clone::Clone
pub trait Clone {
    fn clone(&self) -> Self;
    fn clone_from(&mut self, source: &Self) { ... }
}
// std::marker::Copy
pub trait Copy: Clone { }

// 类型转换:
//      ToString / FromStr: Type T <==> String ( T.to_string() <==> "".parse::<T>() )
//      From / Into: Type A <==> Type B
//      AsRef / AsMut: [mut] ref Type A <==> [mut] ref Type B
//      Borrow / BorrowMut / ToOwned: 获得引用(所有)
// std::sting::ToString
pub trait ToString {
    fn to_string(&self) -> String;
}
// std::str::FromStr
pub trait FromStr {
    type Err;
    fn from_str(s: &str) -> Result<Self, Self::Err>;
}
// std::convert::From
pub trait From<T> {
    fn from(T) -> Self;
}
// std::convert::Into
pub trait Into<T> {
    fn into(self) -> T;
}
// std::convert::AsRef
pub trait AsRef<T> where T: ?Sized, {
    fn as_ref(&self) -> &T;
}
// std::convert::AsMut
pub trait AsMut<T> where
    T: ?Sized, {
    fn as_mut(&mut self) -> &mut T;
}
// std::borrow::Borrow
pub trait Borrow<Borrowed> where Borrowed: ?Sized, {
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

// 操作符重载
//      std::ops::Add: operator +
//      std::ops::Sub: operator -
//      std::ops::Mul: operator *
//      std::ops::Div: operator /
//      ...
```