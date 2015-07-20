#!/usr/bin/env bash

sudo sed -i 's/http:\/\/us.archive.ubuntu.com/http:\/\/ubuntu.eecs.wsu.edu/' /etc/apt/sources.list
sudo sed -i 's/http:\/\/security.ubuntu.com/http:\/\/ubuntu.eecs.wsu.edu/' /etc/apt/sources.list

sudo apt-get update
sudo apt-get install -y vim tmux nginx

sudo mv /etc/nginx/nginx.conf /etc/nginx/original_nginx.conf
sudo ln -s $HOME/.cypress/web/conf/nginx.conf /etc/nginx/nginx.conf

sudo nginx -s reload

