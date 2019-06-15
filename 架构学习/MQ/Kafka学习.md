# Kafka学习
- Concept
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