#!/bin/bash

# 更新包列表并安装必要的依赖库
sudo apt-get update
sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

# 下载并解压Python 3.10.14源码包
cd /home/user/test
wget https://www.python.org/ftp/python/3.10.14/Python-3.10.14.tgz
tar -xzf Python-3.10.14.tgz
cd Python-3.10.14

# 配置和编译Python 3.10.14
./configure --enable-optimizations
make -j $(nproc)
sudo make altinstall

# 备份原来的python3和pip3符号链接
sudo mv /usr/bin/python3 /usr/bin/python3.bak
sudo mv /usr/bin/pip3 /usr/bin/pip3.bak

# 创建新的符号链接指向Python 3.10.14
sudo ln -s /usr/local/bin/python3.10 /usr/bin/python3

# 安装Python 3.10的pip
curl -sS https://bootstrap.pypa.io/get-pip.py | sudo /usr/local/bin/python3.10

# 创建pip3符号链接指向Python 3.10的pip
sudo ln -s /usr/local/bin/pip3.10 /usr/bin/pip3

# 验证安装
python3 --version
pip3 --version
