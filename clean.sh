#!/bin/sh
docker rmi $(docker images -f "dangling=true" -q);
docker rm -v $(docker ps -a -q -f status=exited);
docker ps -a | sed '1 d' | awk '{print $1}' | xargs -L1 docker rm;
# docker images -a | sed '1 d' | awk '{print $3}' | xargs -L1 docker rmi -f;
