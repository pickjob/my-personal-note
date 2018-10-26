#!/bin/bash

rsync -vaP --delete chuanglan disk
rsync -vaP --delete .vim disk
rsync -vaP --delete .dbeaver4 disk
rsync -vaP --delete code disk
rsync -vaP --delete repo disk
rsync -vaP --delete 软件开发 disk