# Gentoo安装
- 基本系统安装
    ```bash
    # 磁盘配置
    # /dev/sda1 fat32 512M EFI   EFI partition
    # /dev/sda2 ext4  Rest DATA  partition
    parted
    mklabel gpt && mkpart primary 1M 513M && name 1 EFI && set 1 boot on && mkpart primary 513M -1M && name 2 DATA
    # 格式化磁盘并挂载
    mkfs.fat -F 32 -n EFI /dev/sda1 && mkfs.ext4 -i 8192 -L DATA /dev/sda2
    mount /dev/sda2 /mnt/gentoo && mkdir --parent /mnt/gentoo/boot && mount /dev/sda1 /mnt/gentoo/boot
    tar -xvf stage3
    # 配置 /etc/portage/make.conf
    # 配置 /etc/portage/package.use
    # 配置 /etc/portage/repos.conf
    # 必要环境准备
    cp --dereference /etc/resolv.conf /mnt/gentoo/etc/ && \
    mount --types proc /proc /mnt/gentoo/proc && \
    mount --rbind /sys /mnt/gentoo/sys && \
    mount --make-rslave /mnt/gentoo/sys && \
    mount --rbind /dev /mnt/gentoo/dev && \
    mount --make-rslave /mnt/gentoo/dev
    # 切换 /
    chroot /mnt/gentoo /bin/bash && source /etc/profile 
    export PS1="(chroot) ${PS1}"
    # 基本系统安装
    emerge --sync
    eselect profile list
    eselect profile set 16
    cat /etc/portage/make.profile/parent
    emerge --update --deep --with-bdeps=y --newuse @world
    emerge --depclean
    emerge sys-kernel/gentoo-sources
    make defconfig && make menuconfig
    make && make modules_install && make install
    emerge sys-kernel/linux-firmware
    # 配置基本环境
    emerge sys-apps/systemd sys-boot/grub:2 app-admin/sudo
    ln -sf /proc/self/mounts /etc/mtab && \
    echo 'LABEL=EFI      /boot vfat defaults,noatime 0 2' >> /etc/fstab && \
    echo 'LABEL=DATA     /     ext4 defaults,noatime 0 1' >> /etc/fstab
    mount -o remount,rw /sys/firmware/efi/efivars && grub-install --target=x86_64-efi --efi-directory=/boot
    # GRUB_CMDLINE_LINUX="init=/usr/lib/systemd/systemd" /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg
    passwd
    useradd --groups wheel --shell /bin/bash china
    echo 'china ALL = (ALL) ALL' > /etc/sudoers.d/china
    passwd china
    # 配置 /etc/systemd/network/dhcp.netword
    emerge net-wireless/wpa_supplicant net-misc/dhcpcd net-misc/dhcpcd-ui
    # 配置 /etc/wpa_supplicant/wpa_supplicant-wlp4s0.conf
    mkdir --parents /usr/lib/dhcpcd/dhcp-hooks/ && ln --symbolic /usr/share/dhcpcd/hooks/10-wpa_supplicant /usr/lib/dhcpcd/dhcp-hooks/
    # 输入法
    emerge app-i18n/fcitx app-i18n/fcitx-configtool app-i18n/fcitx-sunpinyin
    # Sound
    emerge media-sound/alsa-utils media-sound/rhythmbox
    # GUI
    emerge x11-base/xorg-server \
           media-fonts/fira-code media-fonts/source-pro media-fonts/noto-cjk \
           lxqt-base/lxqt-meta x11-themes/lxqt-themes x11-misc/lightdm x11-misc/lightdm-gtk-greeter
    # 基本工具
    emerge  dev-libs/nss dev-vcs/git dev-python/pip \
            app-portage/conf-update app-portage/portage-utils app-portage/gentoolkit \
            app-editors/vim app-shells/bash-completion app-arch/p7zip \
            net-misc/curl net-misc/telnet-bsd net-misc/ntp \
            sys-apps/pciutils sys-auth/consolekit \
            sys-block/parted sys-fs/dosfstools sys-process/htop \
            x11-terms/guake
    exit
    reboot
    ```
- 初次启动
    ```bash
    # 计算机基本设置
    systemd-machine-id-setup
    hostnamectl set-hostname GENTOO
    localectl set-locale LANG=zh_CN.utf8
    timedatectl set-timezone 'Asia/Shanghai'
    timedatectl set-local-rtc 1
    systemctl start systemd-networkd.service && systemctl enable systemd-networkd.service
    systemctl start systemd-resolved.service && systemctl enable systemd-resolved.service
    ln -snf /run/systemd/resolve/resolv.conf /etc/resolv.conf
    systemctl restart wpa_supplicant@wlp4s0 && systemctl enable wpa_supplicant@wlp4s0
    systemctl restart dhcpcd && systemctl enable dhcpcd
    reboot
    ```
- 其他常用命令
    ```bash
    # 内核重建
    emerge @module-rebuild
    # 升级
    emerge --update --deep --with-bdeps=y --newuse @world
    emerge --depclean
    revdep-rebuild
    etc-update

    # 常用软件安装
    emerge www-client/firefox-bin www-client/opera \
           net-misc/teamviewer sys-apps/yarn \
           app-emulation/docker app-emulation/docker-compose
    # themes
    git clone https://github.com/addy-dclxvi/openbox-theme-collections ~/.themes
    # rust
    curl https://sh.rustup.rs | bash
    rustup component add rls rust-analysis rust-src rustfmt
    # yarn
    curl -o- -L https://yarnpkg.com/install.sh | bash
    # fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
    # vim
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    # npm
    npm install -g typescript
    npm install -g @angular/cli
    # python
    pip3 install --user requests beautifulsoup4
    # git
    git config --global user.email "pickjob@126.com"
    git config --global user.name "吴胜"
    # docker image pull pickjob/pause:3.1
    # docker tag pickjob/pause:3.1 k8s.gcr.io/pause:3.1
    # docker image pull pickjob/k8s-dns-kube-dns-amd64:1.14.7
    # docker tag pickjob/k8s-dns-kube-dns-amd64:1.14.7 gcr.io/google_containers/k8s-dns-kube-dns-amd64:1.14.7
    # docker image pull pickjob/k8s-dns-dnsmasq-nanny-amd64:1.14.7
    # docker tag pickjob/k8s-dns-dnsmasq-nanny-amd64:1.14.7 gcr.io/google_containers/k8s-dns-dnsmasq-nanny-amd64:1.14.7
    # docker image pull pickjob/k8s-dns-sidecar-amd64:1.14.7
    # docker tag pickjob/k8s-dns-sidecar-amd64:1.14.7 gcr.io/google_containers/k8s-dns-sidecar-amd64:1.14.7
    # docker image pull pickjob/heapster-influxdb-amd64:v1.3.3
    # docker tag pickjob/heapster-influxdb-amd64:v1.3.3 k8s.gcr.io/heapster-influxdb-amd64:v1.3.3
    # docker image pull pickjob/heapster-grafana-amd64:v4.4.3
    # docker tag pickjob/heapster-grafana-amd64:v4.4.3 k8s.gcr.io/heapster-grafana-amd64:v4.4.3
    # docker image pull pickjob/kubernetes-dashboard-amd64:v1.8.3
    # docker tag pickjob/kubernetes-dashboard-amd64:v1.8.3 k8s.gcr.io/kubernetes-dashboard-amd64:v1.8.3
    # docker image pull pickjob/heapster-amd64:v1.5.2
    # docker tag pickjob/heapster-amd64:v1.5.2 k8s.gcr.io/heapster-amd64:v1.5.2
    ```