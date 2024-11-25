from dataklasser.Spørsmål import Spørsmål
from dataklasser.Tema import Tema
from dataklasser.Undertema import Undertema
from util.sql_eksport import (
    gjør_tema_inaktivt,
    gjør_undertema_inaktivt,
    knytt_spørsmål_til_tema,
    knytt_spørsmål_til_undertema,
    nytt_spørsmål,
    nytt_svaralternativ,
    nytt_tema,
    nytt_undertema,
)

#### Partssamarbeid ####


forrige_tema_id = 15
undertema_id = 15
spørreundersøkelse_type = "Evaluering"

undertema_id += 1
utvikle_partssamarbeidet = Undertema(
    id=undertema_id,
    navn="Utvikle partssamarbeidet",
    spørsmål=[
        Spørsmål(
            tekst="Hvordan opplever du at partssamarbeidet har utviklet seg i løpet av samarbeidsperioden?",
            alternativer=[
                "Svært godt",
                "Godt",
                "Dårlig",
                "Svært dårlig",
                "Vet ikke",
            ],
        ),
        Spørsmål(
            tekst="Som leder, tillitsvalgt eller verneombud har jeg fått en bedre forståelse av min rolle og mine ansvarsområder i partssamarbeidet",
        ),
        Spørsmål(
            tekst="Vi har opparbeidet oss nødvendig kompetanse for å forebygge og håndtere sykefraværet vårt",
        ),
    ],
)

undertema_id += 1
veien_videre_partssamarbeid = Undertema(
    id=undertema_id,
    navn="Veien videre",
    spørsmål=[
        Spørsmål(
            tekst="Vi har laget konkrete planer for hvordan vi i partssamarbeidet skal jobbe fremover",
        ),
        Spørsmål(
            tekst="Jeg opplever at vi er motiverte for å samarbeide videre om sykefravær og arbeidsmiljø",
        ),
    ],
    obligatorisk=True,
)

#### Sykefraværsarbeid ####
# undertemaer


undertema_id += 1
sykefraværsrutiner = Undertema(
    id=undertema_id,
    navn="Sykefraværsrutiner",
    spørsmål=[
        Spørsmål(
            tekst="Vi jobber nå mer systematisk for å forebygge sykefraværet vårt",
        ),
        Spørsmål(
            tekst="Vi har godt etablerte og lett tilgjengelige sykefraværsrutiner",
        ),
        Spørsmål(
            tekst="Ansatte kjenner til egne plikter og rettigheter når de er sykmeldt eller står i fare for å bli det",
        ),
    ],
)

undertema_id += 1

oppfølgingssamtaler = Undertema(
    id=undertema_id,
    navn="Oppfølgingssamtaler",
    spørsmål=[
        Spørsmål(
            tekst="Jeg opplever at ledere er trygge under oppfølgingsamtaler med ansatte som er sykmeldt eller står i fare for å bli det",
        ),
    ],
)

undertema_id += 1

tilretteleggings_og_medvirkningsplikt = Undertema(
    id=undertema_id,
    navn="Tilretteleggings- og medvirkningsplikt",
    spørsmål=[
        Spørsmål(
            tekst="Vi har utarbeidet og tilgjengeliggjort en oversikt over våre tilretteleggingsmuligheter",
        ),
        Spørsmål(
            tekst="Vi har etablerte rutiner og god kultur for tilrettelegging for ansatte ",
        ),
        Spørsmål(
            tekst="Ansatte medvirker under tilrettelegging av arbeidsoppgaver",
        ),
    ],
)


undertema_id += 1

sykefravær_enkeltsaker = Undertema(
    id=undertema_id,
    navn="Sykefravær - enkeltsaker",
    spørsmål=[
        Spørsmål(
            tekst="Vi har nødvendig kompetanse for å håndtere vanskelige sykefraværssaker",
        ),
    ],
)

undertema_id += 1

veien_videre_sykefraværsarbeid = Undertema(
    id=undertema_id,
    navn="Veien videre",
    spørsmål=[
        Spørsmål(
            tekst="Vi vet hvor vi finner gode verktøy i arbeidet med å redusere sykefraværet vårt",
        ),
        Spørsmål(
            tekst="Jeg tror videre forebyggende sykefraværsarbeid vil bidra til å redusere sykefraværet hos oss",
        ),
    ],
    obligatorisk=True,
)


#### Arbeidsmiljø ####

# undertemaer
undertema_id += 1

utvikle_arbeidsmiljøet = Undertema(
    id=undertema_id,
    navn="Utvikle arbeidsmiljøet",
    spørsmål=[
        Spørsmål(
            tekst="Vi har nå nødvendig kompetanse til å gjøre tiltak og forbedre arbeidsmiljøet vårt ",
        ),
        Spørsmål(
            tekst="Vi har utarbeidet konkrete planer for hvordan vi skal jobbe systematisk med arbeidsmiljøet",
        ),
        Spørsmål(
            tekst="Vi har fått god forståelse for hvilke faktorer som påvirker arbeidsmiljøet vårt ",
        ),
    ],
)

undertema_id += 1

endring_og_omstilling = Undertema(
    id=undertema_id,
    navn="Endring og omstilling",
    spørsmål=[
        Spørsmål(
            tekst="Vi har etablert rutiner for medvirkning og forebygging under endrings- og omstillingsprosesser ",
        ),
        Spørsmål(
            tekst="Vi har nødvendig kompetanse for å forebygge sykefravær under omstillingsprosesser",
        ),
    ],
)

undertema_id += 1


oppfølging_av_arbeidsmiljøundersøkelser = Undertema(
    id=undertema_id,
    navn="Oppfølging av arbeidsmiljøundersøkelser",
    spørsmål=[
        Spørsmål(
            tekst="Vi har fått tilstrekkelig støtte til å gjennomføre tiltak basert på egen arbeidsmiljøundersøkelse",
        ),
        Spørsmål(
            tekst="Vi har opparbeidet oss nødvendig kompetanse til å følge opp fremtidige arbeidsmiljøundersøkelser",
        ),
    ],
)

undertema_id += 1

livsfaseorientert_personalpolitikk = Undertema(
    id=undertema_id,
    navn="Livsfaseorientert personalpolitikk",
    spørsmål=[
        Spørsmål(
            tekst="Vi har en personalpolitikk som ivaretar ansattes behov i ulike deler av livet (f.eks. graviditet, førpensjon)",
        ),
        Spørsmål(
            tekst="Vi har utarbeidet gode rutiner for hvordan vi tilrettelegger ansattes arbeid i ulike deler av livet ",
        ),
    ],
)

undertema_id += 1

psykisk_helse = Undertema(
    id=undertema_id,
    navn="Psykisk helse",
    spørsmål=[
        Spørsmål(
            tekst="Vi får tilbakemeldinger om at ansatte med psykiske plager blir godt ivaretatt",
        ),
        Spørsmål(
            tekst="Som leder, tillitsvalgt eller verneombud har jeg opparbeidet meg ferdigheter til å møte og støtte ansatte med psykiske plager",
        ),
        Spørsmål(
            tekst="Vi jobber kontinuerlig for å redusere stigma rundt psykiske plager",
        ),
    ],
)

undertema_id += 1

helseIArbeid = Undertema(
    id=undertema_id,
    navn="HelseIArbeid",
    spørsmål=[
        Spørsmål(
            tekst="Vi har fått økt kompetanse om tilrettelegging for ansatte med muskel-, skjelett- og psykiske plager",
        ),
        Spørsmål(
            tekst="Ansatte ønsker i større grad å jobbe til tross for muskel-, skjelett- og psykiske plager",
        ),
    ],
)

undertema_id += 1

veien_videre_arbeidsmiljø = Undertema(
    id=undertema_id,
    navn="Veien videre",
    spørsmål=[
        Spørsmål(
            tekst="Vi har opparbeidet oss et godt grunnlag for å jobbe videre med arbeidsmiljøet vårt   ",
        ),
        Spørsmål(
            tekst="Vi har utarbeidet konkrete planer for hvordan vi skal videreutvikle arbeidsmiljøet vårt",
        ),
    ],
    obligatorisk=True,
)


# Temaer


forrige_tema_id += 1

partssamarbeid = Tema(
    id=forrige_tema_id,
    navn="Partssamarbeid",
    type=spørreundersøkelse_type,
    undertemaer=[utvikle_partssamarbeidet, veien_videre_partssamarbeid],
)


forrige_tema_id += 1

sykefraværsarbeid = Tema(
    id=forrige_tema_id,
    navn="Sykefraværsarbeid",
    type=spørreundersøkelse_type,
    undertemaer=[
        sykefraværsrutiner,
        oppfølgingssamtaler,
        tilretteleggings_og_medvirkningsplikt,
        sykefravær_enkeltsaker,
        veien_videre_sykefraværsarbeid,
    ],
)

forrige_tema_id += 1

arbeidsmiljø = Tema(
    id=forrige_tema_id,
    navn="Arbeidsmiljø",
    type=spørreundersøkelse_type,
    undertemaer=[
        utvikle_arbeidsmiljøet,
        endring_og_omstilling,
        oppfølging_av_arbeidsmiljøundersøkelser,
        livsfaseorientert_personalpolitikk,
        psykisk_helse,
        helseIArbeid,
        veien_videre_arbeidsmiljø,
    ],
)

if __name__ == "__main__":
    sql_script = ""
    sql_script += gjør_tema_inaktivt(temaId=7) + "\n"
    sql_script += gjør_undertema_inaktivt(undertema_id=7) + "\n"
    sql_script += gjør_tema_inaktivt(temaId=8) + "\n"
    sql_script += gjør_undertema_inaktivt(undertema_id=8) + "\n"
    sql_script += gjør_tema_inaktivt(temaId=9) + "\n"
    sql_script += gjør_undertema_inaktivt(undertema_id=9) + "\n"

    for tema_nr, tema in enumerate([partssamarbeid, sykefraværsarbeid, arbeidsmiljø]):
        sql_script += nytt_tema(tema=tema, rekkefølge=tema_nr + 1) + "\n"

        for undertema_nr, undertema in enumerate(tema.undertemaer):
            sql_script += (
                nytt_undertema(
                    undertema=undertema, tema=tema, rekkefølge=undertema_nr + 1
                )
                + "\n"
            )

            for spørsmål_nr, spørsmål in enumerate(undertema.spørsmål):
                sql_script += (
                    f"-- Nytt spørsmål for undertema -> '{tema.navn}' : '{undertema.navn}'"
                    + "\n"
                )

                sql_script += nytt_spørsmål(spørsmål)
                sql_script += knytt_spørsmål_til_undertema(
                    spørsmål=spørsmål, undertema=undertema, rekkefølge=spørsmål_nr + 1
                )
                sql_script += (
                    knytt_spørsmål_til_tema(spørsmål=spørsmål, tema=tema) + "\n"
                )
                sql_script += "-- Svaralternativer:" + "\n"

                for svaralternativ in spørsmål.svaralternativer:
                    sql_script += nytt_svaralternativ(
                        svaralternativ=svaralternativ, spørsmål=spørsmål
                    )
                sql_script += "\n"
            sql_script += "\n"
        sql_script += "\n"

    with open(
        "V1__nytt_migreringsskript.sql",
        "w",
    ) as text_file:
        text_file.write(sql_script)
        print("Done")
