# jcmd命令学习
```bash
# 基本格式
jcmd [pid | main-class] command... | PerfCounter.print | -f filename
options:
    command:
        GC:
            GC.class_histogram [options]
            GC.class_stats [options] [arguments]
            GC.finalizer_info
            GC.heap_dump [options] [arguments]
            GC.heap_info
            GC.run
            GC.run_finalization
        JFR:
            JFR.check [options]
            JFR.configure [options]
            JFR.dump [options]
            JFR.start [options]
            JFR.stop [options]
        ManagementAgent
            ManagementAgent.start [options]
            ManagementAgent.start_local
            ManagementAgent.status
            ManagementAgent.stop
        VM:
            VM.command_line
            VM.dynlibs
            VM.info
            VM.log [options]
            VM.flags [options]
            VM.native_memory [options]
            VM.print_touched_methods
            VM.set_flag [arguments]
            VM.stringtable [options]
            VM.symboltable [options]
            VM.systemdictionary
            VM.system_properties
            VM.uptime [options]
            VM.version
```