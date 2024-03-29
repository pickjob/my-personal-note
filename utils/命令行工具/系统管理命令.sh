# 命令信息
    type [-t] CMD
# 进程信息
    ps -ef
    # 线程信息
    ps -T -p PID
#   top 排序
#       top -p PID
#           M: MEM
#           N: PID
#           P: CPU
#           T: TIME
#           H: Thread
#           移动: alt + hjkl
    top alt + hjkl
# 杀死进程
    kill [-9] PID
# 内存信息
    free --human
    vmstat --wide
# 程序的内存信息
    pmap --extended PID
# 程序依赖共享库信息
    ldd file
# 进程资源控制
#   ulimit
#       -a 显示所有资源控制
#       -b socket buffer size
#       -c maximum size of core files create
#       -f maximum size of files written
#       -n maximum number of open file descriptors
#       -T maximum number of threads
# CPU负载情况
#   mpstat
#       -A: -I ALL -u -P ALL
#       interval [count]
#       columns:
#           %usr: user level
#           %nice: user level with nice priority
#           %sys: system level
#           %iowait: waiting io
#           %irq: hardware interrupt
#           %soft: software interrupt
#           %steal:
#           %guest:
#           %idle: idle
    mpstat -A 1
    mpstat 1
# 显示时间
#   date +<FORMAT> : 指定输出格式
#       %S: seconde(00-60)
#       %M: minute(00-59)
#       %H: hour(00-23)
#       %d: day(01-31)
#       %m: month(01-12)
#       %Y: year(0000-9999)
#       %F: %Y-%m-%d
    date +'%Y-%m-%d %H:%M:%S'
# 显示/设置硬件时钟
#   hwclock:
#       --adjust: 自动调整硬件时钟时间
#       --systohc: 系统时间写入硬件时钟
#       --localtime: 使用本地时间
    hwclock --systohc
# 日历
    cal [--year / --months N]
# 系统运行时长
    uptime --pretty
