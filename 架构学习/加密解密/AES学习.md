# AES(Advanced Encryption Standard)学习
- 密钥长度
    - AES-128, 128bit密钥, 128bit分组, 10轮加密
    - AES-192, 192bit密钥, 128bit分组, 12轮加密
    - AES-256, 256bit密钥, 128bit分组, 14轮加密
- 加密方式(MODE)
    - ECB(Electronic Codebook Book): 分为若干相同长度段, 每一段加密(iv不需要)
    - CBC(Cipher Block Chaining): 分为若干相同长度段, 每一小段与上一段米文段一或运算再加密
    - CFB(Cipher FeedBack)
    - OFB(Output FeedBack)
- 初始化向量(Initialization Vector)
    - 16 byte
- 填充方式(PADDING)
    - ZeroPadding
    - PKCS#5 / PKCS#7
- Java示例
    ```java
    //  Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
    Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
    byte[] ivBytes = {0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf};
    IvParameterSpec aesIvParameterSpec = new IvParameterSpec(ivBytes);
    SecretKeySpec aesSecretKeySpec = new SecretKeySpec(keyBytes, "AES");
    // 加密
    //  cipher.init(Cipher.ENCRYPT_MODE, desSecretKey);
    cipher.init(Cipher.ENCRYPT_MODE, aesSecretKeySpec, aesIvParameterSpec);
    byte[] encryptData = cipher.doFinal(plainText.getBytes("UTF-8"));
    // 解密
    //  cipher.init(Cipher.DECRYPT_MODE, desSecretKey);
    cipher.init(Cipher.DECRYPT_MODE, aesSecretKeySpec, aesIvParameterSpec);
    byte[] decryptData = cipher.doFinal(encryptData);
    ```