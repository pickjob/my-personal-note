# ChannelHandlerAdapter / ChannelInboundHandlerAdapter / ChannelOutboundHandlerAdapter / ChannelDuplexHandler学习
- ChannelHandlerAdapter
    ```java
    /**
     *   基本什么都不做
     */
    public abstract class ChannelHandlerAdapter implements ChannelHandler {
        // Not using volatile because it's used only for a sanity check.
        boolean added;
        protected void ensureNotSharable() {
            if (isSharable()) {
                throw new IllegalStateException("ChannelHandler " + getClass().getName() + " is not allowed to be shared");
            }
        }
        public boolean isSharable() {
            Class<?> clazz = getClass();
            Map<Class<?>, Boolean> cache = InternalThreadLocalMap.get().handlerSharableCache();
            Boolean sharable = cache.get(clazz);
            if (sharable == null) {
                sharable = clazz.isAnnotationPresent(Sharable.class);
                cache.put(clazz, sharable);
            }
            return sharable;
        }
        @Override
        public void handlerAdded(ChannelHandlerContext ctx) throws Exception {
            // NOOP
        }
        @Override
        public void handlerRemoved(ChannelHandlerContext ctx) throws Exception {
            // NOOP
        }
        @Override
        public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception {
            ctx.fireExceptionCaught(cause);
        }
    }
    ```
- ChannelInboundHandlerAdapter
    ```java
    /**
     *  基本什么都给下一个ChannelInboundHandler做
     */
    public class ChannelInboundHandlerAdapter extends ChannelHandlerAdapter implements ChannelInboundHandler {
        @Override
        public void channelRegistered(ChannelHandlerContext ctx) throws Exception {
            ctx.fireChannelRegistered();
        }
        @Override
        public void channelUnregistered(ChannelHandlerContext ctx) throws Exception {
            ctx.fireChannelUnregistered();
        }
        @Override
        public void channelActive(ChannelHandlerContext ctx) throws Exception {
            ctx.fireChannelActive();
        }
        @Override
        public void channelInactive(ChannelHandlerContext ctx) throws Exception {
            ctx.fireChannelInactive();
        }
        @Override
        public void channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
            ctx.fireChannelRead(msg);
        }
        @Override
        public void channelReadComplete(ChannelHandlerContext ctx) throws Exception {
            ctx.fireChannelReadComplete();
        }
        @Override
        public void userEventTriggered(ChannelHandlerContext ctx, Object evt) throws Exception {
            ctx.fireUserEventTriggered(evt);
        }
        @Override
        public void channelWritabilityChanged(ChannelHandlerContext ctx) throws Exception {
            ctx.fireChannelWritabilityChanged();
        }
        @Override
        public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause)
                throws Exception {
            ctx.fireExceptionCaught(cause);
        }
    }
    ```
- ChannelOutboundHandlerAdapter
    ```java
    /**
     *  基本什么都给上一个ChannelOutboundHandler做
     */
    public class ChannelOutboundHandlerAdapter extends ChannelHandlerAdapter implements ChannelOutboundHandler {
        @Override
        public void bind(ChannelHandlerContext ctx, SocketAddress localAddress,
                ChannelPromise promise) throws Exception {
            ctx.bind(localAddress, promise);
        }
        @Override
        public void connect(ChannelHandlerContext ctx, SocketAddress remoteAddress,
                SocketAddress localAddress, ChannelPromise promise) throws Exception {
            ctx.connect(remoteAddress, localAddress, promise);
        }
        @Override
        public void disconnect(ChannelHandlerContext ctx, ChannelPromise promise)
                throws Exception {
            ctx.disconnect(promise);
        }
        @Override
        public void close(ChannelHandlerContext ctx, ChannelPromise promise)
                throws Exception {
            ctx.close(promise);
        }
        @Override
        public void deregister(ChannelHandlerContext ctx, ChannelPromise promise) throws Exception {
            ctx.deregister(promise);
        }
        @Override
        public void read(ChannelHandlerContext ctx) throws Exception {
            ctx.read();
        }
        @Override
        public void write(ChannelHandlerContext ctx, Object msg, ChannelPromise promise) throws Exception {
            ctx.write(msg, promise);
        }
        @Override
        public void flush(ChannelHandlerContext ctx) throws Exception {
            ctx.flush();
        }
    }

    ```
- ChannelDuplexHandle
    ```java
    /**
     *  ChannelInboundHandlerAdapter & ChannelOutboundHandlerAdapter 合集
     */
    public class ChannelDuplexHandler extends ChannelInboundHandlerAdapter implements ChannelOutboundHandler {
        @Override
        public void bind(ChannelHandlerContext ctx, SocketAddress localAddress,
                        ChannelPromise promise) throws Exception {
            ctx.bind(localAddress, promise);
        }
        @Override
        public void connect(ChannelHandlerContext ctx, SocketAddress remoteAddress,
                            SocketAddress localAddress, ChannelPromise promise) throws Exception {
            ctx.connect(remoteAddress, localAddress, promise);
        }
        @Override
        public void disconnect(ChannelHandlerContext ctx, ChannelPromise promise)
                throws Exception {
            ctx.disconnect(promise);
        }
        @Override
        public void close(ChannelHandlerContext ctx, ChannelPromise promise) throws Exception {
            ctx.close(promise);
        }
        @Override
        public void deregister(ChannelHandlerContext ctx, ChannelPromise promise) throws Exception {
            ctx.deregister(promise);
        }
        @Override
        public void read(ChannelHandlerContext ctx) throws Exception {
            ctx.read();
        }
        @Override
        public void write(ChannelHandlerContext ctx, Object msg, ChannelPromise promise) throws Exception {
            ctx.write(msg, promise);
        }
        @Override
        public void flush(ChannelHandlerContext ctx) throws Exception {
            ctx.flush();
        }
    }
    ```