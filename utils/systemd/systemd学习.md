# systemd学习
- systemctl
    - start
    - stop
    - kill
    - restart
    - status
    - enable
    - disable
    - daemon reload
    - list-unit-files --type=service
    - list-dependencies
    - 电源管理
        - reboot
        - poweroff
        - suspend
        - hibernate
        - hybrid-sleep
- journalctl
    - /etc/systemd/journald.conf
    - -k : 内核日志
    - -b : 本次启动日志
    - --since=""
    - -n
    - -f
    - _PID=1
    - _UID
    - -u
- systemd-analyze 查看启动耗时
    - blame 查看每个服务的启动耗时
    - critical-chain 显示瀑布状启动过程流
- hostnamectl
    - set-hostname : 设置主机名
- localectl
- timedatectl
- loginctl
- systemd-cgls 列出控制组
# 配置文件
- 配置文件路径
    - system mode
        - /etc/systemd/system/
        - /run/systemd/system/
        - /usr/lib/systemd/system/
    - user mode
        - /etc/systemd/user
        - /run/systemd/user
        - /usr/lib/systemd/user
        - $HOME/.config/systemd/user
- UNIT类型
    - service : 后台服务进程(*.service)
    - socket : (*.socket)
    - device : Linux设备树(*.device)
    - mount ： 一个挂载点(*.mount)
    - automount : 自挂载点(*.atomount)
    - path : (*.path)
    - scope : (*.scope)
    - slice : 进程组(*.slice)
    - swap : (*.swap)
    - target : 逻辑分组(*.target)
    - timer : 定时器配置单元(*.timer)
    - snapshot : (*.snapshot)
- 格式
    - [Unit]
        - Description：简短描述
        - Documentation：文档地址
        - Requires：当前 Unit 依赖的其他 Unit，如果它们没有运行，当前 Unit 会启动失败
        - Wants：与当前 Unit 配合的其他 Unit，如果它们没有运行，当前 Unit 不会启动失败
        - BindsTo：与Requires类似，它指定的 Unit 如果退出，会导致当前 Unit 停止运行
        - Before：如果该字段指定的 Unit 也要启动，那么必须在当前 Unit 之后启动
        - After：如果该字段指定的 Unit 也要启动，那么必须在当前 Unit 之前启动
        - Conflicts：这里指定的 Unit 不能与当前 Unit 同时运行
        - Condition...：当前 Unit 运行必须满足的条件，否则不会运行
        - Assert...：当前 Unit 运行必须满足的条件，否则会报启动失败
    - [Install]
        - WantedBy：它的值是一个或多个Unit，当前 Unit 激活时（enable）符号链接会放入/etc/systemd/system目录下面以Unit名 + .wants后缀构成的子目录中
        - RequiredBy：它的值是一个或多个Unit，当前 Unit 激活时，符号链接会放入/etc/systemd/system目录下面以Unit名 + .required后缀构成的子目录中
        - Alias：当前 Unit 可用于启动的别名
        - Also：同时激活、取消激活的unit
    - [Service]
        - Type：定义启动时的进程行为
            - simple：默认值，执行ExecStart指定的命令，启动主进程
            - forking：以 fork 方式从父进程创建子进程，创建后父进程会立即退出
            - oneshot：一次性进程，Systemd 会等当前服务退出，再继续往下执行
            - dbus：当前服务通过D-Bus启动
            - notify：当前服务启动完毕，会通知Systemd，再继续往下执行
            - idle：若有其他任务执行完毕，当前服务才会运行
        -  ExecStart：启动当前服务的命令
        -  ExecStartPre / ExecStartPost
        -  ExecReload：重启当前服务时执行的命令
        -  ExecStop / ExecStopPost
        -  Restart：定义何种情况 Systemd 会自动重启当前服务
            -  no
            -  always
            -  on-success
            -  on-failure
            -  on-abnormal
            -  on-abort
            -  on-watchdog
        - RestartSec：自动重启当前服务间隔的秒数
        - TimeoutSec：定义 Systemd 停止当前服务之前等待的秒数
        - Environment
            - ONE='one' "TWO='two two' too" THREE=
            - "ONE=one" 'TWO=two two'
        - PIDFile
    - [Timer]
        - OnActiveSec, OnBootSec, OnStartupSec, OnUnitActiveSec, OnUnitInactiveSec
        - OnCalendar
            - Thu,Fri 2012-*-1,5 11:12:13
            -  minutely → *-*-* *:*:00
            -  hourly → *-*-* *:00:00
            -  daily → *-*-* 00:00:00
            -  monthly → *-*-01 00:00:00
            -  weekly → Mon *-*-* 00:00:00
            -  yearly → *-01-01 00:00:00
            -  quarterly → *-01,04,07,10-01 00:00:00
            -  semiannually → *-01,07-01 00:00:00
        - AccuracySec
        - Unit
        - Persistent : true / false
        - WakeSystem : true / false
        - RemainAfterElapse : true / false
        - Time and date specifications
            - usec, us
            - msec, ms
            - seconds, second, sec, s
            - minutes, minute, min, m
            - hours, hour, hr, h
            - days, day, d
            - weeks, week, w
            - months, month, M (defined as 30.44 days)
            - years, year, y (defined as 365.25 days)
- Specifiers available in unit files
    - "%n"	Full unit name
    - "%N"	Unescaped full unit name
    - "%p"	Prefix name
    - "%P"	Unescaped prefix name
    - "%i"	Instance name
    - "%I"	Unescaped instance name	Same as "%i", but with escaping undone
    - "%f"	Unescaped filename
    - "%t"	Runtime directory root
    - "%S"	State directory root
    - "%C"	Cache directory root
    - "%L"	Log directory root
    - "%u"	User name
    - "%U"	User UID
    - "%h"	User home directory
    - "%s"	User shell
    - "%m"	Machine ID
    - "%b"	Boot ID
    - "%H"	Host name
    - "%v"	Kernel release
    - "%%"	Single percent sign
