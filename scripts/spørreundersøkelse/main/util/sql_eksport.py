from main.dataklasser.Tema import Tema
from main.dataklasser.Undertema import Undertema
from main.dataklasser.Spørsmål import Spørsmål
from main.dataklasser.Svaralternativ import Svaralternativ


def gjør_tema_inaktivt(temaId: int):
    sql_fil = (
            "UPDATE ia_sak_kartlegging_tema"
            + "\n"
            + "SET status = 'INAKTIV'"
            + "\n"
            + "WHERE tema_id = "
            + str(temaId)
            + ";"
    )
    return sql_fil


def gjør_undertema_inaktivt(undertema_id: int):
    sql_fil = (
            "UPDATE ia_sak_kartlegging_undertema"
            + "\n"
            + "SET status = 'INAKTIV'"
            + "\n"
            + "WHERE undertema_id = "
            + str(undertema_id)
            + ";"
    )
    return sql_fil


def nytt_tema(tema: Tema):
    return (
        "INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, status, rekkefolge, type)"
        + "\n"
        + f"VALUES ({tema.id}, '{tema.navn}', 'AKTIV', {tema.rekkefølge}, '{tema.type}');"
    )


def nytt_undertema(undertema: Undertema, tema: Tema):
    return (
        "INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)"
        + "\n"
        + f"VALUES ({undertema.id}, '{undertema.navn}', 'AKTIV', {undertema.rekkefølge}, {tema.id}, {str(undertema.obligatorisk).lower()});"
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

def knytt_spørsmål_til_undertema(spørsmål: Spørsmål, undertema: Undertema):
    return (
        "INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id)"
        + "\n"
        + f"VALUES ({undertema.id}, '{spørsmål.id}');"
    )
