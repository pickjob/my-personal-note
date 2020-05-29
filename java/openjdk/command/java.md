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
    # log
    -Xlog[:[what][:[output][:[decorators][:output-options[,...]]]]]
        what:
            tag=level
        output:
            file=%p_%t
        decorators:
            time or t 	        Current time and date in ISO-8601 format.
            utctime or utc 	    Universal Time Coordinated or Coordinated Universal Time.
            uptime or u 	    Time since the start of the JVM in seconds and milliseconds. For example, 6.567s.
            timemillis or tm 	The same value as generated by System.currentTimeMillis()
            uptimemillis or um 	Milliseconds since the JVM started.
            timenanos or tn 	The same value generated by System.nanoTime().
            uptimenanos or un 	Nanoseconds since the JVM started.
            hostname or hn 	    The host name.
            pid or p 	        The process identifier.
            tid or ti 	        The thread identifier.
            level or l 	        The level associated with the log message.
            tags or tg 	        The tag-set associated with the log message.
        output-options:
            filecount
            filesize
        -Xlog:gc+heap=trace:file=%p_%t.txt:time,hostname,pid,tid,level,tags:filesize=10240
```