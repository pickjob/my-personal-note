# hyper学习
```rust
use hyper::{Body, Method, Request, Client};
use hyper::client::HttpConnector;
use hyper::body;
use std::error::Error;
use bytes::buf::BufExt as _;
use std::io::Read as _;

async fn post_req(client: &Client<HttpConnector, Body>) -> Result<(), Box<dyn Error + Send + Sync>> {
    let client = Client::new();
    let req = Request::builder()
            .method(Method::POST)
            .version(Version::HTTP_2)
            .uri("http://httpbin.org/post")
            .header("content-type", "application/json")
            .body(Body::from(r#"{"library":"hyper"}"#))?;
    println!("url: {:?}", req.uri());
    let resp = client.request(req).await?;
    println!("code: {:?}, reason: {:?}", resp.status().as_u16(), resp.status().as_str());
    println!("version: {:?}", resp.version());
    println!("headers: {:?}", resp.headers());
    let body = body::aggregate(resp).await?;
    let mut resp_body = String::new();
    body.reader().read_to_string(&mut resp_body)?;
    println!("respBody: {:?}", resp_body);
    Ok(())
}
```
