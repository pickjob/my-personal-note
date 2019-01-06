# WSL配置
- 运行VSCODE
  - Install VcXsrv on Windows
  - Install code on wsl
    ```bash
    sudo apt-get install -y libgtk2.0-0 libxss1 libasound2
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt update
    sudo apt install -y code
    ```
  - Configura wsl
    ```bash
    # .bashrc
    # X Server
    export LIBGL_ALWAYS_INDIRECT=1
    export DISPLAY=0:0
    sudo /etc/init.d/dbus start &> /dev/null
    # /etc/sudoers.d/dbus
    your_username ALL = (root) NOPASSWD: /etc/init.d/dbus
    ```
  - Launch XLaunch and VS Code
- python环境
  - sudo apt -y install python3 python3-pip
- rust环境
  - curl https://sh.rustup.rs -sSf | sh
  - rustup update
  - rustup component add rls-preview rust-analysis rust-src
  - sudo apt install -y gcc