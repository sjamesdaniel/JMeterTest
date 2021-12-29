#!/bin/bash
app_name=$1
# This builds the images and needs to only be run once.
  docker rmi -f ${app_name}jmeterbase
  docker rmi -f ${app_name}jmetermaster
  docker rmi -f ${app_name}jmeterslave
  docker rmi -f phusion/baseimage:bionic-1.0.0
 
docker build -t ${app_name}jmeterbase -f jmeterbase/Dockerfile . \
  && docker build -t ${app_name}jmetermaster --build-arg app_name=${app_name} -f jmetermaster/Dockerfile . \
  && docker build -t ${app_name}jmeterslave --build-arg app_name=${app_name} -f jmeterslave/Dockerfile . \
