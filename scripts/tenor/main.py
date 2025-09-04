import json
import os


class Virksomhet:
    def __init__(
        self,
        orgnummer: str,
        navn: str,
        næringskode: list[str],
        kommune: str,
        postnummer: str,
        adresse_lines: list[str],
        kommunenummer: str,
        poststed: str,
        landkode: str,
        land: str,
        oppstartsdato: str,
        antall_ansatte: int,
    ):
        self.orgnummer: str = orgnummer
        self.navn: str = navn
        self.næringskode: list[str] = næringskode
        self.kommune: str = kommune
        self.postnummer: str = postnummer
        self.adresse_lines: list[str] = adresse_lines
        self.kommunenummer: str = kommunenummer
        self.poststed: str = poststed
        self.landkode: str = landkode
        self.land: str = land
        self.oppstartsdato: str = oppstartsdato
        self.antall_ansatte: int = antall_ansatte

    def __eq__(self, other: object) -> bool:
        if not isinstance(other, Virksomhet):
            return NotImplemented

        return self.orgnummer == other.orgnummer

    def __hash__(self) -> int:
        return hash(("orgnummer", self.orgnummer))


def parse_tenor_fil(
    import_filename: str,
) -> list[Virksomhet]:
    nye_virksomheter: list[Virksomhet] = []

    with open(import_filename, "r") as tenorTestDataFil:
        json_decode = json.load(tenorTestDataFil)
        for virksomhet in json_decode["dokumentListe"]:
            nye_virksomheter.append(
                Virksomhet(
                    orgnummer=virksomhet.get("organisasjonsnummer"),
                    navn=virksomhet.get("navn"),
                    næringskode=virksomhet.get("naeringKode"),
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
                    ny_virksomhet.orgnummer, ny_virksomhet.næringskode[0]
                )
            )
            sql_file.write("\n")
            sql_file.write("\n")

    return len(nye_virksomheter)


if __name__ == "__main__":
    input_folder = "data"
    output_folder = "output"

    alle_virksomheter: list[Virksomhet] = []
    innleste_orgnr: set[str] = set()
    duplikater_fjernet = 0
    total_count = 0

    if not os.path.exists(output_folder):
        os.mkdir(output_folder)

    for fil in os.listdir(input_folder):
        if fil == ".DS_Store":
            continue

        filename: str = f"{input_folder}/{fil}"

        nye_virksomheter: list[Virksomhet] = parse_tenor_fil(filename)
        antall_nye_virksomheter: int = len(nye_virksomheter)

        nye_virksomheter = [
            virksomhet
            for virksomhet in nye_virksomheter
            if virksomhet.orgnummer not in innleste_orgnr
        ]

        innleste_orgnr.update([virksomhet.orgnummer for virksomhet in nye_virksomheter])

        duplikater_fjernet += antall_nye_virksomheter - len(nye_virksomheter)

        total_count += len(nye_virksomheter)

        skriv_til_fil(
            f"{output_folder}/{fil}.sql",
            nye_virksomheter,
        )

        alle_virksomheter.extend(nye_virksomheter)

    print(f"Totalt antall virksomheter: {total_count}")

    if duplikater_fjernet > 0:
        print(f"Duplikater droppet: {duplikater_fjernet}")
