# Gentoo安装
- 基本系统安装
    ```bash
    # ssh设置
    # passwd
    # rc-service sshd start && ip addr
    # 磁盘配置
    # /dev/sda1 fat32 512M Boot/EFI system partition
    # /dev/sda2 ext4  Rest Root partition
    parted
    mklabel gpt && mkpart primary 1M 513M && name 1 EFI && set 1 boot on && mkpart primary 513M -1M && name 2 ROOT
    # 格式化磁盘并挂载
    mkfs.fat -F 32 /dev/sda1 && mkfs.ext4 /dev/sda2 && mount /dev/sda2 /mnt/gentoo && mkdir --parent /mnt/gentoo/boot && mount /dev/sda1 /mnt/gentoo/boot
    tar -xvf stage3
    # 配置make.conf
    # -march=native /mnt/gentoo/etc/portage/make.conf 
    echo 'GENTOO_MIRRORS="https://mirrors.ustc.edu.cn/gentoo/"' >> /mnt/gentoo/etc/portage/make.conf && \
    echo 'USE="bindist "' >> /mnt/gentoo/etc/portage/make.conf && \
    echo 'MAKEOPTS="-j9"' >> /mnt/gentoo/etc/portage/make.conf && \
    echo 'GRUB_PLATFORMS="efi-64"' >> /mnt/gentoo/etc/portage/make.conf && \
    echo 'VIDEO_CARDS="nvidia"' >> /mnt/gentoo/etc/portage/make.conf && \
    echo 'INPUT_DEVICES="libinput synaptics"' >> /mnt/gentoo/etc/portage/make.conf && \
    mkdir --parents /mnt/gentoo/etc/portage/repos.conf && \
    echo '[DEFAULT]' >> /mnt/gentoo/etc/portage/repos.conf/ustc.conf && \
    echo 'main-repo = ustc' >> /mnt/gentoo/etc/portage/repos.conf/ustc.conf && \
    echo '[gentoo]' >> /mnt/gentoo/etc/portage/repos.conf/ustc.conf && \
    echo 'location = /usr/portage' >> /mnt/gentoo/etc/portage/repos.conf/ustc.conf && \
    echo 'sync-type = rsync' >> /mnt/gentoo/etc/portage/repos.conf/ustc.conf && \
    echo 'sync-uri = rsync://rsync.mirrors.ustc.edu.cn/gentoo-portage/' >> /mnt/gentoo/etc/portage/repos.conf/ustc.conf && \
    echo 'auto-sync = yes' >> /mnt/gentoo/etc/portage/repos.conf/ustc.conf
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
    emerge-webrsync
    eselect profile list
    eselect profile set 20
    cat /etc/portage/make.profile/parent
    emerge --update --deep --with-bdeps=y --newuse @world
    emerge --depclean
    emerge sys-kernel/gentoo-sources sys-apps/pciutils app-portage/gentoolkit app-portage/portage-utils app-editors/vim
    make defconfig && make menuconfig
    make && make modules_install && make install
    emerge sys-kernel/linux-firmware sys-boot/grub:2
    # 配置基本环境
    ln -sf /proc/self/mounts /etc/mtab && \
    echo '/dev/sda1     /boot vfat defaults,noatime 0 2' >> /etc/fstab && \
    echo '/dev/sda2     /     ext4 defaults,noatime 0 1' >> /etc/fstab
    mount -o remount,rw /sys/firmware/efi/efivars && grub-install --target=x86_64-efi --efi-directory=/boot
    # GRUB_CMDLINE_LINUX="init=/usr/lib/systemd/systemd" /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg
    passwd
    useradd --groups wheels,users --shell /bin/bash china 
    echo 'china ALL = (ALL) ALL' > /etc/sudoers.d/china
    echo 'consolefont="lat9w-16"' > /etc/conf.d/consolefont
    passwd china
    # 网络配置
    echo '[Match]' > /etc/systemd/network/dhcp.network && \
    echo 'Name=en*' >> /etc/systemd/network/dhcp.network && \
    echo '[Network]' >> /etc/systemd/network/dhcp.network && \
    echo 'DHCP=yes' >> /etc/systemd/network/dhcp.network
    emerge app-admin/sudo app-shells/bash-completion
    exit
    reboot
    ```
- 初次启动
    ```bash
    # 计算机基本设置
    systemd-machine-id-setup
    hostnamectl set-hostname GENTOO
    localectl set-locale LANG="zh_CN.utf8"
    timedatectl set-timezone 'Asia/Shanghai'
    systemctl start systemd-networkd.service && systemctl enable systemd-networkd.service
    systemctl start systemd-resolved.service && systemctl enable systemd-resolved.service
    ln -snf /run/systemd/resolve/resolv.conf /etc/resolv.conf
    # GUI
    ./Nvidiaxxx.run
    eselect opengl set nvidia
    eselect opencl set nvidia
    emerge x11-base/xorg-x11 x11-terms/guake
    emerge kde-plasma/plasma-meta && \
           kde-apps/kdeadmin-meta && \
           kde-apps/kdecore-meta && \
           kde-apps/kdegraphics-meta && \
           kde-apps/kdeutils-meta
    # 无线网卡
    emerge net-misc/dhcpcd-ui
    echo 'ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=users' > wpa_supplicant-wlp4s0.conf && \
    echo 'update_config=1' >> wpa_supplicant-wlp4s0.conf
    systemctl restart wpa_supplicant@wlp4s0 && systemctl enable wpa_supplicant@wlp4s0
    mkdir --parents /usr/lib/dhcpcd/dhcp-hooks/ && ln --symbolic /usr/share/dhcpcd/hooks/10-wpa_supplicant /usr/lib/dhcpcd/dhcp-hooks/
    systemctl restart dhcpcd && systemctl enable dhcpcd
    # 输入法
    emerge app-i18n/fcitx app-i18n/fcitx-configtool app-i18n/fcitx-sunpinyin
    echo 'eval "$(dbus-launch --sh-syntax --exit-with-session)"' >> ~/.xprofile
    echo 'export XMODIFIERS="@im=fcitx"' >> ~/.xprofile
    echo 'export QT_IM_MODULE=fcitx' >> ~/.xprofile
    echo 'export GTK_IM_MODULE=fcitx' >> ~/.xprofile
    echo 'fcitx &' >> ~/.xprofile
    echo 'guake &' >> ~/.xprofile
    # flatpak
    echo '[flatpak-overlay]' > /etc/portage/repos.conf/flatpak.conf
    echo 'priority = 50' >> /etc/portage/repos.conf/flatpak.conf
    echo 'location = /usr/flatpak-overlay' >> /etc/portage/repos.conf/flatpak.conf
    echo 'sync-type = git' >> /etc/portage/repos.conf/flatpak.conf
    echo 'sync-uri = https://github.com/fosero/flatpak-overlay.git' >> /etc/portage/repos.conf/flatpak.conf
    echo 'auto-sync = Yes' >> /etc/portage/repos.conf/flatpak.conf
    emerge --sync
    emerge sys-apps/flatpak
    reboot
    ```
- 常用命令
    ```bash
    # 内核重建
    emerge @module-rebuild
    # 升级
    emerge --update --deep --with-bdeps=y --newuse @world
    emerge --depclean
    revdep-rebuild
    etc-update

    # 常用软件安装
    emerge www-client/firefox-bin www-client/opera-developer && \
           dev-vcs/git dev-python/pip app-emulation/docker app-emulation/docker-compose
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install flathub com.axosoft.GitKraken
    flatpak install flathub com.syntevo.SmartGit
    flatpak install flathub com.visualstudio.code
    flatpak install flathub com.jetbrains.IntelliJ-IDEA-Community
    flatpak install flathub org.apache.netbeans
    flatpak install flathub com.getpostman.Postman
    flatpak install flathub 
    flatpak install flathub org.wireshark.Wireshark com.google.AndroidStudio io.dbeaver.DBeaverCommunity
    flatpak install flathub com.syntevo.SmartSynchronize com.github.muriloventuroso.easyssh com.github.mdh34.quickdocs

    ```