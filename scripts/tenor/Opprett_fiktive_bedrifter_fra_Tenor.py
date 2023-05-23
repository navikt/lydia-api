import json

import_file = 'tenor/data/eksport-brreg-er-fr-2023-05-22T14_28_30.635Z--Sykehus--86.json'

output_file_SQL = 'tenor/output/insert_fiktive_virksomheter.sql'
output_file_fiktive_orgnr_liste_TXT = 'tenor/output/fiktive_orgnr.txt'


def insert_into_virksomhet(
        orgnr,
        navn,
        kommune,
        postnummer,
        adresse_lines,
        kommunenummer,
        poststed,
        oppstartsdato,
        landkode,
        land
):
    separator = ', '
    adresse = separator.join(f'"{adresse_line}"' for adresse_line in adresse_lines)
    return f"INSERT INTO public.virksomhet " \
           f"(orgnr, land, landkode, postnummer, poststed, kommune, kommunenummer, navn, adresse, status, oppstartsdato) " \
           f"VALUES ('{orgnr}', '{land}', '{landkode}', '{postnummer}', '{poststed}', '{kommune}', '{kommunenummer}', " \
           f"'{navn}', '{{{adresse}}}', " \
           f"'AKTIV', '{oppstartsdato}');"


def insert_into_virksomhet_naring(orgnr, naringskode):
    return f"INSERT INTO public.virksomhet_naring " \
           f" (virksomhet, narings_kode) " \
           f"select id, '{naringskode}' as kode from virksomhet where orgnr='{orgnr}'; "


with open(import_file, 'r') as tenorTestDataFil, \
        open(output_file_SQL, 'w') as output_file_inserts_sql, \
        open(output_file_fiktive_orgnr_liste_TXT, 'w') as output_file_liste_av_fiktive_orgnr:
    json_decode = json.load(tenorTestDataFil)
    result = []
    for item in json_decode['dokumentListe']:
        organisasjonner = {
            'orgnr': item.get('organisasjonsnummer'),
            'navn': item.get('navn'),
            'organisasjonsform': item.get('organisasjonsform').get('kode'),
            'naringskode': item.get('naeringKode')[0],
            'forretningsadresse': item.get('forretningsadresse'),
            'registreringsdatoEnhetsregisteret': item.get('registreringsdatoEnhetsregisteret')
        }
        result.append(organisasjonner)

    antall_fiktive_virksomheter = 0
    for item in result:
        kommune = item.get('forretningsadresse').get('kommune')
        postnummer = item.get('forretningsadresse').get('postnummer')
        adresse_lines: list = item.get('forretningsadresse').get('adresse')
        kommunenummer = item.get('forretningsadresse').get('kommunenummer')
        poststed = item.get('forretningsadresse').get('poststed')
        landkode = item.get('forretningsadresse').get('landkode')
        land = item.get('forretningsadresse').get('land')
        oppstartsdato = item.get('registreringsdatoEnhetsregisteret')

        # orgnr, navn, kommune, postnummer, adresse_lines, kommunenummer, poststed, landkode, land
        output_file_inserts_sql.write(
            insert_into_virksomhet(
                item.get('orgnr'),
                item.get('navn'),
                kommune,
                postnummer,
                adresse_lines,
                kommunenummer,
                poststed,
                oppstartsdato,
                landkode,
                land
            )
        )
        output_file_inserts_sql.write('\n')
        output_file_inserts_sql.write(
            insert_into_virksomhet_naring(
                item.get('orgnr'),
                item.get('naringskode')
            )
        )
        output_file_inserts_sql.write('\n')
        output_file_liste_av_fiktive_orgnr.write(item.get('orgnr'))
        output_file_liste_av_fiktive_orgnr.write('\n')
    print('----> Closing files')
    output_file_inserts_sql.close()
    output_file_liste_av_fiktive_orgnr.close()

print('----> Nye bedrifter som kan opprettes: ')
for item in result:
    antall_fiktive_virksomheter = antall_fiktive_virksomheter + 1
    print(item.get('orgnr'))

print(f'----> Antall bedrifter: {antall_fiktive_virksomheter}')
