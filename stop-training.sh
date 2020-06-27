#!/usr/bin/env bash

RM_FLAG=$1

source config.env

export ROBOMAKER_COMMAND=""
docker-compose -f ./docker-compose.yml stop
docker stop $(docker ps | awk ' /sagemaker/ { print $1 }')

SAGEMAKER_ID=$(docker ps -a | grep sagemaker | awk '{ print $1}')
ROBOMAKER_ID=$(docker ps -a | grep robomaker | awk '{ print $1}')

docker logs $SAGEMAKER_ID > log_sagemaker.txt
docker logs $ROBOMAKER_ID > log_robomaker.txt

docker-compose -f ./docker-compose.yml down
docker rm $(docker ps -a | awk ' /sagemaker/ { print $1 }')


if [ "$ENABLE_LOCAL_DESKTOP" = true ] ; then
    wmctrl -c kvs_stream
fi

if [ ! -z "$(which tmux)" ]
then
  tmux kill-session
fi

