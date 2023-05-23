

with open('tenor/output/fiktive_orgnr.txt', 'r') as fiktive_orgnr_fil, \
        open('tenor/input/ekte_orgnr.txt', 'r') as ekte_orgnr_fil, \
        open('tenor/output/update_ekte_orgnr_med_fiktive_orgnr.sql', 'w') as sql_fil:
    result = []
    for fiktiv, ekte in zip(fiktive_orgnr_fil, ekte_orgnr_fil):
        fiktiv = fiktiv.strip()
        ekte = ekte.strip()
        result.append('')
        sql_fil.write(f"UPDATE public.IA_SAK set ORGNR='{fiktiv}' where ORGNR='{ekte}';\n")
        sql_fil.write(f"UPDATE public.IA_SAK_HENDELSE set ORGNR='{fiktiv}' where ORGNR='{ekte}';\n")
        sql_fil.write(f"UPDATE public.sykefravar_statistikk_virksomhet_siste_4_kvartal set ORGNR='{fiktiv}' where ORGNR='{ekte}';\n")
        sql_fil.write(f"UPDATE public.sykefravar_statistikk_virksomhet set ORGNR='{fiktiv}' where ORGNR='{ekte}';\n")
        sql_fil.write(f"UPDATE public.virksomhet_statistikk_metadata set ORGNR='{fiktiv}' where ORGNR='{ekte}';\n")

print("-----")
sql_fil.close()
