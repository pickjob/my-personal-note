# RSA学习
- 长度
    - RSA长度: 模值长度
        - 1024bit
        - 2048bit
        - ...
    - 加密明文长度
        - 不padding最长为模值长度
        - PKCS#1 占用11个字节
        - 最长长度成为 (模值 / 8 - 11 ) bytes
- 公私钥编码
    - PKCS#1 (openssl默认生成公私钥格式, Java支持改格式公钥)
    - PKCS#8 (Java私钥唯一支持格式)
- Java示例
    ```java
    KeyFactory rsaKeyFactory = KeyFactory.getInstance("RSA");
    // RSA公钥 X509编码
    X509EncodedKeySpec publicKeySpec = new X509EncodedKeySpec(Base64.getDecoder().decode(publicKey));
    PublicKey publicKey = rsaKeyFactory.generatePublic(publicKeySpec);
    // 私钥 PKCS8编码
    PKCS8EncodedKeySpec privateKeySpec = new PKCS8EncodedKeySpec(Base64.getDecoder().decode(privateKey));
    PrivateKey privateKey = rsaKeyFactory.generatePrivate(privateKeySpec);
    // 加密解密器
    Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
    // 加密
    cipher.init(Cipher.ENCRYPT_MODE, publicKey);
    byte[] encryptData = cipher.doFinal(plainText.getBytes());
    // 解密
    cipher.init(Cipher.DECRYPT_MODE, privateKey);
    byte[] decryptData = cipher.doFinal(encryptData);
    ```