package no.nav.lydia.sykefraversstatistikk

import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.google.gson.reflect.TypeToken
import kotliquery.*
import no.nav.lydia.sykefraversstatistikk.api.Periode
import no.nav.lydia.sykefraversstatistikk.domene.BransjeSykefraværsstatistikk
import no.nav.lydia.sykefraversstatistikk.domene.NæringSykefraværsstatistikk
import no.nav.lydia.sykefraversstatistikk.import.*
import no.nav.lydia.sykefraversstatistikk.import.SykefraversstatistikkPerKategoriImportDto.Companion.tilBehandletBransjeSykefraværsstatistikk
import no.nav.lydia.sykefraversstatistikk.import.SykefraversstatistikkPerKategoriImportDto.Companion.tilBehandletLandSykefraværsstatistikk
import no.nav.lydia.sykefraversstatistikk.import.SykefraversstatistikkPerKategoriImportDto.Companion.tilBehandletNæringSykefraværsstatistikk
import no.nav.lydia.sykefraversstatistikk.import.SykefraversstatistikkPerKategoriImportDto.Companion.tilBehandletNæringsundergruppeSykefraværsstatistikk
import no.nav.lydia.sykefraversstatistikk.import.SykefraversstatistikkPerKategoriImportDto.Companion.tilBehandletSektorSykefraværsstatistikk
import no.nav.lydia.sykefraversstatistikk.import.SykefraversstatistikkPerKategoriImportDto.Companion.tilBehandletVirksomhetSykefraværsstatistikk
import no.nav.lydia.sykefraversstatistikk.import.SykefraversstatistikkPerKategoriImportDto.Companion.tilBehandletVirksomhetSykefraværsstatistikkSiste4Kvartal
import javax.sql.DataSource

class SykefraversstatistikkRepository(val dataSource: DataSource) {
    private val gson: Gson = GsonBuilder().create()

    private fun felterTilSykefraværsprosent(prefix: String) = """
        ${prefix}.tapte_dagsverk as ${prefix}_tapte_dagsverk,
        ${prefix}.mulige_dagsverk as ${prefix}_mulige_dagsverk,
        ${prefix}.prosent as ${prefix}_prosent,
        ${prefix}.maskert as ${prefix}_maskert,
    """.trimIndent()

    fun hentBransjeSykefraværsstatistikk(
            bransje: String,
            gjeldendePeriode: Periode
    ): BransjeSykefraværsstatistikk? =
            using(sessionOf(dataSource)) { session ->
                val query = queryOf(
                        statement = """
                    SELECT
                        siste_kvartal.bransje as siste_kvartal_bransje,
                        siste_kvartal.arstall as siste_kvartal_arstall,
                        siste_kvartal.kvartal as siste_kvartal_kvartal,
                        siste_kvartal.antall_personer as siste_kvartal_antall_personer,
                        ${felterTilSykefraværsprosent("siste_kvartal")}
                        ${felterTilSykefraværsprosent("siste4")}
                        siste4.kvartaler as siste4_kvartaler
                  FROM sykefravar_statistikk_bransje AS siste_kvartal
                  JOIN sykefravar_statistikk_kategori_siste_4_kvartal AS siste4 
                    ON (
                        siste4.kategori = 'BRANSJE' 
                        AND kode = siste_kvartal.bransje
                        AND siste4.publisert_kvartal = siste_kvartal.kvartal
                        AND siste4.publisert_arstall = siste_kvartal.arstall
                    )
                  WHERE siste_kvartal.bransje = :bransje
                        AND siste_kvartal.kvartal = ${gjeldendePeriode.kvartal}
                        AND siste_kvartal.arstall = ${gjeldendePeriode.årstall}
                """.trimIndent(),
                        paramMap = mapOf(
                                "bransje" to bransje
                        )
                ).map { mapRowToBransjeSykefraværsstatistikk(it) }.asSingle
                session.run(query)
            }

    fun hentNæringSykefraværsstatistikk(
            næringskode: String,
            gjeldendePeriode: Periode
    ): NæringSykefraværsstatistikk? =
            using(sessionOf(dataSource)) { session ->
                val query = queryOf(
                        statement = """
                    SELECT
                        siste_kvartal.naring as siste_kvartal_naring,
                        siste_kvartal.arstall as siste_kvartal_arstall,
                        siste_kvartal.kvartal as siste_kvartal_kvartal,
                        siste_kvartal.antall_personer as siste_kvartal_antall_personer,
                        ${felterTilSykefraværsprosent("siste_kvartal")}
                        ${felterTilSykefraværsprosent("siste4")}
                        ${felterTilSykefraværsprosent("siste_kvartal")}
                        ${felterTilSykefraværsprosent("siste4")}
                        siste4.kvartaler as siste4_kvartaler
                  FROM sykefravar_statistikk_naring AS siste_kvartal
                  JOIN sykefravar_statistikk_kategori_siste_4_kvartal AS siste4 
                      ON (
                            siste4.kategori = 'NÆRING' 
                            AND kode = siste_kvartal.naring
                            AND siste4.publisert_kvartal = siste_kvartal.kvartal
                            AND siste4.publisert_arstall = siste_kvartal.arstall
                      )
                  WHERE siste_kvartal.naring = :naring
                        AND siste_kvartal.kvartal = ${gjeldendePeriode.kvartal}
                        AND siste_kvartal.arstall = ${gjeldendePeriode.årstall}
                """.trimIndent(),
                        paramMap = mapOf(
                                "naring" to næringskode
                        )
                ).map { mapRowToNæringSykefraværsstatistikk(it) }.asSingle
                session.run(query)
            }

    fun insertSykefraværsstatistikkForSisteGjelendeKvartalForLand(
        sykefraværsstatistikk: List<SykefraversstatistikkPerKategoriImportDto>
    ) {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.insertBehandletLandStatistikk(
                    behandletLandSykefraværsstatistikk = sykefraværsstatistikk.tilBehandletLandSykefraværsstatistikk()
                )
            }
        }
    }

    fun insertSykefraværsstatistikkForSisteGjelendeKvartalForSektor(
        sykefraværsstatistikk: List<SykefraversstatistikkPerKategoriImportDto>
    ) {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.insertBehandletSektorStatistikk(
                    behandletSektorSykefraværsstatistikk = sykefraværsstatistikk.tilBehandletSektorSykefraværsstatistikk()
                )
            }
        }
    }

    fun insertSykefraværsstatistikkForSisteGjelendeKvartalForBransje(
        sykefraværsstatistikk: List<SykefraversstatistikkPerKategoriImportDto>
    ) {
        using(sessionOf(dataSource)) {session ->
            session.transaction { tx ->
                tx.insertBehandletBransjeStatistikk(
                    behandletBransjeSykefraværsstatistikk = sykefraværsstatistikk.tilBehandletBransjeSykefraværsstatistikk()
                )
            }
        }
    }

    fun insertSykefraværsstatistikkForSisteGjelendeKvartalForNæring(
        sykefraværsstatistikk: List<SykefraversstatistikkPerKategoriImportDto>
    ) {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.insertBehandletNæringsStatistikk(
                    behandletNæringSykefraværsstatistikk = sykefraværsstatistikk.tilBehandletNæringSykefraværsstatistikk()
                )
            }
        }
    }

    fun insertSykefraværsstatistikkForSisteGjelendeKvartalForNæringskode(
        sykefraværsstatistikk: List<SykefraversstatistikkPerKategoriImportDto>
    ) {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.insertBehandletNæringsundergruppeStatistikk(
                    behandletNæringsundergruppeSykefraværsstatistikk = sykefraværsstatistikk.tilBehandletNæringsundergruppeSykefraværsstatistikk()
                )
            }
        }
    }

    fun insertSykefraværsstatistikkForSisteGjelendeKvartalForVirksomhet(
        sykefraværsstatistikk: List<SykefraversstatistikkPerKategoriImportDto>
    ) {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.insertVirksomhetsstatistikk(
                    behandletVirksomhetStatistikkListe = sykefraværsstatistikk.tilBehandletVirksomhetSykefraværsstatistikk()
                )
            }
        }
    }

    fun insertStatistikkVirksomhetGraderingSiste4Kvartal(
        gradertSykemeldingImportDtoList: List<GradertSykemeldingImportDto>
    ) = using(sessionOf(dataSource)) { session ->
        session.transaction { tx ->
            gradertSykemeldingImportDtoList.forEach {
                tx.run(
                    queryOf(
                        """
                            INSERT INTO sykefravar_statistikk_virksomhet_gradering_siste_4_kvartal (
                                orgnr,
                                publisert_arstall,
                                publisert_kvartal,
                                tapte_dagsverk_gradert,
                                tapte_dagsverk,
                                prosent,
                                maskert, 
                                antall_kvartaler, 
                                kvartaler
                            )
                            VALUES(
                                :orgnr,
                                :publisert_arstall,
                                :publisert_kvartal,
                                :tapte_dagsverk_gradert,
                                :tapte_dagsverk,
                                :prosent,
                                :maskert, 
                                :antall_kvartaler, 
                                :kvartaler::jsonb
                            )
                            ON CONFLICT (orgnr, publisert_arstall, publisert_kvartal) DO UPDATE SET
                                tapte_dagsverk_gradert = :tapte_dagsverk_gradert,
                                tapte_dagsverk = :tapte_dagsverk,
                                prosent = :prosent,
                                maskert = :maskert,
                                antall_kvartaler = :antall_kvartaler,
                                kvartaler = :kvartaler::jsonb,
                                endret = now()
                        """.trimIndent(),
                        mapOf(
                            "orgnr" to it.kode,
                            "publisert_arstall" to it.sistePubliserteKvartal.årstall,
                            "publisert_kvartal" to it.sistePubliserteKvartal.kvartal,
                            "tapte_dagsverk_gradert" to it.siste4Kvartal.tapteDagsverkGradert,
                            "tapte_dagsverk" to it.siste4Kvartal.tapteDagsverk,
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


    fun insertStatistikkVirksomhetGraderingGjeldendeKvartal(
        gradertSykemeldingImportDtoList: List<GradertSykemeldingImportDto>
    ) = using(sessionOf(dataSource)) { session ->
        session.transaction { tx ->
            gradertSykemeldingImportDtoList.tilBehandletImportGradertSykmelding().forEach {
                tx.run(
                        queryOf(
                                """
                            INSERT INTO sykefravar_statistikk_virksomhet_gradering (
                                orgnr,
                                arstall,
                                kvartal,
                                antall_personer,
                                tapte_dagsverk_gradert,
                                tapte_dagsverk,
                                prosent,
                                maskert
                            )
                            VALUES(
                                :orgnr,
                                :arstall,
                                :kvartal,
                                :antall_personer,
                                :tapte_dagsverk_gradert,
                                :tapte_dagsverk,
                                :prosent,
                                :maskert
                            )
                            ON CONFLICT (orgnr, arstall, kvartal) DO UPDATE SET
                                antall_personer = :antall_personer,
                                tapte_dagsverk_gradert = :tapte_dagsverk_gradert,
                                tapte_dagsverk = :tapte_dagsverk,
                                prosent = :prosent,
                                maskert = :maskert,
                                endret = now()
                        """.trimIndent(),
                                mapOf(
                                        "orgnr" to it.kode,
                                        "arstall" to it.årstall,
                                        "kvartal" to it.kvartal,
                                        "antall_personer" to it.antallPersoner,
                                        "tapte_dagsverk_gradert" to it.tapteDagsverkGradert,
                                        "tapte_dagsverk" to it.tapteDagsverk,
                                        "prosent" to it.prosent,
                                        "maskert" to it.erMaskert
                                )
                        ).asUpdate
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
                                kvartaler,
                                publisert_kvartal,
                                publisert_arstall
                            )
                            VALUES(
                                :kategori,
                                :kode,
                                :tapte_dagsverk,
                                :mulige_dagsverk,
                                :prosent,
                                :maskert,
                                :antall_kvartaler,
                                :kvartaler::jsonb,
                                :publisert_kvartal,
                                :publisert_arstall
                            )
                            ON CONFLICT (kategori, kode, publisert_kvartal, publisert_arstall) DO UPDATE SET
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
                            "publisert_kvartal" to it.sistePubliserteKvartal.kvartal,
                            "publisert_arstall" to it.sistePubliserteKvartal.årstall,
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
            tx.insertVirksomhetsstatistikkSiste4Kvartal(
                behandletVirksomhetSykefraværsstatistikkSiste4KvartalListe = sykefraværsstatistikk.tilBehandletVirksomhetSykefraværsstatistikkSiste4Kvartal()
            )
        }
    }

    private fun TransactionalSession.insertVirksomhetsstatistikkSiste4Kvartal(behandletVirksomhetSykefraværsstatistikkSiste4KvartalListe: List<BehandletVirksomhetSykefraværsstatistikkSiste4Kvartal>) =
        behandletVirksomhetSykefraværsstatistikkSiste4KvartalListe.forEach { sykefraværsstatistikk ->
            run(
                queryOf(
                    """
                            INSERT INTO sykefravar_statistikk_virksomhet_siste_4_kvartal(
                                orgnr,
                                tapte_dagsverk,
                                mulige_dagsverk,
                                prosent,
                                maskert,
                                antall_kvartaler,
                                kvartaler,
                                publisert_kvartal,
                                publisert_arstall
                            )
                            VALUES(
                                :orgnr,
                                :tapte_dagsverk,
                                :mulige_dagsverk,
                                :prosent,
                                :maskert,
                                :antall_kvartaler,
                                :kvartaler::jsonb,
                                :publisert_kvartal,
                                :publisert_arstall
                            )
                            ON CONFLICT (orgnr, publisert_kvartal, publisert_arstall) DO UPDATE SET
                                tapte_dagsverk = :tapte_dagsverk,
                                mulige_dagsverk = :mulige_dagsverk,
                                prosent = :prosent,
                                maskert = :maskert,
                                antall_kvartaler = :antall_kvartaler,
                                kvartaler = :kvartaler::jsonb,
                                sist_endret = now()
                        """.trimIndent(),
                    mapOf(
                        "orgnr" to sykefraværsstatistikk.orgnr,
                        "tapte_dagsverk" to sykefraværsstatistikk.tapteDagsverk,
                        "mulige_dagsverk" to sykefraværsstatistikk.muligeDagsverk,
                        "prosent" to sykefraværsstatistikk.prosent,
                        "maskert" to sykefraværsstatistikk.maskert,
                        "antall_kvartaler" to sykefraværsstatistikk.kvartaler.size,
                        "kvartaler" to gson.toJson(sykefraværsstatistikk.kvartaler),
                        "publisert_kvartal" to sykefraværsstatistikk.publisertKvartal,
                        "publisert_arstall" to sykefraværsstatistikk.publisertÅrstall,
                    )
                ).asUpdate
            )
        }

    fun insertMetadataForVirksomhet(
        virksomhetMetadata: List<BehandletImportMetadataVirksomhet>
    ) = using(sessionOf(dataSource)) { session ->
        session.transaction { tx ->
            virksomhetMetadata.forEach {
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
                            "orgnr" to it.orgnr,
                            "kategori" to Kategori.VIRKSOMHET.name,
                            "sektor" to it.sektor.kode
                        )
                    ).asUpdate
                )
            }
        }
    }

    private fun BehandletKvartalsvisSykefraværsstatistikk.tilStatistikkSpesifikkVerdi() = when (this) {
        is BehandletLandSykefraværsstatistikk -> this.land
        is BehandletBransjeSykefraværsstatistikk -> this.bransje
        is BehandletNæringSykefraværsstatistikk -> this.næring
        is BehandletNæringsundergruppeSykefraværsstatistikk -> this.næringsundergruppe
        is BehandletSektorSykefraværsstatistikk -> this.sektor
        is BehandletVirksomhetSykefraværsstatistikk -> this.orgnr
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

    private fun TransactionalSession.insertBehandletBransjeStatistikk(behandletBransjeSykefraværsstatistikk: Collection<BehandletBransjeSykefraværsstatistikk>) =
        insertBehandletSykefraværsstatistikk(
            tabellNavn = "sykefravar_statistikk_bransje",
            kolonneNavn = "bransje",
            behandletStatistikkListe = behandletBransjeSykefraværsstatistikk
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
                    ON CONFLICT ($kolonneNavn, arstall, kvartal) DO UPDATE SET
                        antall_personer = :antall_personer,
                        tapte_dagsverk = :tapte_dagsverk,
                        mulige_dagsverk = :mulige_dagsverk,
                        prosent = :prosent,
                        maskert = :maskert,
                        endret = now()
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

    private val kvartalListeType = object : TypeToken<List<Kvartal>>() {}.type
    private fun mapRowToSiste4Kvartal(row: Row) = Siste4Kvartal(
            prosent = row.double("siste4_prosent"),
            tapteDagsverk = row.double("siste4_tapte_dagsverk"),
            muligeDagsverk = row.double("siste4_mulige_dagsverk"),
            erMaskert = row.boolean("siste4_maskert"),
            kvartaler = gson.fromJson(row.string("siste4_kvartaler"), kvartalListeType)
    )

    private fun mapRowToSistePubliserteKvartal(row: Row) = SistePubliserteKvartal(
            årstall = row.int("siste_kvartal_arstall"),
            kvartal = row.int("siste_kvartal_kvartal"),
            prosent = row.double("siste_kvartal_prosent"),
            tapteDagsverk = row.double("siste_kvartal_tapte_dagsverk"),
            muligeDagsverk = row.double("siste_kvartal_mulige_dagsverk"),
            antallPersoner = row.int("siste_kvartal_antall_personer"),
            erMaskert = row.boolean("siste_kvartal_maskert")
    )

    private fun mapRowToNæringSykefraværsstatistikk(row: Row) = NæringSykefraværsstatistikk(
            næring = row.string("siste_kvartal_naring"),
            sisteGjeldendeKvartal = mapRowToSistePubliserteKvartal(row),
            siste4Kvartal = mapRowToSiste4Kvartal(row)
    )

    private fun mapRowToBransjeSykefraværsstatistikk(row: Row) = BransjeSykefraværsstatistikk(
            bransje = row.string("siste_kvartal_bransje"),
            sisteGjeldendeKvartal = mapRowToSistePubliserteKvartal(row),
            siste4Kvartal = mapRowToSiste4Kvartal(row)
    )
}
