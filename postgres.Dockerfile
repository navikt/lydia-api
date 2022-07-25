FROM postgres:14

COPY ./scripts/db/PostgreSQL___lydia_api_container_db_localhost-2022_07_21_09_37_13-dump.sql /docker-entrypoint-initdb.d