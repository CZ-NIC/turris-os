#!/bin/sh

# use Czech mirror
sudo sed -i "s~http://archive~http://cz.archive~g" /etc/apt/sources.list

sudo apt-get update
sudo apt-get install -y build-essential bzr cvs gawk gcc-multilib flex git-core gettext libncurses5-dev libssl-dev libxml-parser-perl openjdk-6-jdk subversion unzip zip zlib1g-dev

if [ "$1" = "install_bashcompletion" ]; then
    sudo wget https://raw.githubusercontent.com/sairon/openwrt-bash-completion/master/openwrt_make -O /etc/bash_completion.d/openwrt_make
    echo "OPENWRT_COMPL_USE_PRINTDB=1" >> /home/vagrant/.bashrc
fi
