# java命令学习
```bash
# 基本格式
java [options] mainclass [args...]
java [options] -jar jarfile [args...]
java [options] -m module[/mainclass] [args...]
java [options] source-file [args...]

options:
    # standard
        -Dproperty=value
        -verbose:class
        -verbose:gc
        -verbose:jni
        -verbose:module

        --class-path(-cp) classpath(; dir/*)

        --list-modules
        --describe-module(-d) module_name
        --add-modules [ALL-DEFAULT, ALL-SYSTEM, ALL-MODULE-PATH] 
        --module-path(-m) modulepath(; dir)
    # extra -X
        # heap for the young generation (nursery)
        -XX:NewSize / -XX:MaxNewSize
        -Xmn size
        # heap
        -Xms size
        -Xmx size
        # thread stack
        -Xss size
        # modules
        --add-reads   module=target-module(,target-module)*
        --add-exports module/package=target-module(,target-module)*
        --add-opens   module/package=target-module(,target-module)*
        --illegal-access=parameter permit / warn / debug / deny
    # advance -XX
        # runtime
        -XX:ErrorFile=./hs_err_pid%p.log
        -XX:MaxDirectMemorySize=size
        # jit
        # serviceability 
        -XX:HeapDumpPath=./java_pid%p.hprof
        -XX:+HeapDumpOnOutOfMemoryError
        # gc
```