apt install unzip screen -y
wget https://fs-im-kefu.7moor-fs1.com/29397395/4d2c3f00-7d4c-11e5-af15-41bf63ae4ea0/1696334272363/clash-linux-amd64-v1.17.0.gz
wget https://fs-im-kefu.7moor-fs1.com/29397395/4d2c3f00-7d4c-11e5-af15-41bf63ae4ea0/1696334646991/Country.mmdb.zip
unzip Country.mmdb.zip
gunzip -d clash-linux-amd64-v1.17.0.gz
mv clash-linux-amd64-v1.17.0 /usr/local/bin/clash
chmod +x /usr/local/bin/clash
mkdir -p ~/.config/clash
mv Country.mmdb ~/.config/clash/Country.mmdb
wget https://vpn-1257774372.cos.ap-nanjing.myqcloud.com/1714113215346.yml
mv 1714113215346.yml ~/.config/clash/config.yaml
export http_proxy=127.0.0.1:7890
export https_proxy=127.0.0.1:7890
export socks5_proxy=127.0.0.1:7890
screen -dmS VPN clash -d ~/.config/clash


echo 'export http_proxy=127.0.0.1:7890' >> ~/.bashrc;
echo 'export https_proxy=127.0.0.1:7890' >> ~/.bashrc;
echo 'export socks5_proxy=127.0.0.1:7890' >> ~/.bashrc;
echo 'source ~/.bashrc';
