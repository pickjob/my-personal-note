# http协议学习
- 报文格式
  - line spliter(ASCII 0x0D0x0A)
  - request
    ```tcp
    <method> <request-url> <version>\r\n
    [<header>\r\n]
    \r\n
    [<entity-body>]
    ```
  - response
    ```tcp
    <version> <status> <reson-phrase>\r\n
    [<header>\r\n]
    \r\n
    <entity-body>
    ```
  - entity-body
    - Content-Type
      - application/x-www-form-urlencoded
        ```tcp
        Content-Type: application/x-www-form-urlencoded\r\n
        \r\n
        key1=val1&key2=val2\r\n
        ```
      - multipart/form-data
        ```tcp
        Content-Type: multipart/form-data;boundary=--AaB03x\r\n
        \r\n
        --AaB03x\r\n
        Content-Disposition: form-data; name="submit-name"\r\n
        \r\n
        Sally
        --AaB03x
        Content-Disposition: form-data; name="files"; filename="easy.txt"\r\n
        Content-Type: text/plain
        --AaB03x--
        ```
      - Transfer-Encoding: chunked
        - 每个分块包含十六进制的长度值和数据
        - 最后一个分块长度值必须为 0
            ```tcp
            HTTP/1.1 200 OK\r\n
            Content-Type: text/plain\r\n
            Transfer-Encoding: chunked\r\n
            \r\n
            4\r\n
            Wiki\r\n
            5\r\n
            pedia\r\n
            0\r\n
            \r\n
            ```
  - version
    - HTTP/1.0
    - HTTP/1.1
    - HTTP/2
  - method
    - GET
    - POST
    - PUT
    - DELETE
    - OPTIONS
    - HEAD
    - TRACE
    - CONNECT
    - PATCH
  - status
    - 1xx消息——请求已被服务器接收，继续处理
      - 100 Continue
      - 101 Switching Protocols
      - 102 Processing
    - 2xx成功——请求已成功被服务器接收、理解、并接受
      - 200 OK
      - 201 Created
      - 202 Accepted
      - 204 No Content
      - 205 Reset Content
      - 206 Partial Content
      - 207 Multi-Status
    - 3xx重定向——需要后续操作才能完成这一请求
      - 300 Multiple Choices
      - 301 Moved Permanently
      - 302 Found (Location)
      - 303 See Other
      - 304 Not Modified(If-Modified-Since或If-None-Match)
      - 307 Temporary Redirect
      - 308 Permanent Redirect
    - 4xx请求错误——请求含有词法错误或者无法被执行
      - 400 Bad Request
      - 401 Unauthorized
      - 403 Forbidden
      - 404 Not Found
      - 405 Method Not Allowed
      - 406 Not Acceptable
      - 407 Proxy Authentication Required
      - 413 Request Entity Too Large
      - 414 Request-URI Too Long
      - 415 Unsupported Media Type
    - 5xx服务器错误——服务器在处理某个正确请求时发生错误
      - 500 Internal Server Error
      - 501 Not Implemented
      - 502 Bad Gateway
      - 503 Service Unavailable
      - 504 Gateway Timeout