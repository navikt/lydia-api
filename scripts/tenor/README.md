# Opprett testdata med Tenor

## Hent testdata

Logg inn med egen BankId på [Tenor](https://testdata.skatteetaten.no/web/testnorge/soek/freg)

Naviger til [avansert søk med KQL](https://testdata.skatteetaten.no/web/testnorge/avansert/brreg-er-fr)

Lim inn f.eks. følgende søk i søkefeltet:

```erUnderenhet : * and naeringKode : 86* and antallAnsatte>= 5 ```

I eksempelet over ønsker vi å hente en liste av underenheter med næringskode `86.***` som har flere enn 5 ansatte.

## Eksport testdata til JSON

På høyresiden av KQL søkefeltet klick på de tre prikkene. I dialogboksen velg "Eksportere resultat"

I neste vindu angi/velg:

- antall bedrifter du vil eksportere
- hukk av check-box "all informasjon inkludert tilknyttende kilder"

Ta vare på filen som lastes ned på din maskin, og legg i rett mappe:
```lydia-api/scripts/tenor/data_per_fylke/Fylke/primærnæring/din_nye_fil.json```

## Lag SQL scripts for å opprette testdata

Kjør script som parser json lokalt: `python3 Opprett_fiktive_bedrifter_fra_Tenor.py`
Dette scriptet oppretter to filer:

- csv fil som skal til sykefraværsstatisikk-api for å genere sykefraværsstatistikk
- sql fil som skal kjøres i databasen for å opprette testdata.