# Sentinel学习
```java
// ttry-with-resources
// 资源名可使用任意有业务语义的字符串，比如方法名、接口名或其它可唯一标识的字符串。
try (Entry entry = SphU.entry("resourceName")) {
  // 被保护的业务逻辑
  // do something here...
} catch (BlockException ex) {
  // 资源访问阻止，被限流或被降级
  // 在此处进行相应的处理操作
}

// if-else
// 资源名可使用任意有业务语义的字符串
if (SphO.entry("自定义资源名")) {
  // 务必保证finally会被执行
  try {
    /**
    * 被保护的业务逻辑
    */
  } finally {
    SphO.exit();
  }
} else {
  // 资源访问阻止，被限流或被降级
  // 进行相应的处理操作
}

// annotation
@SentinelResource(blockHandler = "blockHandlerForGetUser")

```
- FlowRule
    - resource: 资源名
    - count: 限流阈值
    - grade: 1-QPS 0-并发线程
    - limitApp: 针对调用来源
    - strategy: 直接、链路、关联
    - controlBehavior: 流控效果  直接拒绝 / WarmUp / 匀速 + 排队等待
    - clusterMode
- ParamFlowRule
    - resource: 资源名
    - count: 限流阈值
    - grade: 1-QPS 0-并发线程
    - durationInSec: 统计窗口时间长度
    - controlBehavior: 留空效果 快速失败 匀速排队
    - maxQueueingTimeMs: 最大排队等待时长
    - paramIdx: 热点参数索引
    - paramFlowitemList
    - clusterMode
    - clusterConfig
- DegradeRule
    - resource: 资源名
    - grade: 熔断策略  慢调用比例 、异常比例、异常数
    - count: 慢调用: 临界值  异常比例 、 异常数: 阈值
    - timeWindow: 熔断时长 s
    - minRequestAmount: 触发最小请求数
    - statIntervalMs: 统计时长 ms
    - slowRatioThreshold: 慢调用比例阈值
- SystemRule
    - highestSystemLoad
    - avgRt
    - maxThread
    - qps
    - highestCpuUsage
- AuthorityRule
    - resource
    - limitApp
    - stratey: AUTHORITY_WHITE AUTHORITY_BLACK
- ParamFlowRule
- Restful
    - curl http://localhost:8719/cnode?id=<资源名称>