# http相关学习
- channelhandler
    - ByteToMessageDecoder
        - HttpObjectDecoder
            - HttpRequestDecoder
    - MessageToMessageEncoder
        - HttpObjectEncoder
          - HttpResponseEncoder
    - HttpObjectAggregator
    - CorsHandler
- 数据类
    - HttpObject
        - HttpMessage
            - HttpRequest
                - FullHttpRequest
            - HttpResponse
                - FullHttpResponse
            - FullHttpMessage
        - HttpContent
            - LastHttpContent
    - Cookie
- 工具类
    - QueryStringDecoder / QueryStringEncoder 
        ```java
        QueryStringEncoder encoder = new QueryStringEncoder("/hello");
        encoder.addParam("recipient", "world");
        assert encoder.toString().equals("/hello?recipient=world");
        QueryStringDecoder decoder = new QueryStringDecoder("/hello?recipient=world&x=1;y=2");
        assert decoder.path().equals("/hello");
        assert decoder.parameters().get("recipient").get(0).equals("world");
        assert decoder.parameters().get("x").get(0).equals("1");
        assert decoder.parameters().get("y").get(0).equals("2");
        ```
    - HttpPostRequestDecoder / HttpPostRequestEncoder
    - HttpPostMultipartRequestDecoder / HttpPostStandardRequestDecoder
    - ServerCookieDecoder / ServerCookieEncoder / ClientCookieDecoder / ClientCookieEncoder