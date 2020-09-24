# tokio学习
```rust
#[tokio::main]
async fn main() -> Result<(), Box<dyn Error + Send + Sync>> {
    let handle = tokio::spawn(async {
        // Do some async work
        "return value"
    });

    // Do some other work
    let out = handle.await.unwrap();
    println!("GOT {}", out);
}
// equals =====>
fn main() {
    let mut rt = tokio::runtime::Runtime::new().unwrap();
    rt.block_on(async {
        println!("hello");
    });
}
```