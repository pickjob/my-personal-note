# http协议学习
- HTTP1/1.1
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
              0\r\n
              \r\n
              ```
    - version
        - HTTP/1.0
        - HTTP/1.1
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
- Http2
    - Frame Format
        - Fixed 9-octet
            - Lenght(24 bit): 默认不超过 14 bit
            - Type(8 bit)
                - DATA(0x0)
                - HEADERS(0x1)
                - PRIORITY(0x2)
                - RST_STREAM(0x3)
                - SETTINGS(0x4)
                - PUSH_PROMISE(0x5)
                - PING(0x6)
                - GOAWAY(0x7)
                - WINDOW_UPDATE(0x8)
                - CONTINUATION(0x9)
            - Flags(8 bit)
                - DATA
                    - END_STREAM(0x1)
                    - PADDED(0x8)
                - HEADERS
                    - END_STREAM(0x1)
                    - END_HEADERS(0x4)
                    - PADDED(0x8)
                    - PRIORITY(0x20)
                - SETTINGS
                    - ACK(0x1)
                - PUSH_PROMISE
                    - END_HEADERS (0x4)
                    - PADDED (0x8)
                - PING
                    - ACK(0x1)
                - CONTINUATION
                    - END_HEADERS (0x4)
            - R(1 bit 0x0)
            - Stream Identifier(32 bit)
        - Frame Payload
            - DATA
                - Pad Length ? (8)
                - Data (*)
                - Padding (*)
            - HEADERS
                - Pad Length ? (8)
                - E
                - Stream Dependency ? (31)
                - Weight ? (8)
                - Header Block Fragment (*)
                - Padding
            - PRIORITY
                - E
                - Stream Dependency (31)
                - Weight (8)
            - RST_STREAM
                - Error Code (32)
            - SETTINGS
                - Identifier (16)
                    - SETTINGS_HEADER_TABLE_SIZE (0x1)
                    - SETTINGS_ENABLE_PUSH (0x2)
                    - SETTINGS_MAX_CONCURRENT_STREAMS (0x3)
                    - SETTINGS_INITIAL_WINDOW_SIZE (0x4)
                    - SETTINGS_MAX_FRAME_SIZE (0x5)
                    - SETTINGS_MAX_HEADER_LIST_SIZE (0x6)
                - Value (32)
            - PUSH_PROMISE
                - Pad Length ? (8)
                - R
                - Promised Stream ID (31)
                - Header Block Fragment (*)
                - Padding (*)
            - PING
                - Opaque Data (64)
            - GOAWAY
                - R
                - Last-Stream-ID (31)
                - Error Code (32)
                - Additional Debug Data (*)
            - WINDOW_UPDATE
                - R
                - Window Size Increment (31)
            - CONTINUATION
                - Header Block Fragment
        - Error Code
            - NO_ERROR (0x0)
            - PROTOCOL_ERROR (0x1)
            - INTERNAL_ERROR (0x2)
            - FLOW_CONTROL_ERROR (0x3)
            - SETTINGS_TIMEOUT (0x4)
            - STREAM_CLOSED (0x5)
            - FRAME_SIZE_ERROR (0x6)
            - REFUSED_STREAM (0x7)
            - CANCEL (0x8)
            - COMPRESSION_ERROR (0x9)
            - CONNECT_ERROR (0xa)
            - ENHANCE_YOUR_CALM (0xb)
            - INADEQUATE_SECURITY (0xc)
            - HTTP_1_1_REQUIRED (0xd)