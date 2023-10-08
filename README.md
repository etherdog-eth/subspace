# subspace 测试网一件安装脚本

#### 关注我Twitter
Twitter : [https://twitter.com/etherdog_eth](https://twitter.com/etherdog_eth)

#### 使用方法

```commandline
sudo apt update && sudo apt -y install wget && sudo wget https://raw.githubusercontent.com/wenjiping/subspace/main/subspace.sh && sudo chmod +x subspace.sh && sudo ./subspace.sh
```

其他常用命令
```commandline
ps aux|grep subspace|grep -v grep | awk '{print $2}'|xargs kill -9
rm -rf subspace.sh subspace
ls
```