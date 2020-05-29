# Lettuce学习
- 示例
    ```java
    // redis :// [[username :] password@] host [: port] [/ database][? [timeout=timeout[d|h|m|s|ms|us|ns]] [&_database=database_]]
    RedisClient redisClient = RedisClient.create("redis://password@localhost:6379/0");
    StatefulRedisConnection<String, String> connection = redisClient.connect();
    // sync
    RedisCommands<String, String> syncCommands = connection.sync();
    // async
    RedisAsyncCommands<String, String> asyncCommands = connection.async();
    // reactive
    RedisReactiveCommands<String, String> reactiveCommands = connection.reactive();

    // Publish / Subscribe
    StatefulRedisPubSubConnection<String, String> connection = client.connectPubSub()
    connection.addListener(new RedisPubSubListener<String, String>() { ... })
    RedisPubSubAsyncCommands<String, String> async = connection.async();
    RedisFuture<Void> future = async.subscribe("channel");

    StatefulRedisPubSubConnection<String, String> connection = client.connectPubSub()
    RedisPubSubReactiveCommands<String, String> reactive = connection.reactive();
    reactive.subscribe("channel").subscribe();
    reactive.observeChannels().doOnNext(patternMessage -> {...}).subscribe()

    RedisPubSubReactiveCommands<String, String> reactive = connection.reactive();
    reactive.subscribe("channel").subscribe();
    reactive.observeChannels().doOnNext(patternMessage -> {...}).subscribe()

    connection.close();
    redisClient.shutdown();
    ```