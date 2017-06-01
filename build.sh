#!/bin/bash

sudo rm -rf jenkins_home

docker kill jenk
docker rm jenk

docker build -t jenk .

docker run -d -v /var/run/docker.sock:/var/run/docker.sock -v $PWD/jenkins_home:/var/jenkins_home --name jenk -p 8080:8080 jenk

printf "Waiting for jenkins..."
until curl http://localhost:8080/login &> /dev/null
  do
    #printf "."
    curl -s -o /dev/null -w "%{http_code}" http://localhost:8080
    sleep 2
  done

open http://localhost:8080