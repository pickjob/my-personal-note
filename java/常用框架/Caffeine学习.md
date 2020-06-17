# Caffeine学习
```java
// Cache
Cache<Key, Graph> cache = Caffeine.newBuilder()
    .expireAfterWrite(10, TimeUnit.MINUTES)
    .maximumSize(10_000)
    .build();
// LoadingCache
LoadingCache<Key, Graph> cache = Caffeine.newBuilder()
    .maximumSize(10_000)
    .expireAfterWrite(10, TimeUnit.MINUTES)
    .build(key -> createExpensiveGraph(key));
// Evict Policy
// Evict based on the number of entries in the cache
LoadingCache<Key, Graph> graphs = Caffeine.newBuilder()
    .maximumSize(10_000)
    .build(key -> createExpensiveGraph(key));
// Evict based on the number of vertices in the cache
LoadingCache<Key, Graph> graphs = Caffeine.newBuilder()
    .maximumWeight(10_000)
    .weigher((Key key, Graph graph) -> graph.vertices().size())
    .build(key -> createExpensiveGraph(key));
// Evict based on a fixed expiration policy
LoadingCache<Key, Graph> graphs = Caffeine.newBuilder()
    .expireAfterAccess(5, TimeUnit.MINUTES)
    .build(key -> createExpensiveGraph(key));
LoadingCache<Key, Graph> graphs = Caffeine.newBuilder()
    .expireAfterWrite(10, TimeUnit.MINUTES)
    .build(key -> createExpensiveGraph(key));
// Evict when neither the key nor value are strongly reachable
LoadingCache<Key, Graph> graphs = Caffeine.newBuilder()
    .weakKeys()
    .weakValues()
    .build(key -> createExpensiveGraph(key));
// Evict when the garbage collector needs to free memory
LoadingCache<Key, Graph> graphs = Caffeine.newBuilder()
    .softValues()
    .build(key -> createExpensiveGraph(key));
// Evict based on a varying expiration policy
LoadingCache<Key, Graph> graphs = Caffeine.newBuilder()
    .expireAfter(new Expiry<Key, Graph>() {
      public long expireAfterCreate(Key key, Graph graph, long currentTime) {
        // Use wall clock time, rather than nanotime, if from an external resource
        long seconds = graph.creationDate().plusHours(5)
            .minus(System.currentTimeMillis(), MILLIS)
            .toEpochSecond();
        return TimeUnit.SECONDS.toNanos(seconds);
      }
      public long expireAfterUpdate(Key key, Graph graph, 
          long currentTime, long currentDuration) {
        return currentDuration;
      }
      public long expireAfterRead(Key key, Graph graph,
          long currentTime, long currentDuration) {
        return currentDuration;
      }
    })
    .build(key -> createExpensiveGraph(key));

// Get
// Lookup an entry, or null if not found
Graph graph = cache.getIfPresent(key);
// Lookup and compute an entry if absent, or null if not computable
graph = cache.get(key, k -> createExpensiveGraph(key));

// Put
// Insert or update an entry
cache.put(key, graph);    

// Invalidate
// individual key
cache.invalidate(key);
// bulk keys
cache.invalidateAll(keys);
// all keys
cache.invalidateAll();
```