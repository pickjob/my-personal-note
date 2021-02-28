# Gentoo安装
```bash
rc-service sshd start
# 分区:
#       /dev/sda1 fat32 512M EFI   EFI partition
#       /dev/sda2 ext4  Rest DATA  partition
parted /dev/sda
#       mklabel gpt
#       mkpart primary 1M 513M && name 1 EFI && set 1 boot on && mkpart primary 513M -1M && name 2 DATA
mkfs.fat -F 32 -n EFI /dev/sda1 && mkfs.ext4 -i 8192 -L DATA /dev/sda2
# 必要环境准备
mount /dev/sda2 /mnt/gentoo && mkdir --parent /mnt/gentoo/boot && mount /dev/sda1 /mnt/gentoo/boot
tar -xpvf stage3-*.xz --xattrs-include='*.*' --numeric-owner
cp --dereference /etc/resolv.conf /mnt/gentoo/etc && \
mount --types proc /proc /mnt/gentoo/proc && \
mount --rbind /sys /mnt/gentoo/sys && \
mount --make-rslave /mnt/gentoo/sys && \
mount --rbind /dev /mnt/gentoo/dev && \
mount --make-rslave /mnt/gentoo/dev
chroot /mnt/gentoo /bin/bash && source /etc/profile
export PS1="(chroot) ${PS1}"
rm -rf /etc/portage/package.use/
rm -rf /etc/portage/package.mask/
mount /tmp
# 执行copy-config.bat, 复制配置文件
emerge --sync
eselect profile list
# eselect profile set xx
emerge app-portage/cpuid2cpuflags
cpuid2cpuflags | awk -F: '{print "CPU_FLAGS_X86=\""$2"\"")}' >> /etc/portage/make.conf
emerge app-shells/bash-completion \
    app-portage/flaggie \
    dev-lang/rust-bin \
    virtual/rust \
    sys-fs/ntfs3g \
    app-editors/vim \
    sys-kernel/genkernel
emerge sys-kernel/gentoo-sources
emerge --update --newuse @world
# cd /usr/src/linux
make defconfig && make menuconfig
make -j9 && make modules_install && make install
genkernel --install --no-ramdisk-modules --firmware initramfs

emerge sys-kernel/linux-firmware
emerge sys-boot/grub:2 sys-boot/os-prober
# mount -o remount,rw /sys/firmware/efi/efivars
grub-install --target=x86_64-efi --efi-directory=/boot
# /etc/default/grub GRUB_CMDLINE_LINUX="init=/usr/lib/systemd/systemd" 
grub-mkconfig -o /boot/grub/grub.cfg
emerge sys-apps/systemd
ln -sf /proc/self/mounts /etc/mtab
passwd

# 初次启动
systemd-machine-id-setup
hostnamectl set-hostname GENTOO
locale-gen --all
localectl set-locale LANG=zh_CN.utf8
timedatectl set-timezone 'Asia/Shanghai'
timedatectl set-local-rtc 1 --adjust-system-clock
systemctl start systemd-networkd.service && systemctl enable systemd-networkd.service
systemctl start systemd-resolved.service && systemctl enable systemd-resolved.service
ln -snf /run/systemd/resolve/resolv.conf /etc/resolv.conf

# 必要软件
emerge x11-base/xorg-server \
    kde-plasma/plasma-meta \
    kde-plasma/discover \
    kde-apps/ark \
    kde-apps/dolphin \
    kde-apps/dolphin-plugins-git \
    kde-apps/dolphin-plugins-subversion \
    media-fonts/fira-code \
    app-admin/sudo \
    sys-process/htop \
    app-editors/gvim \
    x11-terms/guake \
    net-misc/dhcpcd \
    net-wireless/wpa_supplican \
    app-i18n/ibus app-i18n/ibus-libpinyin \
    media-sound/alsa-utils \
    dev-lang/go \
    dev-tcltk/expect
systemctl enable sddm.service
systemctl enable dhcpd.service
systemctl enable wpa_supplicant@wlp4s0
useradd --groups wheel --shell /bin/bash china
passwd china

emerge --ask --quiet --update --deep --with-bdeps=y --newuse @world
emerge --ask --quiet --update --deep --with-bdeps=y --changed-use @world

# 升级内核
# 更新
emerge --update --newuse @world
# 内核选择
eselect kernel list
eselect kernel set xx
# 备份
cp /usr/src/linux/.config ~/kernel-config-`uname -r`
# 配置
make olddefconfig && make menuconfig
# 安装
make && make modules_install && make install
# 外部构建
emerge @module-rebuild
grub-mkconfig -o /boot/grub/grub.cfg

# KDE环境配置
# Global Themes: Sweet KDE
# Aurorae Themes: Sweet Aurorae
# Icon Themes: Candy icons
# Wallpapers: Sweet wallpaper
# SDDM Login Themes: Sweet sddm
```
