#!/usr/bin/env bash

./gradlew build -x test
docker-compose up -d
curl -o db_script.sql https://raw.githubusercontent.com/navikt/lydia-api/main/scripts/db/lydia-api-container-db_localhost-2024_10_24_16_39_14-dump.sql
sleep 3
PGPASSWORD=test psql -h localhost -p 5432 -U postgres -f db_script.sql > /dev/null
rm db_script.sql
