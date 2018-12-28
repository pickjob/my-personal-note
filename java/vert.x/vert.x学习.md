# vert.x学习
- Future
  - CompositeFuture.all
  - CompositeFuture.any
  - CompositeFuture.join
  - CompositeFuture.compose
- Verticle
  - Stardand Verticle
  - Stardand Verticle
  - Multi-threaded Worker Verticle
- Context
- Timer
  - setTimer
  - setTimer
  - cancelTimer
- Event Bus
    ```java
    EventBus eb = vertx.eventBus();
    // Consumer
    eb.consumer("news.uk.sport", message -> {
        System.out.println("I have received a message: " + message.body());
    });
    eb.consumer("news.uk.sport", message -> {
        System.out.println("I have received a message: " + message.body());
    });
    consumer.unregister(res -> {
        if (res.succeeded()) {
            System.out.println("The handler un-registration has reached all nodes");
        } else {
            System.out.println("Un-registration failed!");
        }
    });
    // Publish
    eventBus.publish("news.uk.sport", "Yay! Someone kicked a ball");
    // P2P
    eventBus.send("news.uk.sport", "Yay! Someone kicked a ball");
    // DeliveryOptions
    DeliveryOptions options = new DeliveryOptions();
    options.addHeader("some-header", "some-value");
    eventBus.send("news.uk.sport", "Yay! Someone kicked a ball", options);
    // Reply
    MessageConsumer<String> consumer = eventBus.consumer("news.uk.sport");
    consumer.handler(message -> {
        System.out.println("I have received a message: " + message.body());
        message.reply("how interesting!");
    });
    MessageConsumer<String> consumer = eventBus.consumer("news.uk.sport");
        consumer.handler(message -> {
        System.out.println("I have received a message: " + message.body());
        message.reply("how interesting!");
    });
    ```
- Codec
    ```java
    eventBus.registerCodec(myCodec);
    DeliveryOptions options = new DeliveryOptions().setCodecName(myCodec.name());
    eventBus.send("orders", new MyPOJO(), options);
    eventBus.registerDefaultCodec(MyPOJO.class, myCodec);
    eventBus.send("orders", new MyPOJO());
    ```
- JSON
  - JSONObject
    - mapTo
    - encode
  - JSONArray
- Buffer
    ```java
    // Create
    Buffer buff = Buffer.buffer();
    Buffer buff = Buffer.buffer("some string");
    Buffer buff = Buffer.buffer("some string", "UTF-16");
    Buffer buff = Buffer.buffer("some string", "UTF-16");
    Buffer buff = Buffer.buffer(new byte[] {1, 3, 5});
    // write
    buff.appendInt(123).appendString("hello\n");
    // Random
    buff.setInt(1000, 123);
    buff.setString(0, "hello");
    ```
- TCP
    ```java
    NetServer server = vertx.createNetServer(options);
    server.listen();
    server.listen(1234, "localhost");
    server.connectHandler(socket -> {
        // read
        socket.handler(buffer -> {
            System.out.println("I received some bytes: " + buffer.length());
        });
        // write
        Buffer buffer = Buffer.buffer().appendFloat(12.34f).appendInt(123);
        socket.write(buffer);
        socket.write("some data");
        socket.write("some data", "UTF-16");
        // close
        socket.closeHandler(v -> {
            System.out.println("The socket has been closed");
        });
    });
    NetClientOptions options = new NetClientOptions()
                        .setConnectTimeout(10000)
                        .setReconnectAttempts(10)
                        .setReconnectInterval(500)
                        .setLogActivity(true);
                        ;
    NetClient client = vertx.createNetClient(options);
    client.connect(4321, "localhost", res -> {
    if (res.succeeded()) {
        System.out.println("Connected!");
        NetSocket socket = res.result();
    } else {
        System.out.println("Failed to connect: " + res.cause().getMessage());
    }
    });
    ```
- FileSystem
    ```java
    Vertx vertx = Vertx.vertx();
    // Read a file
    vertx.fileSystem().readFile("target/classes/readme.txt", result -> {
        if (result.succeeded()) {
            System.out.println(result.result());
        } else {
            System.err.println("Oh oh ..." + result.cause());
        }
    });
    // Copy a file
    vertx.fileSystem().copy("target/classes/readme.txt", "target/classes/readme2.txt", result -> {
        if (result.succeeded()) {
            System.out.println("File copied");
        } else {
            System.err.println("Oh oh ..." + result.cause());
        }
    });
    // Write a file
    vertx.fileSystem().writeFile("target/classes/hello.txt", Buffer.buffer("Hello"), result -> {
        if (result.succeeded()) {
            System.out.println("File written");
        } else {
            System.err.println("Oh oh ..." + result.cause());
        }
    });
    // Check existence and delete
    vertx.fileSystem().exists("target/classes/junk.txt", result -> {
        if (result.succeeded() && result.result()) {
            vertx.fileSystem().delete("target/classes/junk.txt", r -> {
                System.out.println("File deleted");
            });
        } else {
            System.err.println("Oh oh ... - cannot delete the file: " + result.cause());
        }
    });
    ```