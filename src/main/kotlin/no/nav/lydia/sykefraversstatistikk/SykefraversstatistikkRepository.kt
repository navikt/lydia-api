package no.nav.lydia.sykefraversstatistikk

import com.google.gson.Gson
import com.google.gson.GsonBuilder
import kotlinx.datetime.toKotlinLocalDate
import kotliquery.Row
import kotliquery.TransactionalSession
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.UnleashKlient.skalHenteSiste4Kvartal
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IAProsessStatus.IKKE_AKTIV
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere
import no.nav.lydia.sykefraversstatistikk.api.geografi.Kommune
import no.nav.lydia.sykefraversstatistikk.domene.SykefraversstatistikkVirksomhet
import no.nav.lydia.sykefraversstatistikk.import.BehandletImportStatistikk
import no.nav.lydia.sykefraversstatistikk.import.BehandletKvartalsvisSykefraværsstatistikk
import no.nav.lydia.sykefraversstatistikk.import.BehandletLandSykefraværsstatistikk
import no.nav.lydia.sykefraversstatistikk.import.BehandletNæringSykefraværsstatistikk
import no.nav.lydia.sykefraversstatistikk.import.BehandletNæringsundergruppeSykefraværsstatistikk
import no.nav.lydia.sykefraversstatistikk.import.BehandletSektorSykefraværsstatistikk
import no.nav.lydia.sykefraversstatistikk.import.BehandletVirksomhetSykefraværsstatistikk
import no.nav.lydia.sykefraversstatistikk.import.SykefraversstatistikkPerKategoriImportDto
import no.nav.lydia.virksomhet.domene.VirksomhetStatus
import javax.sql.DataSource

class SykefraversstatistikkRepository(val dataSource: DataSource) {
    private val gson: Gson = GsonBuilder().create()

    fun insert(behandletImportStatistikkListe: List<BehandletImportStatistikk>) {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.insertBehandletImportStatistikk(
                    behandletImportStatistikkListe = behandletImportStatistikkListe
                )
            }
        }
    }

    fun insertSykefraværsstatistikkForSiste4KvartalerForAndreKategorier(
        sykefraværsstatistikk: List<SykefraversstatistikkPerKategoriImportDto>,
    ) = using(sessionOf(dataSource)) { session ->
        session.transaction { tx ->
            sykefraværsstatistikk.forEach {
                tx.run(
                    queryOf(
                        """
                            INSERT INTO sykefravar_statistikk_kategori_siste_4_kvartal(
                                kategori,
                                kode,
                                tapte_dagsverk,
                                mulige_dagsverk,
                                prosent,
                                maskert,
                                antall_kvartaler,
                                kvartaler
                            )
                            VALUES(
                                :kategori,
                                :kode,
                                :tapte_dagsverk,
                                :mulige_dagsverk,
                                :prosent,
                                :maskert,
                                :antall_kvartaler,
                                :kvartaler::jsonb
                            )
                            ON CONFLICT ON CONSTRAINT kategori_og_kode DO UPDATE SET
                                tapte_dagsverk = :tapte_dagsverk,
                                mulige_dagsverk = :mulige_dagsverk,
                                prosent = :prosent,
                                maskert = :maskert,
                                antall_kvartaler = :antall_kvartaler,
                                kvartaler = :kvartaler::jsonb,
                                sist_endret = now()
                        """.trimIndent(),
                        mapOf(
                            "kategori" to it.kategori.name,
                            "kode" to it.kode,
                            "tapte_dagsverk" to it.siste4Kvartal.tapteDagsverk,
                            "mulige_dagsverk" to it.siste4Kvartal.muligeDagsverk,
                            "prosent" to it.siste4Kvartal.prosent,
                            "maskert" to it.siste4Kvartal.erMaskert,
                            "antall_kvartaler" to it.siste4Kvartal.kvartaler.size,
                            "kvartaler" to gson.toJson(it.siste4Kvartal.kvartaler),
                        )
                    ).asUpdate
                )
            }
        }
    }

    fun insertSykefraværsstatistikkForSiste4KvartalerForVirksomhet(
        sykefraværsstatistikk: List<SykefraversstatistikkPerKategoriImportDto>,
    ) = using(sessionOf(dataSource)) { session ->
        session.transaction { tx ->
            sykefraværsstatistikk.forEach {
                tx.run(
                    queryOf(
                        """
                            INSERT INTO sykefravar_statistikk_virksomhet_siste_4_kvartal(
                                orgnr,
                                tapte_dagsverk,
                                mulige_dagsverk,
                                prosent,
                                maskert,
                                antall_kvartaler,
                                kvartaler
                            )
                            VALUES(
                                :orgnr,
                                :tapte_dagsverk,
                                :mulige_dagsverk,
                                :prosent,
                                :maskert,
                                :antall_kvartaler,
                                :kvartaler::jsonb
                            )
                            ON CONFLICT (orgnr) DO UPDATE SET
                                tapte_dagsverk = :tapte_dagsverk,
                                mulige_dagsverk = :mulige_dagsverk,
                                prosent = :prosent,
                                maskert = :maskert,
                                antall_kvartaler = :antall_kvartaler,
                                kvartaler = :kvartaler::jsonb,
                                sist_endret = now()
                        """.trimIndent(),
                        mapOf(
                            "orgnr" to it.kode,
                            "tapte_dagsverk" to it.siste4Kvartal.tapteDagsverk,
                            "mulige_dagsverk" to it.siste4Kvartal.muligeDagsverk,
                            "prosent" to it.siste4Kvartal.prosent,
                            "maskert" to it.siste4Kvartal.erMaskert,
                            "antall_kvartaler" to it.siste4Kvartal.kvartaler.size,
                            "kvartaler" to gson.toJson(it.siste4Kvartal.kvartaler),
                        )
                    ).asUpdate
                )
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

    private fun getTabellOgKolonneNavn(skalHentePåSiste4Kvartal: Boolean, feltnavn: String): String {
        return when(feltnavn) {
            "tapte_dagsverk" -> if(skalHentePåSiste4Kvartal) "statistikk_siste4.tapte_dagsverk" else "statistikk.tapte_dagsverk"
            "mulige_dagsverk" -> if(skalHentePåSiste4Kvartal) "statistikk_siste4.mulige_dagsverk" else "statistikk.mulige_dagsverk"
            "prosent" -> if(skalHentePåSiste4Kvartal) "statistikk_siste4.prosent" else "statistikk.sykefraversprosent"
            "maskert" -> if(skalHentePåSiste4Kvartal) "statistikk_siste4.maskert" else "statistikk.maskert"
            "sist_endret" -> if(skalHentePåSiste4Kvartal) "statistikk_siste4.sist_endret" else "statistikk.opprettet"
            else -> {
                throw RuntimeException("Ukjent felt $feltnavn")
            }
        }


    }

    fun hentSykefravær(
        søkeparametere: Søkeparametere,
    ) = using(sessionOf(dataSource)) { session ->
        val skalHentePåSiste4Kvartal = skalHenteSiste4Kvartal()
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
                        ${getTabellOgKolonneNavn(skalHentePåSiste4Kvartal, "tapte_dagsverk")},
                        ${getTabellOgKolonneNavn(skalHentePåSiste4Kvartal, "mulige_dagsverk")},
                        ${getTabellOgKolonneNavn(skalHentePåSiste4Kvartal, "prosent")},
                        ${getTabellOgKolonneNavn(skalHentePåSiste4Kvartal, "maskert")},
                        ${getTabellOgKolonneNavn(skalHentePåSiste4Kvartal, "sist_endret")},
                        ia_sak.status,
                        ia_sak.eid_av,
                        ia_sak.endret
                    ${
            filter(
                tmpKommuneTabell = tmpKommuneTabell,
                tmpNavIdenterTabell = tmpNavIdenterTabell,
                tmpNæringTabell = tmpNæringTabell,
                søkeparametere = søkeparametere
            )
        }
                    GROUP BY 
                        virksomhet.orgnr,
                        virksomhet.navn,
                        virksomhet.kommune,
                        virksomhet.kommunenummer,
                        statistikk.arstall,
                        statistikk.kvartal,
                        statistikk.antall_personer,
                        ${getTabellOgKolonneNavn(skalHentePåSiste4Kvartal, "tapte_dagsverk")},
                        ${getTabellOgKolonneNavn(skalHentePåSiste4Kvartal, "mulige_dagsverk")},
                        ${getTabellOgKolonneNavn(skalHentePåSiste4Kvartal, "prosent")},
                        ${getTabellOgKolonneNavn(skalHentePåSiste4Kvartal, "maskert")},
                        ${getTabellOgKolonneNavn(skalHentePåSiste4Kvartal, "sist_endret")},
                        ia_sak.status,
                        ia_sak.eid_av,
                        ia_sak.endret
                    ${søkeparametere.sorteringsnøkkel.tilOrderBy(skalHentePåSiste4Kvartal)} ${søkeparametere.sorteringsretning} NULLS LAST
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

    fun hentTotaltAntall(søkeparametere: Søkeparametere): Int? =
        using(sessionOf(dataSource)) { session ->
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
                        ${
                    filter(
                        tmpKommuneTabell = tmpKommuneTabell,
                        tmpNavIdenterTabell = tmpNavIdenterTabell,
                        tmpNæringTabell = tmpNæringTabell,
                        søkeparametere = søkeparametere
                    )
                }
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

    private fun filter(
        tmpKommuneTabell: String,
        tmpNavIdenterTabell: String,
        tmpNæringTabell: String,
        søkeparametere: Søkeparametere,
    ) = """
        FROM sykefravar_statistikk_virksomhet AS statistikk
        JOIN virksomhet USING (orgnr)
        LEFT JOIN sykefravar_statistikk_virksomhet_siste_4_kvartal AS statistikk_siste4 USING (orgnr)
        LEFT JOIN ia_sak ON (
            (ia_sak.orgnr = statistikk.orgnr) AND
            ia_sak.endret = (select max(endret) from ia_sak iasak2 where iasak2.orgnr = statistikk.orgnr)
        )
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
                        
        ${
        søkeparametere.status?.let { status ->
            when (status) {
                IKKE_AKTIV -> " AND ia_sak.status IS NULL"
                else -> " AND ia_sak.status = '$status'"
            }
        } ?: ""
    }
                        
        ${søkeparametere.sykefraværsprosentFra?.let { " AND statistikk_siste4.prosent >= $it " } ?: ""}
        ${søkeparametere.sykefraværsprosentTil?.let { " AND statistikk_siste4.prosent <= $it " } ?: ""}
        
        ${søkeparametere.ansatteFra?.let { " AND statistikk.antall_personer >= $it " } ?: ""}
        ${søkeparametere.ansatteTil?.let { " AND statistikk.antall_personer <= $it " } ?: ""}
        AND virksomhet.status = '${VirksomhetStatus.AKTIV.name}'
        """.trimIndent()


    fun hentSykefraværForVirksomhet(orgnr: String): List<SykefraversstatistikkVirksomhet> {
        val skalHentePåSiste4Kvartal = skalHenteSiste4Kvartal()
        return using(sessionOf(dataSource)) { session ->
            val query = queryOf(
                statement = """
                    SELECT
                        statistikk_siste4.orgnr,
                        virksomhet.navn,
                        virksomhet.kommune,
                        virksomhet.kommunenummer,
                        statistikk.arstall,
                        statistikk.kvartal,
                        statistikk.antall_personer,
                        ${getTabellOgKolonneNavn(skalHentePåSiste4Kvartal, "tapte_dagsverk")},
                        ${getTabellOgKolonneNavn(skalHentePåSiste4Kvartal, "mulige_dagsverk")},
                        ${getTabellOgKolonneNavn(skalHentePåSiste4Kvartal, "prosent")},
                        ${getTabellOgKolonneNavn(skalHentePåSiste4Kvartal, "maskert")},
                        ${getTabellOgKolonneNavn(skalHentePåSiste4Kvartal, "sist_endret")},
                        ia_sak.status,
                        ia_sak.eid_av,
                        ia_sak.endret
                  FROM sykefravar_statistikk_virksomhet AS statistikk
                  JOIN virksomhet USING (orgnr)
                  LEFT JOIN sykefravar_statistikk_virksomhet_siste_4_kvartal AS statistikk_siste4 USING (orgnr)
                  LEFT JOIN ia_sak USING(orgnr)
                  WHERE (statistikk.orgnr = :orgnr)
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
            sykefraversprosent = if (skalHenteSiste4Kvartal()) row.double("prosent") else row.double("sykefraversprosent"),
            maskert = row.boolean("maskert"),
            opprettet = if (skalHenteSiste4Kvartal()) row.localDateTime("sist_endret") else row.localDateTime("opprettet"),
            status = row.stringOrNull("status")?.let {
                IAProsessStatus.valueOf(it)
            },
            eidAv = row.stringOrNull("eid_av"),
            sistEndret = row.localDateOrNull("endret")?.toKotlinLocalDate()
        )
    }
}

private fun TransactionalSession.insertMetadataForVirksomhet(behandletImportStatistikk: List<BehandletImportStatistikk>) =
    behandletImportStatistikk.forEach { sykefraværsStatistikk ->
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
                    "sektor" to sykefraværsStatistikk.sektorSykefravær.sektor
                )
            ).asUpdate
        )
    }

private fun BehandletKvartalsvisSykefraværsstatistikk.tilStatistikkSpesifikkVerdi() = when (this) {
    is BehandletLandSykefraværsstatistikk -> this.land
    is BehandletNæringSykefraværsstatistikk -> this.næring
    is BehandletNæringsundergruppeSykefraværsstatistikk -> this.næringsundergruppe
    is BehandletSektorSykefraværsstatistikk -> this.sektor
    is BehandletVirksomhetSykefraværsstatistikk -> this.orgnr
}

private fun TransactionalSession.insertBehandletImportStatistikk(behandletImportStatistikkListe: List<BehandletImportStatistikk>) {
    insertVirksomhetsstatistikk(behandletVirksomhetStatistikkListe = behandletImportStatistikkListe.map { it.virksomhetSykefravær })
    insertMetadataForVirksomhet(behandletImportStatistikk = behandletImportStatistikkListe)

    insertBehandletSektorStatistikk(behandletSektorSykefraværsstatistikk = behandletImportStatistikkListe.map { it.sektorSykefravær }
        .toSet())
    insertBehandletNæringsStatistikk(behandletNæringSykefraværsstatistikk = behandletImportStatistikkListe.map { it.næringSykefravær }
        .toSet())
    insertBehandletNæringsundergruppeStatistikk(behandletNæringsundergruppeSykefraværsstatistikk = behandletImportStatistikkListe.flatMap { it.næring5SifferSykefravær }
        .toSet())
    insertBehandletLandStatistikk(behandletLandSykefraværsstatistikk = behandletImportStatistikkListe.map { it.landSykefravær }
        .toSet())
}


private fun TransactionalSession.insertVirksomhetsstatistikk(behandletVirksomhetStatistikkListe: List<BehandletVirksomhetSykefraværsstatistikk>) =
    behandletVirksomhetStatistikkListe.forEach { sykefraværsStatistikk ->
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
                    "orgnr" to sykefraværsStatistikk.orgnr,
                    "arstall" to sykefraværsStatistikk.årstall,
                    "kvartal" to sykefraværsStatistikk.kvartal,
                    "antall_personer" to sykefraværsStatistikk.antallPersoner,
                    "tapte_dagsverk" to sykefraværsStatistikk.tapteDagsverk,
                    "mulige_dagsverk" to sykefraværsStatistikk.muligeDagsverk,
                    "sykefraversprosent" to sykefraværsStatistikk.prosent,
                    "maskert" to sykefraværsStatistikk.maskert
                )
            ).asUpdate
        )
    }

private fun TransactionalSession.insertBehandletSektorStatistikk(behandletSektorSykefraværsstatistikk: Collection<BehandletSektorSykefraværsstatistikk>) =
    insertBehandletSykefraværsstatistikk(
        tabellNavn = "sykefravar_statistikk_sektor",
        kolonneNavn = "sektor_kode",
        behandletStatistikkListe = behandletSektorSykefraværsstatistikk
    )

private fun TransactionalSession.insertBehandletNæringsStatistikk(behandletNæringSykefraværsstatistikk: Collection<BehandletNæringSykefraværsstatistikk>) =
    insertBehandletSykefraværsstatistikk(
        tabellNavn = "sykefravar_statistikk_naring",
        kolonneNavn = "naring",
        behandletStatistikkListe = behandletNæringSykefraværsstatistikk
    )

private fun TransactionalSession.insertBehandletNæringsundergruppeStatistikk(
    behandletNæringsundergruppeSykefraværsstatistikk: Collection<BehandletNæringsundergruppeSykefraværsstatistikk>,
) = insertBehandletSykefraværsstatistikk(
    tabellNavn = "sykefravar_statistikk_naringsundergruppe",
    kolonneNavn = "naringsundergruppe",
    behandletStatistikkListe = behandletNæringsundergruppeSykefraværsstatistikk
)

private fun TransactionalSession.insertBehandletLandStatistikk(behandletLandSykefraværsstatistikk: Collection<BehandletLandSykefraværsstatistikk>) =
    insertBehandletSykefraværsstatistikk(
        tabellNavn = "sykefravar_statistikk_land",
        kolonneNavn = "land",
        behandletStatistikkListe = behandletLandSykefraværsstatistikk
    )


private fun TransactionalSession.insertBehandletSykefraværsstatistikk(
    tabellNavn: String,
    kolonneNavn: String,
    behandletStatistikkListe: Collection<BehandletKvartalsvisSykefraværsstatistikk>,
) =
    behandletStatistikkListe.forEach { sykefraværsstatistikk ->
        run(
            queryOf(
                """
                    INSERT INTO $tabellNavn(
                        arstall,
                        kvartal,
                        $kolonneNavn,
                        antall_personer,
                        tapte_dagsverk,
                        mulige_dagsverk,
                        prosent,
                        maskert
                    )
                    VALUES(
                        :arstall,
                        :kvartal,
                        :statistikkSpesifikkVerdi,
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
                    "statistikkSpesifikkVerdi" to sykefraværsstatistikk.tilStatistikkSpesifikkVerdi(),
                    "antall_personer" to sykefraværsstatistikk.antallPersoner,
                    "tapte_dagsverk" to sykefraværsstatistikk.tapteDagsverk,
                    "mulige_dagsverk" to sykefraværsstatistikk.muligeDagsverk,
                    "prosent" to sykefraværsstatistikk.prosent,
                    "maskert" to sykefraværsstatistikk.maskert,
                )
            ).asUpdate
        )
    }
