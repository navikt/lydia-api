# Data delt til datavarehus (DVH)

## Flyt fra Fia til DVH

Når en innlogget IA-rådgiver i Fia gjør noe på en sak for en virksomhet i Fia,
vil det bli lagret som en hendelse i systemet som blir sendt ut på kafka på forskjellige topics.
Disse kafkameldingen inneholder meta-info on hendelsen, saken og eventuelt leveranser.

Det finnes så en annen app, `pia-bigquery-sink` som lytter på disse topicene, og lagrer til tabeller i Bigquery.

Data leveres til DVH gjennom to views i Bigquery, `dvh-ia-sak-view` og `dvh-ia-sak-leveranse-view`.
Disse viewene baserer seg på tabellene `ia-sak-statistikk-v1` og `ia-sak-leveranse-v1`, også i Bigquery.


## Oversikt over viewene:

### dvh-ia-sak-leveranse-view

Query:
```
SELECT 
  leveranseId, saksnummer, navenhet,
  iaModulId, iaModulNavn, iaTjenesteId, iaTjenesteNavn,
  frist, status, sistEndret, opprettetTidspunkt,
  fullfort, tidsstempel 
  FROM (
    SELECT 
      id as leveranseId, saksnummer, if(enhetsnummer is null, 'ukjent', enhetsnummer) as navenhet,
      null as iaModulId, null as iaModulNavn, iaTjenesteId, iaTjenesteNavn,
      frist, status, sistEndret, opprettetTidspunkt,
      fullfort, tidsstempel, row_number() over (partition by id, status order by tidsstempel desc) radnummerBasertPaaTidsstempel
    FROM `pia_bigquery_sink_v1_dataset_prod.ia-sak-leveranse-v1` 
  ) WHERE radnummerBasertPaaTidsstempel = 1
```

Skjema:
```json
[
  {
    "name": "leveranseId",
    "mode": "NULLABLE",
    "type": "INTEGER",
    "description": null
  },
  {
    "name": "saksnummer",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null
  },
  {
    "name": "navenhet",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null
  },
  {
    "name": "iaModulId",
    "mode": "NULLABLE",
    "type": "INTEGER",
    "description": null
  },
  {
    "name": "iaModulNavn",
    "mode": "NULLABLE",
    "type": "INTEGER",
    "description": null
  },
  {
    "name": "iaTjenesteId",
    "mode": "NULLABLE",
    "type": "INTEGER",
    "description": null
  },
  {
    "name": "iaTjenesteNavn",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null
  },
  {
    "name": "frist",
    "mode": "NULLABLE",
    "type": "DATE",
    "description": null
  },
  {
    "name": "status",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null
  },
  {
    "name": "sistEndret",
    "mode": "NULLABLE",
    "type": "TIMESTAMP",
    "description": null
  },
  {
    "name": "opprettetTidspunkt",
    "mode": "NULLABLE",
    "type": "TIMESTAMP",
    "description": null
  },
  {
    "name": "fullfort",
    "mode": "NULLABLE",
    "type": "TIMESTAMP",
    "description": null
  },
  {
    "name": "tidsstempel",
    "mode": "NULLABLE",
    "type": "TIMESTAMP",
    "description": null
  }
]
```

### dvh-ia-sak-view

Query:
```
SELECT
    hendelsesId, saksnummer, orgnr, navenhet,
    status, ikkeAktuelBegrunnelse,
    opprettetTidspunkt, endretTidspunkt, avsluttetTidspunkt,
    sektor, neringer, bransjeprogram,
    postnummer, kommunenummer, fylkesnummer,
    tidsstempel 
  FROM (
        SELECT
            endretAvHendelseId as hendelsesId, saksnummer, orgnr, if(enhetsnummer is null, 'ukjent', enhetsnummer) as navenhet,
            status, ikkeAktuelBegrunnelse,
            opprettetTidspunkt, endretTidspunkt, avsluttetTidspunkt,
            sektor, neringer, bransjeprogram,
            postnummer, kommunenummer, fylkesnummer,
            tidsstempel,
            row_number() over (partition by endretAvHendelseId order by tidsstempel desc) radnummerBasertPaaTidsstempel
        FROM `pia_bigquery_sink_v1_dataset_prod.ia-sak-statistikk-v1`
    ) WHERE radnummerBasertPaaTidsstempel = 1;
```

Skjema:
```json
[
  {
    "name": "hendelsesId",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null
  },
  {
    "name": "saksnummer",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null
  },
  {
    "name": "orgnr",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null
  },
  {
    "name": "navenhet",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null
  },
  {
    "name": "status",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null
  },
  {
    "name": "ikkeAktuelBegrunnelse",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null
  },
  {
    "name": "opprettetTidspunkt",
    "mode": "NULLABLE",
    "type": "TIMESTAMP",
    "description": null
  },
  {
    "name": "endretTidspunkt",
    "mode": "NULLABLE",
    "type": "TIMESTAMP",
    "description": null
  },
  {
    "name": "avsluttetTidspunkt",
    "mode": "NULLABLE",
    "type": "TIMESTAMP",
    "description": null
  },
  {
    "name": "sektor",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null
  },
  {
    "name": "neringer",
    "mode": "NULLABLE",
    "type": "JSON",
    "description": null
  },
  {
    "name": "bransjeprogram",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null
  },
  {
    "name": "postnummer",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null
  },
  {
    "name": "kommunenummer",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null
  },
  {
    "name": "fylkesnummer",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null
  },
  {
    "name": "tidsstempel",
    "mode": "NULLABLE",
    "type": "TIMESTAMP",
    "description": null
  }
]
```

## Samhandlingskanal

Primær samhandlingskanal er #ia-dvh på navikt slack.