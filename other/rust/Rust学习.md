# Rust学习
```rust
// prelude
use std::prelude::v1::*;
// 基本数据类型(Sized Type):
//      bool: true / false
//      number:
//          unsigned: u8 u16 u32 u64 u128 
//          signed: i8 i16 i32 i64 i128
//          dynamic: usize isize (4 / 8 bytes)
//          float: f32 f64
//          char
fn main() {
    println!("Hello World", i);
    // println! 格式:
    //      "{}": Display
    //      "{:?}: Debug
    //      "{:#?}": 换行缩进的Debug
    //      "{a}": 命名参数
    //      {:b}: 二进制
    //      "{:0}: 八进制
    //      "{:x}: 十六进制, 小写(X, 大写)
    //      "{:p}: 指针
    //      "{:e}: 科学计数法，小写(E, 大写)
}
// 流程控制
if expr1 {
} else {
}
for var in iterator {
    code
}
while expression {
    code
}
match x {
    0 if expr => expr, // 模式守护
    1..3 => expr,
    n @ 2 => expr, // 重新绑定, varName @ pattern
    ref r => println("{}", r) // 被匹配的引用
    _ => expr, // 默认情况
}
if let Some(y) = x { // 匹配的模式 = 匹配的值
}
while let Some(y) = x { // 匹配的模式 = 匹配的值
}
// 其他数据类型(Dynamic Sized Type / Zero Sized Type):
//      array: [T; N]
let arr: [i32; 3] = [1, 2, 3];
for i in 1..5 {
    println!("{}", i); // 1, 2, 3, 4
}
for i in 1 ..= 5 {
    println!("{}", i); // 1, 2, 3, 4, 5
}
//      slice: &[T] &mut[T]     len is_empty
let arr = &mut [1, 2, 3];
arr[1] = 7
//      str:    不可变长度字符串
//      string: 可变长度字符串
//      truple: (T, U, M, N)
let truth: &'static str = "Rust 是一门优雅的语言";
// struct
struct People {
    name: &'static str,
    gender: u32
}
struct Color(i32, i32, i32);
struct Empty;
// enum
enum Number {
    Zero,
    One,
    Two,
}
// 常见集合
//      Vec<T>: 动态可增长
//      VecDeque<T>: FIFO双端队列
//      LinkedList<T>: 双向链表
//      BinaryHeap<T>: 优先队列
//      HashMap<K, V>: 无序K-V集合
//      BtreeMap<K, V>: 基于BTree有序映射, 按Key排序
//      HaseSet<T>
//      BtreeSet<T>

// 智能指针(内部可变性)
//      Box<T>: 在堆中创建对象, 允许未知大小对象
//      Rc<T>: 引用计数, 允许引用同一块内存, 引用对象不可变
//      Arc<T>: RC<T>线程安全版本
//      Cell<T> / RefCell<T>: 外部看是不变的,内部对象可变
//      Weak<T>
//      Metux<T>: 互斥锁, 只有一个线程能拥有锁
//      Cow<T>: Copy on write 以不可变的方式访问借用内容,需要可变借用或所有权时再克隆
//      RwLock<T>: 读写锁

// maker trait:
//      Sized
//      Unsize
//      ?Sized: Sized + Unsized
//      Copy: 可复制, 对象需实现 Clone 来实现对象复制语义
//      Send: 跨线程传递所有权 不安全 !Send
//      Sync: 款线程传递共享引用 不安全 !Sync
```