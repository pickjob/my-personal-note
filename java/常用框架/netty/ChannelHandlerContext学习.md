# ChannelHandlerContext学习
- 父类
    ```java
    // ChannelInboundInvoker
    public interface ChannelInboundInvoker {
        ChannelInboundInvoker fireChannelRegistered();
        ChannelInboundInvoker fireChannelUnregistered();
        ChannelInboundInvoker fireChannelActive();
        ChannelInboundInvoker fireChannelInactive();
        ChannelInboundInvoker fireExceptionCaught(Throwable cause);
        ChannelInboundInvoker fireUserEventTriggered(Object event);
        ChannelInboundInvoker fireChannelRead(Object msg);
        ChannelInboundInvoker fireChannelReadComplete();
        ChannelInboundInvoker fireChannelWritabilityChanged();
    }
    // ChannelOutboundInvoker
    public interface ChannelOutboundInvoker {
        ChannelFuture bind(SocketAddress localAddress);
        ChannelFuture connect(SocketAddress remoteAddress);
        ChannelFuture connect(SocketAddress remoteAddress, SocketAddress localAddress);
        ChannelFuture disconnect();
        ChannelFuture close();
        ChannelFuture deregister();
        ChannelFuture bind(SocketAddress localAddress, ChannelPromise promise);
        ChannelFuture connect(SocketAddress remoteAddress, ChannelPromise promise);
        ChannelFuture connect(SocketAddress remoteAddress, SocketAddress localAddress, ChannelPromise promise);
        ChannelFuture disconnect(ChannelPromise promise);
        ChannelFuture close(ChannelPromise promise);
        ChannelFuture deregister(ChannelPromise promise);
        ChannelOutboundInvoker read();
        ChannelFuture write(Object msg);
        ChannelFuture write(Object msg, ChannelPromise promise);
        ChannelOutboundInvoker flush();
        ChannelFuture writeAndFlush(Object msg, ChannelPromise promise);
        ChannelFuture writeAndFlush(Object msg);
        ChannelPromise newPromise();
        ChannelProgressivePromise newProgressivePromise();
        ChannelFuture newSucceededFuture();
        ChannelFuture newFailedFuture(Throwable cause);
        ChannelPromise voidPromise();
    }
    ```
- propagation
  - Inbound event propagation methods:
    - ChannelHandlerContext.fireChannelRegistered()
    - ChannelHandlerContext.fireChannelActive()
    - ChannelHandlerContext.fireChannelRead(Object)
    - ChannelHandlerContext.fireChannelReadComplete()
    - ChannelHandlerContext.fireExceptionCaught(Throwable)
    - ChannelHandlerContext.fireUserEventTriggered(Object)
    - ChannelHandlerContext.fireChannelWritabilityChanged()
    - ChannelHandlerContext.fireChannelInactive()
    - ChannelHandlerContext.fireChannelUnregistered()
  - Outbound event propagation methods:
    - ChannelOutboundInvoker.bind(SocketAddress, ChannelPromise)
    - ChannelOutboundInvoker.connect(SocketAddress, SocketAddress, ChannelPromise)
    - ChannelOutboundInvoker.write(Object, ChannelPromise)
    - ChannelHandlerContext.flush()
    - ChannelHandlerContext.read()
    - ChannelOutboundInvoker.disconnect(ChannelPromise)
    - ChannelOutboundInvoker.close(ChannelPromise)
    - ChannelOutboundInvoker.deregister(ChannelPromise)