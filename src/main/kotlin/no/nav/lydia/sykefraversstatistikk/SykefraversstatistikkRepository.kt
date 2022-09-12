package no.nav.lydia.sykefraversstatistikk

import kotlinx.datetime.toKotlinLocalDate
import kotliquery.Row
import kotliquery.TransactionalSession
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IAProsessStatus.IKKE_AKTIV
import no.nav.lydia.sykefraversstatistikk.api.SykefraværsstatistikkListResponse
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere
import no.nav.lydia.sykefraversstatistikk.api.geografi.Kommune
import no.nav.lydia.sykefraversstatistikk.api.geografi.NavEnheter
import no.nav.lydia.sykefraversstatistikk.domene.SykefraversstatistikkVirksomhet
import no.nav.lydia.sykefraversstatistikk.import.AggregertSykefraværsstatistikk
import no.nav.lydia.sykefraversstatistikk.import.LandSykefravær
import no.nav.lydia.sykefraversstatistikk.import.NæringSykefravær
import no.nav.lydia.sykefraversstatistikk.import.NæringsundergruppeSykefravær
import no.nav.lydia.sykefraversstatistikk.import.SektorSykefravær
import no.nav.lydia.sykefraversstatistikk.import.SykefraversstatistikkImportDto
import no.nav.lydia.virksomhet.domene.VirksomhetStatus
import javax.sql.DataSource

class SykefraversstatistikkRepository(val dataSource: DataSource) {
    fun insert(sykefraværsStatistikkListe: List<SykefraversstatistikkImportDto>) {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.insertVirksomhetsstatistikk(sykefraværsStatistikkListe = sykefraværsStatistikkListe)
                tx.insertAggregertSykefraværsstatistikk(sykefraværsStatistikkListe = sykefraværsStatistikkListe.map { it.sektorSykefravær }.toSet())
                tx.insertAggregertSykefraværsstatistikk(sykefraværsStatistikkListe = sykefraværsStatistikkListe.map { it.næringSykefravær }.toSet())
                tx.insertAggregertSykefraværsstatistikk(sykefraværsStatistikkListe = sykefraværsStatistikkListe.flatMap { it.næring5SifferSykefravær }.toSet())
                tx.insertAggregertSykefraværsstatistikk(sykefraværsStatistikkListe = sykefraværsStatistikkListe.map { it.landSykefravær }.toSet())
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


    fun hentTotaltAntall(søkeparametere: Søkeparametere): Int? {
        if (!søkeparametere.skalInkludereTotaltAntall) {
            return null
        }
        return using(sessionOf(dataSource)) { session ->
            val næringsgrupperMedBransjer = søkeparametere.næringsgrupperMedBransjer()
            val tmpKommuneTabell = "kommuner"
            val tmpNæringTabell = "naringer"
            val tmpNavIdenterTabell = "nav_identer"
            val sql =
                """
                        WITH 
                            ${filterVerdi(tmpKommuneTabell, søkeparametere.kommunenummer)},
                            ${filterVerdi(tmpNæringTabell, næringsgrupperMedBransjer)},
                            ${filterVerdi(tmpNavIdenterTabell, søkeparametere.navIdenter)}
                        SELECT
                            COUNT(DISTINCT virksomhet.orgnr) AS total
                        ${filter(
                    tmpKommuneTabell = tmpKommuneTabell,
                    tmpNavIdenterTabell = tmpNavIdenterTabell,
                    tmpNæringTabell = tmpNæringTabell,
                    søkeparametere = søkeparametere
                )}
                    """.trimIndent()

            val query = queryOf(
                statement = sql,
                mapOf(
                    tmpKommuneTabell to session.connection.underlying.createArrayOf(
                        "text",
                        søkeparametere.kommunenummer.toTypedArray()
                    ),
                    tmpNæringTabell to session.connection.underlying.createArrayOf(
                        "text",
                        næringsgrupperMedBransjer.toTypedArray()
                    ),
                    tmpNavIdenterTabell to session.connection.underlying.createArrayOf(
                        "text",
                        søkeparametere.navIdenter.toTypedArray()
                    ),
                    "kvartal" to søkeparametere.periode.kvartal,
                    "arstall" to søkeparametere.periode.årstall
                )
            )
            session.run(query.map { it.int("total") }.asSingle)
        }
    }

    fun hentSykefravær(
        søkeparametere: Søkeparametere
    ): SykefraværsstatistikkListResponse {
        val sykefraværsStatistikk = using(sessionOf(dataSource)) { session ->
            val næringsgrupperMedBransjer = søkeparametere.næringsgrupperMedBransjer()
            val tmpKommuneTabell = "kommuner"
            val tmpNæringTabell = "naringer"
            val tmpNavIdenterTabell = "nav_identer"
            val sql = """
                    WITH 
                        ${filterVerdi(tmpKommuneTabell, søkeparametere.kommunenummer)},
                        ${filterVerdi(tmpNæringTabell, næringsgrupperMedBransjer)},
                        ${filterVerdi(tmpNavIdenterTabell, søkeparametere.navIdenter)}
                    SELECT
                        virksomhet.orgnr,
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
                        ia_sak.endret
                    ${filter(
                        tmpKommuneTabell = tmpKommuneTabell,
                        tmpNavIdenterTabell = tmpNavIdenterTabell,
                        tmpNæringTabell = tmpNæringTabell,
                        søkeparametere = søkeparametere
                    )}
                    GROUP BY 
                        virksomhet.orgnr,
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
                        ia_sak.endret
                    ${søkeparametere.sorteringsnøkkel.tilOrderBy()} ${søkeparametere.sorteringsretning} NULLS LAST
                    LIMIT ${søkeparametere.virksomheterPerSide()}
                    OFFSET ${søkeparametere.offset()}
                """.trimIndent()

            val query = queryOf(
                statement = sql,
                mapOf(
                    tmpKommuneTabell to session.connection.underlying.createArrayOf(
                        "text",
                        søkeparametere.kommunenummer.toTypedArray()
                    ),
                    tmpNæringTabell to session.connection.underlying.createArrayOf(
                        "text",
                        næringsgrupperMedBransjer.toTypedArray()
                    ),
                    tmpNavIdenterTabell to session.connection.underlying.createArrayOf(
                        "text",
                        søkeparametere.navIdenter.toTypedArray()
                    ),
                    "kvartal" to søkeparametere.periode.kvartal,
                    "arstall" to søkeparametere.periode.årstall
                )
            ).map(this::mapRow).asList
            session.run(query)
        }

        val totaltAntallVirksomheter = hentTotaltAntall(søkeparametere = søkeparametere)

        return SykefraværsstatistikkListResponse(data = sykefraværsStatistikk, total = totaltAntallVirksomheter)
    }

    private fun filter(
        tmpKommuneTabell: String,
        tmpNavIdenterTabell: String,
        tmpNæringTabell: String,
        søkeparametere: Søkeparametere
    ) = """
        FROM sykefravar_statistikk_virksomhet AS statistikk
        JOIN virksomhet USING (orgnr)
        LEFT JOIN ia_sak USING (orgnr)
        JOIN virksomhet_naring AS vn on (virksomhet.id = vn.virksomhet)
        
        WHERE (
            (SELECT inkluderAlle FROM $tmpKommuneTabell) IS TRUE OR
            virksomhet.kommunenummer in (select unnest($tmpKommuneTabell.filterverdi) FROM $tmpKommuneTabell)
        )
        AND (
            (SELECT inkluderAlle FROM $tmpNavIdenterTabell) IS TRUE OR
            ia_sak.eid_av in (select unnest($tmpNavIdenterTabell.filterverdi) FROM $tmpNavIdenterTabell)
        )
        AND (
            (SELECT inkluderAlle FROM $tmpNæringTabell) IS TRUE
            OR substr(vn.narings_kode, 1, 2) in (select unnest($tmpNæringTabell.filterverdi) FROM $tmpNæringTabell)
            ${
                if (søkeparametere.bransjeprogram.isNotEmpty()) {
                    val koder = søkeparametere.bransjeprogram.flatMap { it.næringskoder }.groupBy {
                        it.length
                    }
                    val femsifrede = koder[5]?.joinToString { "'${it.take(2)}.${it.takeLast(3)}'" }
                    femsifrede?.let { "OR (vn.narings_kode in (select unnest($tmpNæringTabell.filterverdi) FROM $tmpNæringTabell))" } ?: ""
                } else ""
            }
        )
        AND statistikk.kvartal = :kvartal
        AND statistikk.arstall = :arstall
        AND ( virksomhet.orgnr NOT in ${
            NavEnheter.enheterSomSkalSkjermes.joinToString(
                prefix = "(",
                postfix = ")",
                separator = ","
            ) { s -> "\'$s\'" }
        } )
                        
        ${søkeparametere.status?.let { status ->
                when (status) {
                    IKKE_AKTIV -> " AND ia_sak.status IS NULL"
                    else -> " AND ia_sak.status = '$status'"
                }
            } ?: ""
        }
                        
        ${søkeparametere.sykefraværsprosentFra?.let { " AND statistikk.sykefraversprosent >= $it " } ?: ""}
        ${søkeparametere.sykefraværsprosentTil?.let { " AND statistikk.sykefraversprosent <= $it " } ?: ""}
        
        ${søkeparametere.ansatteFra?.let { " AND statistikk.antall_personer >= $it " } ?: ""}
        ${søkeparametere.ansatteTil?.let { " AND statistikk.antall_personer <= $it " } ?: ""}
        AND virksomhet.status = '${VirksomhetStatus.AKTIV.name}'
        """.trimIndent()


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
                        ia_sak.endret
                  FROM sykefravar_statistikk_virksomhet AS statistikk
                  JOIN virksomhet USING (orgnr)
                  LEFT JOIN ia_sak USING(orgnr)
                  WHERE (statistikk.orgnr = :orgnr) AND statistikk.orgnr NOT in ${
                    NavEnheter.enheterSomSkalSkjermes.joinToString(
                        prefix = "(",
                        postfix = ")",
                        separator = ","
                    ) { s -> "\'$s\'" }
                }
                """.trimIndent(),
                paramMap = mapOf(
                    "orgnr" to orgnr
                )
            ).map(this::mapRow).asList
            session.run(query)
        }
    }

    private fun mapRow(row: Row): SykefraversstatistikkVirksomhet {
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
            eidAv = row.stringOrNull("eid_av"),
            sistEndret = row.localDateOrNull("endret")?.toKotlinLocalDate()
        )
    }
}

private fun TransactionalSession.insertVirksomhetsstatistikk(sykefraværsStatistikkListe: List<SykefraversstatistikkImportDto>) =
    sykefraværsStatistikkListe.forEach { sykefraværsStatistikk ->
        run(
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
                        ON CONFLICT ON CONSTRAINT sykefravar_periode DO UPDATE SET
                            antall_personer = :antall_personer,
                            tapte_dagsverk = :tapte_dagsverk,
                            mulige_dagsverk = :mulige_dagsverk,
                            sykefraversprosent = :sykefraversprosent,
                            maskert = :maskert,
                            endret = now()
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

        run(
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

private fun AggregertSykefraværsstatistikk.tilTabellnavn() = when (this) {
    is NæringSykefravær -> "sykefravar_statistikk_naring"
    is NæringsundergruppeSykefravær -> "sykefravar_statistikk_naringsundergruppe"
    is SektorSykefravær -> "sykefravar_statistikk_sektor"
    is LandSykefravær -> "sykefravar_statistikk_land"
}

private fun AggregertSykefraværsstatistikk.tilKolonnenavn() = when (this) {
    is NæringSykefravær -> "naring"
    is NæringsundergruppeSykefravær -> "naringsundergruppe"
    is SektorSykefravær -> "sektor_kode"
    is LandSykefravær -> "land"
}

private fun TransactionalSession.insertAggregertSykefraværsstatistikk(sykefraværsStatistikkListe: Collection<AggregertSykefraværsstatistikk>) =
    sykefraværsStatistikkListe.forEach { sykefraværsstatistikk ->
        run(
            queryOf(
                """
                    INSERT INTO ${sykefraværsstatistikk.tilTabellnavn()}(
                        arstall,
                        kvartal,
                        ${sykefraværsstatistikk.tilKolonnenavn()},
                        antall_personer,
                        tapte_dagsverk,
                        mulige_dagsverk,
                        prosent,
                        maskert
                    )
                    VALUES(
                        :arstall,
                        :kvartal,
                        :kode,
                        :antall_personer,
                        :tapte_dagsverk,
                        :mulige_dagsverk,
                        :prosent,
                        :maskert
                    )
                    ON CONFLICT DO NOTHING
                """.trimIndent(),
                mapOf(
                    "arstall" to sykefraværsstatistikk.årstall,
                    "kvartal" to sykefraværsstatistikk.kvartal,
                    "kode" to sykefraværsstatistikk.kode,
                    "antall_personer" to sykefraværsstatistikk.antallPersoner,
                    "tapte_dagsverk" to sykefraværsstatistikk.tapteDagsverk,
                    "mulige_dagsverk" to sykefraværsstatistikk.muligeDagsverk,
                    "prosent" to sykefraværsstatistikk.prosent,
                    "maskert" to sykefraværsstatistikk.maskert,
                )
            ).asUpdate
        )
    }
