CREATE MATERIALIZED VIEW virksomhetsstatistikk_for_prioritering
AS
SELECT
    virksomhet.orgnr AS orgnr,
    virksomhet.navn AS navn,
    virksomhet.kommunenummer AS kommunenummer,
    virksomhet_statistikk_metadata.sektor AS sektor,
    vn.naringsundergruppe1 AS naringsundergruppe1,
    vn.naringsundergruppe2 AS naringsundergruppe2,
    vn.naringsundergruppe3 AS naringsundergruppe3,
    statistikk_siste_kvartal.arstall AS arstall,
    statistikk_siste_kvartal.kvartal AS kvartal,
    statistikk_siste_kvartal.antall_personer AS antall_personer_siste_kvartal,
    statistikk.tapte_dagsverk AS tapte_dagsverk,
    statistikk.mulige_dagsverk AS mulige_dagsverk,
    statistikk.prosent AS prosent,
    statistikk.maskert AS maskert,
    statistikk.sist_endret AS statistikk_sist_endret,
    bransje.kode AS bransje_kode,
    bransje.prosent AS bransje_prosent,
    naring.kode AS naring_kode,
    naring.prosent AS naring_prosent
FROM
    sykefravar_statistikk_virksomhet AS statistikk_siste_kvartal
JOIN virksomhet USING (orgnr)
JOIN sykefravar_statistikk_virksomhet_siste_4_kvartal AS statistikk ON (
    statistikk_siste_kvartal.orgnr = statistikk.orgnr
    AND statistikk_siste_kvartal.kvartal = statistikk.publisert_kvartal
    AND statistikk_siste_kvartal.arstall = statistikk.publisert_arstall
)
JOIN virksomhet_naringsundergrupper AS vn ON (virksomhet.id = vn.virksomhet)
LEFT JOIN virksomhet_statistikk_metadata ON (
    virksomhet.orgnr = virksomhet_statistikk_metadata.orgnr
)
LEFT JOIN naringsundergrupper_per_bransje AS bransjeprogram ON (
    vn.naringsundergruppe1 = bransjeprogram.naringsundergruppe
)
LEFT JOIN sykefravar_statistikk_kategori_siste_4_kvartal AS bransje ON (
    bransjeprogram.bransje = bransje.kode
    AND bransje.kategori = 'BRANSJE'
    AND bransje.publisert_kvartal = statistikk_siste_kvartal.kvartal
    AND bransje.publisert_arstall = statistikk_siste_kvartal.arstall
)
JOIN sykefravar_statistikk_kategori_siste_4_kvartal AS naring ON (
    substr(vn.naringsundergruppe1, 1, 2) = naring.kode
    AND naring.kategori = 'NÆRING'
    AND naring.publisert_kvartal = statistikk_siste_kvartal.kvartal
    AND naring.publisert_arstall = statistikk_siste_kvartal.arstall
)
WHERE
    statistikk_siste_kvartal.arstall = (
        SELECT gjeldende_arstall FROM siste_publiseringsinfo ORDER BY gjeldende_arstall DESC, gjeldende_kvartal DESC LIMIT 1
    )
    AND statistikk_siste_kvartal.kvartal = (
        SELECT gjeldende_kvartal FROM siste_publiseringsinfo ORDER BY gjeldende_arstall DESC, gjeldende_kvartal DESC LIMIT 1
    )
    AND virksomhet.status = 'AKTIV';
