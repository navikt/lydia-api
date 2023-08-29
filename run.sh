#!/usr/bin/env bash

./gradlew build -x test
docker-compose up -d
curl -o db_script.sql https://raw.githubusercontent.com/navikt/lydia-api/main/scripts/db/lydia_api_container_db_localhost-2023_08_29_15_47_10-dump.sql
sleep 3
PGPASSWORD=test psql -h localhost -p 5432 -U postgres -f db_script.sql > /dev/null
rm db_script.sql
