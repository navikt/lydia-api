package no.nav.lydia.integrasjoner.kartlegging

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import java.time.LocalDateTime
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
import no.nav.lydia.tilgangskontroll.NavAnsatt
import java.util.UUID
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

    fun hentAntallUnikeDeltakereSomHarMinstEttSvar(kartleggingId: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT COUNT(DISTINCT sesjon_id) AS antall
                        FROM ia_sak_kartlegging_svar
                        WHERE kartlegging_id = :kartleggingId
                    """.trimMargin(),
                    mapOf(
                        "kartleggingId" to kartleggingId,
                    )
                ).map { rad -> rad.int("antall") }.asSingle
            ) ?: 0
        }

    fun hentAntallUnikeDeltakereSomHarSvartPåAlt(kartleggingId: String, antallSpørsmål: Int) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT COUNT(DISTINCT svar_id) AS antall_svar
                        FROM ia_sak_kartlegging_svar
                        WHERE kartlegging_id = :kartleggingId
                        GROUP BY sesjon_id
                        HAVING COUNT(DISTINCT svar_id) = :antallSporsmal
                    """.trimMargin(),
                    mapOf(
                        "kartleggingId" to kartleggingId,
                        "antallSporsmal" to antallSpørsmål,
                    )
                ).map { rad -> rad.int("antall_svar") }.asList
            ).size
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
        kartleggingId: UUID,
        vertId: UUID,
        saksnummer: String,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
        spørsmålIDer: List<UUID>,
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
                            "kartlegging_id" to kartleggingId,
                            "vert_id" to vertId,
                            "orgnr" to orgnummer,
                            "saksnummer" to saksnummer,
                            "status" to "OPPRETTET",
                            "opprettet_av" to saksbehandler.navIdent
                        )
                    ).asUpdate
                )

                spørsmålIDer.forEach { sporsmalId ->
                    tx.run(
                        queryOf(
                            """
                    INSERT INTO ia_sak_kartlegging_sporsmal_til_kartlegging (
                        kartlegging_id,
                        sporsmal_id
                    )
                    VALUES (
                        :kartleggingId,
                        :sporsmalId
                    )
                    """.trimMargin(),
                            mapOf(
                                "kartleggingId" to kartleggingId,
                                "sporsmalId" to sporsmalId,
                            )
                        ).asUpdate,
                    )
                }
            }
        }

        return hentKartleggingEtterId(kartleggingId = kartleggingId.toString())?.right()
            ?: Feil(
                feilmelding = "Kunne ikke opprette kartlegging",
                httpStatusCode = HttpStatusCode.InternalServerError
            ).left()
    }


    data class SpørsmålOgSvar(
        val kartleggingId: UUID,
        val spørsmålId: UUID,
        val spørsmåltekst: String,
        val svarId: UUID,
        val svartekst: String
    )

    fun hentAlleSpørsmålIDer() = using(sessionOf(dataSource)) { session ->
        session.run(
            queryOf(
                """
                    SELECT sporsmal_id
                    FROM ia_sak_kartlegging_sporsmal
                """.trimMargin()
            ).map { UUID.fromString(it.string("sporsmal_id")) }.asList
        )
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
            spørsmålOgSvaralternativer = hentSpørsmålOgSvaralternativer(kartleggingId),
            opprettetAv = this.string("opprettet_av"),
            opprettetTidspunkt = this.localDateTime("opprettet"),
            endretTidspunkt = this.localDateTimeOrNull("endret"),
        )
    }

    private fun hentSpørsmålOgSvaralternativer(kartleggingId: UUID) =
        using(sessionOf(dataSource)) { session ->
            val results = session.run(
                queryOf(
                    """
                        SELECT *
                        FROM ia_sak_kartlegging_sporsmal
                        JOIN ia_sak_kartlegging_svaralternativer USING (sporsmal_id) 
                        JOIN ia_sak_kartlegging_sporsmal_til_kartlegging USING (sporsmal_id) 
                        WHERE kartlegging_id = :kartleggingId
                    """.trimMargin(), mapOf(
                        "kartleggingId" to kartleggingId.toString(),
                    )
                ).map { row ->
                    SpørsmålOgSvar(
                        kartleggingId = kartleggingId,
                        spørsmålId = UUID.fromString(row.string("sporsmal_id")),
                        spørsmåltekst = row.string("sporsmal_tekst"),
                        svarId = UUID.fromString(row.string("svaralternativ_id")),
                        svartekst = row.string("svaralternativ_tekst")
                    )
                }.asList
            )

            results.groupBy { it.spørsmålId }
                .map { spørsmål ->
                    SpørsmålOgSvaralternativer(
                        spørsmålId = spørsmål.key,
                        tema = SpørsmålOgSvaralternativer.Tema.PARTSSAMARBEID,
                        spørsmåltekst = spørsmål.value.first().spørsmåltekst,
                        svaralternativer = spørsmål.value.map {
                            Svaralternativ(
                                svarId = it.svarId,
                                svartekst = it.svartekst
                            )
                        }
                    )
                }
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
                    kartleggingId = kartleggingId,
                    spørsmålId = spørsmålId,
                    antallSvar = rad.int("antallSvar")
                )}.asSingle
            )
        } ?: SpørreundersøkelseAntallSvar(
                kartleggingId = kartleggingId,
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
}
