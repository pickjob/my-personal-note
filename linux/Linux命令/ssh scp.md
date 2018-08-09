# SSH 命令
- ssh 
    - [-p port] : 指定远程主机端口
    - [user@hostname]

# SCP 命令
- scp
    - [-P port] : 指定远程端口
    - [[user@host1:]file]
    - [[user@host2:]file2]

# 无密码配置
- cd ~/.ssh/
- ssh-keygen -t rsa
- scp id_rsa.pub user@server:~/.ssh/id_rsa.pub
- ssh user@server
- cd ~/.ssh
- cp authorized_keys authorized_keys.bak
- cat id_rsa.pub >> authorized_keys
- chmod 700 ~/.ssh
- chmod 600 ~/.ssh/authorized_keys