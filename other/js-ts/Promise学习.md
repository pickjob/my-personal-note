# Promise学习
- 约定
    - 在本轮 事件循环 运行完成之前，回调函数是不会被调用的
    - 即使异步操作已经完成（成功或失败），在这之后通过 then() 添加的回调函数也会被调用
    - 通过多次调用 then() 可以添加多个回调函数，它们会按照插入顺序进行执行
- 一个 Promise 必然处于以下几种状态之一:
    - 待定(pending): 初始状态，既没有被兑现，也没有被拒绝
    - 已兑现(fulfilled): 意味着操作成功完成
    - 已拒绝(rejected): 意味着操作失败
- prototype method
    - constructor
    - then
    - catch
    - finally
    ```javascript
    // 构造函数
    // executor = (resolve, reject) => {}
    new Promise(executor)
    // then
    p.then(onFulfilled[, onRejected]);
    p.then(value => {
        // fulfillment
    }, reason => {
        // rejection
    });
    // catch
    p.catch(onRejected);
    p.catch(function(reason) {
        // 拒绝
    });
    // finally
    p.finally(onFinally);
    p.finally(function() {
        // 返回状态为(resolved 或 rejected)
    });
    ```
- static method
    - Promise.all(iterable) / Promise.allSettled(iterable) / Promise.any(iterable) / Promise.race(iterable)
    - Promise.reject(reason) / Promise.resolve(value) 