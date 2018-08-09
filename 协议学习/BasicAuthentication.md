# Basic HTTP Authentication Scheme
- 流程
    - 客户端请求受限资源
    - 服务端响应401 Unauthorized 并附带相应头 WWW-Authenticate: Basic realm="User Visible Realm"[ charset="UTF-8"]
    - 客户端重新请求附带请求头 Authorization: Basic xxx(user:password Base64)