package no.nav.lydia.integrasjoner.kartlegging

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.toKotlinLocalDateTime
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.domene.IASakKartlegging
import no.nav.lydia.ia.sak.domene.IASakKartleggingOversikt
import no.nav.lydia.ia.sak.domene.KartleggingStatus
import no.nav.lydia.ia.sak.domene.SpørreundersøkelseAntallSvar
import no.nav.lydia.ia.sak.domene.SpørsmålOgSvaralternativer
import no.nav.lydia.ia.sak.domene.Svaralternativ
import no.nav.lydia.ia.sak.domene.Tema
import no.nav.lydia.ia.sak.domene.TemaMedSpørsmålOgSvaralternativer
import no.nav.lydia.ia.sak.domene.TemaStatus
import no.nav.lydia.ia.sak.domene.Temanavn
import no.nav.lydia.tilgangskontroll.NavAnsatt
import java.time.LocalDateTime
import java.util.*
import javax.sql.DataSource

class KartleggingRepository(val dataSource: DataSource) {
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

    private fun hentTemaerForKartlegging(kartleggingId: UUID) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT ia_sak_kartlegging_tema.* FROM ia_sak_kartlegging_tema
                          JOIN ia_sak_kartlegging_kartlegging_til_tema USING (tema_id)
                          WHERE kartlegging_id = :kartlegging_id
                          ORDER BY rekkefolge
                    """.trimIndent(),
                    mapOf(
                        "kartlegging_id" to kartleggingId.toString()
                    )
                ).map(this::mapTilTema).asList
            )
        }

    fun hentTemaMedSpørsmålOgSvaralternativer(kartleggingId: UUID): List<TemaMedSpørsmålOgSvaralternativer> =
        using(sessionOf(dataSource)) { session ->
            hentTemaerForKartlegging(kartleggingId).map { tema ->
                TemaMedSpørsmålOgSvaralternativer(
                    tema,
                    session.run(
                        queryOf(
                            """
                                SELECT *
                                FROM ia_sak_kartlegging_sporsmal
                                JOIN ia_sak_kartlegging_tema_til_spørsmål USING (sporsmal_id)
                                WHERE tema_id = :temaId
                            """.trimMargin(),
                            mapOf(
                                "temaId" to tema.id,
                            )
                        ).map { row ->
                            val spørsmålId = UUID.fromString(row.string("sporsmal_id"))
                            SpørsmålOgSvaralternativer(
                                spørsmålId = spørsmålId,
                                spørsmåltekst = row.string("sporsmal_tekst"),
                                svaralternativer = hentSvaralternativer(spørsmålId)
                            )
                        }.asList
                    )
                )
            }
        }

    private fun hentSvaralternativer(spørsmålsId: UUID) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT * from ia_sak_kartlegging_svaralternativer
                            WHERE sporsmal_id = :sporsmalId
                    """.trimIndent(),
                    mapOf(
                        "sporsmalId" to spørsmålsId.toString()
                    )
                ).map { Svaralternativ(
                    svarId = UUID.fromString(it.string("svaralternativ_id")),
                    svartekst = it.string("svaralternativ_tekst")
                ) }.asList
            )
        }

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

    fun Row.tilSpørreundersøkelseSvarDto(): SpørreundersøkelseSvarDto =
        SpørreundersøkelseSvarDto(
            spørreundersøkelseId = this.string("kartlegging_id"),
            sesjonId = this.string("sesjon_id"),
            spørsmålId = this.string("sporsmal_id"),
            svarId = this.string("svar_id")
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
                            svar_id
                        )
                        VALUES (
                            :kartleggingId,
                            :sesjonId,
                            :sporsmalId,
                            :svarId
                        )
                        ON CONFLICT ON CONSTRAINT ia_sak_kartlegging_svar_kartlegging_sesjon_spm DO UPDATE SET
                            svar_id = :svarId,
                            endret = now()
                        """.trimMargin(),
                    mapOf(
                        "kartleggingId" to karleggingSvarDto.spørreundersøkelseId,
                        "sesjonId" to karleggingSvarDto.sesjonId,
                        "sporsmalId" to karleggingSvarDto.spørsmålId,
                        "svarId" to karleggingSvarDto.svarId
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
}
