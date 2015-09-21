#!/usr/bin/env bash

DOCKER_IP = 172.17.42.1

docker run -it -h node \
 -p 8500:8500 \
 -p 8600:53/udp \
 progrium/consul \
 -server \
 -bootstrap \
 -advertise $DOCKER_IP \
 -log-level debug

docker run -it \
-v /var/run/docker.sock:/tmp/docker.sock \
-h $DOCKER_IP progrium/registrator \
consul://$DOCKER_IP:8500
