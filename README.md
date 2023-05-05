# lydia-api

# Ved ny publisering

## Oppdatere gjeldende kvartal og publiseringsdato
Hvert kvartal publiserer NAV ny statistikk for sykefravær iht [publiseringkalender](https://www.nav.no/no/nav-og-samfunn/statistikk/publiseringskalender) 

Lydia-api mottar de nye data via Kafka. Etter importen er ferdig må vi legge til et nytt script som oppdaterer tabellen `siste_publiseringsinfo`

# Komme i gang med lydia-api

Kjør ./run.sh -cif

Besøk deretter http://localhost:2222 i din favorittbrowser

NB! Gå inn i `/etc/hosts` og legg til `127.0.0.1 host.docker.internal` som et eget entry.
Da vil browseren automatisk fange opp wonderwall og mock-oauth2-server, som da vil resolve det til localhost.


## Docker-oppsett med `colima`

I teamet bruker vi [`colima`](https://github.com/abiosoft/colima) som container runtime. Det skal strengt tatt ikke 
være noe problem å bruke en annen runtime, men dette er stegene må på plass for å sette opp `colima`, i tillegg til de
som er nevnte i [`README i repoet`](https://github.com/abiosoft/colima).

**Migrering fra Docker desktop**

- installere nye versjoner av `docker` og `docker-compose` (for eksempel med Homebrew) linke disse til PATH
- passe på at `credsStore` i `~/.docker/config.json` ikke har verdien `desktop`
- symlinke den nye versjonen av `docker-compose` til `~/.docker/cli-plugins/docker-compose` hvis man vil kunne skrive `docker compose` uten bindestrek: ```ln -sfn $(which docker-compose) ~/.docker/cli-plugins/docker-compose```

## Interagere med Kafka lokalt

For å koble seg mot Aiven Kafka lokalt trenger man:
- [kafka-cli](https://kafka.apache.org/quickstart) (kan også installeres med [brew install kafka](https://formulae.brew.sh/formula/kafka))
- [nais-cli](https://doc.nais.io/cli/install/)

Vi har gitt tilgang til en k8s-ressurs som heter `pia-devops` som har lese- og skrivetilgang til `ia-sak-v1`-topicet. 
Det er denne man bruker som utvikler om man vil koble seg opp mot topicet lokalt. Det gjør man slik: 

1. `nais aiven create kafka pia-devops pia` (lager en [AivenApplication](https://doc.nais.io/cli/commands/aiven/#aiven-command))
2. `kubectl get AivenApplication -c <cluster> -n pia` for å finne ut hva den genererte secreten til `pia-devops` heter
3. `nais aiven get kafka <navn på secret> pia` (lager en lokal config i under `/var/` basert på k8s-secreten)
4. `KAFKA_CONFIG=<path til der config ble lagret i forrige steg>`
5. `source $KAFKA_CONFIG/kafka-secret.env`
6. Nå skal man klar for å koble seg opp mot topicet i miljøet man har valgt. Bruk de ulike kommandoene i `kafka-cli` for å gjøre det du har tenkt å gjøre. For å f.eks. konsumere meldinger på `ia-sak-v1`-topicet kan man kjøre kommandoen:
`kafka-console-consumer --bootstrap-server $KAFKA_BROKERS --consumer.config $KAFKA_CONFIG/kafka.properties --topic "pia.ia-sak-v1"`

## Oppdater testdata til lokalt kjøring etter endringer i db skjema

Når du kjører lydia-api lokalt bruker applikasjonen testdata fra et sql script i ``scripts/db/``

Denne filen samme testdata som integrasjonstestene våre bruker, dvs kunstig data og fiktive organisasjonsnummere. Filen bør oppdateres manuelt etter hver endring i db struktur. 

### Opprett en tilkobling til Postgresql db i testcontainer  
 1. Åpne integrasjsontest "Test for å hente datasource" i `SykefraversstatistikkApiTest` i IntelliJ
 2. Legg til en breakpoint etter utledding av `jdbcUrl`, f.eks på linjen med kode `jdbcUrl shouldStartWith "jdbc:postgresql"`
 3. Start testen med debug og kopier innhold av variabel `jdbcUrl` når testen stopper på breakpoint (_copy value_ med `Command + c`)
 4. La testen stoppet på breakpoint da det blir mulig å koble til db i test-container. Du vil miste tilkobling hvis testen kjører ferdig. 
 5. I `Database` panelet i IntelliJ opprett en ny Data Source av type PostgreSQL (ved bruk av `+` knappen) 
 6. Limm inn det du har kopiert i feltet `URL`. Da skal feltene `Host`, `Port` og `Database` fylles opp automatisk
 7. Velg "User & Password" ved dropdown `Authentication`. Fyll ut med user `test` og password `test` 
 8. Gi Data Source navn "lydia_api_container_db_localhost" (ved `Name` på topp av modal vinduet)
 9. Sjekk at tilkobling til databasen fungerer ved å clicke på `Test connection` (på bunnen av samme vindu)
 10. Opprett tilkoblingen (datasource) ved å trykke på `OK`

### Ta en dump av testdata fra PostgreSQL test-container
1. Fra database panel i IntelliJ, click på `>` for å vise frem database og skjema `public` til den Data Source som du har akkurat opprettet 👆
2. Høyre click på skjemaet `public` 
3. Velg `Export with 'pg_dump'` og sjekk/fyll ut følgende options: 
   1. `Path til pgdump`: din path til programmet `pg_dump` (som regel: `/usr/local/bin/pg_dump`)
   2. `Statements`: `insert`
   3. `Database`: `lydia-api-container-db`
   4. `Schemas`: `public`
   5. `Format`: `file`
   6. Enable følgende check-boxes: `Clean database` og `Add "If exists"`
   7. `Out path`: path til `lydia-api/scripts/db/{data_source}-{timestamp}-dump.sql`
4. Kjør med `Run`
5. Den genererte filen skal nå være tilgjengelig i mappen `scripts/db/` 

### Oppdater run.sh med ny sql fil
I script filen `run.sh` kan du oppdatere lenken til filen du har generert og lastet opp (commit) på github

