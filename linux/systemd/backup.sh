#!/bin/bash
# 备份文件
tar --create --xz --verbose --file backup.xz .icons \
                                        .themes \
                                        .local/share/icons \
                                        .local/share/fonts \
                                        .local/share/plasma/desktoptheme \
                                        .local/share/plasma/look-and-feel \
                                        .local/share/aurorae \
                                        .local/share/color-schemes \
                                        /usr/share/sddm/themes \
