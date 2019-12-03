# REST(Representational State Transfer)
- 注解
    - @ApplicationPath Application: 指定压缩包内素有的资源基本路径
    - @PATH: 定义资源
    - @PathParam: 绑定模板参数到资源类属性字段
    - @QueryParam: 请求URL路径部分抽取一个路径参数
    - @CookieParam: 绑定一个cookie值
    - @HeaderParam: 绑定一个HTTP头信息
    - @FormParam: 绑定HTML表单参数到资源的方法的参数或字段
    - @MatrixParam: 绑定URI路径的键/值参数
    - @DefaultValue: 绑定HTTP方法
        - @GET
        - @POST
        - @DELETE
        - @HEAD
    - @Consumes: 指定MIME,接受或使用,qs指定服务端媒体偏好(0-1,0不会选择,1选择)
    - @Produces: 指定MIME,产生相应,qs指定服务端媒体偏好(0-1,0不会选择,1选择)
    - @Contex: 获得应用程序部署上下文和单个请求的上下文
        - Application
        - UriInfo
        - HttpHeaders
        - Request
        - SecurityContext
        - Provier
    - @Provier
      - 实体Provider, Java到消息的映射
      - 接口MessageBodyReader
      - 接口MessageBodyWriter
- 客户端
    ```java
    Client client = ClientBuilder.newClient();
    client.target("xxx").path("{xx}").resolveTemplate("x", x).request().get(xx.class);
    // 异步调用
    client.target("xxx").path("{xx}").resolveTemplate("x", x).request().async().get(new InvocationCallBack<xx>() { ... });
    ```
- 映射异常
    - @Provider
    - ExceptionMapper<xx>
- 过滤器
    - ClientRequestFilter
    - ClientResponseFilter
    - ContainerRequestFilter
    - ContainerResponseFilter
- 注册
    - 客户端
        Client.register(xx.class);
    - 服务器段
        - @Provider
        - Application中注册
        - @NamedBinding指定范围
        - DynamicFeature指定范围
        - @Priority注解指定优先级
    - 实体拦截
        - ReaderInterceptor
        - WriterInteceptor
