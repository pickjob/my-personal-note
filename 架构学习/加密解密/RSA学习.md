# RSA学习
- 加密模式(MODE)
    - ECB(Electronic Codebook Book): 分为若干相同长度段, 每一段加密(iv不需要)
    - CBC(Cipher Block Chaining): 分为若干相同长度段, 每一小段与上一段米文段一或运算再加密
    - CFB(Cipher FeedBack)
    - OFB(Output FeedBack)
- 填充方式(PADDING)
    - PKCS#1
    - PKCS#8
    - NOPADDING
- RSA密钥编码格式
    ```bash
    # PKCS1
    # 公钥
    -----BEGIN RSA PUBLIC KEY-----
    -----END RSA PUBLIC KEY-----
    # 私钥
    -----BEGIN RSA PRIVATE KEY-----
    -----END RSA PRIVATE KEY-----
    # PKCS8
    # 公钥
    -----BEGIN PUBLIC KEY-----
    -----END PUBLIC KEY-----
    # 私钥
    -----BEGIN PRIVATE KEY-----
    -----END PRIVATE KEY-----
    ```
- openssl生成RSA
    ```bash
    # openssl 默认是PKCS1Padding，Java支持PKCS8Padding私钥、PKCS1Padding、PKCS8padding公钥
    openssl genrsa -out private_key.pem 1024
    openssl pkcs8 -topk8 -inform PEM -in private_key.pem -outform PEM -nocrypt -out private_key_pkcs8.pem
    openssl rsa -in private_key.pem -pubout -out public_key.pem
    ```