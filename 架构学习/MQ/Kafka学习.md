# Kafka学习
- Concept
    - Broker: 一个broker至少存储一个topic一个partition
    - Topic: 消息类别
    - Partition: 消息数据分割成区, 同一个分区消息顺序一致, 消息追加时分配offset
        - Leader
        - Follower
    - Producer
    - Consumer
    - Consumer Group: 不同消费组消费全量数据, 同一消费组消费不同数据(Rebalance)
    - DelayedOperation
        - DelayedProduce
        - DelayedFetch
        - DelayedJoin
        - DelayedHeartbeat
        - DelayedCreateTopics
    - KafkaController
    - Coordinator
        - ConsumerCoordinator
        - GroupCoordinator
        - WorkCoordinator
- 基本命令
    ```bash
    # start zookeeper
    bin/zookeeper-server-start.sh config/zookeeper.properties &
    # start kafka
    bin/kafka-server-start.sh config/server.properties &
    # create topic
    bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test &
    # produce messages
    bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test &
    # consume messages
    bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning &
    ```