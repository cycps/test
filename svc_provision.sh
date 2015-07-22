#!/usr/bin/env bash

mkdir -p /home/vagrant/go/src/github.com/cycps
sudo ln -s /home/vagrant/.cypress/addie /home/vagrant/go/src/github.com/cycps/addie

sudo sed -i 's/http:\/\/us.archive.ubuntu.com/http:\/\/ubuntu.eecs.wsu.edu/' /etc/apt/sources.list
sudo sed -i 's/http:\/\/security.ubuntu.com/http:\/\/ubuntu.eecs.wsu.edu/' /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y vim tmux git golang
echo "installing go"
echo "export GOPATH=/home/vagrant/go" >> /home/vagrant/.bashrc
echo "export PATH=$PATH:/home/vagrant/go/bin" >> /home/vagrant/.bashrc
mkdir -p /home/vagrant/.cypress/keys
cp /home/vagrant/go/src/github.com/cycps/addie/devkeys/* /home/vagrant/.cypress/keys/
source /home/vagrant/.bashrc  
echo "installing addie"
GOPATH=/home/vagrant/go go get github.com/lib/pq github.com/julienschmidt/httprouter
GOPATH=/home/vagrant/go go install github.com/cycps/addie/go-addie
#echo "running design"
#PATH=$PATH:/home/vagrant/go/bin design &
