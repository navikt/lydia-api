import json

# Script som parser json response fra api_sykefraversstatistikk_response.json
#  og skriver ut alle orgnr til fia_orgnr.txt
input_file = 'tenor/tmp/api_sykefraversstatistikk_response.json'
output_file = 'tenor/tmp/fia_orgnr.txt'


with open(input_file, 'r') as fiaBedrifterFraAPI, \
        open(output_file, 'w') as fiaOrgnr:
    json_decode = json.load(fiaBedrifterFraAPI)

    antall_fia_virksomheter = 0
    for item in json_decode['data']:
        orgnr = item.get('orgnr')
        antall_fia_virksomheter = antall_fia_virksomheter + 1
        fiaOrgnr.write(orgnr)
        fiaOrgnr.write('\n')

    fiaOrgnr.close()
    fiaBedrifterFraAPI.close()
    print(f'----> {antall_fia_virksomheter}')
