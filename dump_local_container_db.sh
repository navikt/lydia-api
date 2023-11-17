#!/usr/bin/env bash

## Script som tar en dump av lokal postgres database
##  - kalles fra en kjørende test (som selv kalles fra Gradle)
##  - bør ikke kjøre på CI (GitHub actions)

timestamp=$(date +'%Y_%m_%d_%H_%M_%S')
port=$1
database=$2
host=$3
filnavn=$database\_$host-$timestamp-dump.sql
scripts_mappe="scripts/db"
relativ_sti_til_dump_fil=$scripts_mappe/$filnavn
echo "Skal lage en dump av lokal test DB (db navn:'$database', startet på port:'$port', på host:'$host') i filen med navn:'$filnavn'"

export PGPASSWORD="test"
pg_dump --file=$relativ_sti_til_dump_fil --inserts --if-exists --clean --dbname=$database --schema=public --username=test --host=$host --port=$port

echo "Filen er nå tilgjengelig her: $relativ_sti_til_dump_fil"
