# JSON Web Token(JWT)学习
- 格式
    - base64url_encode(Header) + '.' + base64url_encode(Claims) + '.' + base64url_encode(Signature)
    - Header
        - {"typ":"JWT","alg":"HS256"}
    - Claims (Payload)
        - {"iss":"mozillazg.com","exp":1435055117,"user_id":1,"foo":"bar"}
        - iss: The issuer of the token
        - sub: The subject of the token
        - exp: Expiration Time
        - iat: Issued At
        - jti: JWT ID
    - Signature
        - content = base64url_encode(Header) + '.' + base64url_encode(Claims)
        - signature = hmacsha256.hash(content)
- 注意
    - claims/playload并没有加密
    - base64url_encode编码而不是base64.b64encode是因为token可能会被用作url参数,而base64中的+,/,=在url里被转义成%2B%2F%3D,导致token的值变得更长了,所以这里使用 base64url,即进行如下替换+->-,/->_,删除=