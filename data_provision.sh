#!/usr/bin/env bash

sudo chown -R vagrant:vagrant $HOME/.cypress
sudo sed -i 's/http:\/\/us.archive.ubuntu.com/http:\/\/ubuntu.eecs.wsu.edu/' /etc/apt/sources.list
sudo sed -i 's/http:\/\/security.ubuntu.com/http:\/\/ubuntu.eecs.wsu.edu/' /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y vim tmux postgresql postgresql-contrib postgresql-doc
echo "making cyp dir"
mkdir -p $HOME/.cypress/log
echo "dbscript"
sudo -E $HOME/.cypress/data/sql/createCypDB.sh
