# Guava学习
- Cache
    ```java
    LoadingCache<Key, Graph> graphs = CacheBuilder.newBuilder()
       .maximumSize(1000)
       .expireAfterWrite(10, TimeUnit.MINUTES)
       .removalListener(MY_LISTENER)
       .build(new CacheLoader<Key, Graph>() {
            public Graph load(Key key) throws AnyException {
              return createExpensiveGraph(key);
            }
        });
        // Size-based Eviction
        .maximumSize(1000)

        .maximumWeight(100000)
        .weigher(new Weigher<Key, Graph>() {
            public int weigh(Key k, Graph g) {
              return g.vertices().size();
            }
        })
        // timed Eviction
        .expireAfterAccess(long, TimeUnit)
        .expireAfterWrite(long, TimeUnit)
        // Reference-based Eviction
        CacheBuilder.weakKeys()
        CacheBuilder.weakValues()
        CacheBuilder.softValues()
    ```
- RateLimiter
    ```java
    RateLimiter rateLimiter = RateLimiter.create(0.5);
    rateLimiter.acquire();
    ```
- String
    ```java
    Joiner.on("; ").skipNulls().join("Harry", null, "Ron", "Hermione"));
    Splitter.on(',').trimResults().omitEmptyStrings().split("foo,bar,,   qux");
    ```
- EventBus
    ```java
    // Class is typically registered by the container.
    class EventBusChangeRecorder {
        @Subscribe public void recordCustomerChange(ChangeEvent e) {
            recordChange(e.getChange());
        }
    }
    // somewhere during initialization
    eventBus.register(new EventBusChangeRecorder());
    // much later
    public void changeCustomer()
    ChangeEvent event = getChangeEvent();
    eventBus.post(event);
    ```