
sudo apt update
sudo apt install snapd
sudo snap install go --classic
sudo apt install git make
git clone https://github.com/dominant-strategies/go-quai
cd go-quai
wget https://raw.githubusercontent.com/wenjiping/subspace/main/network.env
make go-quai
tail -f nodelogs/prime.log