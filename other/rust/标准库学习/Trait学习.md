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
//      FnOnce: 捕获环境自由变量所有权 (self)
//      FnMut: 可变方式借用环境自由变量 (&mut T)
//      Fn: 不可变方式借用环境自由变量 (&T)
//      where F: FnOnce(arg1: type1, ...) -> R
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

// Function: std::mem::drop(): 释放实现了Drop Trait对象
// std::ops::Drop: 析构逻辑处理, 不要手动调用
pub trait Drop {
    fn drop(&mut self);
}

// 解引用 *type, 编译器自动解引用 &&ref ==> &ref
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

// Copy: 实现COPY语义, 一定要同步实现Clone
// #[derive(Debug, Copy, Clone)]
// std::clone::Clone
pub trait Clone {
    fn clone(&self) -> Self;
    fn clone_from(&mut self, source: &Self) { ... }
}
// std::marker::Copy
pub trait Copy: Clone { }

// 类型转换:
// std::sting::ToString
pub trait ToString {
    fn to_string(&self) -> String;
}
// std::str::FromStr: 实现FromStr即可调用 "".parse::<T>()
pub trait FromStr {
    type Err;
    fn from_str(s: &str) -> Result<Self, Self::Err>;
}
// std::convert::From <==> std::convert::Into
// From / Into: Type A <==> Type B: From 和 Into 相同操作只需实现一个实现两个方法
pub trait From<T> {
    fn from(T) -> Self;
}
pub trait Into<T> {
    fn into(self) -> T;
}

// AsRef / AsMut: 一类可得到引用接口
// std::convert::AsRef
// std::convert::AsMut
pub trait AsRef<T> where T: ?Sized, {
    fn as_ref(&self) -> &T;
}
pub trait AsMut<T> where T: ?Sized, {
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
pub trait Add<Rhs = Self> {
    type Output;
    fn add(self, rhs: Rhs) -> Self::Output;
}

// 索引操作:
//      std::ops::Index
//      std::ops::IndexMut
pub trait Index<Idx> where Idx: ?Sized, {
    type Output: ?Sized;
    fn index(&self, index: Idx) -> &Self::Output;
}
pub trait IndexMut<Idx>: Index<Idx> where Idx: ?Sized, {
    fn index_mut(&mut self, index: Idx) -> &mut Self::Output;
}
```