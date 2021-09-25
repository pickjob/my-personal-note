@echo off
SET REMOT_ADDRES=127.0.0.1
SET PREFIX=/mnt/gentoo

scp fstab root@%REMOT_ADDRES%:%PREFIX%/etc
scp system-auth root@%REMOT_ADDRES%::%PREFIX%/etc/pam.d
scp make.conf root@%REMOT_ADDRES%:%PREFIX%/etc/portage
scp repos.conf root@%REMOT_ADDRES%:%PREFIX%/etc/portage
scp package.use root@%REMOT_ADDRES%:%PREFIX%/etc/portage
scp package.mask root@%REMOT_ADDRES%:%PREFIX%/etc/portage
scp package.accept_keywords root@%REMOT_ADDRES%:%PREFIX%/etc/portage
