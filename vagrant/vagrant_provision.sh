#!/bin/sh

# use Czech mirror
sudo sed -i "s~http://archive~http://cz.archive~g" /etc/apt/sources.list

sudo apt-get update
sudo apt-get install -y build-essential bzr cvs gawk gcc-multilib flex git-core gettext libncurses5-dev libssl-dev libxml-parser-perl openjdk-6-jdk subversion unzip zip zlib1g-dev
