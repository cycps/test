#!/usr/bin/env bash

sudo chown -R vagrant:vagrant /home/vagrant/apitest
sudo sed -i 's/http:\/\/us.archive.ubuntu.com/http:\/\/ubuntu.eecs.wsu.edu/' /etc/apt/sources.list
sudo sed -i 's/http:\/\/security.ubuntu.com/http:\/\/ubuntu.eecs.wsu.edu/' /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y vim tmux nodejs-legacy npm
hash dredd 2>/dev/null || sudo npm install -g dredd 
