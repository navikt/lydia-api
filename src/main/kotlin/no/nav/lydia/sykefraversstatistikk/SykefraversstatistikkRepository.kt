package no.nav.lydia.sykefraversstatistikk

import com.google.gson.Gson
import com.google.gson.GsonBuilder
import kotliquery.*
import no.nav.lydia.sykefraversstatistikk.domene.SykefraversstatistikkVirksomhetSisteKvartal
import no.nav.lydia.sykefraversstatistikk.import.*
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

    fun hentSisteSykefraværForVirksomhet(orgnr: String) =
        using(sessionOf(dataSource)) { session ->
            val query = queryOf(
                statement = """
                    SELECT
                        orgnr,
                        arstall,
                        kvartal,
                        antall_personer,
                        tapte_dagsverk,
                        mulige_dagsverk,
                        sykefraversprosent,
                        maskert
                  FROM sykefravar_statistikk_virksomhet
                  WHERE (orgnr = :orgnr)
                  ORDER BY arstall, kvartal DESC
                  LIMIT 1
                """.trimIndent(),
                paramMap = mapOf(
                    "orgnr" to orgnr
                )
            ).map { mapRow(it) }.asSingle
            session.run(query)
        }

    private fun mapRow(row: Row) = SykefraversstatistikkVirksomhetSisteKvartal(
        orgnr = row.string("orgnr"),
        arstall = row.int("arstall"),
        kvartal = row.int("kvartal"),
        antallPersoner = row.double("antall_personer"),
        tapteDagsverk = row.double("tapte_dagsverk"),
        muligeDagsverk = row.double("mulige_dagsverk"),
        sykefraversprosent = row.double("sykefraversprosent"),
        maskert = row.boolean("maskert"),
    )
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
