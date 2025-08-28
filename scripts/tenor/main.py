import json
import os


class Virksomhet:
    def __init__(
        self,
        orgnummer,
        navn,
        næringskode,
        kommune,
        postnummer,
        adresse_lines,
        kommunenummer,
        poststed,
        landkode,
        land,
        oppstartsdato,
        antall_ansatte,
    ):
        self.orgnummer: str = orgnummer
        self.navn = navn
        self.næringskode = næringskode
        self.kommune = kommune
        self.postnummer = postnummer
        self.adresse_lines = adresse_lines
        self.kommunenummer = kommunenummer
        self.poststed = poststed
        self.landkode = landkode
        self.land = land
        self.oppstartsdato = oppstartsdato
        self.antall_ansatte = antall_ansatte

    def __eq__(self, other):
        return self.orgnummer == other.orgnummer

    def __hash__(self):
        return hash(("orgnummer", self.orgnummer))




def parse_tenor_fil(
    import_filename: str,
) -> list[Virksomhet]:
    nye_virksomheter = []

    with open(import_filename, "r") as tenorTestDataFil:
        json_decode = json.load(tenorTestDataFil)
        for virksomhet in json_decode["dokumentListe"]:
            nye_virksomheter.append(
                Virksomhet(
                    orgnummer=virksomhet.get("organisasjonsnummer"),
                    navn=virksomhet.get("navn"),
                    næringskode=virksomhet.get("naeringKode")[0],
                    kommune=virksomhet.get("forretningsadresse").get("kommune"),
                    postnummer=virksomhet.get("forretningsadresse").get("postnummer"),
                    adresse_lines=[
                        adresse.replace("'", "")
                        for adresse in virksomhet.get("forretningsadresse").get(
                            "adresse"
                        )
                    ],
                    kommunenummer=virksomhet.get("forretningsadresse").get(
                        "kommunenummer"
                    ),
                    poststed=virksomhet.get("forretningsadresse").get("poststed"),
                    landkode=virksomhet.get("forretningsadresse").get("landkode"),
                    land=virksomhet.get("forretningsadresse").get("land"),
                    oppstartsdato=virksomhet.get("registreringsdatoEnhetsregisteret"),
                    antall_ansatte=virksomhet.get("antallAnsatte"),
                )
            )
    return nye_virksomheter


def insert_virksomhet_naringsundergrupper(orgnr: str, naringskode: str) -> str:
    return (
        f"INSERT INTO public.virksomhet_naringsundergrupper (virksomhet, naringsundergruppe1)\n"
        f"SELECT id, '{naringskode}' AS kode FROM virksomhet\n"
        f"WHERE orgnr='{orgnr}'\n"
        f"ON CONFLICT DO NOTHING;"
    )


def insert_virksomhet(virksomhet: Virksomhet):
    separator = ", "
    adresse = separator.join(
        f'"{adresse_line}"' for adresse_line in virksomhet.adresse_lines
    )
    return (
        f"INSERT INTO public.virksomhet "
        f"(orgnr, land, landkode, postnummer, poststed, kommune, kommunenummer, navn, adresse, status, oppstartsdato)\n"
        f"VALUES ('{virksomhet.orgnummer}', '{virksomhet.land}', '{virksomhet.landkode}', '{virksomhet.postnummer}', '{virksomhet.poststed}', '{virksomhet.kommune}', '{virksomhet.kommunenummer}', '{virksomhet.navn}', '{{{adresse}}}', 'AKTIV', '{virksomhet.oppstartsdato}')\n"
        f"ON CONFLICT DO NOTHING;"
    )


def skriv_til_fil(
    output_filename_SQL: str,
    nye_virksomheter: list[Virksomhet],
):
    with open(output_filename_SQL, "w") as sql_file:
        for ny_virksomhet in nye_virksomheter:
            sql_file.write(insert_virksomhet(ny_virksomhet))
            sql_file.write("\n")
            sql_file.write("\n")
            sql_file.write(
                insert_virksomhet_naringsundergrupper(
                    ny_virksomhet.orgnummer, ny_virksomhet.næringskode
                )
            )
            sql_file.write("\n")
            sql_file.write("\n")

    return len(nye_virksomheter)


if __name__ == "__main__":
    input_folder = "data"
    output_folder = "output"

    alle_virksomheter = []
    innleste_orgnr: set[str] = set()
    duplikater_fjernet = 0

    if not os.path.exists(output_folder):
        os.mkdir(output_folder)

    for fylke in os.listdir(input_folder):
        if fylke == ".DS_Store":
            continue

        print(f"Antall virksomheter for {fylke}:")
        count = 0

        for næring in os.listdir(f"{input_folder}/{fylke}"):
            if næring == ".DS_Store":
                continue

            for filename in os.listdir(f"{input_folder}/{fylke}/{næring}"):
                if filename == ".DS_Store":
                    continue

                filename: str = f"{input_folder}/{fylke}/{næring}/{filename}"

                nye_virksomheter: list[Virksomhet] = parse_tenor_fil(filename)

                antall_nye_virksomheter: int = len(nye_virksomheter)
                print(f" {næring}: {len(nye_virksomheter)}")

                nye_virksomheter = [
                    virksomhet
                    for virksomhet in nye_virksomheter
                    if virksomhet.orgnummer not in innleste_orgnr
                ]

                innleste_orgnr.update(
                    [virksomhet.orgnummer for virksomhet in nye_virksomheter]
                )

                duplikater_fjernet += antall_nye_virksomheter - len(nye_virksomheter)

                count += len(nye_virksomheter)

                skriv_til_fil(
                    f"{output_folder}/{fylke.lower().replace(' ', '')}_{næring}_insert_testvirksomheter.sql",
                    nye_virksomheter,
                )

                alle_virksomheter.extend(nye_virksomheter)

        print(f" Totalt: {count}")
        print("---------------")

    if duplikater_fjernet > 0:
        print(f"Duplikater droppet: {duplikater_fjernet}")
