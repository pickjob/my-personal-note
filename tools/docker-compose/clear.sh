#!/bin/bash

function chk_if_exists() {
    if [ `grep $1 /etc/passwd | grep -v grep | wc -l ` -gt 0 ]
    then
        echo $1': 已存在'
        return 0
    else
        return 1
    fi
}


sudo rm -rf ~/data

# mysql
mkdir -p ~/data/mysql/data
mkdir -p ~/data/mysql/logs
sudo chown --recursive 999:999 ~/data/mysql

# kafka
mkdir -p ~/data/kafka
sudo chown --recursive 1001:0 ~/data/kafka

# rocketmq
mkdir -p ~/data/rocketmq/broker/logs
mkdir -p ~/data/rocketmq/broker/store
sudo chown --recursive 3000:3000 ~/data/rocketmq

# elasticsearch
mkdir -p ~/data/elasticsearch
sudo chown --recursive 1000:0 ~/data/elasticsearch
