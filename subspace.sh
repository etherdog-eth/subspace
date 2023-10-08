
# Licensed under the Apache License, Version 2.0 (the "License");
# You may not use this file except in compliance with the License.

sudo apt-get -y install bc

cd ~ && mkdir subspace && cd "subspace"
wget https://github.com/subspace/subspace/releases/download/gemini-3f-2023-oct-06/subspace-farmer-ubuntu-x86_64-skylake-gemini-3f-2023-oct-06 -O subspace-farmer
wget https://github.com/subspace/subspace/releases/download/gemini-3f-2023-oct-06/subspace-node-ubuntu-x86_64-skylake-gemini-3f-2023-oct-06 -O subspace-node

chmod +x subspace-farmer && chmod +x subspace-node

# Replace `NODE_FILE_NAME` with the name of the node file you downloaded from releases
# Replace `INSERT_YOUR_ID` with a nickname you choose
# Copy all of the lines below, they are all part of the same command
sudo nohup ./subspace-node --chain gemini-3f --execution wasm --blocks-pruning 256 --state-pruning archive --no-private-ipv4 --validator --name "etherdog" > node.log 2>&1 &

# 计算挂载点以及空间大小
df -B1 | awk 'NR>1{print $4,$6}' | sort -h -r | head -n 1 | while read -r space mount; do

  if [ $space -ge 1099511627776 ]; then
      result=$(echo "scale=2; $space / 1024 / 1024 / 1024 / 1024" | bc)
      unit="T"
    elif [ $space -ge 1073741824 ]; then
      result=$(echo "scale=2; $space / 1024 / 1024 / 1024" | bc)
      unit="G"
    else
      result=$(echo "scale=2; $space / 1024 / 1024" | bc)
      unit="M"
    fi

  echo "挂载点：$mount 可用空间为：$result$unit"

  # 在挂载点下创建一个目录文件
  path="$mount/subspace"
  echo "$path"

  size=$(echo "scale=2; $result * 0.9" | bc)
  echo "实际使用空间为：$size$unit"

  # Replace `PATH_TO_FARM` with location where you want you store plot files
  # Replace `FARMER_FILE_NAME` with the name of the farmer file you downloaded from releases
  # Replace `WALLET_ADDRESS` below with your account address from Polkadot.js wallet
  # Replace `PLOT_SIZE` with plot size in gigabytes or terabytes, for example 100G or 2T (but leave at least 60G of disk space for node and some for OS)

  cmd="sudo nohup ./subspace-farmer farm --reward-address st8MUEgiU7cDiCF1BQm6RyyW5J2e3wprXMLNqXsabv3VRsbS4 path=$path,size=$size$unit > farm.log 2>&1 &"
  echo $cmd
  eval $cmd
done

ps -ef | grep subspace