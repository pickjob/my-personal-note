# JCA学习
```java
    /**
     * MessageDigest
     */
    MessageDigest messageDigest = MessageDigest.getInstance("MD5"); // MD5 SHA-1 SHA-224 SHA-256 SHA-384 SHA-512 SHA-512/224 SHA-512/256 SHA3-256 SHA3-384 SHA3-512
    messageDigest.update(xx);
    byte[] result = messageDigest.digest();
    // messageDigest.reset()
    

    /**
     * Cipher AES/CBC/NoPadding(128)  AES/CBC/PKCS5Padding(128)  AES/ECB/NoPadding(128) AES/ECB/PKCS5Padding(128)
     *        DES/CBC/NoPadding(56)  DES/CBC/PKCS5Padding(56)  DES/ECB/NoPadding(56) DES/ECB/PKCS5Padding(56)
     *        RSA/ECB/PKCS1Padding(1024 2048)
     */
    /**
     * DES SecretKeyFactory(DES DESede)
     */
    // KeyGenerator AES(128)    DES(56)    DESede(168)  HmacSHA1  HmacSHA256
    KeyGenerator desKeyGenerator = KeyGenerator.getInstance("DES");
    byte[] keyBytes = desKeyGenerator.generateKey().getEncoded();
    // 加密解密器
    //    Cipher cipher = Cipher.getInstance("DES/ECB/PKCS5Padding");
    Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
    byte[] ivBytes = {0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8};
    IvParameterSpec desIvParameterSpec = new IvParameterSpec(ivBytes);
    DESKeySpec desKeySpec = new DESKeySpec(keyBytes);
    SecretKeyFactory desSecretKeyFactory = SecretKeyFactory.getInstance("DES");
    SecretKey desSecretKey = desSecretKeyFactory.generateSecret(desKeySpec);
    // 加密
    //    cipher.init(Cipher.ENCRYPT_MODE, desSecretKey);
    cipher.init(Cipher.ENCRYPT_MODE, desSecretKey, desIvParameterSpec);
    byte[] encryptData = cipher.doFinal(plainText.getBytes("UTF-8"));
    // 解密
    //    cipher.init(Cipher.DECRYPT_MODE, desSecretKey);
    cipher.init(Cipher.DECRYPT_MODE, desSecretKey, desIvParameterSpec);
    byte[] decryptData = cipher.doFinal(encryptData);

    /**
     * AES
     */
    // KeyGenerator AES(128)    DES(56)    DESede(168)  HmacSHA1  HmacSHA256
    KeyGenerator desKeyGenerator = KeyGenerator.getInstance("AES");
    byte[] keyBytes = desKeyGenerator.generateKey().getEncoded();
    // 加密解密器
    //    Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
    Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
    byte[] ivBytes = {0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf};
    IvParameterSpec aesIvParameterSpec = new IvParameterSpec(ivBytes);
    SecretKeySpec aesSecretKeySpec = new SecretKeySpec(keyBytes, "AES");
    // 加密
    //    cipher.init(Cipher.ENCRYPT_MODE, desSecretKey);
    cipher.init(Cipher.ENCRYPT_MODE, aesSecretKeySpec, aesIvParameterSpec);
    byte[] encryptData = cipher.doFinal(plainText.getBytes());
    // 解密
    //    cipher.init(Cipher.DECRYPT_MODE, desSecretKey);
    cipher.init(Cipher.DECRYPT_MODE, aesSecretKeySpec, aesIvParameterSpec);
    byte[] decryptData = cipher.doFinal(encryptData);
    
    /**
     * RSA KeyPairGenerator KeyFactory Cipher
     */
    // KeyPairGenerator RSA(1024 2048 4096) DSA(1024 2048)
    KeyPairGenerator rsaKeyPairGenerator = KeyPairGenerator.getInstance("RSA");
    rsaKeyPairGenerator.initialize(2048);
    KeyPair keyPair = rsaKeyPairGenerator.generateKeyPair();
    byte[] publicKeyBytes = keyPair.getPublic().getEncoded();
    byte[] privateKeyBytes = keyPair.getPrivate().getEncoded();
    KeyFactory rsaKeyFactory = KeyFactory.getInstance("RSA");
    // RSA公钥 X509编码
    X509EncodedKeySpec publicKeySpec = new X509EncodedKeySpec(publicKeyBytes);
    PublicKey publicKey = rsaKeyFactory.generatePublic(publicKeySpec);
    // 私钥 PKCS8编码
    PKCS8EncodedKeySpec privateKeySpec = new PKCS8EncodedKeySpec(privateKeyBytes);
    PrivateKey privateKey = rsaKeyFactory.generatePrivate(privateKeySpec);
    // 加密解密器
    Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
    // 加密
    cipher.init(Cipher.ENCRYPT_MODE, publicKey);
    byte[] encryptData = cipher.doFinal(plainText.getBytes());
    // 解密
    cipher.init(Cipher.DECRYPT_MODE, privateKey);
    byte[] decryptData = cipher.doFinal(encryptData);

    /*
     * Signature  SHA1withDSA  SHA256withDSA  SHA1withRSA  SHA256withRSA
     */
    Signature sha1withRSASignature = Signature.getInstance("SHA1withRSA");
    // 签名
    sha1withRSASignature.initSign(keyPair.getPrivate());
    sha1withRSASignature.update(plainText.getBytes());
    byte[] signature = sha1withRSASignature.sign();
    // 校验
    sha1withRSASignature.initVerify(keyPair.getPublic());
    sha1withRSASignature.update(plainText.getBytes());
    sha1withRSASignature.verify(signature);

    /**
     *  Mac
     */
    Mac mac = Mac.getInstance("HmacSHA256");
    mac.init(hmacSHA256SecretKey);
    mac.doFinal(plainText.getBytes());
```