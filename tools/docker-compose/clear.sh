#!/bin/bash
sudo rm -rf ~/data
mkdir -p ~/data/mysql/data
mkdir -p ~/data/mysql/logs
mkdir -p ~/data/kafka
mkdir -p ~/data/elasticsearch
sudo chmod 777 -R ~/data/mysql/data
sudo chmod 777 -R ~/data/mysql/logs
sudo chmod 777 -R ~/data/elasticsearch
sudo chmod 777 -R ~/data/kafka
