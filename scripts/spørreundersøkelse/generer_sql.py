from main.dataklasser.Tema import Tema
from main.dataklasser.Undertema import Undertema
from main.dataklasser.Spørsmål import Spørsmål
from main.dataklasser.Svaralternativ import lagSvaralternativer
from main.util.generer_uuider import generer_uuid_med_delay
from main.util.sql_eksport import nytt_tema, nytt_spørsmål, nytt_svaralternativ, knytt_spørsmål_til_tema, nytt_undertema,gjør_tema_inaktivt,gjør_undertema_inaktivt,knytt_spørsmål_til_undertema


# # TODO: viktig at svaralternativ med samme tekst ikke får samme id
# TODO: Gitt et SQL script sin output som json/csv eller noe, gi ut alle spørsmål som basemodel klasser (kun aktive og rett type)
# -> gi kode for å flytte spørsmål
# TODO: sjekk at alt tekst er uten trailing space


#### Partssamarbeid ####
# undertemaer

forrige_tema_id = 15
forrige_undertema_id = 15
undertemanummer = 1
spørreundersøkelse_type = "Evaluering"
temanummer = 1


utvikle_partssamarbeidet = Undertema(
    id=forrige_undertema_id + undertemanummer,
    navn="Utvikle partssamarbeidet",
    rekkefølge=undertemanummer,
    spørsmål=[
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Hvordan opplever du at partssamarbeidet har utviklet seg i løpet av samarbeidsperioden?",
            svaralternativer=lagSvaralternativer(
                [
                    "Svært godt",
                    "Godt",
                    "Dårlig",
                    "Svært dårlig",
                    "Vet ikke",
                ]
            ),
        ),
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Som leder, tillitsvalgt eller verneombud har jeg fått en bedre forståelse av min rolle og mine ansvarsområder i partssamarbeidet",
        ),
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Vi har opparbeidet oss nødvendig kompetanse for å forebygge og håndtere sykefraværet vårt",
        ),
    ],
)

undertemanummer += 1

veien_videre_partssamarbeid = Undertema(
    id=forrige_undertema_id + undertemanummer,
    navn="Veien videre",
    rekkefølge=undertemanummer,
    spørsmål=[
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Vi har laget konkrete planer for hvordan vi i partssamarbeidet skal jobbe fremover",
        ),
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Jeg opplever at vi er motiverte for å samarbeide videre om sykefravær og arbeidsmiljø",
        ),
    ],
    obligatorisk=True
)

#### Sykefraværsarbeid ####
# undertemaer


undertemanummer += 1

sykefraværsrutiner = Undertema(
    id=forrige_undertema_id + undertemanummer,
    navn="Sykefraværsrutiner",
    rekkefølge=undertemanummer,
    spørsmål=[
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Vi jobber nå mer systematisk for å forebygge sykefraværet vårt",
        ),
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Vi har godt etablerte og lett tilgjengelige sykefraværsrutiner",
        ),
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Ansatte kjenner til egne plikter og rettigheter når de er sykmeldt eller står i fare for å bli det",
        ),
    ],
)

undertemanummer += 1

oppfølgingssamtaler = Undertema(
    id=forrige_undertema_id + undertemanummer,
    navn="Oppfølgingssamtaler",
    rekkefølge=undertemanummer,
    spørsmål=[
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Jeg opplever at ledere er trygge under oppfølgingsamtaler med ansatte som er sykmeldt eller står i fare for å bli det",
        ),
    ],
)

undertemanummer += 1

tilretteleggings_og_medvirkningsplikt = Undertema(
    id=forrige_undertema_id + undertemanummer,
    navn="Tilretteleggings- og medvirkningsplikt",
    rekkefølge=undertemanummer,
    spørsmål=[
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Vi har utarbeidet og tilgjengeliggjort en oversikt over våre tilretteleggingsmuligheter",
        ),
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Vi har etablerte rutiner og god kultur for tilrettelegging for ansatte ",
        ),
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Ansatte medvirker under tilrettelegging av arbeidsoppgaver",
        ),
    ],
)


undertemanummer += 1

sykefravær_enkeltsaker = Undertema(
    id=forrige_undertema_id + undertemanummer,
    navn="Sykefravær - enkeltsaker",
    rekkefølge=undertemanummer,
    spørsmål=[
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Vi har nødvendig kompetanse for å håndtere vanskelige sykefraværssaker",
        ),
    ],
)

undertemanummer += 1

veien_videre_sykefraværsarbeid = Undertema(
    id=forrige_undertema_id + undertemanummer,
    navn="Veien videre",
    rekkefølge=undertemanummer,
    spørsmål=[
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Vi vet hvor vi finner gode verktøy i arbeidet med å redusere sykefraværet vårt",
        ),
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Jeg tror videre forebyggende sykefraværsarbeid vil bidra til å redusere sykefraværet hos oss",
        ),
    ],
    obligatorisk=True
)


#### Arbeidsmiljø ####

# undertemaer
undertemanummer += 1

utvikle_arbeidsmiljøet = Undertema(
    id=forrige_undertema_id + undertemanummer,
    navn="Utvikle arbeidsmiljøet",
    rekkefølge=undertemanummer,
    spørsmål=[
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Vi har nå nødvendig kompetanse til å gjøre tiltak og forbedre arbeidsmiljøet vårt ",
        ),
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Vi har utarbeidet konkrete planer for hvordan vi skal jobbe systematisk med arbeidsmiljøet",
        ),
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Vi har fått god forståelse for hvilke faktorer som påvirker arbeidsmiljøet vårt ",
        ),
    ],
)

undertemanummer += 1

endring_og_omstilling = Undertema(
    id=forrige_undertema_id + undertemanummer,
    navn="Endring og omstilling",
    rekkefølge=undertemanummer,
    spørsmål=[
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Vi har etablert rutiner for medvirkning og forebygging under endrings- og omstillingsprosesser ",
        ),
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Vi har nødvendig kompetanse for å forebygge sykefravær under omstillingsprosesser",
        ),
    ],
)

undertemanummer += 1


oppfølging_av_arbeidsmiljøundersøkelser = Undertema(
    id=forrige_undertema_id + undertemanummer,
    navn="Oppfølging av arbeidsmiljøundersøkelser",
    rekkefølge=undertemanummer,
    spørsmål=[
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Vi har fått tilstrekkelig støtte til å gjennomføre tiltak basert på egen arbeidsmiljøundersøkelse",
        ),
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Vi har opparbeidet oss nødvendig kompetanse til å følge opp fremtidige arbeidsmiljøundersøkelser",
        ),
    ],
)

undertemanummer += 1

livsfaseorientert_personalpolitikk = Undertema(
    id=forrige_undertema_id + undertemanummer,
    navn="Livsfaseorientert personalpolitikk",
    rekkefølge=undertemanummer,
    spørsmål=[
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Vi har en personalpolitikk som ivaretar ansattes behov i ulike deler av livet (f.eks. graviditet, førpensjon)",
        ),
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Vi har utarbeidet gode rutiner for hvordan vi tilrettelegger ansattes arbeid i ulike deler av livet ",
        ),
    ],
)

undertemanummer += 1


psykisk_helse = Undertema(
    id=forrige_undertema_id + undertemanummer,
    navn="Psykisk helse",
    rekkefølge=undertemanummer,
    spørsmål=[
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Vi får tilbakemeldinger om at ansatte med psykiske plager blir godt ivaretatt",
        ),
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Som leder, tillitsvalgt eller verneombud har jeg opparbeidet meg ferdigheter til å møte og støtte ansatte med psykiske plager",
        ),
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Vi jobber kontinuerlig for å redusere stigma rundt psykiske plager",
        ),
    ],
)

undertemanummer += 1


helseIArbeid = Undertema(
    id=forrige_undertema_id + undertemanummer,
    navn="HelseIArbeid",
    rekkefølge=undertemanummer,
    spørsmål=[
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Vi har fått økt kompetanse om tilrettelegging for ansatte med muskel-, skjelett- og psykiske plager",
        ),
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Ansatte ønsker i større grad å jobbe til tross for muskel-, skjelett- og psykiske plager",
        ),
    ],
)

undertemanummer += 1


veien_videre_arbeidsmiljø = Undertema(
    id=forrige_undertema_id + undertemanummer,
    navn="Veien videre",
    rekkefølge=undertemanummer,
    spørsmål=[
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Vi har opparbeidet oss et godt grunnlag for å jobbe videre med arbeidsmiljøet vårt   ",
        ),
        Spørsmål(
            id= generer_uuid_med_delay(),
            tekst="Vi har utarbeidet konkrete planer for hvordan vi skal videreutvikle arbeidsmiljøet vårt",
        ),
    ],
    obligatorisk=True
)


# Temaer

partssamarbeid = Tema(
    id=forrige_tema_id + temanummer,
    navn="Partssamarbeid",
    rekkefølge=temanummer,
    type=spørreundersøkelse_type,
    undertemaer=[utvikle_partssamarbeidet, veien_videre_partssamarbeid],
)

temanummer += 1

sykefraværsarbeid = Tema(
    id=forrige_tema_id + temanummer,
    navn="Sykefraværsarbeid",
    rekkefølge=temanummer,
    type=spørreundersøkelse_type,
    undertemaer=[
        sykefraværsrutiner,
        oppfølgingssamtaler,
        tilretteleggings_og_medvirkningsplikt,
        sykefravær_enkeltsaker,
        veien_videre_sykefraværsarbeid,
    ],
)

temanummer += 1

arbeidsmiljø = Tema(
    id=forrige_tema_id + temanummer,
    navn="Arbeidsmiljø",
    rekkefølge=temanummer,
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
    sql_script += gjør_tema_inaktivt(temaId=7)

    sql_script += "\n"
    sql_script += "\n"
    sql_script += gjør_tema_inaktivt(temaId=8)

    sql_script += "\n"
    sql_script += "\n"
    sql_script += gjør_tema_inaktivt(temaId=9)

    sql_script += "\n"
    sql_script += "\n"
    sql_script += gjør_undertema_inaktivt(undertema_id=7)

    sql_script += "\n"
    sql_script += "\n"
    sql_script += gjør_undertema_inaktivt(undertema_id=8)

    sql_script += "\n"
    sql_script += "\n"
    sql_script += gjør_undertema_inaktivt(undertema_id=9)
    for tema in [partssamarbeid, sykefraværsarbeid, arbeidsmiljø]:
        sql_script += "\n"
        sql_script += "\n"
        sql_script += "-- Nytt tema"
        sql_script += "\n"
        sql_script += "\n"

        sql_script += nytt_tema(tema)
        sql_script += "\n"
        sql_script += "\n"
        for undertema in tema.undertemaer:
            sql_script += "\n"
            sql_script += "\n"
            sql_script += "-- Nytt undertema"
            sql_script += "\n"
            sql_script += "\n"
            sql_script += nytt_undertema(undertema=undertema, tema=tema)

            for spørsmål in undertema.spørsmål:
                sql_script += "\n"
                sql_script += "\n"
                sql_script += "-- Nytt spørsmål"
                sql_script += "\n"
                sql_script += "\n"
                sql_script += nytt_spørsmål(spørsmål)
                sql_script += "\n"
                sql_script += "\n"
                sql_script += "-- Svaralternativer:"
                sql_script += "\n"
                sql_script += "\n"

                for svaralternativ in spørsmål.svaralternativer:
                    sql_script += nytt_svaralternativ(
                        svaralternativ=svaralternativ, spørsmål=spørsmål
                    )
                    sql_script += "\n"

                sql_script += "\n"
                sql_script += "\n"

                sql_script += knytt_spørsmål_til_tema(spørsmål=spørsmål, tema=tema)


                sql_script += "\n"
                sql_script += "\n"

                sql_script += knytt_spørsmål_til_undertema(spørsmål=spørsmål, undertema=undertema)

    with open("Output.sql", "w") as text_file:
        text_file.write(sql_script)
