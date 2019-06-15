# Guava学习
- Collections
  - Immutable Collections
    - ImmutableXXX
      - of
      - copyOf
    - class
      - ImmutableCollection
      - ImmutableList
      - ImmutableSet
      - ImmutableSortedSet
      - ImmutableMap
      - ImmutableSortedMap
      - ImmutableMultiset
      - ImmutableSortedMultiset
      - ImmutableMultimap
      - ImmutableListMultimap
      - ImmutableSetMultimap
      - ImmutableBiMap
      - ImmutableClassToInstanceMap
      - ImmutableTable
  - Multiset( more like ArrayList / Map<String, Integer> )
    - method
      - count(E)
      - elementSet()
      - entrySet()
      - add(E, int)
      - remove(E, int)
      - setCount(E, int)
      - size()
    - class
      - HashMultiset
      - TreeMultiset
      - LinkedHashMultiset
      - ConcurrentHashMultiset
      - ImmutableMultiset
  - Multimap( Map<K, List<V>> / Map<K, Set<V>>)
    - method
      - put(K, V)
      - putAll(K, Iterable<V>)
      - remove(K, V)
      - removeAll(K)
      - replaceValues(K, Iterable<V>)
    - class
      - ArrayListMultimap
      - HashMultimap
      - LinkedListMultimap
      - LinkedHashMultimap
      - TreeMultimap
      - ImmutableListMultimap
      - ImmutableSetMultimap
  - Table( Table<R, C, V>)
    - method
      - rowMap( -> Map<R, Map<C, V>>)
      - row(r) (-> Map<C, V>)
      - columnMap(), columnKeySet(), column(c)
      - cellSet() (Table.Cell<R, C, V>)
    - class
      - HashBasedTable
      - TreeBasedTable
      - ImmutableTable
      - ArrayTable
  - RangeSet
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
    }
    ```