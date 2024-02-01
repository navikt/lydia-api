package no.nav.lydia.integrasjoner.kartlegging

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.domene.IASakKartlegging
import no.nav.lydia.ia.sak.domene.KartleggingStatus
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

    fun hentKartlegginger(saksnummer: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT *
                    FROM ia_sak_kartlegging
                    WHERE saksnummer = :saksnummer
                """.trimMargin(),
                    mapOf(
                        "saksnummer" to saksnummer,
                    )
                ).map(this::mapRowToIASakKartlegging).asList
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
                ).map(this::mapRowToIASakKartlegging).asSingle
            )
        }

    fun opprettKartlegging(
        orgnummer: String,
        kartleggingId: UUID,
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
                                orgnr,
                                saksnummer,
                                status,
                                opprettet_av
                            )
                            VALUES (
                                :kartlegging_id,
                                :orgnr,
                                :saksnummer,
                                :status,
                                :opprettet_av
                            )
                        """.trimMargin(),
                        mapOf(
                            "kartlegging_id" to kartleggingId,
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

    private fun mapRowToIASakKartlegging(row: Row): IASakKartlegging {
        return row.tilIASakKartlegging()
    }

    private fun Row.tilIASakKartlegging(): IASakKartlegging {
        val kartleggingId = UUID.fromString(this.string("kartlegging_id"))
        return IASakKartlegging(
            kartleggingId = kartleggingId,
            saksnummer = this.string("saksnummer"),
            status = KartleggingStatus.valueOf(this.string("status")),
            spørsmålOgSvaralternativer = hentSpørsmålOgSvaralternativer(kartleggingId),
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
                        kategori = "Partssamarbeid",
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

    fun avsluttKartlegging(kartleggingId: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        UPDATE ia_sak_kartlegging SET
                            status = 'AVSLUTTET'
                        WHERE kartlegging_id = :kartleggingId
                        RETURNING *
                    """.trimIndent(),
                    mapOf(
                        "kartleggingId" to kartleggingId
                    )
                ).map(this::mapRowToIASakKartlegging).asSingle
            )
        }
}
