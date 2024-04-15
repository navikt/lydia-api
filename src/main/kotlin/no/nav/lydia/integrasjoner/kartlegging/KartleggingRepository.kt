package no.nav.lydia.integrasjoner.kartlegging

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.google.gson.reflect.TypeToken
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.toKotlinLocalDateTime
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.IASakKartlegging
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.IASakKartleggingOversikt
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.KartleggingStatus
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseAntallSvar
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørsmålOgSvaralternativer
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Svaralternativ
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Tema
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.TemaMedSpørsmålOgSvaralternativer
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.TemaStatus
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Temanavn
import no.nav.lydia.tilgangskontroll.NavAnsatt
import java.time.LocalDateTime
import java.util.*
import javax.sql.DataSource

class KartleggingRepository(val dataSource: DataSource) {
    private val gson: Gson = GsonBuilder().create()

    fun hentSvarForTema(kartleggingId: UUID, temaId: Int) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT ia_sak_kartlegging_svar.*
                        FROM ia_sak_kartlegging_svar
                        JOIN ia_sak_kartlegging_tema_til_spørsmål USING (sporsmal_id)
                        JOIN ia_sak_kartlegging_kartlegging_til_tema USING (kartlegging_id, tema_id)
                        WHERE ia_sak_kartlegging_svar.kartlegging_id = :kartleggingId
                        AND ia_sak_kartlegging_kartlegging_til_tema.tema_id = :temaId
                        AND ia_sak_kartlegging_kartlegging_til_tema.stengt = true
                    """.trimIndent(),
                    mapOf(
                        "kartleggingId" to kartleggingId.toString(),
                        "temaId" to temaId
                    )
                ).map(this::mapRowToSpørreundersøkelseSvarDto).asList
            )
        }

    fun hentAlleSvar(kartleggingId: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT *
                        FROM ia_sak_kartlegging_svar
                        WHERE kartlegging_id = :kartleggingId
                    """.trimMargin(),
                    mapOf(
                        "kartleggingId" to kartleggingId,
                    )
                ).map(this::mapRowToSpørreundersøkelseSvarDto).asList
            )
        }

    fun hentKartlegginger(saksnummer: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT *
                    FROM ia_sak_kartlegging
                    WHERE saksnummer = :saksnummer
                    AND status != '${KartleggingStatus.SLETTET}'
                """.trimMargin(),
                    mapOf(
                        "saksnummer" to saksnummer,
                    )
                ).map(this::mapRowToIASakKartleggingOversikt).asList
            )
        }

    fun hentKartleggingEtterId(kartleggingId: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT *
                        FROM ia_sak_kartlegging
                        WHERE kartlegging_id = :kartleggingId
                    """.trimMargin(),
                    mapOf(
                        "kartleggingId" to kartleggingId,
                    )
                ).map(this::mapRowToIASakKartleggingMedSpørsmålOgSvaralternativer).asSingle
            )
        }

    fun opprettKartlegging(
        orgnummer: String,
        kartlegging: UUID,
        vertId: UUID,
        saksnummer: String,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
        temaer: List<Tema>,
    ): Either<Feil, IASakKartlegging> {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.run(
                    queryOf(
                        """
                            INSERT INTO ia_sak_kartlegging (
                                kartlegging_id,
                                vert_id,
                                orgnr,
                                saksnummer,
                                status,
                                opprettet_av
                            )
                            VALUES (
                                :kartlegging_id,
                                :vert_id,
                                :orgnr,
                                :saksnummer,
                                :status,
                                :opprettet_av
                            )
                        """.trimMargin(),
                        mapOf(
                            "kartlegging_id" to kartlegging,
                            "vert_id" to vertId,
                            "orgnr" to orgnummer,
                            "saksnummer" to saksnummer,
                            "status" to "OPPRETTET",
                            "opprettet_av" to saksbehandler.navIdent
                        )
                    ).asUpdate
                )

                temaer.sortedBy{ it.rekkefølge }.forEach { tema ->
                    tx.run(
                        queryOf(
                            """
                    INSERT INTO ia_sak_kartlegging_kartlegging_til_tema (
                        kartlegging_id,
                        tema_id
                    )
                    VALUES (
                        :kartlegging_id,
                        :tema_id
                    )
                    """.trimMargin(),
                            mapOf(
                                "kartlegging_id" to kartlegging,
                                "tema_id" to tema.id,
                            )
                        ).asUpdate,
                    )
                }
            }
        }

        return hentKartleggingEtterId(kartleggingId = kartlegging.toString())?.right()
            ?: Feil(
                feilmelding = "Kunne ikke opprette kartlegging",
                httpStatusCode = HttpStatusCode.InternalServerError
            ).left()
    }


    private fun mapRowToIASakKartleggingOversikt(row: Row): IASakKartleggingOversikt {
        return row.tilIASakKartleggingOversikt()
    }

    private fun Row.tilIASakKartleggingOversikt(): IASakKartleggingOversikt {
        val kartleggingId = UUID.fromString(this.string("kartlegging_id"))
        val vertId = this.stringOrNull("vert_id")?.let { UUID.fromString(it) }
        return IASakKartleggingOversikt(
            kartleggingId = kartleggingId,
            vertId = vertId,
            saksnummer = this.string("saksnummer"),
            status = KartleggingStatus.valueOf(this.string("status")),
            opprettetAv = this.string("opprettet_av"),
            opprettetTidspunkt = this.localDateTime("opprettet"),
            endretTidspunkt = this.localDateTimeOrNull("endret"),
        )
    }

    private fun mapRowToIASakKartleggingMedSpørsmålOgSvaralternativer(row: Row): IASakKartlegging {
        return row.tilIASakKartleggingMedSpørsmålOgSvaralternativer()
    }

    private fun Row.tilIASakKartleggingMedSpørsmålOgSvaralternativer(): IASakKartlegging {
        val kartleggingId = UUID.fromString(this.string("kartlegging_id"))
        val vertId = this.stringOrNull("vert_id")?.let { UUID.fromString(it) }
        return IASakKartlegging(
            kartleggingId = kartleggingId,
            vertId = vertId,
            saksnummer = this.string("saksnummer"),
            status = KartleggingStatus.valueOf(this.string("status")),
            temaMedSpørsmålOgSvaralternativer = hentTemaMedSpørsmålOgSvaralternativer(kartleggingId),
            opprettetAv = this.string("opprettet_av"),
            opprettetTidspunkt = this.localDateTime("opprettet"),
            endretTidspunkt = this.localDateTimeOrNull("endret"),
        )
    }

    fun hentTemaMedSpørsmålOgSvaralternativer(kartleggingId: UUID) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT *
                        FROM ia_sak_kartlegging_sporsmal
                        JOIN ia_sak_kartlegging_tema_til_spørsmål USING (sporsmal_id)
                        JOIN ia_sak_kartlegging_svaralternativer USING (sporsmal_id)
                        JOIN ia_sak_kartlegging_tema USING (tema_id)
                        JOIN ia_sak_kartlegging_kartlegging_til_tema USING (tema_id)
                        WHERE kartlegging_id = :kartlegging_id
                        ORDER BY ia_sak_kartlegging_tema.rekkefolge
                    """.trimIndent(),
                    mapOf(
                        "kartlegging_id" to kartleggingId.toString()
                    )
                ).map {
                    SpørsmålsRad(
                        kartleggingId = UUID.fromString(it.string("kartlegging_id")),
                        tema = mapTilTema(it),
                        erTemaStengt = it.boolean("stengt"),
                        spørsmålId = UUID.fromString(it.string("sporsmal_id")),
                        spørsmåltekst = it.string("sporsmal_tekst"),
                        flervalg = it.boolean("flervalg"),
                        svaralternativ = mapTilSvaralternativ(it)
                    )
                }.asList
            ).tilTemaMedSpørsmålOgSvaralternativer()
        }

    private data class SpørsmålsRad(
        val kartleggingId: UUID,
        val tema: Tema,
        val erTemaStengt: Boolean,
        val spørsmålId: UUID,
        val spørsmåltekst: String,
        val flervalg: Boolean,
        val svaralternativ: Svaralternativ
    )

    private fun List<SpørsmålsRad>.tilTemaMedSpørsmålOgSvaralternativer() = this.groupBy {
        it.tema
    }.map {
        val tema = it.key
        val erTemaStengt = it.value.any { it.erTemaStengt }
        val spørsmålOgSvaralternativer = it.value.groupBy {
            it.spørsmålId
        }.map {
            val spørsmålId = it.key
            val spørsmåltekst = it.value.first().spørsmåltekst
            val flervalg = it.value.first().flervalg
            val svaralternativer = it.value.map {
                it.svaralternativ
            }
            SpørsmålOgSvaralternativer(
                spørsmålId = spørsmålId,
                spørsmåltekst = spørsmåltekst,
                flervalg = flervalg,
                svaralternativer = svaralternativer
            )
        }
        TemaMedSpørsmålOgSvaralternativer(
            tema = tema,
            stengtForSvar = erTemaStengt,
            spørsmålOgSvaralternativer = spørsmålOgSvaralternativer
        )
    }

    private fun mapTilSvaralternativ(row: Row) =
        Svaralternativ(
            svarId = UUID.fromString(row.string("svaralternativ_id")),
            svartekst = row.string("svaralternativ_tekst")
        )

    fun hentAntallSvar(kartleggingId: UUID, spørsmålId: UUID) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT COUNT(*) AS antallSvar
                        FROM ia_sak_kartlegging_svar
                        WHERE kartlegging_id = :kartleggingId
                        AND sporsmal_id = :sporsmalId
                    """.trimMargin(),
                    mapOf(
                        "kartleggingId" to kartleggingId.toString(),
                        "sporsmalId" to spørsmålId.toString()
                    )
                ).map { rad -> SpørreundersøkelseAntallSvar(
                    spørreundersøkelseId = kartleggingId,
                    spørsmålId = spørsmålId,
                    antallSvar = rad.int("antallSvar")
                )}.asSingle
            )
        } ?: SpørreundersøkelseAntallSvar(
                spørreundersøkelseId = kartleggingId,
                spørsmålId = spørsmålId,
                antallSvar = 0
            )

    private fun mapRowToSpørreundersøkelseSvarDto(row: Row): SpørreundersøkelseSvarDto {
        return row.tilSpørreundersøkelseSvarDto()
    }

    private val svarIderType = object : TypeToken<List<String>>() {}.type

    fun Row.tilSpørreundersøkelseSvarDto(): SpørreundersøkelseSvarDto =
        SpørreundersøkelseSvarDto(
            spørreundersøkelseId = this.string("kartlegging_id"),
            sesjonId = this.string("sesjon_id"),
            spørsmålId = this.string("sporsmal_id"),
            svarIder = gson.fromJson(this.string("svar_ider"), svarIderType)
        )

    fun lagreSvar(karleggingSvarDto: SpørreundersøkelseSvarDto) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        INSERT INTO ia_sak_kartlegging_svar (
                            kartlegging_id,
                            sesjon_id,
                            sporsmal_id,
                            svar_ider
                        )
                        VALUES (
                            :kartleggingId,
                            :sesjonId,
                            :sporsmalId,
                            :svar_ider::jsonb
                        )
                        ON CONFLICT ON CONSTRAINT ia_sak_kartlegging_svar_kartlegging_sesjon_spm DO UPDATE SET
                            svar_ider = :svar_ider::jsonb,
                            endret = now()
                        """.trimMargin(),
                    mapOf(
                        "kartleggingId" to karleggingSvarDto.spørreundersøkelseId,
                        "sesjonId" to karleggingSvarDto.sesjonId,
                        "sporsmalId" to karleggingSvarDto.spørsmålId,
                        "svar_ider" to gson.toJson(karleggingSvarDto.svarIder)
                    )
                ).asUpdate
            )
        }

    fun slettKartlegging(
        kartleggingId: String,
        sistEndret: LocalDateTime = LocalDateTime.now()
    ) =
        using(sessionOf(dataSource)) { session ->
            session.transaction {tx->
                tx.run (
                    queryOf(
                        """
                        DELETE FROM ia_sak_kartlegging_svar
                        WHERE kartlegging_id = :kartleggingId
                    """.trimMargin(),
                        mapOf(
                            "kartleggingId" to kartleggingId
                        )
                    ).asUpdate
                )
                tx.run (
                    queryOf(
                        """
                        UPDATE ia_sak_kartlegging SET
                            status = '${KartleggingStatus.SLETTET}',
                            endret = :sistEndret
                        WHERE kartlegging_id = :kartleggingId
                        RETURNING *
                    """.trimIndent(),
                        mapOf(
                            "kartleggingId" to kartleggingId,
                            "sistEndret" to sistEndret
                        )
                    ).map(this::mapRowToIASakKartleggingMedSpørsmålOgSvaralternativer).asSingle
                )
            }
        }

    fun endreKartleggingStatus(
        kartleggingId: String,
        status: KartleggingStatus,
        sistEndret: LocalDateTime = LocalDateTime.now()
    ) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        UPDATE ia_sak_kartlegging SET
                            status = '${status.name}',
                            endret = :sistEndret
                        WHERE kartlegging_id = :kartleggingId
                        RETURNING *
                    """.trimIndent(),
                    mapOf(
                        "kartleggingId" to kartleggingId,
                        "sistEndret" to sistEndret
                    )
                ).map(this::mapRowToIASakKartleggingMedSpørsmålOgSvaralternativer).asSingle
            )
        }

    fun hentTema(temanavn: Temanavn) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT * FROM ia_sak_kartlegging_tema 
                          WHERE navn = :temanavn
                          AND status = '${TemaStatus.AKTIV}'
                    """.trimIndent(),
                    mapOf(
                        "temanavn" to temanavn.name
                    )
                ).map(this::mapTilTema).asSingle
            )
        } ?: throw IllegalStateException("Fant ingen aktive kartleggingstemaer for $temanavn")

    private fun mapTilTema(row: Row) =
        Tema(
            id = row.int("tema_id"),
            rekkefølge = row.int("rekkefolge"),
            navn = Temanavn.valueOf(row.string("navn")),
            beskrivelse = row.string("beskrivelse"),
            introtekst = row.string("introtekst"),
            status = TemaStatus.valueOf(row.string("status")),
            sistEndret = row.localDateTime("sist_endret").toKotlinLocalDateTime(),
        )

    fun stengTema(spørreundersøkelseId: String, temaId: Int) {
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        UPDATE ia_sak_kartlegging_kartlegging_til_tema
                          SET stengt = true 
                          WHERE kartlegging_id = :kartleggingId
                          AND tema_id = :temaId 
                    """.trimIndent(),
                    mapOf(
                        "kartleggingId" to spørreundersøkelseId,
                        "temaId" to temaId
                    )
                ).asUpdate
            )
        }
    }
}
