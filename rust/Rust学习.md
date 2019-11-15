# Rust学习
```rust
// 基本数据类型:
//      bool: true / false
//      number:
//          unsigned: u8 u16 u32 u64 u128 
//          signed: i8 i16 i32 i64 i128
//          dynamic: usize isize (4 / 8 bytes)
//          float: f32 f64
//          char
fn main() {
    println!("Hello World", i);
}
// 流程控制
if expr1 {
} else {
}
if let Some(y) = x { // if let => match
} else {
}
for var in iterator {
    code
}
while expression {
    code
}
// 其他数据类型:
//      array: [T: N]
let arr: [i32; 3] = [1, 2, 3];
for i in (1 .. 5) {
    println!("{}", i); // 1, 2, 3, 4
}
for i in (1 ..= 5) {
    println!("{}", i); // 1, 2, 3, 4, 5
}
//      slice: &[T] &mut[T]
let arr = &mut [1, 2, 3];
arr[1] = 7
//      str:    不可变长度字符串
//      string: 可变长度字符串
//      truple: (T, U, M, N)
let truth: &'static str = "Rust 是一门优雅的语言";
// struct:
struct People {
    name: &'static str,
    gender: u32
}
//      enum
enum Number {
    Zero,
    One,
    Two
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
let mut v1 = vec![];
v1.push(1);
let mut v2 = Vec::new();
let mut buf = VecDeque::new();
buf.push_front(1);
let mut hmap = HashMap::new();
let mut bmap = BTreeMap::new();
// trait标签:
//      Sized  另一种写法 ?Sized
//      Unsize
//      Copy
//      Send : 跨线程传递所有权 不安全 !Send
//      Sync : 款线程传递共享引用 不安全 !Sync
#[lang = "sized"]
pub trait Sized {
}
#[lang = "copy"]
pub trait Copy : Clone {
}
#[Derive(Copy, Clone)]
struct MyStruct;
```