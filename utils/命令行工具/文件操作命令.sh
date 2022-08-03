# 信息:
#   ls:
#       -l
#       --all
#       --human-readable
#       --inode
#       --sort=[none|size|time|version|extension]
#       --reverse
    ls -l --all --human-readable --sort=time
    tree .
#   du: 统计文件和目录占用的磁盘空间
#       --inodes
#       --human-readable
#       --max-depth
#   df: 显示文件系统磁盘使用情况
#       --human-readable
#       --inodes
#   blkid: 显示磁盘文件UUID
# 查找:
#   find:
#       -name pattern
#       -regex pattern
#       -type (b: block c: character d: directory p: named pipe f: regular file l: symbolic link s: socket)
#       -exec command( {} \; 绝对路径)
    find . -name 'docker*' -exec echo {} \;
#   fd:
#       --color=always
#       --ignore-case
#       --hidden
#       --list-details
#       --follow: symbolic links are also traversed
#       --max-depth
#       --type
#           f / file: regular files
#           d / directory: directories
#           l / symlink: symbolic links
#           x / executable: executables
#           e / empty: empty files or directories
#           s / socket: socket
#           p / pipe: named pipe (FIFO)
#       --exec <cmd>
#           {}: path
#           {/}:  basename
#           {//}: parent directory
#           {.}:  path without file extension
#           {/.}: basename without file extension
#       --exclude
# 切分:
#   cut:
#       --delimiter=DELIM: 分割字符
#       --fields=<N1-N2> / --bytes=<N1-N2> / --characters=<N1-N2>: 按字段、字节、 字符选择
    cut --delimiter=':' /etc/passwd --fields=1,6
#   awk: 切割文件行
#       -F 分割字符
#       -v var=value
#       ' exp {action $0}'
#           $0: 原始文件行
#           $1..n: 相对应字段
#           NF: 一条记录的字段的数目
#           FS：字段分隔符，默认是空格和制表符
#           RS：行分隔符，用于分割每一行，默认是换行符
#           OFS：输出字段的分隔符，用于打印时分隔字段，默认为空格。
#           ORS：输出记录的分隔符，用于打印时分隔记录，默认为换行符。
#           FILENAME: 当前文件名
#       action:
#           print
#           system
    echo '192.168.0.1/24' | awk -F'/' '{print $1}'
    echo 'A,B,C,D,E,F,G' | awk -v RS=',' '{print $1}'
# 排序:
#   sort
#       --ignore-case / --ignore-leading-blanks / --ignore-nonprinting
#       --numeric-sort
#       --reverse
#       --unique
# 流输出:
#   tee: 输出一个副本标准输出，一个指定到文件
    tee -a files
# 流输入:
#   xargs: 标准输入转为命令行参数
#       --delimiter=CHARACTER
# 文件创建、复制、删除、移动
    touch file
    mkdir --partents DIR
    ln --force --symbolic SRC DST
    mkfifo file
    cp --force --recursive SRC DST
    mv --force SRC DST
    rm --force --recursive DST
# tar: 归档
#       --create
#       --extract
#       --verbose
#       --file ARCHIVE
#       --gzip, --gunzip, --ungzip(.gz)
#       --compress, --uncompress(.Z)
#       --bzip2(.bz2)
#       --xz(.xz)
#       --lzip(.lzip)
#       --lzma(.lzma)
#       --lzop(.lzop)
    tar --create --gzip --verbose --file directory.tar.gz directory/
    tar --extract --verbose *.tar.gz -d directory
    tar --use-compress-program=unzstd -xvf archive.tar.zst
# 各个压缩包格式命令:
#       .gz: gzip guzip
#       .bz2: bzip2 bunzip2 bzcat
#       .zip uzip zipinfo(.zip)
# chmod: 改变文件(夹)属性
#       u: 文件拥有者 g: 同组用户 o: 其他用户 a: 所有用户
#       +: 加权限 -: 减去权限
#       r: 4 w: 2 x: 1
    chmod --recursive +x bin/*.sh
# chown: 改变文件所有者
    chown usr directory
