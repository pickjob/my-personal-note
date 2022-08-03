# 用户信息
    who
    whoami
    id
# 用户的新增、修改、删除
#   useradd / usermod / userdel
    useradd --groups wheel --shell /bin/bash --create-home china
    usermod --append --group Docker china
# 修改密码
    passwd [USER]
# 组的新增、修改、删除
#   groupadd / groupmod / groupdel
# 用户组的更改
    gpasswd --add USER GROUP
    gpasswd --delete USER GROUP
# 更改当前用户
    su -
    su USER
# 更改当前用户shell
    chsh --shell /bin/zsh
# 远程管理
    ssh -i identity_file [-P port] USER@HOST
    scp -i identity_file [-P port] USER@HOST:/path
# 默认的用户组
#       wheel:  管理组
#`      systemd-journal:  /var/log/journal/*  只读方式访问系统日志
