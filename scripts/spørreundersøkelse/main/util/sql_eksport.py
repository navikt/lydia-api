from dataklasser.Tema import Tema
from dataklasser.Spørsmål import Spørsmål
from dataklasser.Svaralternativ import Svaralternativ


def nytt_tema(tema: Tema):
    return (
        "INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, status, rekkefolge, type)"
        + "\n"
        + f"VALUES ({tema.id}, '{tema.navn}', 'AKTIV', {tema.rekkefølge}, '{tema.type})';"
    )


def nytt_svaralternativ(
    svaralternativ: Svaralternativ,
    spørsmål: Spørsmål,
):
    return (
        "INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)"
        + "\n"
        + f"VALUES ('{svaralternativ.id}', '{spørsmål.id}', '{svaralternativ.tekst}');"
    )


def nytt_spørsmål(spørsmål: Spørsmål):
    return (
        "INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)"
        + "\n"
        + f"VALUES ('{spørsmål.id}','{spørsmål.tekst.strip()}',{str(spørsmål.flervalg).lower()});"
    )


def knytt_spørsmål_til_tema(spørsmål: Spørsmål, tema: Tema):
    return (
        "INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)"
        + "\n"
        + f"VALUES ({tema.id}, '{spørsmål.id}');"
    )
