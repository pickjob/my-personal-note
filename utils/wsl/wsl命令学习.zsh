# 设置WSL版本
wsl --set-default-version <Version>
# 安装
wsl --install --distribution <Distribution Name>
# 升级内核版本
wsl --update
# 导出
wsl --export <Distribution Name> <FileName>
# 导入
wsl --import <Distribution Name> <InstallLocation> <FileName>

# 安装到其他盘符
wsl --install --distribution Debian
wsl --export Debian D:\Debian.tar
wsl --unregister Debian
wsl --import Debian D:\repository_all\VM\WSLDebian D:\Debian.tar
Debian config --default-user china
