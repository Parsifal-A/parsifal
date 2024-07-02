# 检查是否安装wget
echo "Checking if wget is installed..."
! command -v wget &> /dev/null && echo "wget is not installed, installing wget..." && sudo apt-get update && sudo apt-get install -y wget || echo "wget is already installed"

# 检查是否安装Python3
echo "Checking if Python3 is installed..."
! command -v python3 &> /dev/null && echo "Python3 is not installed, installing Python3..." && sudo apt-get update && sudo apt-get install -y python3 || echo "Python3 is already installed"

# 下载api_server.zip文件
echo "Downloading api_server.zip..."
wget https://multi-pc-test.oss-cn-shanghai.aliyuncs.com/api_server.zip

# 下载initiate_device_A100.zip文件
echo "Downloading initiate_device_A100.zip..."
wget https://multi-pc-test.oss-cn-shanghai.aliyuncs.com/initiate_device_A100.zip

# 检查是否安装unzip
echo "Checking if unzip is installed..."
! command -v unzip &> /dev/null && echo "unzip is not installed, installing unzip..." && sudo apt-get install -y unzip || echo "unzip is already installed"

# 解压api_server.zip文件
echo "Unzipping api_server.zip..."
unzip api_server.zip

# 解压initiate_device_A100.zip文件
echo "Unzipping initiate_device_A100.zip..."
unzip initiate_device_A100.zip

# 检查是否安装pip3
echo "Checking if pip3 is installed..."
! command -v pip3 &> /dev/null && echo "pip3 is not installed, installing pip3..." && sudo apt-get install -y python3-pip || echo "pip3 is already installed"

# 安装api_server的依赖
echo "Installing dependencies for api_server..."
cd api_server/api_server
pip3 install -r requirement.txt

# 赋予pow_exec/main执行权限
echo "Granting execute permission to pow_exec/main..."
chmod +x pow_exec/main

# 后台运行api_server并输出日志
echo "Running api_server in the background and outputting logs..."
nohup python3 api.py > api_server.log 2>&1 &
cd ../..

# 安装initiate_device_A100的依赖
echo "Installing dependencies for initiate_device_A100..."
cd initiate_device_A100/initiate_device_A100
pip3 install -r requirements.txt
python3 get_freshtoken.py

# 运行generate.py  "$1" "$2" "$3"对应 device_id user_id gpt_type（a100）
echo "Running generate.py..."
python3 generate.py "$1" "$2" "$3"

# 运行initiate_device_A100.py
echo "Running initiate_device_A100.py..."
python3 initiate_device_A100.py

# 运行heart_beat_check.py
echo "Running heart_beat_check.py..."
nohup python3 heart_beat_check.py > heart_beat_check.log 2>&1 &

# 运行get_checker_bytes.py
echo "Running get_checker_bytes.py..."
nohup python3 get_checker_bytes.py > get_checker_bytes.log 2>&1 &

cat miner_config/*init.json | grep device_name

cd ../..

# 检查api_server是否运行
if pgrep -f "python3 api.py" > /dev/null
then
    echo "api_server is running."
else
    echo "api_server failed to start."
fi

# 检查heart_beat_check.py是否运行
if pgrep -f "python3 heart_beat_check.py" > /dev/null
then
    echo "heart_beat_check.py is running."
else
    echo "heart_beat_check.py failed to start."
fi

# 检查get_checker_bytes.py是否运行
if pgrep -f "python3 get_checker_bytes.py" > /dev/null
then
    echo "get_checker_bytes.py is running."
else
    echo "get_checker_bytes.py failed to start."
fi

echo "All tasks are completed!"
