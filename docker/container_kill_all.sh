#!/bin/sh

docker kill -f $(docker ps -aq)
