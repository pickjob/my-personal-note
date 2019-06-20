# CombinedChannelDuplexHandler学习
- 组合ChannelInboundHandler和ChannelOutboundHandler
    ```java
    public class CombinedChannelDuplexHandler<I extends ChannelInboundHandler, O extends ChannelOutboundHandler>
        extends ChannelDuplexHandler {
        // 内部委托ChannelInboundHandler, ChannelOutboundHandler处理请求
        private DelegatingChannelHandlerContext inboundCtx;
        private DelegatingChannelHandlerContext outboundCtx;
        private volatile boolean handlerAdded;
        // 实际处理的ChannelInboundHandler, ChannelOutboundHandler
        private I inboundHandler;
        private O outboundHandler;
    }
    ```