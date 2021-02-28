SET REMOT_ADDRES=192.168.0.106
scp make.conf root@%REMOT_ADDRES%:/mnt/gentoo/etc/portage
scp repos.conf root@%REMOT_ADDRES%:/mnt/gentoo/etc/portage
scp package.use root@%REMOT_ADDRES%:/mnt/gentoo/etc/portage
scp package.mask root@%REMOT_ADDRES%:/mnt/gentoo/etc/portage
scp fstab root@%REMOT_ADDRES%:/mnt/gentoo/etc
scp 50-dhcp.network root@%REMOT_ADDRES%:/mnt/gentoo/etc/systemd/network

@REM china root@%REMOT_ADDRES%:/mnt/gentoo/etc/sudoers.d
@REM system-auth root@%REMOT_ADDRES%:/mnt/gentoo/etc/pam.d
@REM wpa_supplicant.conf root@%REMOT_ADDRES%:/etc/wpa_supplicant/wpa_supplicant.conf
@REM xinitrc root@%REMOT_ADDRES%:/mnt/gentoo/home/china/.xinitrc
@REM xprofile root@%REMOT_ADDRES%:/mnt/gentoo/home/china/.xprofile
