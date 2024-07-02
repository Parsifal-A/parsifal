#!/bin/bash

# 检查是否安装lsof
echo "Checking if lsof is installed..."
if ! command -v lsof &> /dev/null
then
    echo "lsof is not installed. Installing lsof..."
    if [ -x "$(command -v apt-get)" ]; then
        sudo apt-get update
        sudo apt-get install -y lsof
    elif [ -x "$(command -v yum)" ]; then
        sudo yum install -y lsof
    else
        echo "Package manager not found. Please install lsof manually."
        exit 1
    fi
else
    echo "lsof is already installed."
fi

# 检查8080端口是否被占用
echo "Checking if port 8080 is in use..."
output=$(sudo lsof -i :8080)

if [ -z "$output" ]; then
    echo "Port 8080 is not in use."
else
    echo "Port 8080 is in use by the following process:"
    echo "$output"
    
    # 提取PID并终止进程
    pid=$(echo "$output" | awk 'NR==2 {print $2}')
    echo "Killing process with PID $pid"
    sudo kill -9 $pid
    
    echo "Process with PID $pid has been terminated."
fi
