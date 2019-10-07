# OAuth 2.0学习
- 流程
        +--------+                               +---------------+
        |        |--(A)- Authorization Request ->|   Resource    |
        |        |                               |     Owner     |
        |        |<-(B)-- Authorization Grant ---|               |
        |        |                               +---------------+
        |        |
        |        |                               +---------------+
        |        |--(C)-- Authorization Grant -->| Authorization |
        | Client |                               |     Server    |
        |        |<-(D)----- Access Token -------|               |
        |        |                               +---------------+
        |        |
        |        |                               +---------------+
        |        |--(E)----- Access Token ------>|    Resource   |
        |        |                               |     Server    |
        |        |<-(F)--- Protected Resource ---|               |
        +--------+                               +---------------+
- 授权类型
    - Authorization Code
        +----------+
        | Resource |
        |   Owner  |
        |          |
        +----------+
            ^
            |
        (B)
        +----|-----+          Client Identifier      +---------------+
        |         -+----(A)-- & Redirection URI ---->|               |
        |  User-   |                                 | Authorization |
        |  Agent  -+----(B)-- User authenticates --->|     Server    |
        |          |                                 |               |
        |         -+----(C)-- Authorization Code ---<|               |
        +-|----|---+                                 +---------------+
        |    |                                           ^      v
        (A)  (C)                                         |      |
        |    |                                           |      |
        ^    v                                           |      |
        +---------+                                      |      |
        |         |>---(D)-- Authorization Code ---------’      |
        |  Client |          & Redirection URI                  |
        |         |                                             |
        |         |<---(E)----- Access Token -------------------’
        +---------+       (w/ Optional Refresh Token)
        - Authorization Request(application/x-www-form-urlencoded)
            - response_type : code
            - client_id
            - redirect_uri
            - scope
            - state
        - Authorization Response(application/x-www-form-urlencoded)
            - code
            - state
        - Access Token Request
            - rant_type: authorization_code
            - code
            - redirect_uri
            - client_id
        - Access Token Response
            - access_token
            - token_type
            - expires_in
            - expire
            - scope
            - state
    - Implicit : 直接在浏览器中向认证服务器申请令牌
    - Resource Owner Password Credentials : 用户向客户端提供自己的用户名和密码
    - Client Credential : 客户端以自己的名义, 而不是以用户的名义