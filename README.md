# lydia-api

# Ved ny publisering

## Oppdatere gjeldende kvartal og publiseringsdato
Hvert kvartal publiserer NAV ny statistikk for sykefravær iht [publiseringkalender](https://www.nav.no/no/nav-og-samfunn/statistikk/publiseringskalender) 

Lydia-api mottar de nye data via Kafka. Etter importen er ferdig må vi legge til et nytt script som oppdaterer tabellen `siste_publiseringsinfo`. 

### Oppdater siste_publiseringsinfo
Kopier denne f.eks `V64__oppdatere_siste_publiseringsinfo_Q3_2023.sql` og lag en ny fil med riktig datoer.
Push endringen i produksjon etter import er ferdig. 

### Lag en ny dump fil til lokal kjøring
Etter `gjeldendePeriode` er oppdatert må du lage en ny dump fil med testdata til lokal kjøring (se [her](#fra-kommandolinja))

### I dev-miljø
Automatisk eksport fra `sykefravarsstatistikk-api` sender data i både dev og prod miljø. 


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

0. `logg på gcloud og sett cluster med kubectx`
1. `nais aiven create kafka pia-devops pia` (lager en [AivenApplication](https://doc.nais.io/cli/commands/aiven/#aiven-command) og gir neste kommando i output)
2. Output fra forrige steg gir neste kommando, noe som: `nais aiven get kafka pia-devops-pia-<id> pia` denne lager lage secrets
3. Output fra forrige steg gir path til der config ble lagret `KAFKA_CONFIG=<path-til-config>`
4. `source $KAFKA_CONFIG/kafka-secret.env`
5. Nå skal man klar for å koble seg opp mot topicet i miljøet man har valgt. Bruk de ulike kommandoene i `kafka-cli` for å gjøre det du har tenkt å gjøre. For å f.eks. konsumere meldinger på `ia-sak-v1`-topicet kan man kjøre kommandoen:
`kafka-console-consumer --bootstrap-server $KAFKA_BROKERS --consumer.config $KAFKA_CONFIG/kafka.properties --topic "pia.ia-sak-v1"`

## Oppdater testdata til lokal kjøring etter endringer i db skjema

Når du kjører lydia-api lokalt bruker applikasjonen testdata fra et sql script i ``scripts/db/``.

Denne filen bruker samme testdata som integrasjonstestene våre, dvs kunstig data og fiktive organisasjonsnummere. Filen bør oppdateres manuelt etter hver endring i db struktur, og i alle tilfeller etter publisering av ny sykefraværsstatistikk. (2023-06-06)

### Fra kommandolinja
0. Installer psql lokalt (https://www.timescale.com/blog/how-to-install-psql-on-mac-ubuntu-debian-windows/)
1. Verifiser at du har psql installert ved å kjøre `psql --version` i terminalen
2. Kjør `./gradlew cleanTest test --tests no.nav.lydia.DbDumpTest -PlokalDbDump=true`


### Oppdater run.sh med ny sql fil
I script filen `run.sh` kan du oppdatere lenken til filen du har generert og lastet opp (commit) på github

1. Gå til repoet på GitHub (https://github.com/navikt/lydia-api).
2. Finn dump-fila, `/lydia-api/scripts/db/[filnavn_her].sql` (Sannsynleg lenke til mappa: https://github.com/navikt/lydia-api/tree/main/scripts/db).
3. Klikk på "Raw" og kopier lenka til sida du kjem til. Formatet skal vere `https://raw.githubusercontent.com/navikt/lydia-api/main/scripts/db/{data_source}_{timestamp}-dump.sql`.
4. Lim inn denne lenka i `run.sh`.
5. Commit og push. (Du treng ikkje vente på at GitHub Actions skal bli ferdig med build og deploy.)
6. Oppdater `run.sh` i lydia-rådgiver-frontend også med den same lenka.

## Koble til postgresql lokalt via docker-compose oppsett

0. Kjør `./run.sh` i roten av repoet for å starte appen med alle avhengigheter

### Med psql (terminal)

0. Installer psql lokalt (https://www.timescale.com/blog/how-to-install-psql-on-mac-ubuntu-debian-windows/)
1. Verifiser at du har psql installert ved å kjøre `psql --version` i terminalen
2. Koble til postgresql lokalt ved å kjøre `PGPASSWORD=test psql -h localhost -p 5432 -U postgres` i terminalen

### Med IntelliJ

1. Åpne IntelliJ og gå til Database panelet
2. Trykk på `+` og velg `Data Source` og `PostgreSQL`
3. Fyll ut feltene slik:
`Host`: `localhost`  
`Port`: `5432`  
`User`: `postgres`  
`Password`: `test`  
`Database`: `postgres`  
4. Trykk på `Test connection` for å verifisere at tilkoblingen fungerer

### Med Visual Studio Code
1. Installer [Database Client extension](https://marketplace.visualstudio.com/items?itemName=cweijan.vscode-mysql-client2)
2. Åpne databasepanelet
3. Trykk på `+` og velg `PostgreSQL` under `Server Type`
4. Fyll ut feltene slik:
`Host`: `localhost`
`Port`: `5432`
`User`: `postgres`
`Password`: `test`
`Database`: `postgres`
5. Trykk på `Connect`/`Save`

## Kode generert av GitHub Copilot

Dette repoet tar i bruk GitHub Copilot for kodeforslag.

## Ymse feilsøking
### "Test framework quit unexpectedly" ved køyring av testar
Dato: 2023-08-22  
Utviklar med problemet: Ingrid  
Med på feilsøking: Thomas, Christian og Per-Christian  

Problemet: 
Får ikkje til å køyre testane lokalt på ei maskin. Får feilmelding "Test framework quit unexpectedly". Unit-testar køyrer fint, men problem med container-testar.

<details>
<summary> Feilsøking:</summary>
1. Ta ned docker-containarar (`dc down` til `docker ps` blir tom)
2. `./gradlew clean`
3. `./gradlew build`
4. Stoppe colima: `colima stop`
5. Å køyre testar på andre maskiner, det er berre Ingrid si som ikkje får det til.
6. Starte colima, og gjere "sudo"-kommandoen `sudo rm -rf /var/run/docker.sock && sudo ln -s /Users/$(whoami)/.colima/docker.sock /var/run/docker.sock`
7. Melding om at ingen testar vart køyrd fordi koden var utan endringar, men heller ingen feilmelding, så 🎉🎉🎉
</details>

Konklusjon/løysing: Skru ting av og på att, det løyser stundom alt.
