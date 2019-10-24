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