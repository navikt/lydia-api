#!/usr/bin/env bash

./gradlew build -x test
docker-compose up --force-recreate -d