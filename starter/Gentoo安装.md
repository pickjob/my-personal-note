# Gentoo安装
- 基本系统安装
    ```bash
    # ssh设置
    passwd
    rc-service sshd start
    ip addr
    # 磁盘配置
    # /dev/sda1 fat32 512M Boot/EFI system partition
    # /dev/sda2 ext4  Rest Root partition
    parted
    mklabel gpt && \
    mkpart primary 1M 513M && \
    name 1 EFI && \
    set 1 boot on && \
    mkpart primary 513M -1M && name 2 ROOT
    mkfs.fat -F 32 /dev/sda1 && \
    mkfs.ext4 /dev/sda2 && \
    mount /dev/sda2 /mnt/gentoo
    tar -xvf stage3
    # 配置make.conf
    # /mnt/gentoo/etc/portage/make.conf
    # -march=native
    echo 'MAKEOPTS="-j9"' >> /mnt/gentoo/etc/portage/make.conf && \
    echo 'GRUB_PLATFORMS="efi-64"' >> /mnt/gentoo/etc/portage/make.conf && \
    echo 'GENTOO_MIRRORS="https://mirrors.ustc.edu.cn/gentoo/"' >> /mnt/gentoo/etc/portage/make.conf && \
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
    # 挂载必要目录
    mount /dev/sda1 /mnt/gentoo/boot && \
    cp --dereference /etc/resolv.conf /mnt/gentoo/etc/ && \
    mount --types proc /proc /mnt/gentoo/proc && \
    mount --rbind /sys /mnt/gentoo/sys && \
    mount --make-rslave /mnt/gentoo/sys && \
    mount --rbind /dev /mnt/gentoo/dev && \
    mount --make-rslave /mnt/gentoo/dev
    # 切换 /
    chroot /mnt/gentoo /bin/bash
    source /etc/profile
    export PS1="(chroot) ${PS1}"
    # 基本系统安装
    emerge-webrsync
    emerge --sync
    emerge sys-kernel/gentoo-sources sys-kernel/genkernel app-shells/bash-completion app-editors/vim app-portage/gentoolkit
    eselect profile list
    eselect profile set 16
    echo '../../../../../targets/systemd' >> /etc/portage/make.profile/parent
    cat /etc/portage/make.profile/parent
    emerge --update --deep --with-bdeps=y --newuse @world
    emerge --depclean
    revdep-rebuild
    genkernel --menuconfig --install all
    emerge sys-kernel/linux-firmware sys-apps/systemd
    # 配置基本环境
    ln -sf /proc/self/mounts /etc/mtab && \
    echo '/dev/sda1 /boot vfat defaults,noatime 0 2' >> /etc/fstab && \
    echo '/dev/sda2 /     ext4 noatime          0 1' >> /etc/fstab
    emerge sys-boot/grub:2
    mount -o remount,rw /sys/firmware/efi/efivars
    grub-install --target=x86_64-efi --efi-directory=/boot
    # /etc/default/grub
    # GRUB_CMDLINE_LINUX="init=/usr/lib/systemd/systemd"
    grub-mkconfig -o /boot/grub/grub.cfg
    # 其他环境
    echo '[Match]' > /etc/systemd/network/dhcp.network && \
    echo 'Name=en*' >> /etc/systemd/network/dhcp.network && \
    echo '[Network]' >> /etc/systemd/network/dhcp.network && \
    echo 'DHCP=yes' >> /etc/systemd/network/dhcp.network
    systemd-machine-id-setup
    passwd
    exit
    reboot
    # 计算机设置
    hostnamectl set-hostname gentoo
    localectl set-locale LANG="zh_CN.utf8"
    timedatectl set-timezone Asia/Shanghai
    systemctl enable systemd-networkd.service
    systemctl start systemd-networkd.service
    systemctl start systemd-resolved.service
    systemctl enable systemd-resolved.service
    ln -snf /run/systemd/resolve/resolv.conf /etc/resolv.conf
    useradd -m -G users,wheel,portage,usb,audio,video -s /bin/bash china
    # GUI
    ./Nvidiaxxx.run
    eselect opengl set nvidia
    eselect opencl set nvidia
    emerge app-admin/sudo x11-terms/terminology
    echo 'china ALL = (ALL) ALL' > /etc/sudoers.d/china
    emerge x11-base/xorg-server
    emerge x11-wm/i3 x11-misc/dmenu x11-misc/i3blocks x11-misc/i3lock
    reboot
    echo 'exec i3' > xiinitrc
    startx
    ```
- 常用命令
    ```bash
    # 内核重建
    emerge @module-rebuild
    etc-update
    # 升级
    emerge --update --deep --with-bdeps=y --newuse @world
    emerge --depclean
    revdep-rebuild

    equery list *
    eread
    eclean

    # 常用软件安装
    emerge www-client/firefox
    ```
- i3学习
  - 快捷键
    - Alt + Enter: Terminal
    - Alt + Shift + E: Exit
    - Alt + D: Menu
    - Alt + Shift + Q: Close
    - Alt + Num: WorkSpace