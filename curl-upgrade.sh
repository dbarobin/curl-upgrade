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

sudo apt-get update
sudo apt-get install -y build-essential libssl-dev
cd ~
wget https://curl.se/download/curl-8.4.0.tar.gz
tar -zxvf curl-8.4.0.tar.gz
cd curl-8.4.0 && ./configure --with-ssl && make && sudo make install
sudo ldconfig
cd ~ && rm -rf curl-8.4.0 curl-8.4.0.tar.gz
sudo rm -f /usr/bin/curl
sudo mv /usr/local/bin/curl /usr/bin
which curl
curl --version