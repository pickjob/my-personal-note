#!/bin/bash
cur_dir=`pwd`
mkdir --parent ~/repository/bin/
cp --force --symbolic ${cur_dir}/startup.sh ~/repository/bin/
cp --force --symbolic ${cur_dir}/backup.sh ~/repository/bin/
mkdir --parent ~/.config/systemd/user/
cp --force --symbolic ${cur_dir}/startup.service ~/.config/systemd/user/
cp --force --symbolic ${cur_dir}/backup.timer ~/.config/systemd/user/
cp --force --symbolic ${cur_dir}/backup.service ~/.config/systemd/user/
