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

# install dependencies
sudo apt-get update
sudo apt-get install -y build-essential libssl-dev

# build curl from source
cd ~
wget https://curl.se/download/curl-8.4.0.tar.gz
tar -zxvf curl-8.4.0.tar.gz
cd curl-8.4.0 && ./configure --with-ssl && make && sudo make install
sudo ldconfig

# remove source file
cd ~ && rm -rf curl-8.4.0 curl-8.4.0.tar.gz
sudo rm -f /usr/bin/curl

if [ -f "/usr/local/bin/curl" ]; then
    sudo mv /usr/local/bin/curl /usr/bin/
fi

# check curl location and version
which curl
curl --version

# remove upgrade script
count=`curl --version | grep -w 8.4.0 | wc -l`
if [ $count -eq 1 ]; then
    cd ~ && rm -f curl-upgrade.sh
fi