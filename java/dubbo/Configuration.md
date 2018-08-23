# Configuration
- XML
    - Server
        - <dubbo:application/> : Application Config
        - <dubbo:registry/> : Registry Center
        - <dubbo:protocol/> : Protocol Config
        - <dubbo:service/> : Service Export
        - <dubbo:provider/> : Default Config for Providers
        - <dubbo:argument/> : Argument Config
        - <dubbo:module/> : Module Config
        - <dubbo:monitor/> : Monitor Center
        - <dubbo:method/> : Method level Config
    - Client
        - <dubbo:application/>
        - <dubbo:reference/> : Service Reference
        - <dubbo:consumer/> : Default Config for Consumers
        - <dubbo:module/>
        - <dubbo:argument/>
        - <dubbo:method/>
- JAVA API
    - ApplicationConfig
    - RegistryConfig 
    - ProtocolConfig
    - ServiceConfig
    - ReferenceConfig
    - MonitorConfig
    - ModuleConfig
    - MethodConfig
    - ConsumerConfig
    - ArgumentConfig
    - ProviderConfig
- Annotation
    ```java
    //Provider
    @Service(timeout = 5000)
    public class AnnotateServiceImpl implements AnnotateService { 
        // ...
    }
    @Configuration
    @DubboComponentScan(basePackages = "com.alibaba.dubbo.test.service.impl")
    public class DubboConfiguration {

        @Bean
        public ApplicationConfig applicationConfig() {
            ApplicationConfig applicationConfig = new ApplicationConfig();
            applicationConfig.setName("provider-test");
            return applicationConfig;
        }

        @Bean
        public RegistryConfig registryConfig() {
            RegistryConfig registryConfig = new RegistryConfig();
            registryConfig.setAddress("zookeeper://127.0.0.1:2181");
            registryConfig.setClient("curator");
            return registryConfig;
        }
    }
    //Consumer
    public class AnnotationConsumeService {
        @com.alibaba.dubbo.config.annotation.Reference
        public AnnotateService annotateService;
        
        // ...
    }
    @Configuration
    @DubboComponentScan(basePackages = "com.alibaba.dubbo.test.service")
    public class DubboConfiguration {
        @Bean
        public ApplicationConfig applicationConfig() {
            ApplicationConfig applicationConfig = new ApplicationConfig();
            applicationConfig.setName("consumer-test");
            return applicationConfig;
        }
        @Bean
        public ConsumerConfig consumerConfig() {
            ConsumerConfig consumerConfig = new ConsumerConfig();
            consumerConfig.setTimeout(3000);
            return consumerConfig;
        }
        @Bean
        public RegistryConfig registryConfig() {
            RegistryConfig registryConfig = new RegistryConfig();
            registryConfig.setAddress("zookeeper://127.0.0.1:2181");
            registryConfig.setClient("curator");
            return registryConfig;
        }
    }
    ```
- Protocol
    - dubbo
    - rmi
    - hessian
    - http
    - webservice
    - thrift
    - memcached
    - redis
    - rest
- Registry
    - multicast
    - zookeeper
    - redis