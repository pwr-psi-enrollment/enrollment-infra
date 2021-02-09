#!/usr/bin/env bash
set -e

WD=$(pwd)

cd app
docker-compose down

cd ..
rm -rf app
unzip deployment.zip -d app
cd app
docker-compose up -d --build
cd ..
