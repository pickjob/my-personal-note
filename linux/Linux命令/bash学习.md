# Bash学习
- 脚本文件模板
```bash
#!/bin/bash

exit
```
- 分支
    - if
        - if-then-else
            ```bash
                if command1 
                then
                    command2
                else
                    command3
                fi
            ```
        - if-then-elif-then
        - case
            ```bash
            #!/bin/bash
            case $USER in
            rich | barbar)
                echo 'Hello rich'
            testing)
                echo 'Hello testing'
            esac
            ```
        - test (if [ ])
            - 数值比较
                - n1 -eq n2 (n1 == n2)
                - n1 -ge n2 (n1 >= n2)
                - n1 -gt n2 (n1 >  n2)
                - n1 -le n2 (n1 <= n2)
                - n1 -lt n2 (n1 < n2)
            - 字符串比较
                - str1 = str2 (str1.equ(str2))
                - str1 != str2
                - str1 < str2
                - str1 > str2
                - -n str1 (str1.length > 0)
                - -z str1 (str1.length == 0)
            - 文件比较
                - -d file (文件是否存在，且是目录)
                - -e file (文件是否存在)
                - -f file (文件是否存在，且是文件)
                - -r file (文件是否存在，且是可读)
                - -s file (文件是否存在，且是非空)
                - -w file (文件是否存在，且是可写)
                - -x file (文件是否存在，且是可执行)
                - -O file (文件是否存在，且是当前用户所有)
                - -G file (文件是否存在，且是当前用户组)
                - file1 -nt file2 (file1 newer than file2)
                - file1 -ot file2 (file1 older than file2)
            - 复合测试
                - if [] && []
                - if [] || []
    - for
        - IFS(Internal field Separator)
        ```bash
            for var in list
            do
                command
            done
        ```
    - while
        ```bash
            while [ command ]
            do
                command
            done
        ```
    - until
        ```bash
            until [ command ]
            do
                command
            done
        ```
    - break
    - continue
- 位置参数
    - $0 : 程序名
    - $1 - $9 : 参数
    - $* / $@ : 所有位置参数
    - $# : 传入参数的个数
- 重定向
    - 标准文件描述符
        - 0 : stdin
        - 1 : stdout
            - cmd args 2>&1 output.txt / cmd &> out.put(错误重定向到标准输出)
        - 2-stderr
            - cmd 2>stderr.txt 1>stdout.txt
    - > : 输出重定向(覆盖)
    - >> : 输出重定向(追加)
    - < : 输入重定向
    - << : 内联重定向
    - | : 管道
    - &> : 标准输出(stdout) 和标准错误输出(stderr)重定向
    - >& : 2>&1 标准错误输出重定向至标准输出
- 测试是否存在命令
    ```bash
        command_test () { type "$1" &>/dev/null; }
        # 存在的命令,返回0
        cmd=rmdir
        command_test $cmd; echo $?
        # 不存在的命令,返回1
        cmd=bogus_command
        command_test $cmd; echo $?
    ```
- 数学运算
    - $[ operation]
- 退出状态码
    - $?
- 函数
    ```bash
        function name {

        }
        name(){
            return
        }
    ```
- 数组
    ```bash 
    array_var=(1 2 3 4 5)
    for data in ${array_var[@]}
    do
     echo ${data}
    done
    array_var[0]="test1"
    ```