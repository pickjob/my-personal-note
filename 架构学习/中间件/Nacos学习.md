# Nacos学习
- Restful
    ```bash
    # Publish config
    curl -X POST "http://127.0.0.1:8848/nacos/v1/cs/configs?dataId=nacos.cfg.dataId&group=test&content=helloWorld"
    # Get config
    curl -X GET "http://127.0.0.1:8848/nacos/v1/cs/configs?dataId=nacos.cfg.dataId&group=test"
    # Service registration
    curl -X POST 'http://127.0.0.1:8848/nacos/v1/ns/instance?serviceName=nacos.naming.serviceName&ip=20.18.7.10&port=8080'
    # Service discovery
    curl -X GET 'http://127.0.0.1:8848/nacos/v1/ns/instance/list?serviceName=nacos.naming.serviceName'
    ```
- Spring Boot
    ```properties
    # application.properties
    nacos.config.server-addr=wsl2:8848
    nacos.discovery.server-addr=127.0.0.1:8848

    # ${prefix}-${spring.profiles.active}.${file-extension}
    spring.application.name=example
    spring.cloud.nacos.config.server-addr=127.0.0.1:8848
    spring.cloud.nacos.discovery.server-addr=127.0.0.1:8848
    ```
    ```java
    // Configuration Center
    @NacosPropertySource(dataId = "example", autoRefreshed = true)
    // @EnableNacosConfig(globalProperties = @NacosProperties(serverAddr = "127.0.0.1:8848"))
    @Configuration
    public class NacosConfiguration {
    }
    // inject configuration
    @NacosValue(value = "${useLocalCache:false}", autoRefreshed = true)
    private boolean useLocalCache;
    // listener
    @NacosConfigListener(dataId = DATA_ID)
    public void onMessage(String config) {
        assertEquals("mercyblitz", config); // asserts true
    }
    // covert and listener
    public class UserNacosConfigConverter implements NacosConfigConverter<User> {
        @Override
        public boolean canConvert(Class<User> targetType) {
            return true;
        }
        @Override
        public User convert(String source) {
            return JSON.parseObject(source, User.class);
        }
    }
    @NacosConfigListener(dataId = "user", converter = UserNacosConfigConverter.class)
    public void onUser(User user) {
        assertEquals(Long.valueOf(1L), user.getId()); 
        assertEquals("mercyblitz", user.getName());
    }
    @RefreshScope
    // Service Discovery
    @EnableNacosDiscovery(globalProperties = @NacosProperties(serverAddr = "127.0.0.1:8848"))
    @Configuration
    public class NacosConfiguration {
    }
    // inject service
    @NacosInjected
    private NamingService namingService;

    // cloud
    @EnableDiscoveryClient

    @LoadBalanced
    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
    ```
- admin-ui
    - nacos:8848/nacos