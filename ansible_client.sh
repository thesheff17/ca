#!/bin/bash

# This script will bootstrap your chromebook with ansible 
# usage: ./run.sh username webServerIP

echo "ansible_client.sh started..."

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
    python3-pip \
    tmux \
    inotify-tools \
    vim \
    wget

pip3 install $PIPMODULES

# keys
wget -O /home/$1/.ssh/id_rsa_ansible http://$2/keys1/id_rsa
wget -O /home/$1/.ssh/id_rsa.pub http://$2/keys1/id_rsa.pub
chmod 400 /home/$1/.ssh/id_rsa_ansible
chmod 644 /home/$1/.ssh/id_rsa.pub
mkdir /home/$1/.ansible/
cp ansible.cfg /home/$1/.ansible/ansible.cfg
chown -R $1:$1 /home/$1

echo "ansible_client.sh completed"
