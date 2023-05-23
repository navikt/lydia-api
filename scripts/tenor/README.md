# Opprett testdata med Tenor
## Hent testdata
Logg inn med personlig fnr på https://testdata.skatteetaten.no/web/testnorge/soek/freg 

Naviger til [avansert søk med KQL](https://testdata.skatteetaten.no/web/testnorge/avansert/brreg-er-fr)

Limm in følgende søk i søkefeltet: 
```erUnderenhet : * and naeringKode : 86* and antallAnsatte>= 5 ```

Her ønsker vi å hente en liste av underenheter med næringskode `86.***` som har flere enn 5 ansatte. 

## Eksport testdata til JSON
På høyresiden av KQL søkefeltet klick på de tre prikkene. I dialogboksen velg "Eksportere resultat"

I neste vindu angi/velg:
 - antall bedrifter du vil eksportere
 - hukk av check-box "all informasjon inkludert tilknyttende kilder"

Ta vare på filen som lastes ned på din maskin. 

## Lag SQL scripts for å opprette testdata
Kjør følgende scripts lokalt:
 - Parse_api_sykefraversstatistikk_response.py produserer en liste av orgnr basert på en json fil i `scripts/tenor/tmp/api_sykefraversstatistikk_response.json`. Filen laster du ned fra Fia i test. 
 - Opprett_fiktive_bedrifter_fra_Tenor.py lager en SQL fil som oppretter fiktive bedrifter ut i fra en json fil som lastes ned fra Tenor (se eksempler i `scripts/tenor/data` mappe)
