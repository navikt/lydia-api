package no.nav.lydia.ia.sak.db

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.json.Json
import kotliquery.Row
import kotliquery.TransactionalSession
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering.Companion.tilDokumentTilPubliseringStatus
import no.nav.lydia.ia.sak.api.extensions.tilUUID
import no.nav.lydia.ia.sak.api.spørreundersøkelse.IASakSpørreundersøkelseError
import no.nav.lydia.ia.sak.api.spørreundersøkelse.OppdaterBehovsvurderingDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseSvarDto
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse.Companion.ANTALL_TIMER_EN_SPØRREUNDERSØKELSE_ER_TILGJENGELIG
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørsmål
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Svaralternativ
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Tema
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Undertema
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import java.time.LocalDateTime
import java.util.UUID
import javax.sql.DataSource

class SpørreundersøkelseRepository(
    private val dataSource: DataSource,
) {
    companion object {
        const val MINIMUM_ANTALL_SVAR_FØR_MASKERING = Spørreundersøkelse.MINIMUM_ANTALL_DELTAKERE
    }

    fun hentSpørreundersøkelser(
        samarbeid: IASamarbeid,
        type: Spørreundersøkelse.Type,
    ) = using(sessionOf(dataSource)) { session ->
        session.transaction { tx ->
            tx.run(
                queryOf(
                    """
                        SELECT sporreundersokelse.kartlegging_id AS id,
                               sporreundersokelse.type,
                               sporreundersokelse.status,
                               sporreundersokelse.opprettet_av,
                               sporreundersokelse.opprettet,
                               sporreundersokelse.gyldig_til,
                               sporreundersokelse.endret,
                               sporreundersokelse.pabegynt,
                               sporreundersokelse.fullfort,
                               virksomhet.navn,
                               virksomhet.orgnr,
                               sak.saksnummer,
                               samarbeid.id                      AS samarbeid_id,
                               dokument_til_publisering.status   AS publisering_status
                        FROM ia_sak_kartlegging sporreundersokelse
                                 JOIN ia_prosess samarbeid
                                      ON sporreundersokelse.ia_prosess = samarbeid.id
                                 JOIN ia_sak sak USING (saksnummer, orgnr)
                                 JOIN virksomhet USING (orgnr)
                                 LEFT JOIN dokument_til_publisering
                                           ON dokument_til_publisering.referanse_id = sporreundersokelse.kartlegging_id
                        WHERE samarbeid.id = :samarbeidId
                            AND sporreundersokelse.status != '${Spørreundersøkelse.Status.SLETTET}'
                            AND sporreundersokelse.type = :type;
                    """.trimMargin(),
                    mapOf(
                        "samarbeidId" to samarbeid.id,
                        "type" to type.name,
                    ),
                ).map { it.mapRowToSpørreundersøkelse(tx) }.asList,
            )
        }
    }

    fun hentSpørreundersøkelse(spørreundersøkelseId: UUID) =
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.run(
                    queryOf(
                        """
                        SELECT sporreundersokelse.kartlegging_id AS id,
                               sporreundersokelse.type,
                               sporreundersokelse.status,
                               sporreundersokelse.opprettet_av,
                               sporreundersokelse.opprettet,
                               sporreundersokelse.gyldig_til,
                               sporreundersokelse.endret,
                               sporreundersokelse.pabegynt,
                               sporreundersokelse.fullfort,
                               virksomhet.navn,
                               virksomhet.orgnr,
                               sak.saksnummer,
                               samarbeid.id                      AS samarbeid_id,
                               dokument_til_publisering.status   AS publisering_status
                        FROM ia_sak_kartlegging sporreundersokelse
                                 JOIN ia_prosess samarbeid
                                      ON sporreundersokelse.ia_prosess = samarbeid.id
                                 JOIN ia_sak sak USING (saksnummer, orgnr)
                                 JOIN virksomhet USING (orgnr)
                                 LEFT JOIN dokument_til_publisering
                                           ON dokument_til_publisering.referanse_id = sporreundersokelse.kartlegging_id
                        WHERE sporreundersokelse.kartlegging_id = :kartleggingId;
                        """.trimMargin(),
                        mapOf(
                            "kartleggingId" to spørreundersøkelseId.toString(),
                        ),
                    ).map { it.mapRowToSpørreundersøkelse(tx) }.asSingle,
                )
            }
        }

    private fun Row.mapRowToSpørreundersøkelse(transactionalSession: TransactionalSession): Spørreundersøkelse {
        val spørreundersøkelseId: UUID = string("id").tilUUID(hvaErJeg = "spørreundersøkelseId")
        return Spørreundersøkelse(
            id = spørreundersøkelseId,
            type = Spørreundersøkelse.Type.valueOf(string("type")),
            status = Spørreundersøkelse.Status.valueOf(string("status")),
            opprettetAv = string("opprettet_av"),
            opprettetTidspunkt = localDateTime("opprettet").toKotlinLocalDateTime(),
            gyldigTilTidspunkt = localDateTime("gyldig_til").toKotlinLocalDateTime(),
            endretTidspunkt = localDateTimeOrNull("endret")?.toKotlinLocalDateTime(),
            påbegyntTidspunkt = localDateTimeOrNull("pabegynt")?.toKotlinLocalDateTime(),
            fullførtTidspunkt = localDateTimeOrNull("fullfort")?.toKotlinLocalDateTime(),
            virksomhetsNavn = string("navn"),
            orgnummer = string("orgnr"),
            saksnummer = string("saksnummer"),
            samarbeidId = int("samarbeid_id"),
            publiseringStatus = stringOrNull("publisering_status").tilDokumentTilPubliseringStatus(),
            temaer = hentTemaerMedTransaction(transactionalSession, spørreundersøkelseId),
        )
    }

    fun hentTemaerMedTransaction(
        transactionalSession: TransactionalSession,
        spørreundersøkelseId: UUID,
    ): List<Tema> =
        transactionalSession.run(
            queryOf(
                """
                SELECT sporreundersokelse_tema.tema_id AS id,
                       tema.navn,
                       tema.status,
                       tema.rekkefolge,
                       tema.sist_endret,
                       sporreundersokelse_tema.stengt
                FROM ia_sak_kartlegging_kartlegging_til_tema sporreundersokelse_tema
                         JOIN ia_sak_kartlegging_tema tema
                              ON tema.tema_id = sporreundersokelse_tema.tema_id
                WHERE sporreundersokelse_tema.kartlegging_id = :kartleggingId;
                """.trimMargin(),
                mapOf(
                    "kartleggingId" to spørreundersøkelseId.toString(),
                ),
            ).map { it.mapRowToSpørreundersøkelseTema(transactionalSession, spørreundersøkelseId) }.asList,
        )

    private fun Row.mapRowToSpørreundersøkelseTema(
        transactionalSession: TransactionalSession,
        spørreundersøkelseId: UUID,
    ): Tema {
        val temaId = int("id")
        return Tema(
            id = temaId,
            navn = string("navn"),
            status = Tema.Status.valueOf(string("status")),
            rekkefølge = int("rekkefolge"),
            sistEndret = localDateTime("sist_endret").toKotlinLocalDateTime(),
            stengtForSvar = boolean("stengt"),
            undertemaer = hentUndertemaerMedTransaction(transactionalSession, spørreundersøkelseId, temaId),
        )
    }

    fun hentUndertemaerMedTransaction(
        transactionalSession: TransactionalSession,
        spørreundersøkelseId: UUID,
        temaId: Int,
    ): List<Undertema> =
        transactionalSession.run(
            queryOf(
                """
                SELECT undertema.undertema_id AS id,
                       undertema.navn,
                       undertema.status,
                       undertema.rekkefolge,
                       undertema.sist_endret
                FROM ia_sak_kartlegging_kartlegging_til_undertema ktu
                         JOIN ia_sak_kartlegging_undertema undertema
                              ON ktu.undertema_id = undertema.undertema_id
                WHERE ktu.kartlegging_id = :kartleggingId
                  AND undertema.tema_id = :temaId;
                """.trimMargin(),
                mapOf(
                    "kartleggingId" to spørreundersøkelseId.toString(),
                    "temaId" to temaId,
                ),
            ).map { it.mapRowToSpørreundersøkelseUndertema(transactionalSession, spørreundersøkelseId) }.asList,
        )

    private fun Row.mapRowToSpørreundersøkelseUndertema(
        transactionalSession: TransactionalSession,
        spørreundersøkelseId: UUID,
    ): Undertema {
        val undertemaId = int("id")
        return Undertema(
            id = undertemaId,
            navn = string("navn"),
            status = Undertema.Status.valueOf(string("status")),
            rekkefølge = int("rekkefolge"),
            sistEndret = localDateTime("sist_endret").toKotlinLocalDateTime(),
            spørsmål = hentSpørsmålMedTransaction(transactionalSession, spørreundersøkelseId, undertemaId),
        )
    }

    fun hentSpørsmålMedTransaction(
        transactionalSession: TransactionalSession,
        spørreundersøkelseId: UUID,
        undertemaId: Int,
    ): List<Spørsmål> =
        transactionalSession.run(
            queryOf(
                """
                SELECT sporsmal.sporsmal_id                            AS id,
                       sporsmal.sporsmal_tekst                         AS tekst,
                       sporsmal_undertema.rekkefolge,
                       sporsmal.flervalg,
                       (SELECT COUNT(DISTINCT svar.sesjon_id)
                        FROM ia_sak_kartlegging_svar svar
                        WHERE svar.kartlegging_id = :kartleggingId
                          AND svar.sporsmal_id = sporsmal.sporsmal_id) AS antall_svar_per_sporsmal
                FROM ia_sak_kartlegging_sporsmal_til_undertema sporsmal_undertema
                         JOIN ia_sak_kartlegging_sporsmal sporsmal
                              ON sporsmal_undertema.sporsmal_id = sporsmal.sporsmal_id
                WHERE sporsmal_undertema.undertema_id = :undertemaId;
                """.trimMargin(),
                mapOf(
                    "kartleggingId" to spørreundersøkelseId.toString(),
                    "undertemaId" to undertemaId,
                ),
            ).map {
                it.mapRowToSpørreundersøkelseSpørsmål(
                    transactionalSession,
                    spørreundersøkelseId,
                )
            }.asList,
        )

    private fun Row.mapRowToSpørreundersøkelseSpørsmål(
        transactionalSession: TransactionalSession,
        spørreundersøkelseId: UUID,
    ): Spørsmål {
        val spørsmålId = string("id").tilUUID(hvaErJeg = "spørsmålId")
        return Spørsmål(
            id = spørsmålId,
            tekst = string("tekst"),
            rekkefølge = int("rekkefolge"),
            flervalg = boolean("flervalg"),
            antallSvar = int("antall_svar_per_sporsmal"),
            svaralternativer = hentSvarMedTransaction(transactionalSession, spørreundersøkelseId, spørsmålId),
        )
    }

    fun hentSvarMedTransaction(
        transactionalSession: TransactionalSession,
        spørreundersøkelseId: UUID,
        spørsmålId: UUID,
    ): List<Svaralternativ> =
        transactionalSession.run(
            queryOf(
                """
                SELECT svaralternativ.svaralternativ_id,
                       svaralternativ.svaralternativ_tekst,
                       COALESCE(
                               (SELECT CASE
                                           WHEN (SELECT COUNT(DISTINCT us.sesjon_id)
                                                 FROM ia_sak_kartlegging_svar us
                                                 WHERE us.kartlegging_id = :kartleggingId
                                                   AND us.sporsmal_id = :sporsmalId) < $MINIMUM_ANTALL_SVAR_FØR_MASKERING
                                               THEN 0
                                           ELSE COUNT(DISTINCT svar.sesjon_id)
                                           END
                                FROM ia_sak_kartlegging_svar svar
                                WHERE svar.kartlegging_id = :kartleggingId
                                  AND svar.sporsmal_id = :sporsmalId
                                  AND svar.svar_ider @> ('["' || svaralternativ.svaralternativ_id || '"]')::jsonb), 0
                       ) AS antall_svar
                FROM ia_sak_kartlegging_svaralternativer svaralternativ
                WHERE svaralternativ.sporsmal_id = :sporsmalId;
                """.trimMargin(),
                mapOf(
                    "kartleggingId" to spørreundersøkelseId.toString(),
                    "sporsmalId" to spørsmålId.toString(),
                ),
            ).map { it.mapRowToSpørreundersøkelseSvar() }.asList,
        )

    private fun Row.mapRowToSpørreundersøkelseSvar(): Svaralternativ {
        val svaralternativId = string("svaralternativ_id").tilUUID(hvaErJeg = "svaralternativId")
        return Svaralternativ(
            id = svaralternativId,
            tekst = string("svaralternativ_tekst"),
            antallSvar = intOrNull("antall_svar") ?: 0,
        )
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

    fun hentAntallSvar(
        spørreundersøkelseId: UUID,
        spørsmålId: UUID,
    ) = using(sessionOf(dataSource)) { session ->
        session.run(
            queryOf(
                """
                        SELECT COUNT(*) AS antallSvar
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
                    antallSvar = rad.int("antallSvar"),
                )
            }.asSingle,
        )
    } ?: SpørreundersøkelseAntallSvar(
        spørreundersøkelseId = spørreundersøkelseId,
        spørsmålId = spørsmålId,
        antallSvar = 0,
    )

    data class SpørreundersøkelseAntallSvar(
        val spørreundersøkelseId: UUID,
        val spørsmålId: UUID,
        val antallSvar: Int,
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

    fun slettSpørreundersøkelse(
        spørreundersøkelseId: UUID,
        sistEndret: LocalDateTime = LocalDateTime.now(),
    ) = using(sessionOf(dataSource)) { session ->
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

    fun startSpørreundersøkelse(spørreundersøkelseId: UUID) =
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

    fun avsluttSpørreundersøkelse(spørreundersøkelseId: UUID) =
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

    private fun mapTilTema(row: Row): TemaMetadata {
        val temaId = row.int("tema_id")
        return TemaMetadata(
            id = temaId,
            rekkefølge = row.int("rekkefolge"),
            navn = row.string("navn"),
            undertemaer = hentAktiveUndertemaer(temaId = temaId),
        )
    }

    data class TemaMetadata(
        val id: Int,
        val navn: String,
        val rekkefølge: Int,
        val undertemaer: List<UndertemaMetadata>,
    )

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

    fun hentAktiveTemaer(type: Spørreundersøkelse.Type): List<TemaMetadata> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT * FROM ia_sak_kartlegging_tema
                    WHERE status = :status
                    AND type = :type
                    """.trimIndent(),
                    mapOf(
                        "status" to Tema.Status.AKTIV.name,
                        "type" to type.name,
                    ),
                ).map(this::mapTilTema).asList,
            )
        }

    fun hentObligatoriskeAktiveUndertemaer(temaId: Int): List<UndertemaMetadata> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT * FROM ia_sak_kartlegging_undertema
                    WHERE status = :status
                    AND obligatorisk = true
                    AND tema_id = :temaId
                    """.trimIndent(),
                    mapOf(
                        "status" to Tema.Status.AKTIV.name,
                        "temaId" to temaId,
                    ),
                ).map(this::mapTilUndertema).asList,
            )
        }

    private fun hentAktiveUndertemaer(temaId: Int): List<UndertemaMetadata> =
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

    private fun mapTilUndertema(row: Row): UndertemaMetadata =
        UndertemaMetadata(
            id = row.int("undertema_id"),
            navn = row.string("navn"),
            rekkefølge = row.int("rekkefolge"),
        )

    data class UndertemaMetadata(
        val id: Int,
        val navn: String,
        val rekkefølge: Int,
    )

    fun oppdaterBehovsvurdering(
        behovsvurderingId: UUID,
        oppdaterBehovsvurderingDto: OppdaterBehovsvurderingDto,
    ): Either<Feil, Spørreundersøkelse> {
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE ia_sak_kartlegging SET 
                    ia_prosess = :prosessId,
                    endret = now()
                    WHERE kartlegging_id = :behovsvurderingId
                    """.trimIndent(),
                    mapOf(
                        "prosessId" to oppdaterBehovsvurderingDto.prosessId,
                        "behovsvurderingId" to behovsvurderingId.toString(),
                    ),
                ).asUpdate,
            )
        }
        return hentSpørreundersøkelse(behovsvurderingId)?.right()
            ?: IASakSpørreundersøkelseError.`feil under oppdatering`.left()
    }

    fun hentAlleSpørreundersøkelser(): List<Spørreundersøkelse> =
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.run(
                    queryOf(
                        """
                        SELECT sporreundersokelse.kartlegging_id AS id,
                               sporreundersokelse.type,
                               sporreundersokelse.status,
                               sporreundersokelse.opprettet_av,
                               sporreundersokelse.opprettet,
                               sporreundersokelse.gyldig_til,
                               sporreundersokelse.endret,
                               sporreundersokelse.pabegynt,
                               sporreundersokelse.fullfort,
                               virksomhet.navn,
                               virksomhet.orgnr,
                               sak.saksnummer,
                               samarbeid.id                      AS samarbeid_id,
                               dokument_til_publisering.status   AS publisering_status
                        FROM ia_sak_kartlegging sporreundersokelse
                                 JOIN ia_prosess samarbeid
                                      ON sporreundersokelse.ia_prosess = samarbeid.id
                                 JOIN ia_sak sak USING (saksnummer, orgnr)
                                 JOIN virksomhet USING (orgnr)
                                 LEFT JOIN dokument_til_publisering
                                           ON dokument_til_publisering.referanse_id = sporreundersokelse.kartlegging_id
                        """.trimMargin(),
                    ).map { it.mapRowToSpørreundersøkelse(tx) }.asList,
                )
            }
        }
}
