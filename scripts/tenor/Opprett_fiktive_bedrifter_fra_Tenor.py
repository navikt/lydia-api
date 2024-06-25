import json
import os
import csv


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
            antall_ansatte
    ):
        self.orgnummer = orgnummer
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
        return hash(('orgnummer', self.orgnummer))


def insert_into_virksomhet(virksomhet: Virksomhet):
    separator = ", "
    adresse = separator.join(f'"{adresse_line}"' for adresse_line in virksomhet.adresse_lines)
    return (
        f"INSERT INTO public.virksomhet "
        f"(orgnr, land, landkode, postnummer, poststed, kommune, kommunenummer, navn, adresse, status, oppstartsdato) "
        f"VALUES ('{virksomhet.orgnummer}', '{virksomhet.land}', '{virksomhet.landkode}', '{virksomhet.postnummer}', '{virksomhet.poststed}', '{virksomhet.kommune}', '{virksomhet.kommunenummer}', "
        f"'{virksomhet.navn}', '{{{adresse}}}', "
        f"'AKTIV', '{virksomhet.oppstartsdato}') ON CONFLICT DO NOTHING;"
    )


def insert_into_virksomhet_naringsundergrupper(orgnr: str, naringskode: str) -> str:
    return (
        f"INSERT INTO public.virksomhet_naringsundergrupper "
        f" (virksomhet, naringsundergruppe1) "
        f"select id, '{naringskode}' as kode from virksomhet where orgnr='{orgnr}' ON CONFLICT DO NOTHING; "
    )


def ansatteTilEnum(antall_ansatte):
    if antall_ansatte <= 25:
        return "LITEN"
    elif antall_ansatte <= 100:
        return "MEDIUM"
    elif antall_ansatte <= 10000:
        return "STOR"
    else:
        return "ENORM"


def parseTenorFil(
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
                    adresse_lines=[adresse.replace("'", "") for adresse in
                                   virksomhet.get("forretningsadresse").get("adresse")],
                    kommunenummer=virksomhet.get("forretningsadresse").get("kommunenummer"),
                    poststed=virksomhet.get("forretningsadresse").get("poststed"),
                    landkode=virksomhet.get("forretningsadresse").get("landkode"),
                    land=virksomhet.get("forretningsadresse").get("land"),
                    oppstartsdato=virksomhet.get("registreringsdatoEnhetsregisteret"),
                    antall_ansatte=virksomhet.get("antallAnsatte")
                )
            )
    return nye_virksomheter


def skriv_til_fil(
        output_filename_SQL: str,
        output_filename_fiktive_orgnr_liste_csv: str,
        nye_virksomheter: list[Virksomhet]
):
    with (open(output_filename_SQL, "w") as sql_file,
          open(output_filename_fiktive_orgnr_liste_csv, 'w') as csv_file):
        csv_builder = csv.writer(csv_file)
        csv_builder.writerow(
            ['orgnr',
             'sektor',
             'primærnæring',
             'størrelse']
        )

        for indeks, ny_virksomhet in enumerate(nye_virksomheter):
            sektor = (indeks % 3) + 1
            størrelse = ansatteTilEnum(ny_virksomhet.antall_ansatte)

            csv_builder.writerow(
                [ny_virksomhet.orgnummer,
                 sektor,
                 ny_virksomhet.næringskode,
                 størrelse,
                 ]
            )

            sql_file.write(
                insert_into_virksomhet(
                    ny_virksomhet
                )
            )
            sql_file.write("\n")
            sql_file.write(
                insert_into_virksomhet_naringsundergrupper(
                    ny_virksomhet.orgnummer,
                    ny_virksomhet.næringskode
                )
            )
            sql_file.write("\n")

    return len(nye_virksomheter)


if __name__ == "__main__":
    input_folder = "tenor/data"
    output_folder = "tenor/output"

    alle_virksomheter = []
    innleste_orgnr = set()
    duplikater_fjernet = 0

    lag_individuelle_mapper_og_filer = False

    if not os.path.exists(output_folder):
        os.mkdir(output_folder)

    for fylke in os.listdir(input_folder):
        if fylke == ".DS_Store":
            continue

        if not os.path.exists(f"{output_folder}/{fylke}") and lag_individuelle_mapper_og_filer:
            os.mkdir(f"{output_folder}/{fylke}")

        print(f"Antall virksomheter for {fylke}:")
        count = 0

        for næring in os.listdir(f"{input_folder}/{fylke}"):
            if næring == ".DS_Store":
                continue

            if not os.path.exists(f"{output_folder}/{fylke}/{næring}") and lag_individuelle_mapper_og_filer:
                os.mkdir(f"{output_folder}/{fylke}/{næring}")

            for filename in os.listdir(f"{input_folder}/{fylke}/{næring}"):
                if filename == ".DS_Store":
                    continue

                import_file = f"{input_folder}/{fylke}/{næring}/{filename}"

                nye_virksomheter = parseTenorFil(
                    import_file,
                )
                antall_nye_virksomheter = len(nye_virksomheter)
                print(f" {næring}: {len(nye_virksomheter)}")

                nye_virksomheter = [virksomhet for virksomhet in nye_virksomheter if
                                    virksomhet.orgnummer not in innleste_orgnr]

                innleste_orgnr.update([virksomhet.orgnummer for virksomhet in nye_virksomheter])

                duplikater_fjernet += (antall_nye_virksomheter - len(nye_virksomheter))

                count += len(nye_virksomheter)

                if lag_individuelle_mapper_og_filer:
                    skriv_til_fil(
                        f"{output_folder}/{fylke}/{næring}/insert_testvirksomheter.sql",
                        f"{output_folder}/{fylke}/{næring}/testvirksomheter.csv",
                        nye_virksomheter
                    )

                alle_virksomheter.extend(nye_virksomheter)

        print(f" Totalt: {count}")
        print(f"---------------")

    if duplikater_fjernet > 0:
        print(f"Duplikater droppet: {duplikater_fjernet}")
