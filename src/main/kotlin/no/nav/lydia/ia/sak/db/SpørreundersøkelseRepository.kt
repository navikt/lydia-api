package no.nav.lydia.ia.sak.db

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import kotlinx.serialization.json.Json
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering.Companion.tilDokumentTilPubliseringStatus
import no.nav.lydia.ia.sak.api.extensions.tilUUID
import no.nav.lydia.ia.sak.api.spørreundersøkelse.EndreSamarbeidTilSpørreundersøkelseDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.IASakSpørreundersøkelseError
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseSvarDto
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse.Companion.ANTALL_TIMER_EN_SPØRREUNDERSØKELSE_ER_TILGJENGELIG
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse.Companion.tilSpørreundersøkelse
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse.Companion.tilSpørreundersøkelser
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Tema
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Undertema
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import java.time.LocalDateTime
import java.util.UUID
import javax.sql.DataSource

class SpørreundersøkelseRepository(
    private val dataSource: DataSource,
) {
    fun hentSpørreundersøkelse(spørreundersøkelseId: UUID): Spørreundersøkelse? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                SELECT virksomhet.navn,
                       virksomhet.orgnr,
                       sak.saksnummer,
                       samarbeid.id                                          AS samarbeid_id,
                       sporreundersokelse.kartlegging_id                     AS sporreundersokelse_id,
                       sporreundersokelse.type                               AS type,
                       sporreundersokelse.status                             AS status,
                       sporreundersokelse.opprettet_av,
                       sporreundersokelse.opprettet,
                       sporreundersokelse.gyldig_til,
                       sporreundersokelse.endret,
                       sporreundersokelse.pabegynt,
                       sporreundersokelse.fullfort,
                       sporreundersokelse_tema.tema_id,
                       sporreundersokelse_tema.stengt                        AS tema_stengt,
                       tema.navn                                             AS tema_navn,
                       tema.status                                           AS tema_status,
                       tema.rekkefolge                                       AS tema_rekkefolge,
                       tema.sist_endret                                      AS tema_endret,
                       undertema.undertema_id,
                       undertema.navn                                        AS undertema_navn,
                       undertema.status                                      AS undertema_status,
                       undertema.rekkefolge                                  AS undertema_rekkefolge,
                       undertema.sist_endret                                 AS undertema_endret,
                       sporsmal.sporsmal_id,
                       sporsmal.sporsmal_tekst,
                       sporsmal_undertema.rekkefolge                         AS sporsmal_rekkefolge,
                       sporsmal.flervalg,
                       svaralternativ.svaralternativ_id,
                       svaralternativ.svaralternativ_tekst,
                       dokument_til_publisering.status                       AS publisering_status,
                       COALESCE(
                               (SELECT CASE
                                           WHEN (SELECT COUNT(DISTINCT us.sesjon_id)
                                                 FROM ia_sak_kartlegging_svar us
                                                 WHERE us.kartlegging_id = sporreundersokelse.kartlegging_id
                                                   AND us.sporsmal_id = sporsmal.sporsmal_id) < 3
                                               THEN 0
                                           ELSE COUNT(DISTINCT svar.sesjon_id)
                                           END
                                FROM ia_sak_kartlegging_svar svar
                                WHERE svar.kartlegging_id = sporreundersokelse.kartlegging_id
                                  AND svar.sporsmal_id = sporsmal.sporsmal_id
                                  AND svar.svar_ider @> ('["' || svaralternativ.svaralternativ_id || '"]')::jsonb), 0
                       )                                                     AS antall_svar,
                       (SELECT COUNT(DISTINCT unike_svar.sesjon_id)
                        FROM ia_sak_kartlegging_svar unike_svar
                        WHERE unike_svar.kartlegging_id = sporreundersokelse.kartlegging_id
                          AND unike_svar.sporsmal_id = sporsmal.sporsmal_id) AS antall_svar_per_sporsmal
                FROM ia_sak_kartlegging sporreundersokelse
                         JOIN ia_prosess samarbeid
                              ON sporreundersokelse.ia_prosess = samarbeid.id
                         JOIN ia_sak sak USING (saksnummer, orgnr)
                         JOIN virksomhet USING (orgnr)
                         JOIN ia_sak_kartlegging_kartlegging_til_undertema sporreundersokelse_undertema
                              ON sporreundersokelse.kartlegging_id = sporreundersokelse_undertema.kartlegging_id
                         JOIN ia_sak_kartlegging_undertema undertema
                              ON sporreundersokelse_undertema.undertema_id = undertema.undertema_id
                         JOIN ia_sak_kartlegging_sporsmal_til_undertema sporsmal_undertema
                              ON undertema.undertema_id = sporsmal_undertema.undertema_id
                         JOIN ia_sak_kartlegging_sporsmal sporsmal
                              ON sporsmal_undertema.sporsmal_id = sporsmal.sporsmal_id
                         LEFT JOIN ia_sak_kartlegging_svaralternativer svaralternativ
                                   ON sporsmal.sporsmal_id = svaralternativ.sporsmal_id
                         LEFT JOIN ia_sak_kartlegging_kartlegging_til_tema sporreundersokelse_tema
                                   ON sporreundersokelse_tema.kartlegging_id = sporreundersokelse.kartlegging_id
                                       AND sporreundersokelse_tema.tema_id = undertema.tema_id
                         LEFT JOIN ia_sak_kartlegging_tema tema
                                   ON tema.tema_id = sporreundersokelse_tema.tema_id
                         LEFT JOIN dokument_til_publisering
                                   ON dokument_til_publisering.referanse_id = sporreundersokelse.kartlegging_id
                WHERE sporreundersokelse.kartlegging_id = :kartleggingId
                    """.trimMargin(),
                    mapOf(
                        "kartleggingId" to spørreundersøkelseId.toString(),
                    ),
                ).map(this::mapRowToSpørreundersøkelseDbRad).asList,
            ).tilSpørreundersøkelse()
        }

    fun hentSpørreundersøkelser(
        samarbeid: IASamarbeid,
        type: Spørreundersøkelse.Type,
    ): List<Spørreundersøkelse> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                SELECT virksomhet.navn,
                       virksomhet.orgnr,
                       sak.saksnummer,
                       samarbeid.id                                          AS samarbeid_id,
                       sporreundersokelse.kartlegging_id                     AS sporreundersokelse_id,
                       sporreundersokelse.type                               AS type,
                       sporreundersokelse.status                             AS status,
                       sporreundersokelse.opprettet_av,
                       sporreundersokelse.opprettet,
                       sporreundersokelse.gyldig_til,
                       sporreundersokelse.endret,
                       sporreundersokelse.pabegynt,
                       sporreundersokelse.fullfort,
                       sporreundersokelse_tema.tema_id,
                       sporreundersokelse_tema.stengt                        AS tema_stengt,
                       tema.navn                                             AS tema_navn,
                       tema.status                                           AS tema_status,
                       tema.rekkefolge                                       AS tema_rekkefolge,
                       tema.sist_endret                                      AS tema_endret,
                       undertema.undertema_id,
                       undertema.navn                                        AS undertema_navn,
                       undertema.status                                      AS undertema_status,
                       undertema.rekkefolge                                  AS undertema_rekkefolge,
                       undertema.sist_endret                                 AS undertema_endret,
                       sporsmal.sporsmal_id,
                       sporsmal.sporsmal_tekst,
                       sporsmal_undertema.rekkefolge                         AS sporsmal_rekkefolge,
                       sporsmal.flervalg,
                       svaralternativ.svaralternativ_id,
                       svaralternativ.svaralternativ_tekst,
                       dokument_til_publisering.status                       AS publisering_status,
                       COALESCE(
                               (SELECT CASE
                                           WHEN (SELECT COUNT(DISTINCT us.sesjon_id)
                                                 FROM ia_sak_kartlegging_svar us
                                                 WHERE us.kartlegging_id = sporreundersokelse.kartlegging_id
                                                   AND us.sporsmal_id = sporsmal.sporsmal_id) < 3
                                               THEN 0
                                           ELSE COUNT(DISTINCT svar.sesjon_id)
                                           END
                                FROM ia_sak_kartlegging_svar svar
                                WHERE svar.kartlegging_id = sporreundersokelse.kartlegging_id
                                  AND svar.sporsmal_id = sporsmal.sporsmal_id
                                  AND svar.svar_ider @> ('["' || svaralternativ.svaralternativ_id || '"]')::jsonb), 0
                       )                                                     AS antall_svar,
                       (SELECT COUNT(DISTINCT unike_svar.sesjon_id)
                        FROM ia_sak_kartlegging_svar unike_svar
                        WHERE unike_svar.kartlegging_id = sporreundersokelse.kartlegging_id
                          AND unike_svar.sporsmal_id = sporsmal.sporsmal_id) AS antall_svar_per_sporsmal
                FROM ia_sak_kartlegging sporreundersokelse
                         JOIN ia_prosess samarbeid
                              ON sporreundersokelse.ia_prosess = samarbeid.id
                         JOIN ia_sak sak USING (saksnummer, orgnr)
                         JOIN virksomhet USING (orgnr)
                         JOIN ia_sak_kartlegging_kartlegging_til_undertema sporreundersokelse_undertema
                              ON sporreundersokelse.kartlegging_id = sporreundersokelse_undertema.kartlegging_id
                         JOIN ia_sak_kartlegging_undertema undertema
                              ON sporreundersokelse_undertema.undertema_id = undertema.undertema_id
                         JOIN ia_sak_kartlegging_sporsmal_til_undertema sporsmal_undertema
                              ON undertema.undertema_id = sporsmal_undertema.undertema_id
                         JOIN ia_sak_kartlegging_sporsmal sporsmal
                              ON sporsmal_undertema.sporsmal_id = sporsmal.sporsmal_id
                         LEFT JOIN ia_sak_kartlegging_svaralternativer svaralternativ
                                   ON sporsmal.sporsmal_id = svaralternativ.sporsmal_id
                         LEFT JOIN ia_sak_kartlegging_kartlegging_til_tema sporreundersokelse_tema
                                   ON sporreundersokelse_tema.kartlegging_id = sporreundersokelse.kartlegging_id
                                       AND sporreundersokelse_tema.tema_id = undertema.tema_id
                         LEFT JOIN ia_sak_kartlegging_tema tema
                                   ON tema.tema_id = sporreundersokelse_tema.tema_id
                         LEFT JOIN dokument_til_publisering
                                   ON dokument_til_publisering.referanse_id = sporreundersokelse.kartlegging_id
                    WHERE samarbeid.id = :samarbeidId
                        AND sporreundersokelse.status != '${Spørreundersøkelse.Status.SLETTET}'
                        AND sporreundersokelse.type = :type
                    """.trimMargin(),
                    mapOf(
                        "samarbeidId" to samarbeid.id,
                        "type" to type.name,
                    ),
                ).map(this::mapRowToSpørreundersøkelseDbRad).asList,
            ).tilSpørreundersøkelser()
        }

    fun hentAlleSpørreundersøkelser(): List<Spørreundersøkelse> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                SELECT virksomhet.navn,
                       virksomhet.orgnr,
                       sak.saksnummer,
                       samarbeid.id                                          AS samarbeid_id,
                       sporreundersokelse.kartlegging_id                     AS sporreundersokelse_id,
                       sporreundersokelse.type                               AS type,
                       sporreundersokelse.status                             AS status,
                       sporreundersokelse.opprettet_av,
                       sporreundersokelse.opprettet,
                       sporreundersokelse.gyldig_til,
                       sporreundersokelse.endret,
                       sporreundersokelse.pabegynt,
                       sporreundersokelse.fullfort,
                       sporreundersokelse_tema.tema_id,
                       sporreundersokelse_tema.stengt                        AS tema_stengt,
                       tema.navn                                             AS tema_navn,
                       tema.status                                           AS tema_status,
                       tema.rekkefolge                                       AS tema_rekkefolge,
                       tema.sist_endret                                      AS tema_endret,
                       undertema.undertema_id,
                       undertema.navn                                        AS undertema_navn,
                       undertema.status                                      AS undertema_status,
                       undertema.rekkefolge                                  AS undertema_rekkefolge,
                       undertema.sist_endret                                 AS undertema_endret,
                       sporsmal.sporsmal_id,
                       sporsmal.sporsmal_tekst,
                       sporsmal_undertema.rekkefolge                         AS sporsmal_rekkefolge,
                       sporsmal.flervalg,
                       svaralternativ.svaralternativ_id,
                       svaralternativ.svaralternativ_tekst,
                       dokument_til_publisering.status                       AS publisering_status,
                       COALESCE(
                               (SELECT CASE
                                           WHEN (SELECT COUNT(DISTINCT us.sesjon_id)
                                                 FROM ia_sak_kartlegging_svar us
                                                 WHERE us.kartlegging_id = sporreundersokelse.kartlegging_id
                                                   AND us.sporsmal_id = sporsmal.sporsmal_id) < 3
                                               THEN 0
                                           ELSE COUNT(DISTINCT svar.sesjon_id)
                                           END
                                FROM ia_sak_kartlegging_svar svar
                                WHERE svar.kartlegging_id = sporreundersokelse.kartlegging_id
                                  AND svar.sporsmal_id = sporsmal.sporsmal_id
                                  AND svar.svar_ider @> ('["' || svaralternativ.svaralternativ_id || '"]')::jsonb), 0
                       ) AS antall_svar,
                       (SELECT COUNT(DISTINCT unike_svar.sesjon_id)
                        FROM ia_sak_kartlegging_svar unike_svar
                        WHERE unike_svar.kartlegging_id = sporreundersokelse.kartlegging_id
                          AND unike_svar.sporsmal_id = sporsmal.sporsmal_id) AS antall_svar_per_sporsmal
                FROM ia_sak_kartlegging sporreundersokelse
                         JOIN ia_prosess samarbeid
                              ON sporreundersokelse.ia_prosess = samarbeid.id
                         JOIN ia_sak sak USING (saksnummer, orgnr)
                         JOIN virksomhet USING (orgnr)
                         JOIN ia_sak_kartlegging_kartlegging_til_undertema sporreundersokelse_undertema
                              ON sporreundersokelse.kartlegging_id = sporreundersokelse_undertema.kartlegging_id
                         JOIN ia_sak_kartlegging_undertema undertema
                              ON sporreundersokelse_undertema.undertema_id = undertema.undertema_id
                         JOIN ia_sak_kartlegging_sporsmal_til_undertema sporsmal_undertema
                              ON undertema.undertema_id = sporsmal_undertema.undertema_id
                         JOIN ia_sak_kartlegging_sporsmal sporsmal
                              ON sporsmal_undertema.sporsmal_id = sporsmal.sporsmal_id
                         LEFT JOIN ia_sak_kartlegging_svaralternativer svaralternativ
                                   ON sporsmal.sporsmal_id = svaralternativ.sporsmal_id
                         LEFT JOIN ia_sak_kartlegging_kartlegging_til_tema sporreundersokelse_tema
                                   ON sporreundersokelse_tema.kartlegging_id = sporreundersokelse.kartlegging_id
                                       AND sporreundersokelse_tema.tema_id = undertema.tema_id
                         LEFT JOIN ia_sak_kartlegging_tema tema
                                   ON tema.tema_id = sporreundersokelse_tema.tema_id
                         LEFT JOIN dokument_til_publisering
                                   ON dokument_til_publisering.referanse_id = sporreundersokelse.kartlegging_id
                    """.trimMargin(),
                ).map(this::mapRowToSpørreundersøkelseDbRad).asList,
            ).tilSpørreundersøkelser()
        }

    fun opprettSpørreundersøkelse(
        orgnummer: String,
        spørreundersøkelseId: UUID,
        prosessId: Int,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
        temaer: List<TemaMetadata>,
        type: Spørreundersøkelse.Type,
    ): Either<Feil, Spørreundersøkelse> {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                val opprettet = LocalDateTime.now()
                tx.run(
                    queryOf(
                        """
                            INSERT INTO ia_sak_kartlegging (
                                kartlegging_id,
                                orgnr,
                                ia_prosess,
                                status,
                                opprettet_av,
                                type,
                                opprettet,
                                gyldig_til
                            )
                            VALUES (
                                :kartlegging_id,
                                :orgnr,
                                :prosessId,
                                :status,
                                :opprettet_av,
                                :sporreundersokelseType,
                                :opprettet,
                                :gyldigTil
                            )
                        """.trimMargin(),
                        mapOf(
                            "kartlegging_id" to spørreundersøkelseId,
                            "orgnr" to orgnummer,
                            "prosessId" to prosessId,
                            "status" to "OPPRETTET",
                            "opprettet_av" to saksbehandler.navIdent,
                            "sporreundersokelseType" to type.name,
                            "opprettet" to opprettet,
                            "gyldigTil" to opprettet.plusHours(ANTALL_TIMER_EN_SPØRREUNDERSØKELSE_ER_TILGJENGELIG),
                        ),
                    ).asUpdate,
                )

                temaer.sortedBy { it.rekkefølge }.forEach { tema ->
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
                                "kartlegging_id" to spørreundersøkelseId,
                                "tema_id" to tema.id,
                            ),
                        ).asUpdate,
                    )
                }

                temaer.sortedBy { it.rekkefølge }.forEach { tema ->
                    tema.undertemaer.sortedBy { it.rekkefølge }.forEach { undertema ->
                        tx.run(
                            queryOf(
                                """
                        INSERT INTO ia_sak_kartlegging_kartlegging_til_undertema (
                            kartlegging_id,
                            tema_id, 
                            undertema_id
                        )
                        VALUES (
                            :kartlegging_id,
                            :tema_id, 
                            :undertema_id
                        )
                                """.trimMargin(),
                                mapOf(
                                    "kartlegging_id" to spørreundersøkelseId,
                                    "tema_id" to tema.id,
                                    "undertema_id" to undertema.id,
                                ),
                            ).asUpdate,
                        )
                    }
                }
            }
        }

        return hentSpørreundersøkelse(spørreundersøkelseId = spørreundersøkelseId)?.right()
            ?: Feil(
                feilmelding = "Kunne ikke opprette kartlegging",
                httpStatusCode = HttpStatusCode.InternalServerError,
            ).left()
    }

    fun startSpørreundersøkelse(spørreundersøkelseId: UUID): Spørreundersøkelse? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE ia_sak_kartlegging SET
                        status = '${Spørreundersøkelse.Status.PÅBEGYNT.name}',
                        endret = :navaerendeTidspunkt,
                        pabegynt = :navaerendeTidspunkt
                    WHERE kartlegging_id = :kartleggingId
                    """.trimIndent(),
                    mapOf(
                        "kartleggingId" to spørreundersøkelseId.toString(),
                        "navaerendeTidspunkt" to LocalDateTime.now(),
                    ),
                ).asUpdate,
            )
            hentSpørreundersøkelse(spørreundersøkelseId)
        }

    fun slettSpørreundersøkelse(
        spørreundersøkelseId: UUID,
        sistEndret: LocalDateTime = LocalDateTime.now(),
    ): Spørreundersøkelse? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE ia_sak_kartlegging SET
                        status = '${Spørreundersøkelse.Status.SLETTET}',
                        endret = :sistEndret
                    WHERE kartlegging_id = :kartleggingId
                    """.trimIndent(),
                    mapOf(
                        "kartleggingId" to spørreundersøkelseId.toString(),
                        "sistEndret" to sistEndret,
                    ),
                ).asUpdate,
            )
            hentSpørreundersøkelse(spørreundersøkelseId)
        }

    fun stengTema(
        spørreundersøkelseId: UUID,
        temaId: Int,
    ) {
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
                        "kartleggingId" to spørreundersøkelseId.toString(),
                        "temaId" to temaId,
                    ),
                ).asUpdate,
            )
        }
    }

    fun avsluttSpørreundersøkelse(spørreundersøkelseId: UUID): Spørreundersøkelse? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE ia_sak_kartlegging SET
                        status = '${Spørreundersøkelse.Status.AVSLUTTET.name}',
                        endret = :navaerendeTidspunkt,
                        fullfort = :navaerendeTidspunkt
                        WHERE kartlegging_id = :kartleggingId
                    """.trimIndent(),
                    mapOf(
                        "kartleggingId" to spørreundersøkelseId.toString(),
                        "navaerendeTidspunkt" to LocalDateTime.now(),
                    ),
                ).asUpdate,
            )
            hentSpørreundersøkelse(spørreundersøkelseId)
        }

    fun hentAntallSvar(
        spørreundersøkelseId: UUID,
        spørsmålId: UUID,
    ): SpørreundersøkelseAntallSvar =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT COUNT(*) AS antall_svar
                        FROM ia_sak_kartlegging_svar
                        WHERE kartlegging_id = :kartleggingId
                        AND sporsmal_id = :sporsmalId
                    """.trimMargin(),
                    mapOf(
                        "kartleggingId" to spørreundersøkelseId.toString(),
                        "sporsmalId" to spørsmålId.toString(),
                    ),
                ).map { rad ->
                    SpørreundersøkelseAntallSvar(
                        spørreundersøkelseId = spørreundersøkelseId,
                        spørsmålId = spørsmålId,
                        antallSvar = rad.int("antall_svar"),
                    )
                }.asSingle,
            )
        } ?: SpørreundersøkelseAntallSvar(
            spørreundersøkelseId = spørreundersøkelseId,
            spørsmålId = spørsmålId,
            antallSvar = 0,
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
                        "svar_ider" to Json.encodeToString(karleggingSvarDto.svarIder),
                    ),
                ).asUpdate,
            )
        }

    fun hentAktiveTemaMetadata(type: Spørreundersøkelse.Type): List<TemaMetadata> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT * FROM ia_sak_kartlegging_tema
                    WHERE status = '${Tema.Status.AKTIV}'
                    AND type = :type
                    """.trimIndent(),
                    mapOf(
                        "type" to type.name,
                    ),
                ).map(this::mapTilTema).asList,
            )
        }

    private fun hentAktiveUndertemaerMetadata(temaId: Int): List<UndertemaMetadata> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT * FROM ia_sak_kartlegging_undertema
                    WHERE status = '${Tema.Status.AKTIV}'
                    AND tema_id = '$temaId'
                    """.trimIndent(),
                ).map(this::mapTilUndertema).asList,
            )
        }

    fun hentObligatoriskeAktiveUndertemaerMetadata(temaId: Int): List<UndertemaMetadata> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT * FROM ia_sak_kartlegging_undertema
                    WHERE status = '${Tema.Status.AKTIV}'
                    AND obligatorisk = true
                    AND tema_id = :temaId
                    """.trimIndent(),
                    mapOf(
                        "temaId" to temaId,
                    ),
                ).map(this::mapTilUndertema).asList,
            )
        }

    fun endreSamarbeidTilSpørreundersøkelse(
        spørreundersøkelseId: UUID,
        oppdaterSpørreundersøkelseDto: EndreSamarbeidTilSpørreundersøkelseDto,
    ): Either<Feil, Spørreundersøkelse> {
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE ia_sak_kartlegging SET 
                    ia_prosess = :samarbeidId,
                    endret = now()
                    WHERE kartlegging_id = :sporreundersokelseId
                    """.trimIndent(),
                    mapOf(
                        "samarbeidId" to oppdaterSpørreundersøkelseDto.prosessId,
                        "sporreundersokelseId" to spørreundersøkelseId.toString(),
                    ),
                ).asUpdate,
            )
        }

        return hentSpørreundersøkelse(spørreundersøkelseId)?.right()
            ?: IASakSpørreundersøkelseError.`feil under oppdatering`.left()
    }

    data class SpørreundersøkelseDatabaseRad(
        val virksomhetsNavn: String,
        val orgnummer: String,
        val saksnummer: String,
        val samarbeidId: Int,
        val spørreundersøkelseId: UUID,
        val type: Spørreundersøkelse.Type,
        val status: Spørreundersøkelse.Status,
        val opprettetAv: String,
        val opprettet: LocalDateTime,
        val gyldigTil: LocalDateTime,
        val endret: LocalDateTime?,
        val påbegynt: LocalDateTime?,
        val fullført: LocalDateTime?,
        val temaId: Int,
        val temaNavn: String,
        val temaStatus: Tema.Status,
        val temaRekkefølge: Int,
        val temaStengt: Boolean,
        val temaEndret: LocalDateTime,
        val undertemaId: Int,
        val undertemaNavn: String,
        val undertemaStatus: Undertema.Status,
        val undertemaRekkefølge: Int,
        val spørsmålId: UUID,
        val spørsmålTekst: String,
        val spørsmålRekkefølge: Int,
        val flervalg: Boolean,
        val svaralternativId: UUID,
        val svaralternativTekst: String,
        val antallSvar: Int,
        val antallSvarPerSpørsmål: Int,
        val publiseringStatus: DokumentPublisering.Status,
    )

    private fun mapRowToSpørreundersøkelseDbRad(row: Row): SpørreundersøkelseDatabaseRad = row.mapTilSpørreundersøkelseDbRad()

    private fun Row.mapTilSpørreundersøkelseDbRad(): SpørreundersøkelseDatabaseRad =
        SpørreundersøkelseDatabaseRad(
            virksomhetsNavn = string("navn"),
            orgnummer = string("orgnr"),
            saksnummer = string("saksnummer"),
            samarbeidId = int("samarbeid_id"),
            spørreundersøkelseId = string("sporreundersokelse_id").tilUUID("spørreundersøkelseId"),
            type = Spørreundersøkelse.Type.valueOf(string("type")),
            status = Spørreundersøkelse.Status.valueOf(string("status")),
            opprettetAv = string("opprettet_av"),
            opprettet = localDateTime("opprettet"),
            gyldigTil = localDateTime("gyldig_til"),
            endret = localDateTimeOrNull("endret"),
            påbegynt = localDateTimeOrNull("pabegynt"),
            fullført = localDateTimeOrNull("fullfort"),
            temaId = int("tema_id"),
            temaNavn = string("tema_navn"),
            temaStatus = Tema.Status.valueOf(string("tema_status")),
            temaRekkefølge = int("tema_rekkefolge"),
            temaStengt = boolean("tema_stengt"),
            temaEndret = localDateTime("tema_endret"),
            undertemaId = int("undertema_id"),
            undertemaNavn = string("undertema_navn"),
            undertemaStatus = Undertema.Status.valueOf(string("undertema_status")),
            undertemaRekkefølge = int("undertema_rekkefolge"),
            spørsmålId = string("sporsmal_id").tilUUID("spørsmålId"),
            spørsmålTekst = string("sporsmal_tekst"),
            spørsmålRekkefølge = int("sporsmal_rekkefolge"),
            flervalg = boolean("flervalg"),
            svaralternativId = string("svaralternativ_id").tilUUID("svaralternativId"),
            svaralternativTekst = string("svaralternativ_tekst"),
            antallSvar = intOrNull("antall_svar") ?: 0,
            antallSvarPerSpørsmål = intOrNull("antall_svar_per_sporsmal") ?: 0,
            publiseringStatus = stringOrNull("publisering_status").tilDokumentTilPubliseringStatus(),
        )

    data class SpørreundersøkelseAntallSvar(
        val spørreundersøkelseId: UUID,
        val spørsmålId: UUID,
        val antallSvar: Int,
    )

    data class TemaMetadata(
        val id: Int,
        val navn: String,
        val rekkefølge: Int,
        val undertemaer: List<UndertemaMetadata>,
    )

    private fun mapTilTema(row: Row): TemaMetadata {
        val temaId = row.int("tema_id")
        return TemaMetadata(
            id = temaId,
            rekkefølge = row.int("rekkefolge"),
            navn = row.string("navn"),
            undertemaer = hentAktiveUndertemaerMetadata(temaId = temaId),
        )
    }

    data class UndertemaMetadata(
        val id: Int,
        val navn: String,
        val rekkefølge: Int,
    )

    private fun mapTilUndertema(row: Row): UndertemaMetadata =
        UndertemaMetadata(
            id = row.int("undertema_id"),
            navn = row.string("navn"),
            rekkefølge = row.int("rekkefolge"),
        )
}
