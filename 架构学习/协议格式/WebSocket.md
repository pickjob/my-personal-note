# WebSocket
- 协议升级过程
    - client
        ```tcp
        GET /chat HTTP/1.1
        Host: server.example.com
        Upgrade: websocket
        Connection: Upgrade
        Sec-WebSocket-Key: dGhlIHNhbXBsZSBub25jZQ==(key base64编码)
        Origin: http://example.com
        Sec-WebSocket-Protocol: chat, superchat
        Sec-WebSocket-Version: 13
        ```
    - server
        ```tcp
        HTTP/1.1 101 Switching Protocols
        Upgrade: websocket
        Connection: Upgrade
        Sec-WebSocket-Accept: s3pPLMBiTxaQ9kYGzzhZRbK+xOo=(key SHA-1编码)
        Sec-WebSocket-Protocol: chat
        ```
- 使用
    - Javascript
        ```javascript
        var connection = new WebSocket('ws://xxx');
        ```
        - connection.readyState
            - WebSocket.CONNECTING(0)
            - WebSocket.OPEN(1)
            - WebSocket.CLOSING(2)
            - WebSocket.CLOSED(3)
        - connection.binaryType
            - 'arraybuffer'
            - 'blob'
        - connection.onopen
        - connection.onclose
            - event.wasClean
            - event.code(1000正常)
            - event.reason
        - connection.onerror
        - connection.onessage
            - event.data
        - connection.send
    - Java
        - 包
            - javax.websocekt.server
            - javax.websocket
        - WebSocket端点
            - 编程端点(programmatic endpoint)
                - 继承Endpoint,实现onOpen / onClose / onClose / onMessage
                - 部署
                    - ServerApplicaionConfig
                    - ServerEndpointConfig.Builder.create(EchoEndpoint.class,"/echo").build();
            - 注解端点(annotate endpoint)
                - @ServerEndpoint("/echo/{room}")
                    - 支持模板参数 @PathParam("room")
                - @OnMessage
                - @OnOpen
                - @OnClose
                - @OnError
        - Session
            - session.getOpenSessions打开所有的连接
            - session.getUserProperties()存储用户属性
        - 发送消息
            ```java
            RemoteEndpoint.Basic.sendText(String text);
            RemoteEndpoint.Basic.sendBinary(BinaryBuffer data);
            RemoteEndpoint.sendPing(ByteBuffer appData);
            RemoteEndpoint.sendPong(ByteBuffer appData);
            ```
        - 接收消息
            - 至多3个方法@OnMessage,分别处理
                - 文本(String)
                - 二进制(ByteBuffer)
                - pong帧信息(PongMessage)
            - 编码器、解码器
                - Encoder.Text<T>
                - Encoder.Binary<T>
                - Decoder.Text<T>
                - Decoder.Binary<T>
                - @ServerEndpoint中注册
                - RemoteEndpoint.Basic.sendObject(Object)
                - @OnMessage注入Java类
            - 指定端点配置类
                - 继承ServerEndpointConfig.Configurator
        - client
            - ContainerProvider WebSocketContainer RemoteEnpoint Session
            - @ClientEnpoint
            - @OnOpen
                - Session
                - EndpointConfig
            - @OnClose
                - Session
                - CloseReason
            - @OnError
                - Session
                - Throwable
            - @OnMessage
                - String(boolean)
                - Reader
                - ByteBuffer/byte[](boolean)
                - InputStream
                - PongMessage
                - POJO(Decoder.Text/Decoder.Binary/Decoder.TextStream/Decoder.BinaryStream)
        - server
            - @ServerEndpoint()
                - value:部署的URI或URI模板
                - encoders:编码器数组
                - decoders:解码器数组
                - subprotocols:websockets协议数组
                - configurator:WebSocket配置类
