#!/bin/bash

# This script will bootstrap your chromebook with ansible 
# usage: ./run.sh username webServerIP

echo "run.sh started..."

PIPMODULES="ansible"

if [ "$EUID" -ne 0 ]
  then echo "Please run using sudo"
  exit
fi

[ ! -d "/home/$1/.ssh/" ] && mkdir -p "/home/$1/.ssh/"
chown $1 /home/$1/.ssh/

# packages
apt-get update
apt-get upgrade -y
apt-get install -y \
    python3-dev \
    python3-pip \
    sudo \
    tmux \
    vim \
    wget

pip3 install $PIPMODULES

# keys
wget -P /home/$1/.ssh/id_rsa http://$2/keys1/id_rsa
wget -P /home/$1/.ssh/id_rsa.pub http://$2/keys1/id_rsa.pub
chmod 400 /home/$1/.ssh/id_rsa
chmod 644 /home/$1/.ssh/id_rsa.pub

echo "run.sh completed"
