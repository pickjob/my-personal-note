# wsl命令学习
```bat
" linux文件系统: \\wsl$\Debian

" 安装
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
" 设置默认版本
wsl --set-default-version 2

wsl --list --verbose
# 关闭
wsl --terminate debian
" 注销
wslconfig /unregister debian

curl -s https://packagecloud.io/install/repositories/arkane-systems/wsl-translinux/script.deb.sh | sudo bash
```