package no.nav.lydia.sykefraversstatistikk

import SykefraversstatistikkImportDto
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IAProsessStatus.IKKE_AKTIV
import no.nav.lydia.sykefraversstatistikk.api.ListResponse
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere
import no.nav.lydia.sykefraversstatistikk.api.geografi.Kommune
import no.nav.lydia.sykefraversstatistikk.domene.SykefraversstatistikkVirksomhet
import javax.sql.DataSource

class SykefraversstatistikkRepository(val dataSource: DataSource) {
    fun insert(sykefraværsStatistikkListe: List<SykefraversstatistikkImportDto>) {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                sykefraværsStatistikkListe.forEach { sykefraværsStatistikk ->
                    tx.run(
                        queryOf(
                            """
                       INSERT INTO sykefravar_statistikk_virksomhet(
                        orgnr,
                        arstall,
                        kvartal,
                        antall_personer,
                        tapte_dagsverk,
                        mulige_dagsverk,
                        sykefraversprosent,
                        maskert
                       )
                        VALUES(
                        :orgnr,
                        :arstall,
                        :kvartal,
                        :antall_personer,
                        :tapte_dagsverk,
                        :mulige_dagsverk,
                        :sykefraversprosent,
                        :maskert
                        ) 
                        ON CONFLICT DO NOTHING
                        """.trimMargin(),
                            mapOf(
                                "orgnr" to sykefraværsStatistikk.virksomhetSykefravær.orgnr,
                                "arstall" to sykefraværsStatistikk.virksomhetSykefravær.årstall,
                                "kvartal" to sykefraværsStatistikk.virksomhetSykefravær.kvartal,
                                "antall_personer" to sykefraværsStatistikk.virksomhetSykefravær.antallPersoner,
                                "tapte_dagsverk" to sykefraværsStatistikk.virksomhetSykefravær.tapteDagsverk,
                                "mulige_dagsverk" to sykefraværsStatistikk.virksomhetSykefravær.muligeDagsverk,
                                "sykefraversprosent" to sykefraværsStatistikk.virksomhetSykefravær.prosent,
                                "maskert" to sykefraværsStatistikk.virksomhetSykefravær.maskert
                            )
                        ).asUpdate
                    )

                    tx.run(
                        queryOf(
                            """
                        INSERT INTO virksomhet_statistikk_metadata(
                            orgnr,
                            kategori,
                            sektor
                        )
                        VALUES(
                            :orgnr,
                            :kategori,
                            :sektor
                        )
                        ON CONFLICT (orgnr) DO UPDATE SET
                            kategori = :kategori,
                            sektor = :sektor
                    """.trimIndent(),
                            mapOf(
                                "orgnr" to sykefraværsStatistikk.virksomhetSykefravær.orgnr,
                                "kategori" to sykefraværsStatistikk.virksomhetSykefravær.kategori,
                                "sektor" to sykefraværsStatistikk.sektorSykefravær.kode
                            )
                        ).asUpdate
                    )
                }
            }
        }
    }

    private fun filterVerdi(filterNavn: String, filterVerdier: Set<String>) =
        """
            $filterNavn (inkluderAlle, filterverdi) AS (
                    VALUES (
                        ${filterVerdier.isEmpty()},
                        :$filterNavn
                    )    
                )
        """.trimIndent()

    fun hentSykefravær(
        søkeparametere: Søkeparametere
    ): ListResponse<SykefraversstatistikkVirksomhet> {
        val sykefraværMedAntall = using(sessionOf(dataSource)) { session ->
            val tmpKommuneTabell = "kommuner"
            val tmpNæringTabell = "naringer"
            val sql = """
                    WITH 
                        ${filterVerdi(tmpKommuneTabell, søkeparametere.kommunenummer)},
                        ${filterVerdi(tmpNæringTabell, søkeparametere.næringsgruppeKoder)}
                    SELECT
                        DISTINCT virksomhet.orgnr,
                        virksomhet.navn,
                        virksomhet.kommune,
                        virksomhet.kommunenummer,
                        statistikk.arstall,
                        statistikk.kvartal,
                        statistikk.antall_personer,
                        statistikk.tapte_dagsverk,
                        statistikk.mulige_dagsverk,
                        statistikk.sykefraversprosent,
                        statistikk.maskert,
                        statistikk.opprettet,
                        ia_sak.status,
                        ia_sak.eid_av,
                        COUNT(*) OVER() AS total
                    FROM sykefravar_statistikk_virksomhet AS statistikk
                    JOIN virksomhet USING (orgnr)
                    LEFT JOIN ia_sak USING (orgnr)
                    JOIN virksomhet_naring AS vn on (virksomhet.id = vn.virksomhet)
                    
                    WHERE (
                        (SELECT inkluderAlle FROM $tmpKommuneTabell) IS TRUE OR
                        virksomhet.kommunenummer in (select unnest($tmpKommuneTabell.filterverdi) FROM $tmpKommuneTabell)
                    )
                    AND (
                        (SELECT inkluderAlle FROM $tmpNæringTabell) IS TRUE OR
                        vn.narings_kode in (select unnest($tmpNæringTabell.filterverdi) FROM $tmpNæringTabell)
                    )
                    AND (
                        statistikk.kvartal = :kvartal AND statistikk.arstall = :arstall
                    )
                    AND (
                        statistikk.sykefraversprosent BETWEEN :sykefraversprosentFra AND :sykefraversprosentTil
                    )
                    
                    ${søkeparametere.status?.let { status ->
                        when (status) {
                            IKKE_AKTIV -> " AND ia_sak.status IS NULL"
                            else -> " AND ia_sak.status = '$status'"
                        }} ?: ""
                    }
                    ${søkeparametere.sykefraværsprosentFra?.let { " AND statistikk.sykefraversprosent >= $it " } ?: ""}
                    ${søkeparametere.sykefraværsprosentTil?.let { " AND statistikk.sykefraversprosent <= $it " } ?: ""}
                    
                    ${søkeparametere.ansatteFra?.let { " AND statistikk.antall_personer >= $it " } ?: ""}
                    ${søkeparametere.ansatteTil?.let { " AND statistikk.antall_personer <= $it " } ?: ""}
                    
                    ORDER BY statistikk.${søkeparametere.sorteringsnøkkel} ${søkeparametere.sorteringsretning}
                    
                    LIMIT ${søkeparametere.virksomheterPerSide()}
                    OFFSET ${søkeparametere.offset()}
                """.trimIndent()

            val query = queryOf(
                statement = sql,
                mapOf(
                    tmpKommuneTabell to session.connection.underlying.createArrayOf("text", søkeparametere.kommunenummer.toTypedArray()),
                    tmpNæringTabell to session.connection.underlying.createArrayOf("text", søkeparametere.næringsgruppeKoder.toTypedArray()),
                    "kvartal" to søkeparametere.periode.kvartal,
                    "arstall" to søkeparametere.periode.årstall,
                    "sykefraversprosentFra" to søkeparametere.sykefraværsperiode.fra,
                    "sykefraversprosentTil" to søkeparametere.sykefraværsperiode.til
                )
            ).map(this::mapRow).asList
            session.run(query)
        }

        val sykefraværsStatistikk = sykefraværMedAntall.map { it.first }
        val totaltAntallVirksomheter = sykefraværMedAntall.firstOrNull()?.second ?: 0

        return ListResponse(data = sykefraværsStatistikk, total = totaltAntallVirksomheter)
    }


    fun hentSykefraværForVirksomhet(orgnr: String): List<SykefraversstatistikkVirksomhet> {
        return using(sessionOf(dataSource)) { session ->
            val query = queryOf(
                statement = """
                    SELECT
                        statistikk.orgnr,
                        virksomhet.navn,
                        virksomhet.kommune,
                        virksomhet.kommunenummer,
                        statistikk.arstall,
                        statistikk.kvartal,
                        statistikk.antall_personer,
                        statistikk.tapte_dagsverk,
                        statistikk.mulige_dagsverk,
                        statistikk.sykefraversprosent,
                        statistikk.maskert,
                        statistikk.opprettet,
                        ia_sak.status,
                        ia_sak.eid_av,
                        COUNT(*) OVER() AS total
                  FROM sykefravar_statistikk_virksomhet AS statistikk
                  JOIN virksomhet USING (orgnr)
                  LEFT JOIN ia_sak USING(orgnr)
                  WHERE (statistikk.orgnr = :orgnr)
                """.trimIndent(),
                paramMap = mapOf("orgnr" to orgnr)
            ).map(this::mapRow).asList
            session.run(query).map { it.first }
        }
    }

    private fun mapRow(row: Row): Pair<SykefraversstatistikkVirksomhet, Int> {
        return SykefraversstatistikkVirksomhet(
            virksomhetsnavn = row.string("navn"),
            kommune = Kommune(row.string("kommune"), row.string("kommunenummer")),
            orgnr = row.string("orgnr"),
            arstall = row.int("arstall"),
            kvartal = row.int("kvartal"),
            antallPersoner = row.double("antall_personer"),
            tapteDagsverk = row.double("tapte_dagsverk"),
            muligeDagsverk = row.double("mulige_dagsverk"),
            sykefraversprosent = row.double("sykefraversprosent"),
            maskert = row.boolean("maskert"),
            opprettet = row.localDateTime("opprettet"),
            status = row.stringOrNull("status")?.let {
                IAProsessStatus.valueOf(it)
            },
            eidAv = row.stringOrNull("eid_av")
        ) to row.int("total")
    }
}
