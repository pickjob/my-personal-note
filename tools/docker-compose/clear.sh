#!/bin/bash
sudo rm -rf ~/data/mysql
mkdir -p ~/data/mysql/data
mkdir -p ~/data/mysql/logs
sudo chmod 777 -R ~/data/mysql/data
sudo chmod 777 -R ~/data/mysql/logs