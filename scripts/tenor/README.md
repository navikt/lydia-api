# Opprett testdata med Tenor test data

1. Logg inn med egen BankId på [Tenor](https://testdata.skatteetaten.no/web/testnorge/soek/freg)
2. Naviger til [avansert søk med KQL](https://testdata.skatteetaten.no/web/testnorge/avansert/brreg-er-fr) og velg å søke på virksomhet øverst til venstre (i stedet for person)
3. Lim inn f.eks. følgende søk i søkefeltet: `erUnderenhet : * and naeringKode : 86* and antallAnsatte>= 5` og klikk søk. I dette eksempelet søker vi etter alle underenheter med næringskode `86.***` som har flere enn 5 ansatte. 
4. Når du har en liste av virksomheter, kan du begynne å eksportere testdataene. Det gjør du ved å velge "Eksportere resultat". Det er kun mulig å eksportere opp til 200 virksomheter.
5. Velg antall virksomheter du vil eksportere og velg alternativet "All informasjon inkludert tilknyttede kilder". Trykk så på "Eksporter JSON"
6. Ta vare på filen som lastes ned og legg i en mappe som f.eks. `lydia-api/scripts/tenor/data/<filnavn_som_beskriver_søk>.json`
7. Kjør `python3 main.py` for å generere SQL-scripts. Det opprettes flere i output mappen `tenor/output` som matcher navn på input-filene.
8. Finn SQL-scriptet som tilhører test-virksomhetene du ønsker å legge til. Kjør dette i dev-databasen for å opprette virksomhetene.