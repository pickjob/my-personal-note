# arthas学习
```bash
wget https://arthas.aliyun.com/arthas-boot.jar

java -jar arthas-boot.jar
java -jar arthas-boot.jar --target-ip 0.0.0.0

# dashboard
# thread 1
# sc/sm: 查找已加载类/方法 -d (具体信息) 支持通配符 
# jad demo.MathGame
# watch demo.MathGame primeFactors returnObj
# sysprop: JVM 信息
# sysenv: 环境变量
# ognl '@java.lang.System@out.println("hello ognl")'
# help
# quit

# 排查函数调用异常

    # loader
    # clazz
    # method
    # target
    # params
    # returnObj
    # throwExp
    # isBefore
    # isThrow
    # isReturn

watch com.example.demo.arthas.user.UserController * '{params, throwExp}' -e
```