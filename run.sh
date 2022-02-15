#!/usr/bin/env bash

./gradlew clean build -x test
docker-compose up --force-recreate