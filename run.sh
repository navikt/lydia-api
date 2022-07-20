#!/usr/bin/env bash

./gradlew build -x test
docker-compose up -d