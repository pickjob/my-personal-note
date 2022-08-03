# 磁盘信息
    lsblk --fs --perms
# 硬件设备、模块信息
    lspci -k
# 磁盘管理:
#   mount: 挂载指定文件系统(/etc/fstab)
#       --read-only
#       --read-write
#       --verbose
#       --type（/proc/filesystems /lib/modules/$(uname -r)/kernel/fs)
#           - ext2、3、4
#           - iso9660
#           - msdos、udf
#           - vfat
#           - nfs
#           - swap
#           - proc
    mount  /dev/sda   /media/cdrom
    # ntfs 挂载文件管理
    mount -t ntfs -o rw,auto,uid=uid,gid=gid,fmask=0066,dmask=0066 /dev/sda /path/file
#   umount: 卸载挂载的文件系统
#   fsck: 检查文件系统错误并修复
