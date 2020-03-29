# DES(Data Encryption Standard)学习
- 算法过程: 以64位为分组对数据加密，56位参与DES运算（8、16、24、32、40、48、56、64位是校验位，使得每字节都有奇数个1），分组后的明文组和56位的密钥按位替代或交换的方法形成密文组
    - IP置换(数据处理)
        58      50      42      34      26      18      10      2
        60      52      44      36      28      20      12      4
        62      54      46      38      30      22      14      6
        64      56      48      40      32      24      16      8
        57      49      41      33      25      17       9      1
        59      51      43      35      27      19      11      3
        61      53      45      37      29      21      13      5
        63      55      47      39      31      23      15      7
        为L0和R0两部分，L0为新数据的左32位，R0为新数据的右32位
    - 密钥置换(8、16、24、32、40、48、56、64忽略, 最后密钥转为48bit)
        57      49      41      33      25      17      9
        1       58      50      42      34      26      18
        10      2       59      51      43      35      27
        19      11      3       60      52      44      36
        - 将56位的密钥分成两部分，每部分28位
        - 根据轮数(16)左移 1,1,2,2,2,2,2,2,1,2,2,2,2,2,2,1
        - 压缩置换(没有9，18，22，25，35，38，43, 54)
            14      17      11      24      1       5       3       28
            15      6       21      10      23      19      12      4
            26      8       16      7       27      20      13      2
            41      52      31      37      47      55      30      40
            51      45      33      48      44      49      39      56
            34      53      46      42      50      36      29      32
    - 扩展置换(将R0扩展为48bit)
        32      1       2       3       4       5 
        4       5       6       7       8       9 
        8       9       10      11      12      13
        12      13      14      15      16      17
        16      17      18      19      20      21
        20      21      22      23      24      25
        24      25      26      27      28      29
        28      29      30      31      32      1
        - 与密钥置换得到的轮密钥进行异或
    - 盒替换
        - 48位输入分为8个6位的分组, 一个分组对应一个S盒
        - 每个S盒有6位输入4位输出, 前2bit为行数，后4big为烈数
        - S1
            14      4       13      1       2       15      11      8       3       10      6       12      5       9       0       7 
            0       15      7       4       14      2       13      1       10      6       12      11      9       5       3       8 
            4       1       14      8       13      6       2       11      15      12      9       7       3       10      5       0 
            15      12      8       2       4       9       1       7       5       11      3       14      10      0       6       13
        - S2
            15      1       8       14      6       11      3       4       9       7       2       13      12      0       5       10
            3       13      4       7       15      2       8       14      12      0       1       10      6       9       11      5 
            0       14      7       11      10      4       13      1       5       8       12      6       9       3       2       15
            13      8       10      1       3       15      4       2       11      6       7       12      0       5       14      9 
        - S3
            10      0       9       14      6       3       15      5       1       13      12      7       11      4       2       8 
            13      7       0       9       3       4       6       10      2       8       5       14      12      11      15      1 
            13      6       4       9       8       15      3       0       11      1       2       12      5       10      14      7 
            1       10      13      0       6       9       8       7       4       15      14      3       11      5       2       12
        - S4
            7       13      14      3       0       6       9       10      1       2       8       5       11      12      4       15
            13      8       11      5       6       15      0       3       4       7       2       12      1       10      14      9 
            10      6       9       0       12      11      7       13      15      1       3       14      5       2       8       4 
            3       15      0       6       10      1       13      8       9       4       5       11      12      7       2       14
        - S5
            2       12      4       1       7       10      11      6       8       5       3       15      13      0       14      9 
            14      11      2       12      4       7       13      1       5       0       15      10      3       9       8       6 
            4       2       1       11      10      13      7       8       15      9       12      5       6       3       0       14
            11      8       12      7       1       14      2       13      6       15      0       9       10      4       5       3 
        - S6
            12      1       10      15      9       2       6       8       0       13      3       4       14      7       5       11
            10      15      4       2       7       12      9       5       6       1       13      14      0       11      3       8 
            9       14      15      5       2       8       12      3       7       0       4       10      1       13      11      6 
            4       3       2       12      9       5       15      10      11      14      1       7       6       0       8       13
        - S7
            4       11      2       14      15      0       8       13      3       12      9       7       5       10      6       1 
            13      0       11      7       4       9       1       10      14      3       5       12      2       15      8       6 
            1       4       11      13      12      3       7       14      10      15      6       8       0       5       9       2 
            6       11      13      8       1       4       10      7       9       5       0       15      14      2       3       12
        - S8
            13      2       8       4       6       15      11      1       10      9       3       14      5       0       12      7 
            1       15      13      8       10      3       7       4       12      5       6       11      0       14      9       2 
            7       11      4       1       9       12      14      2       0       6       10      13      15      3       5       8 
            2       1       14      7       4       10      8       13      15      12      9       0       3       5       6       11
    - P盒置换
        16      7       20      21      29      12       28        17
        1       15      23      26      5       18       31        10
        2       8       24      14      32      27       3         9 
        19      13      30      6       22      11       4         25
        - P盒置换的结果与最初的64位分组左半部分L0异或，然后左、右半部分交换，接着开始另一轮
    - IP-1末置换
        - DES最后一轮后，左、右两半部分并未进行交换，而是两部分合并形成一个分组做为末置换的输入。末置换规则如下表
            40      8       48      16      56      24      64      32
            39      7       47      15      55      23      63      31
            38      6       46      14      54      22      62      30
            37      5       45      13      53      21      61      29
            36      4       44      12      52      20      60      28
            35      3       43      11      51      19      59      27
            34      2       42      10      50      18      58      26
            33      1       41      9       49      17      57      25
- 加密模式(MODE)
    - ECB(Electronic Codebook Book): 分为若干相同长度段, 每一段加密(iv不需要)
    - CBC(Cipher Block Chaining): 分为若干相同长度段, 每一小段与上一段米文段一或运算再加密
    - CFB(Cipher FeedBack)
    - OFB(Output FeedBack)
- 初始化向量(Initialization Vector)
    - 8 byte
- 填充方式(PADDING)
    - PKCS#5 / PKCS#7: 填充字节值即为需填冲数(PKCS5用于block size为8)
    - ZeroPadding: 填充0
- Java示例
    ```java
    //  Cipher cipher = Cipher.getInstance("DES/ECB/PKCS5Padding");
    Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
    byte[] ivBytes = {0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7};
    IvParameterSpec desIvParameterSpec = new IvParameterSpec(ivBytes);
    DESKeySpec desKeySpec = new DESKeySpec(keyBytes);
    SecretKeyFactory desSecretKeyFactory = SecretKeyFactory.getInstance("DES");
    SecretKey desSecretKey = desSecretKeyFactory.generateSecret(desKeySpec);
    // 加密
    //  cipher.init(Cipher.ENCRYPT_MODE, desSecretKey);
    cipher.init(Cipher.ENCRYPT_MODE, desSecretKey, desIvParameterSpec);
    byte[] encryptData = cipher.doFinal(plainText.getBytes());
    // 解密
    //  cipher.init(Cipher.DECRYPT_MODE, desSecretKey);
    cipher.init(Cipher.DECRYPT_MODE, desSecretKey, desIvParameterSpec);
    byte[] decryptData = cipher.doFinal(encryptData);
    ```