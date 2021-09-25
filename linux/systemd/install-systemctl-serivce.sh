#!/bin/bash
cur_dir=`pwd`
mkdir --parent ~/.config/systemd/user/
cp --force --symbolic ${cur_dir}/startup.service ~/.config/systemd/user/
cp --force --symbolic ${cur_dir}/example.timer ~/.config/systemd/user/
cp --force --symbolic ${cur_dir}/example.service ~/.config/systemd/user/
