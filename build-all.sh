#!/bin/bash

if [ ! -d "app-manager-frontend" ]; then
  git clone https://github.com/ludomirc/app-manager-frontend.git app-manager-frontend
fi

if [ ! -d "app-manager-backend" ]; then
  git clone https://github.com/ludomirc/app-manager-backend.git app-manager-backend
fi

mkdir -p build-logs

docker build -t app-manager-full . | tee build-logs/build.log
