#!/usr/bin/env bash

sudo chown -R vagrant:vagrant /home/vagrant/go
sudo sed -i 's/http:\/\/us.archive.ubuntu.com/http:\/\/ubuntu.eecs.wsu.edu/' /etc/apt/sources.list
sudo sed -i 's/http:\/\/security.ubuntu.com/http:\/\/ubuntu.eecs.wsu.edu/' /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y vim tmux golang
echo "installing go"
echo "export GOPATH=/home/vagrant/go" >> /home/vagrant/.bashrc
echo "export PATH=$PATH:/home/vagrant/go/bin" >> /home/vagrant/.bashrc
source /home/vagrant/.bashrc  
echo "installing addie"
GOPATH=/home/vagrant/go go install github.com/cycps/addie
echo "running addie"
PATH=$PATH:/home/vagrant/go/bin addie &
