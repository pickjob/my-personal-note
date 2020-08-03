# Spring Cloud学习
- 服务发现 / 配置中心
    - Eureka
        - Eureka Server
            - http://localhost:8761/
            - http://localhost:8761/eureka/apps
            - @EnableEurekaServer
            ```yml
            # server
            spring:
                application:
                    name: eureka-server
            eureka:
                instance:
                    hostname: localhost
                    status-page-url: http://${spring.cloud.client.ipAddress}:${server.port}/swagger-ui.html
                server:
                    enableSelfPreservation: false
                    evictionIntervalTimerInMs: 4000
                client:
                    register-with-eureka: false
                    fetch-registry: false
            # client
            eureka:
                instance:
                    prefer-ip-address: true
                    leaseRenewalIntervalInSeconds: 10
                    leaseExpirationDurationInSeconds: 30
                client:
                    service-url:
                        defaultZone: http://yinjihuan:123456@master:8761/eureka/
            ```
            ```java
            @Component
            public class EurekaStateChangeListener {
                @EventListener
                public void listen(EurekaInstanceCanceledEvent event) {
                    System.err.println(event.getServerId() + "\t" + event.getAppName() + " 服务下线");
                }
                @EventListener
                public void listen(EurekaInstanceRegisteredEvent event) {
                    InstanceInfo instanceInfo = event.getInstanceInfo();
                    System.err.println(instanceInfo.getAppName() + "进行注册");
                }
                @EventListener
                public void listen(EurekaInstanceRenewedEvent event) {
                    System.err.println(event.getServerId() + "\t" + event.getAppName() + " 服务进行续约");
                }
                @EventListener
                public void listen(EurekaRegistryAvailableEvent event) {
                    System.err.println("注册中心 启动");
                }
                @EventListener
                public void listen(EurekaServerStartedEvent event) {
                    System.err.println("Eureka Server 启动");
                }
            }
            ```
        - Eureka Client
    - Consul
        - http://localhost:8500
    - Spring Cloud Config
    - Nacos
    - zk
    - etcd
- 负载均衡
    - Ribbon
    ```yml
    # spring retry
    # hystrix的超时时间必须大于ribbon的超时时间
    hystrix.command.default.execution.isolation.thread.timeoutInMilliseconds=10000
    # 开启重试
    zuul.retryable=true
    spring.cloud.loadbalancer.retry.enabled=true
     # 请求连接的超时时间
    ribbon.connectTimeout=2000
    # 请求处理的超时时间
    ribbon.readTimeout=5000
    # 对当前实例的重试次数
    ribbon.maxAutoRetries=1
    # 切换实例的重试次数
    ribbon.maxAutoRetriesNextServer=3
    # 对所有操作请求都进行重试
    ribbon.okToRetryOnAllOperations=true
    ```
- 断路器
    - Hystrix
        - @EnableHystrixDashboard
        - http://localhost:8766/hystrix
- 路由网关
    - Zuul
    - Spring Cloud Gateway
        - 路由(route)
        - 断言(Predicate)
        - 过滤器(filter)
        ```yml
        spring:
            cloud:
                gateway:
                    discovery:
                        locator:
                            enabled: true
                            lowerCaseServiceId: true
                    routes:
                      - id: path_route
                        uri: http://cxytiandi.com
                        predicates:
                          - Path=/house/**
                    filters:
                      - name: RequestRateLimiter
                        args:
                            redis-rate-limiter.replenishRate: 10
                            redis-rate-limiter.burstCapacity: 20
                            key-resolver: "#{@ipKeyResolver}"
                      - name: Retry
                        args:
                        retries: 3
                        series:
                            - SERVER_ERROR
                        statuses:
                            - OK
                        methods:
                            - GET
                            - POST
                        exceptions:
                            - java.io.IOException
                      - AddRequestHeader=NAME, yinjihuan
        ```
        ```java
        @Bean
        public RouteLocator customRouteLocator(RouteLocatorBuilder builder) {
            return builder.routes()
                    .route(r -> r.path("/course").uri("http://cxytiandi.com"))
                    .build();
        }
        @Bean
        @Order(Ordered.HIGHEST_PRECEDENCE)
        public ErrorWebExceptionHandler errorWebExceptionHandler(ErrorAttributes errorAttributes) {
            JsonExceptionHandler exceptionHandler = new JsonExceptionHandler(
                    errorAttributes, 
                    this.resourceProperties,
                    this.serverProperties.getError(), 
                    this.applicationContext);
            exceptionHandler.setViewResolvers(this.viewResolvers);
            exceptionHandler.setMessageWriters(this.serverCodecConfigurer.getWriters());
            exceptionHandler.setMessageReaders(this.serverCodecConfigurer.getReaders());
            return exceptionHandler;
        }
        ```
- 链路追踪
    - sleuth
- 统一日志管理
    - ELK