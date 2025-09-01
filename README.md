# Fia backend (lydia-api)
## Beskrivelse
Fia er et fagsystem for prioritering av virksomheter.

## Innhold
- [Oppsett](#oppsett)
- [Kjør prosjektet](#kjør-prosjektet)
- [Vedlikehold og videreutvikling](#vedlikehold-og-videreutvikling)
    - [Legge til nye testvirksomheter i dev](#legge-til-nye-testvirksomheter-i-dev)
    - [Kvartalsvis publisering av sykefraværsstatistikk](#kvartalsvis-publisering-av-sykefraværsstatistikk)
    - [Oppdater testdata til lokal kjøring etter endringer i db skjema](#oppdater-testdata-til-lokal-kjøring-etter-endringer-i-db-skjema)
    - [Koble til database lokalt](#koble-til-database-lokalt)
    - [Lese fra Kafka topic lokalt](#lese-fra-kafka-topic-i-terminal)
- [Henvendelser](#henvendelser)
- [Krediteringer](#krediteringer)
----

# Oppsett
## Docker-oppsett med Colima
I teamet bruker vi [`colima`](https://github.com/abiosoft/colima) som container runtime. Det skal strengt tatt ikke 
være noe problem å bruke en annen runtime, men dette er stegene må på plass for å sette opp `colima`, i tillegg til de som er nevnte i [`README i repoet`](https://github.com/abiosoft/colima).

**Migrering fra Docker desktop**
- installere nye versjoner av `docker` og `docker-compose` (for eksempel med Homebrew) linke disse til PATH
- passe på at `credsStore` i `~/.docker/config.json` ikke har verdien `desktop`
- symlinke den nye versjonen av `docker-compose` til `~/.docker/cli-plugins/docker-compose` hvis man vil kunne skrive `docker compose` uten bindestrek: ```ln -sfn $(which docker-compose) ~/.docker/cli-plugins/docker-compose```

# Kjør prosjektet
For å kjøre prosjektet lokalt anbefales det å kjøre med frontend. (Se [oppsett i frontend-repo](https://github.com/navikt/lydia-radgiver-frontend) for lokal kjøring med frontend.)

Uten endringer henter frontend siste backend image, men man kan også bygge backend lokalt og bruke dette i kjøring med frontend også, se [guide i frontend-repo](https://github.com/navikt/lydia-radgiver-frontend/blob/main/README.md#k%C3%B8yre-frontend-lokalt-med-lokal-backend)

# Vedlikehold og videreutvikling
## Legge til nye testvirksomheter i dev
For å legge til nye testvirksomheter i dev-miljøet må man hente testvirksomheter fra [Tenor](https://www.skatteetaten.no/testdata/).

Fremgangsmåte er beskrevet [her](scripts/tenor/README.md).

## Kvartalsvis publisering av sykefraværsstatistikk
Hvert kvartal publiserer NAV ny statistikk for sykefravær iht [publiseringkalender](https://www.nav.no/no/nav-og-samfunn/statistikk/publiseringskalender)
Fia mottar ny statistikk via Kafka. Denne produseres av [pia-sykefravarsstatistikk](https://github.com/navikt/pia-sykefravarsstatistikk).

### Testdata i dev-miljø for nytt kvartal
Testdata må produseres av scripts i [pia-dvh-import](https://github.com/navikt/pia-dvh-import) før du følger [vanlig framgangsmåte](#import-av-nytt-kvartal)

Framgangsmåte for å produsere nytt kvartal av testdata er beskrevet [her](todo)

### Import av nytt kvartal
Dette krever noe vedlikehold for å holde appen oppdatert:
1. Importer nytt kvartal med sykefraværsstatistikk ved å kjøre import jobb med [pia-jobbsender](https://github.com/navikt/pia-jobbsender/actions/workflows/deploy.yaml). Dette vil gjøre at [pia-dvh-import](https://github.com/navikt/pia-dvh-import) importerer nylig publisert statistikk fra Bucket. (For dev se [her](#testdata-i-dev-miljø-for-nytt-kvartal))
2. Oppdater siste_publiseringsinfo: publiseringskvartaler lagres i `siste_publiseringsinfo` og må oppdateres med nytt kvartal. Kopier migreringsscript fra tidligere kvartal som: [V119__oppdatere_siste_publiseringsinfo_Q4_2024.sql](src/main/resources/db/migration/2025/V119__oppdatere_siste_publiseringsinfo_Q4_2024.sql) og lag et nytt migreringsscript med riktige datoer. Push til produksjon og dev etter import er ferdig.
3. Etter `gjeldendePeriode` er oppdatert må du lage en ny dump fil med testdata til lokal kjøring (se [her](#fra-kommandolinja))


## Oppdater testdata til lokal kjøring etter endringer i db skjema
Når du kjører lydia-api lokalt bruker applikasjonen testdata fra et sql script i ``scripts/db/``.

Denne filen bruker samme testdata som integrasjonstestene våre, dvs kunstig data og fiktive organisasjonsnummere. Filen bør oppdateres manuelt etter hver endring i db struktur, og i alle tilfeller etter publisering av ny sykefraværsstatistikk.

### Fra kommandolinja
1. Installer psql lokalt (https://www.timescale.com/blog/how-to-install-psql-on-mac-ubuntu-debian-windows/)
2. Verifiser at du har psql installert ved å kjøre `psql --version` i terminalen
3. Kjør `./gradlew cleanTest test --tests no.nav.lydia.DbDumpTest -PlokalDbDump=true`

### Oppdater run.sh med ny sql fil
I script filen `run.sh` kan du oppdatere lenken til filen du har generert og lastet opp (commit) på github
1. Gå til repoet på GitHub (https://github.com/navikt/lydia-api).
2. Finn dump-fila, `/lydia-api/scripts/db/[filnavn_her].sql` (Sannsynleg lenke til mappa: https://github.com/navikt/lydia-api/tree/main/scripts/db).
3. Klikk på "Raw" og kopier lenka til sida du kjem til. Formatet skal vere `https://raw.githubusercontent.com/navikt/lydia-api/main/scripts/db/{data_source}_{timestamp}-dump.sql`.
4. Lim inn denne lenka i `run.sh`.
5. Commit og push. (Du treng ikkje vente på at GitHub Actions skal bli ferdig med build og deploy.)
6. Oppdater `run.sh` i [lydia-rådgiver-frontend](https://github.com/navikt/lydia-radgiver-frontend) med den same lenka.

## Koble til database lokalt
1. Kjør `./run.sh` i roten av repoet for å starte appen i docker med alle avhengigheter

### Med psql (terminal)

1. Installer psql lokalt (https://www.timescale.com/blog/how-to-install-psql-on-mac-ubuntu-debian-windows/)
2. Verifiser at du har psql installert ved å kjøre `psql --version` i terminalen
3. Koble til postgresql lokalt ved å kjøre `PGPASSWORD=test psql -h localhost -p 5432 -U postgres` i terminalen

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

## Lese fra Kafka topic i terminal

For å koble seg mot Aiven Kafka lokalt trenger man:
- [kafka-cli](https://kafka.apache.org/quickstart) (kan også installeres med [brew install kafka](https://formulae.brew.sh/formula/kafka))
- [nais-cli](https://doc.nais.io/operate/cli/how-to/install/)

Vi har gitt tilgang til en k8s-ressurs som heter `pia-devops` som har lese- og skrivetilgang til `ia-sak-v1`-topicet. 
Det er denne man bruker som utvikler om man vil koble seg opp mot topicet lokalt. Det gjør man slik: 

1. `logg på gcloud og sett cluster med kubectx`
2. `nais aiven create -p nav-dev kafka pia-devops pia` (lager en [AivenApplication](https://doc.nais.io/operate/cli/reference/aiven/) i Kafka pool nav-dev og gir neste kommando i output --
   obs: husk å bruke nav-prod i produksjon)
3. Output fra forrige steg gir neste kommando, noe som: `nais aiven get kafka pia-devops-pia-<id> pia` denne lager lage secrets
4. Output fra forrige steg gir path til der config ble lagret `KAFKA_CONFIG=<path-til-config>`
5. `source $KAFKA_CONFIG/kafka-secret.env`
6. Nå skal man klar for å koble seg opp mot topicet i miljøet man har valgt. Bruk de ulike kommandoene i `kafka-cli` for å gjøre det du har tenkt å gjøre. For å f.eks. konsumere meldinger på `ia-sak-v1`-topicet kan man kjøre kommandoen:
`kafka-console-consumer --bootstrap-server $KAFKA_BROKERS --consumer.config $KAFKA_CONFIG/kafka.properties --topic "pia.ia-sak-v1"`


# Henvendelser
Spørsmål knyttet til koden eller prosjektet kan stilles som et [issue her på GitHub](https://github.com/navikt/lydia-api/issues).
## For NAV-ansatte
Interne henvendelser kan sendes via Slack i kanalen #team-pia.

# Krediteringer
## Kode generert av GitHub Copilot
Dette repoet bruker GitHub Copilot til å generere kode.
