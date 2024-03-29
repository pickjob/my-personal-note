
# 模块配置:
#       /etc/modules-load.d/*.conf
#       /etc/modprobe.d/*.conf
# 模块:
#       /lib/modules
# 内核日志
    dmesg --kernel --human [--follow]
    dmesg --userspace --human [--follow]
# 模块信息
    lsmod
    modinfo FileName
# 生成依赖关系
    depmod [--show] [--verbose]
# 模块装载和卸载
    insmod FileName
    rmmod [--force] FileName
# modprobe: 向内核增加或者删除指定模块
#   --show-depends moduleName
#   moduleName
#   --remove
