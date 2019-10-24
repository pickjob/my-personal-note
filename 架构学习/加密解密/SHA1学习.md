# SHA1(Secure Hash Algorithm)学习
- 算法过程: 512bit一组，4 * 20组计算，生成160bit( 5 * 32bit)散列值
    - 源数据处理
        - 填充一个1和n个0, 使源数据长度 Len mod 512 = 448
        - 用64bit来存储填充前信息长度
        - 最终结果: 源数据 + 填充数据 + 消息长度(64bit) Len为512倍数
    - 预定义函数及常量
        - A = 0x67452301, B = 0xEFCDAB89, C = 0x98BADCFE, D = 0x10325476, E = 0xC3D2E1F0
        - Kt = 0x5A827999 (0 <= t < 20)
        - Kt = 0x6ED9EBA1 (20 <= t < 40)
        - Kt = 0x8F1BBCDC (40 <= t < 60)
        - Kt = 0xCA62C1D6 (60 <= t < 80)
    - 计算过程
        - 一组16子小组扩充为80个自小组
            - W[i] = Mj (0 <= i < 16)
            - W[i] = (W[i-3] ^ W[i-8] ^ W[i- 14] ^ W[i-16]) <<< 1 (16 <= i < 80)
        - 第一轮(0 <= i < 20)
            temp = a <<< 5 + ((b & c) | ((~b) & d)) + e + W[i] + k[i]
            e = d
            d = c
            c = b <<< 30
            b = a
            a = temp
        - 第二轮(20 <= i < 40)
            temp = a <<< 5 + (b ^ c ^ d) + e + W[i] + k[i]
            e = d
            d = c;
            c = b <<< 30
            b = a
            a = temp
        - 第三轮(40 <= i < 60)
            temp = a <<< 5 + ((b & c)|(b & d)|(c & d)) + e + W[i] + k[i]
            e = d
            d = c
            c = b <<< 30
            b = a
            a = temp
        - 第四轮(60 <= i < 80)
            temp = a <<< 30 + (b ^ c ^ d) + e + W[i] + k[i];
            e = d
            d = c;
            c = b <<< 30
            b = a
            a = temp
        - 循环累积
            - A += a
            - B += b
            - C += c
            - D += d
            - E += e
        - ft(B,C,D) = (B AND C) OR ((NOT B) AND D) ( 0 <= t <= 19)
        - ft(B,C,D) = B XOR C XOR D (20 <= t <= 39)
        - ft(B,C,D) = (B AND C) OR (B AND D) OR (C AND D) (40 <= t <= 59)
        - ft(B,C,D) = B XOR C XOR D (60 <= t <= 79)
            - 16份子明文分组扩展为80份
                - 
            - 80份子明文分组进行4轮运算
                - TEMP = A <<< 5 + ft(B,C,D) + E + W[i] + K[i]
                - E = D
                - D = C
                - C = B <<< 30
                - B = A
                - A = TEMP
            - 累加
                - A = a + A
                - B = b + B
                - C = c + C
                - D = c + D
                - E = e + E
            - A - B - C - D - E
    - 组合结果
        - A - B - C - D (显示内存中数值，如预定义数值反向操作)