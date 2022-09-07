# lydia-api

# Komme i gang med lydia-api

Kjør ./run.sh

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

Vi har gitt tilgang til en k8s-ressurs som heter `pia-devops` som har lese- og skrivetilgang til `ia-sak-hendelse-v1`-topicet. 
Det er denne man bruker som utvikler om man vil koble seg opp mot topicet lokalt. Det gjør man slik: 

1. `nais aiven create kafka pia-devops pia` (lager en [AivenApplication](https://doc.nais.io/cli/commands/aiven/#aiven-command))
2. `kubectl get AivenApplication -c <cluster> -n pia` for å finne ut hva den genererte secreten til `pia-devops` heter
3. `nais aiven get kafka <navn på secret> pia` (lager en lokal config i under `/var/` basert på k8s-secreten)
4. `KAFKA_CONFIG=<path til der config ble lagret i forrige steg>`
5. `source $KAFKA_CONFIG/kafka-secret.env`
6. Nå skal man klar for å koble seg opp mot topicet i miljøet man har valgt. Bruk de ulike kommandoene i `kafka-cli` for å gjøre det du har tenkt å gjøre. For å f.eks. konsumere meldinger på `ia-sak-hendelse-v1`-topicet kan man kjøre kommandoen:
`kafka-console-consumer --bootstrap-server $KAFKA_BROKERS --consumer.config $KAFKA_CONFIG/kafka.properties --topic "pia.ia-sak-hendelse-v1"`

