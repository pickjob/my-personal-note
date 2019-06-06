# Configuration
- Component (xmlns:dubbo="http://dubbo.apache.org/schema/dubbo")
  - Common
    - ApplicationConfig (<dubbo:application/>)
    - RegistryConfig (<dubbo:registry/>)
      - multicast
      - zookeeper
      - nacos
      - redis
      - simple
    - ProtocolConfig (<dubbo:protocol/>)
      - dubbo
      - rmi
      - hessian
      - http
      - webservice
      - thrift
      - memcached
      - redis
      - rest
    - MethodConfig (<dubbo:method/>)
    - ArgumentConfig (<dubbo:argument/>)
    - MonitorConfig (<dubbo:monitor/>)
    - @DubboComponentScan
  - Server
    - ServiceConfig (<dubbo:service/>)
    - ProviderConfig (<dubbo:provider/>)
    - ModuleConfig (<dubbo:module/>)
    - @Service
  - Client
    - ReferenceConfig (<dubbo:reference>)
    - ConsumerConfig (<dubbo:consumer/>)
    - @Reference
- 常用配置
  ```xml
  <!-- Check on start up -->
  <dubbo:reference interface="com.foo.BarService" check="false" />
  <dubbo:consumer check="false" />
  <dubbo:registry check="false" />
  <!-- Fault Tolerance Strategy -->
  <dubbo:service retries="2" />
  <dubbo:reference retries="2" />
  <dubbo:reference>
      <dubbo:method name="findFoo" retries="2" />
  </dubbo:reference>
  <!-- LoadBalance: random roundrobin leastactive consistenthash -->
  <dubbo:service interface="..." loadbalance="roundrobin" />
  <dubbo:service interface="...">
      <dubbo:method name="..." loadbalance="roundrobin"/>
  </dubbo:service>
  <dubbo:reference interface="..." loadbalance="roundrobin" />
  <dubbo:reference interface="...">
      <dubbo:method name="..." loadbalance="roundrobin"/>
  </dubbo:reference>
  <!-- Thread Model -->
  <!-- dispatcher: all direct message execution connection -->
  <!-- threadpool: fixed cached limit -->
  <dubbo:protocol name="dubbo" dispatcher="all" threadpool="fixed" threads="100" />
  <!-- explicit target -->
  <dubbo:reference id="xxxService" interface="com.alibaba.xxx.XxxService" url="dubbo://localhost:20890" />
  <!-- subscribe only -->
  <dubbo:registry address="10.20.153.10:9090" register="false" />
  <dubbo:registry address="10.20.153.10:9090?register=false" />
  <!-- register only -->
  <dubbo:registry id="qdRegistry" address="10.20.141.150:9090" subscribe="false" />
  <dubbo:registry id="qdRegistry" address="10.20.141.150:9090?subscribe=false" />
  <!-- Parameter Validation -->
  <dubbo:reference id="validationService" interface="org.apache.dubbo.examples.validation.api.ValidationService" validation="true" />
  <dubbo:service interface="org.apache.dubbo.examples.validation.api.ValidationService" ref="validationService" validation="true" />
  <!-- cache result: lru threadlocal jcache -->
  <dubbo:reference interface="com.foo.BarService" cache="lru" />
  <!-- Asynchronous Call -->
  <dubbo:reference id="fooService" interface="com.alibaba.foo.FooService">
      <dubbo:method name="findFoo" async="true" sent="true" return="false" />
  </dubbo:reference>
  <dubbo:reference id="barService" interface="com.alibaba.bar.BarService">
      <dubbo:method name="findBar" async="true" />
  </dubbo:reference>
  <!-- Event Notify -->
  <bean id ="demoCallback" class="com.alibaba.dubbo.callback.implicit.NofifyImpl" />
  <dubbo:reference id="demoService" interface="com.alibaba.dubbo.callback.implicit.IDemoService" version="1.0.0" group="cn" >
      <dubbo:method name="get" async="true" onreturn="demoCallback.onreturn" onthrow="demoCallback.onthrow" />
  </dubbo:reference>
  <!-- Local mock -->
  <dubbo:reference interface="com.foo.BarService" mock="true" />
  <dubbo:reference interface="com.foo.BarService" mock="com.foo.BarServiceMock" />
  <dubbo:reference interface="com.foo.BarService" mock="return null" />
  <!-- parallel control -->
  <dubbo:service interface="com.foo.BarService" executes="10" />
  <dubbo:service interface="com.foo.BarService">
    <dubbo:method name="sayHello" executes="10" />
  </dubbo:service>
  <dubbo:service interface="com.foo.BarService" actives="10" />
  <dubbo:reference interface="com.foo.BarService" actives="10" />
  <dubbo:service interface="com.foo.BarService">
    <dubbo:method name="sayHello" actives="10" />
  </dubbo:service>
  <dubbo:reference interface="com.foo.BarService">
    <dubbo:method name="sayHello" actives="10" />
  </dubbo:service>
  <!-- connection -->
  <dubbo:provider protocol="dubbo" accepts="10" />
  <dubbo:protocol name="dubbo" accepts="10" />
  <dubbo:reference interface="com.foo.BarService" connections="10" />
  <dubbo:service interface="com.foo.BarService" connections="10" />
  <!-- access log -->
  <dubbo:protocol accesslog="true" .../>
  <logger name="dubbo.accesslog.com.dubbo.FooServiceInterface" level="INFO" additivity="false">
        <appender-ref ref="fooServiceAccesslogAppender"/>
  </logger>
  ```
  ```java
  // Asynchronous Call
  // the invoke will return null immediately
  fooService.findFoo(fooId);
  // get current invoke Future instance,when the remote service has return result,will notify this Future instance.
  Future<Foo> fooFuture = RpcContext.getContext().getFuture();
  // the invoke will return null immediately
  barService.findBar(barId);
  // get current invoke Future instance,when the remote service has return result,will notify this Future instance.
  Future<Bar> barFuture = RpcContext.getContext().getFuture();
  // now the request of findFoo and findBar was executed at same time,The client not need setup multithreading for parallel call, which isNIO-based non-blocking implementation of parallel calls
  // Current thread will be blocking,and wait findFoo has return. when remote service has return findFoo result,the current thread will bewake up.
  Foo foo = fooFuture.get();
  // same to findFoo
  Bar bar = barFuture.get();
  // if findFoo expend five second for wait remote service  return result,and findBar expend six second. Actually,only expend six second willget findFoo and findBar result,and proceed to the next step.
  ```