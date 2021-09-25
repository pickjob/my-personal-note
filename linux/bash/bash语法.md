```bash
#!/bin/bash
# if-then-else-fi
# if-then-elif-then-fi
if command1 
then
    command2
else
    command3
fi
# case
case $USER in
rich | barbar)
    echo 'Hello rich'
testing)
    echo 'Hello testing'
esac
# for
for var in list
do
    command
done
# while
while [ command ]
do
    command
done
# until
until [ command ]
do
    command
done
# IFS(Internal field Separator)
# test(if [ ])
# 数值比较
#   n1 -eq n2 (n1 == n2)
#   n1 -ge n2 (n1 >= n2)
#   n1 -gt n2 (n1 >  n2)
#   n1 -le n2 (n1 <= n2)
#   n1 -lt n2 (n1 < n2)
# 字符串比较
#   str1 = str2 (str1.equ(str2))
#   str1 != str2
#   str1 < str2
#   str1 > str2
#   -n str1 (str1.length > 0)
#   -z str1 (str1.length == 0)
# 文件比较
#   -d file (文件是否存在，且是目录)
#   -e file (文件是否存在)
#   -f file (文件是否存在，且是文件)
#   -r file (文件是否存在，且是可读)
#   -s file (文件是否存在，且是非空)
#   -w file (文件是否存在，且是可写)
#   -x file (文件是否存在，且是可执行)
#   -O file (文件是否存在，且是当前用户所有)
#   -G file (文件是否存在，且是当前用户组)
#   file1 -nt file2 (file1 newer than file2)
#   file1 -ot file2 (file1 older than file2)
# function
function name {
    return
}
# 重定向
#   标准文件描述符
#       0: stdin
#       1: stdout
#       2: stderr
#   符号
#       >/>>: 输出重定向(覆盖/追加)
#       </<<: 输入重定向
#       |: 管道
#       >&: 2>&1 标准错误输出重定向至标准输出
# 特殊变量
#   $0: 程序名
#   $1 - $9: 参数
#   $* / $@: 所有参数
#   $#: 传入参数的个数
#   $[ operation]: 数学运算
#   $$: 当前PID
#   $?: 退出状态码
# 后台执行
#   nohup
nohup command > output.log 2>&1 &
#   setsid
#   bg(&)
#   fg
#   jobs
exit
```