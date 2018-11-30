#!/bin/bash

sudo apt-get install build-essential git tree

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
nvm install 8.9.4
sudo npm install pm2 -g
sudo npm install node-gyp -g

mkdir tsdn
cd tsdn
mkdir data

arr=(trustnote-hub trustnote-witness trustnote-headless trustnote-explorer)

echo clone
for name in ${arr[@]}
do
    #./pull.sh $name up
    echo ""
    echo ""
    echo clone $name
    git clone https://github.com/trustnote/$name.git
done
echo clone finish
echo ""

echo install
for name in ${arr[@]}
do
    #./pull.sh $name up
    echo $name
    cd $name
    npm install
    cd ../
done
echo ""
tree -L 1
echo install finish
