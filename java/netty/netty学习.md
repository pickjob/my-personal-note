# netty学习
- ChannelHandler(责任链模式)
    ```java
    public interface ChannelHandler {
        void handlerAdded(ChannelHandlerContext ctx) throws Exception;
        void handlerRemoved(ChannelHandlerContext ctx) throws Exception;
        @Deprecated void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception;
    }
    ```
    - ChannelInboundHandler / ChannelOutboundHandler
    ```java
    public interface ChannelInboundHandler extends ChannelHandler {
        void channelRegistered(ChannelHandlerContext ctx) throws Exception;
        void channelUnregistered(ChannelHandlerContext ctx) throws Exception;
        void channelActive(ChannelHandlerContext ctx) throws Exception;
        void channelInactive(ChannelHandlerContext ctx) throws Exception;
        void channelRead(ChannelHandlerContext ctx, Object msg) throws Exception;
        void channelReadComplete(ChannelHandlerContext ctx) throws Exception;
        void userEventTriggered(ChannelHandlerContext ctx, Object evt) throws Exception;
        void channelWritabilityChanged(ChannelHandlerContext ctx) throws Exception;
        @Override
        @SuppressWarnings("deprecation")
        void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception;
    }
    public interface ChannelOutboundHandler extends ChannelHandler {
        void bind(ChannelHandlerContext ctx, SocketAddress localAddress, ChannelPromise promise) throws Exception;
        void connect(ChannelHandlerContext ctx, SocketAddress remoteAddress, SocketAddress localAddress, ChannelPromise promise) throws Exception;
        void disconnect(ChannelHandlerContext ctx, ChannelPromise promise) throws Exception;
        void close(ChannelHandlerContext ctx, ChannelPromise promise) throws Exception;
        void deregister(ChannelHandlerContext ctx, ChannelPromise promise) throws Exception;
        void read(ChannelHandlerContext ctx) throws Exception;
        void write(ChannelHandlerContext ctx, Object msg, ChannelPromise promise) throws Exception;
        void flush(ChannelHandlerContext ctx) throws Exception;
    }
    ```
    - ChannelHandlerAdapter / ChannelInboundHandlerAdapter / ChannelOutboundHandlerAdapter / ChannelDuplexHandler
- ChannelOption
    - Netty配置
        - ChannelOption.CONNECT_TIMEOUT_MILLIS : 连接超时毫秒数，默认值30000毫秒
        - ChannelOption.MAX_MESSAGES_PER_READ : 一次Loop读取的最大消息数，对于ServerChannel或者NioByteChannel，默认值为16，其他Channel默认值为1。
        - ChannelOption.WRITE_SPIN_COUNT : 一个Loop写操作执行的最大次数，默认值为16
        - ChannelOption.ALLOCATOR : ByteBuf的分配器，默认值为ByteBufAllocator.DEFAULT，4.0版本为UnpooledByteBufAllocator，4.1版本为PooledByteBufAllocator
        - ChannelOption.RCVBUF_ALLOCATOR : 用于Channel分配接受Buffer的分配器
        - ChannelOption.AUTO_READ : 自动读取，默认值为True
        - ChannelOption.WRITE_BUFFER_HIGH_WATER_MARK : 写高水位标记，默认值64KB
        - ChannelOption.WRITE_BUFFER_LOW_WATER_MARK : 写低水位标记，默认值32KB
        - ChannelOption.MESSAGE_SIZE_ESTIMATOR : 消息大小估算器，默认为DefaultMessageSizeEstimator.DEFAULT
        - ChannelOption.SINGLE_EVENTEXECUTOR_PER_GROUP: 单线程执行ChannelPipeline中的事件，默认值为True
    - Socket配置
        - ChannelOption.SO_BACKLOG : 初始化服务端可连接队列
        - ChannelOption.SO_REUSEADDR : 允许重复使用本地地址和端口
        - ChannelOption.SO_KEEPALIVE : 当设置该选项以后，连接会测试链接的状态，这个选项用于可能长时间没有数据交流的连接
        - ChannelOption.SO_SNDBUF和ChannelOption.SO_RCVBUF : 发送缓冲区大小和接受缓冲区大小
        - ChannelOption.SO_LINGER : 阻塞close()的调用时间，直到数据完全发送
        - ChannelOption.TCP_NODELAY : 小数据即时传输
        - ChannelOption.IP_TOS : 设置IP头部的Type-of-Service字段，用于描述IP包的优先级和QoS选项
        - ChannelOption.ALLOW_HALF_CLOSURE : 一个连接的远端关闭时本地端是否关闭，默认值为False
        - ChannelOption.SO_BROADCAST : 设置广播模式
        - ChannelOption.IP_MULTICAST_ADDR : 对应IP参数IP_MULTICAST_IF，设置对应地址的网卡为多播模式
        - ChannelOption.IP_MULTICAST_IF : 对应IP参数IP_MULTICAST_IF2，同上但支持IPV6
        - ChannelOption.IP_MULTICAST_TTL : IP参数，多播数据报的time-to-live即存活跳数
- Example
    ```java
    EventLoopGroup bossGroup = new NioEventLoopGroup(1);
        EventLoopGroup workerGroup = new NioEventLoopGroup();
        final EchoServerHandler serverHandler = new EchoServerHandler();
        try {
            ServerBootstrap b = new ServerBootstrap();
            b.group(bossGroup, workerGroup)
             .channel(NioServerSocketChannel.class)
             .option(ChannelOption.SO_BACKLOG, 100)
             .handler(new LoggingHandler(LogLevel.INFO))
             .childHandler(new ChannelInitializer<SocketChannel>() {
                 @Override
                 public void initChannel(SocketChannel ch) throws Exception {
                     ChannelPipeline p = ch.pipeline();
                     //p.addLast(new LoggingHandler(LogLevel.INFO));
                     p.addLast(serverHandler);
                 }
             });
            // Start the server.
            ChannelFuture f = b.bind(PORT).sync();
            // Wait until the server socket is closed.
            f.channel().closeFuture().sync();
        } finally {
            // Shut down all event loops to terminate all threads.
            bossGroup.shutdownGracefully();
            workerGroup.shutdownGracefully();
        }
    ```
- jar
    ```yaml
    ext {
        nettyVersion = '4.1.24.Final'
    }
    compile "io.netty:netty-all:${nettyVersion}"
    ```