# ActiveMQ学习
- Configuration
    - TransportConnector
        - disableAsyncDispatch(允许异步): true
    - Broker
        - policyEntry
            - expireMessagesPeriod(消息过期): 30000
            - maxPageSize: 1000
            - consumersBeforeDispatchStarts(消费者数): 2
            - timeBeforeDispatchStarts(延迟): 2000
            - schedulePeriodForDestinationPurge(定时): 1000
            - gcInactiveDestinations(删除为活动地址): true
            - inactiveTimoutBeforeGC(为活动时长): 30000
        - offlineDurableSubscriberTimeout: -1
        - offlineDurableSubscriberTaskSchedule: 300000
        - mirrorQueue
            ```xml
            <destinationInterceptors>
                <mirroredQueue copyMessage = "true" postfix=".qmirror" prefix=""/>
            </destinationInterceptors>
            ```
    - Destination
        - Composite: "(queue://)FOO.A, (topic://)FOO.B, FOO.C"
        - Options:
            - consumer.dispatchAsync(异步发送): true
            - consumer.exclusive(排他消费者): false
            - consumer.maximumPendingMEssageLimit: 0
            - consumer.noLocal: false
            - consumer.prefetchSize: n/a
            - consumer.priority: 0(0-127)
            - consumer.retroactive: false
            - consumer.selector
    - Connection
        - redeliveryPolicy
            - backOffMultiplier: 5
            - collisionAvoidanceFactor: 0.15
            - initialRedeliverDealy(重试延迟): 1000l
            - maximumRedeliveries(最大重试): 6(-1)
            - maximumRedeliveryDelay(最大重拾延迟): -1
            - redeliveryDelay: 1000l
            - useCollsionAvoidance: false
            - useExponentialBackoff
- Ports
    - 61616: openwire brokers
    - 5672: amqp
    - 61613: stomp
    - 1883: mqtt
    - 61614: ws
    - 8161: web console
- Command
    ```bash
    # console start
    bin/activemq console
    # start
    bin/activemq start
    # stop
    bin/activemq stop
    # restart
    bin/activemq restart
    ```