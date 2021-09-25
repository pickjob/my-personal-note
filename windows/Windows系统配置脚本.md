```bat
@REM
@REM WSL Hyper-V Open
@REM
DISM /ONLINE /ENABLE-FEATURE /FEATURENAME:Microsoft-Windows-Subsystem-Linux /ALL /NORESTART
DISM /ONLINE /ENABLE-FEATURE /FEATURENAME:VirtualMachinePlatform /ALL /NORESTART
DISM /ONLINE /ENABLE-FEATURE /FEATURENAME:Microsoft-Hyper-V /ALL /NORESTART

@REM
@REM Defender Close
@REM
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender"  /f  /v "DisableAntiSpyware" /t REG_DWORD /d "1"

@REM
@REM WSL命令 linux文件系统: \\wsl$\Debian
@REM
@REM 设置默认版本
wsl --set-default-version 2
wsl --list --verbose
@REM 关闭
wsl --terminate debian
@REM 注销
wslconfig /unregister debian

@REM winget packages:
@REM 系统必备
winget install --location C:\tools\IntelliJIDEA.Community  JetBrains.IntelliJIDEA.Community
winget install Microsoft.VisualStudioCode
winget install Microsoft.WindowsTerminal
winget install msys2.msys2
winget install Git.Git
winget install vim.vim

@REM 编程语言
winget install OpenJS.NodeJSLTS
winget install Python.Python.3

winget install Microsoft.VisualStudio.2019.Community
winget install Microsoft.WindowsSDK
winget install Microsoft.WindowsWDK

@REM 开发工具
winget install Docker.DockerDesktop
winget install Postman.Postman
winget install TortoiseSVN.TortoiseSVN
winget install GitExtensionsTeam.GitExtensions
winget install sqlectron.sqlectron-gui
winget install HeidiSQL.HeidiSQL
winget install dbeaver.dbeaver
winget install WiresharkFoundation.Wireshark

@REM 系统工具
winget install 7zip.7zip
winget install Daum.Potplayer
winget install voidtools.Everything
winget install LibreOffice.LibreOffice
winget install Mozilla.FirefoxDeveloperEdition
winget install Tencent.WeChat
winget install Tencent.wechat-work

@REM 其他
winget install Microsoft.Powertoys
winget install SmartSoft.SmartFTP
winget install OpenVPNTechnologies.OpenVPN
winget install SmartBear.SoapUIOpenSource
winget install MongoDB.Compass.Community
winget install Oracle.VirtualBox
winget install TortoiseGit.TortoiseGit
winget install Microsoft.VisioViewer
winget install bitvise.SSHClient
winget install Devolutions.RemoteDesktopManagerFree

@REM msys2配置
@REM   /etc/pacman.d/mirrorlist.mingw32    Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/i686
@REM   /etc/pacman.d/mirrorlist.mingw64    Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/x86_64
@REM   /etc/pacman.d/mirrorlist.msys       Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/msys/$arch

@REM mingw64
@REM pacman -Syu
@REM pacman -S vim \
@REM         VCS \
@REM         mingw-w64-x86_64-toolchain \
@REM         mingw-w64-x86_64-gcc-libs \
@REM         mingw-w64-x86_64-qt6 \
@REM         mingw-w64-x86_64-qt-creator \
@REM         mingw-w64-x86_64-cmake \
@REM         mingw-w64-x86_64-rust \
@REM         mingw-w64-x86_64-rust-docs \
@REM         

@REM ln --symbolic /mingw64/bin/mingw32-make.exe /usr/bin/make


@REM
@REM    开启远程桌面: 设置 -> 系统 -> 远程桌面
@REM    无密码远程登录: secpol.msc  本地安全策略 -> 安全选项 -> 账户：使用空密码的本地账户只允许进行控制台登录 ->  已禁用
@REM
```
