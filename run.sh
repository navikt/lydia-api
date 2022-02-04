#!/usr/bin/env bash

./gradlew build
docker-compose up -d --force-recreate