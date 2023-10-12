#!/bin/bash
#
# Copyright © 2023 @dbarobin
#
# Distributed under terms of the MIT license.
#
# Desc: Upgrade curl to latest version.
# User: @dbarobin
# Date: 2023-10-12
# Time: 11:44:49

ver="8.4.0"

count=`curl --version | grep -w $ver | wc -l`
if [ $count -eq 1 ]; then
    echo "curl version is ${ver}, no need to upgrade, exit now."
    exit 1
fi

# install dependencies
sudo apt-get update
sudo apt-get install -y build-essential libssl-dev

# build curl from source
cd /home/ubuntu
wget https://curl.se/download/curl-$ver.tar.gz
tar -zxvf curl-$ver.tar.gz
cd curl-$ver && ./configure --with-ssl && make && sudo make install
sudo ldconfig

# remove source file
cd /home/ubuntu && rm -rf curl-$ver curl-$ver.tar.gz
sudo rm -f /usr/bin/curl

if [ -f "/usr/local/bin/curl" ]; then
    sudo mv /usr/local/bin/curl /usr/bin/
fi

# check curl location and version
which curl
curl --version

# remove upgrade script
count=`curl --version | grep -w $ver | wc -l`
if [ $count -eq 1 ]; then
    cd /home/ubuntu && rm -f curl-upgrade.sh
fi