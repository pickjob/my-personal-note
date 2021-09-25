
- 操作
    - 命令
        - Ctrl + Break: 滚动锁定
        - .prefer_dml 1: 设置DML输出兼容
        - .sympath cache*C:\Symbols;srv*https://msdl.microsoft.com/download/symbols
        - .srcpath+ C:\DriverSamples\KMDF_Echo_Sample\driver\AutoSync: 源代码路径
        - .sympath+ C:\DriverSamples\KMDF_Echo_Sample\driver\AutoSync: 调试符号路径
        - .reload /f
        - .hh: help

        - vertarget: target os version
        - lm: list module
            - lm v m tcpip
        - !lmi: 模块信息
        - !dh: 扩展展示头信息
        - ed nt!Kd_DEFAULT_MASK  0xFFFFFFFF: 调试掩码
        - g: 继续运行
        - x notepad!*: 展示模块符号列表
        - bm notepad!wWinMain:  设置断点
        - bl: 展示断电
        - k: 堆栈
        - ~: 线程
        - kb: 显示堆栈和前三个参数
        - kp: 显示参数的堆栈和完整列表
        - kn: 允许你查看堆栈，其中包含框架信息
        - !process
        - !thread
- 配置
    - 目标系统
    ```bat
    kdnet <YourHostIPAddress> <YourDebugPort> 
    ```
    - 主机系统
    ```bat
    windbg –k net:port=<YourDebugPort>,key=<YourDebugKey>
    ```
