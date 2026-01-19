package no.nav.lydia.ia.sak.db

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import kotlinx.datetime.toJavaLocalDateTime
import kotliquery.Row
import kotliquery.TransactionalSession
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASak.Companion.tilIASak
import no.nav.lydia.ia.sak.domene.IASak.Companion.tilIASakDto
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import java.time.LocalDateTime
import javax.sql.DataSource

class IASakRepository(
    val dataSource: DataSource,
) {
    fun opprettSak(iaSakDto: IASakDto): IASakDto =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    INSERT INTO ia_sak (
                        saksnummer,
                        orgnr,
                        status,
                        opprettet_av,
                        opprettet,
                        endret_av_hendelse
                    )
                    VALUES (
                        :saksnummer,
                        :orgnr,
                        :status,
                        :opprettet_av,
                        :opprettet,
                        :endret_av_hendelse
                    )
                    returning *                            
                    """.trimMargin(),
                    mapOf(
                        "saksnummer" to iaSakDto.saksnummer,
                        "orgnr" to iaSakDto.orgnr,
                        "status" to iaSakDto.status.name,
                        "opprettet_av" to iaSakDto.opprettetAv,
                        "opprettet" to iaSakDto.opprettetTidspunkt.toJavaLocalDateTime(),
                        "endret_av_hendelse" to iaSakDto.endretAvHendelseId,
                    ),
                ).map(this::mapRowToIASakDto).asSingle,
            )!!
        }

    fun opprettSak(iaSak: IASak): IASak =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    INSERT INTO ia_sak (
                        saksnummer,
                        orgnr,
                        status,
                        opprettet_av,
                        opprettet,
                        endret_av_hendelse
                    )
                    VALUES (
                        :saksnummer,
                        :orgnr,
                        :status,
                        :opprettet_av,
                        :opprettet,
                        :endret_av_hendelse
                    )
                    returning *                            
                    """.trimMargin(),
                    mapOf(
                        "saksnummer" to iaSak.saksnummer,
                        "orgnr" to iaSak.orgnr,
                        "status" to iaSak.status.name,
                        "opprettet_av" to iaSak.opprettetAv,
                        "opprettet" to iaSak.opprettetTidspunkt,
                        "endret_av_hendelse" to iaSak.endretAvHendelseId,
                    ),
                ).map(this::mapRowToIASak).asSingle,
            )!!
        }

    fun oppdaterSak(
        iaSak: IASak,
        sistOppdatertAvHendelseId: String?,
    ): Either<Feil, IASak> =
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.validerAtSakHarRiktigEndretAvHendelse(saksnummer = iaSak.saksnummer, sistEndretAvHendelseId = sistOppdatertAvHendelseId)
                tx.run(
                    queryOf(
                        """
                        UPDATE ia_sak 
                        SET
                            status = :status,
                            endret_av = :endret_av,
                            endret = :endret,
                            eid_av = :eidAv,
                            endret_av_hendelse = :endret_av_hendelse
                        WHERE saksnummer = :saksnummer
                        RETURNING *
                        """.trimMargin(),
                        mapOf(
                            "saksnummer" to iaSak.saksnummer,
                            "status" to iaSak.status.name,
                            "endret_av" to iaSak.endretAv,
                            "endret" to iaSak.endretTidspunkt,
                            "eidAv" to iaSak.eidAv,
                            "endret_av_hendelse" to iaSak.endretAvHendelseId,
                        ),
                    ).map(this::mapRowToIASak).asSingle,
                )?.right() ?: IASakError.`fikk ikke oppdatert sak`.left()
            }
        }

    fun oppdaterStatusPåSak(
        saksnummer: String,
        status: IASak.Status,
        endretAv: String,
        endretAvHendelseId: String,
        sistEndret: LocalDateTime = LocalDateTime.now(),
    ): Either<Feil, IASakDto> =
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.run(
                    queryOf(
                        """
                        UPDATE ia_sak 
                        SET
                            status = :status,
                            endret_av = :endret_av,
                            endret = :endret,
                            endret_av_hendelse = :endret_av_hendelse
                        WHERE saksnummer = :saksnummer
                        RETURNING *
                        """.trimMargin(),
                        mapOf(
                            "saksnummer" to saksnummer,
                            "status" to status.name,
                            "endret_av" to endretAv,
                            "endret_av_hendelse" to endretAvHendelseId,
                            "endret" to sistEndret,
                        ),
                    ).map(this::mapRowToIASakDto).asSingle,
                )?.right() ?: IASakError.`fikk ikke oppdatert sak`.left()
            }
        }

    fun slettSak(
        saksnummer: String,
        sistEndretAvHendelseId: String?,
    ) {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.validerAtSakHarRiktigEndretAvHendelse(saksnummer, sistEndretAvHendelseId)
                tx.run(
                    queryOf(
                        """
                        DELETE FROM ia_sak 
                        WHERE saksnummer = :saksnummer
                        """.trimIndent(),
                        mapOf(
                            "saksnummer" to saksnummer,
                        ),
                    ).asUpdate,
                )
                tx.run(
                    queryOf(
                        """
                        DELETE FROM ia_sak_hendelse 
                        WHERE saksnummer = :saksnummer
                        """.trimIndent(),
                        mapOf(
                            "saksnummer" to saksnummer,
                        ),
                    ).asUpdate,
                )
            }
        }
    }

    private fun mapRowToIASak(row: Row): IASak = row.tilIASak()

    private fun mapRowToIASakDto(row: Row): IASakDto = row.tilIASakDto()

    fun hentSaker(orgnummer: String): List<IASak> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT *
                    FROM ia_sak
                    WHERE orgnr = :orgnr
                    order by endret
                    """.trimMargin(),
                    mapOf(
                        "orgnr" to orgnummer,
                    ),
                ).map(this::mapRowToIASak).asList,
            )
        }

    fun hentAlleSakerDtoForVirksomhet(orgnummer: String): List<IASakDto> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT *
                    FROM ia_sak
                    WHERE orgnr = :orgnr
                    order by endret
                    """.trimMargin(),
                    mapOf(
                        "orgnr" to orgnummer,
                    ),
                ).map(this::mapRowToIASakDto).asList,
            )
        }

    fun hentAlleSakerForVirksomhet(orgnummer: String): List<IASakDto> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT *
                    FROM ia_sak
                    WHERE orgnr = :orgnr
                    order by endret
                    """.trimMargin(),
                    mapOf(
                        "orgnr" to orgnummer,
                    ),
                ).map(this::mapRowToIASakDto).asList,
            )
        }

    fun hentStatusForSaksnummer(saksnummer: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT status
                    FROM ia_sak
                    WHERE saksnummer = :saksnummer
                    """.trimMargin(),
                    mapOf(
                        "saksnummer" to saksnummer,
                    ),
                ).map { row -> IASak.Status.valueOf(row.string("status")) }.asSingle,
            )
        }

    fun hentIASak(saksnummer: String): IASak? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT *
                    FROM ia_sak
                    WHERE saksnummer = :saksnummer
                    """.trimMargin(),
                    mapOf(
                        "saksnummer" to saksnummer,
                    ),
                ).map(this::mapRowToIASak).asSingle,
            )
        }

    fun hentIASakDto(saksnummer: String): IASakDto? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT *
                    FROM ia_sak
                    WHERE saksnummer = :saksnummer
                    """.trimMargin(),
                    mapOf(
                        "saksnummer" to saksnummer,
                    ),
                ).map(this::mapRowToIASakDto).asSingle,
            )
        }

    fun hentAlleSaker(): List<IASak> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf("SELECT * FROM ia_sak").map(this::mapRowToIASak).asList,
            )
        }

    fun hentUrørteSakerIVurderesUtenEier(): List<IASak> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT * FROM ia_sak 
                    WHERE eid_av IS NULL
                    AND status = '${IASak.Status.VURDERES.name}'
                    AND endret < (now() - INTERVAL '6 MONTH')
                    """.trimIndent(),
                ).map(this::mapRowToIASak).asList,
            )
        }

    fun hentStatusForBehovsvurderinger(samarbeidId: Int): List<Pair<String, Spørreundersøkelse.Status>> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    select kartlegging_id, status from ia_sak_kartlegging
                    where ia_prosess = :prosessId
                    """.trimIndent(),
                    mapOf(
                        "prosessId" to samarbeidId,
                    ),
                ).map {
                    it.string("kartlegging_id") to Spørreundersøkelse.Status.valueOf(it.string("status"))
                }.asList,
            )
        }

    fun hentIkkeAktuelleSakerMedAktiveSamarbeid(): List<IASak> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT DISTINCT ia_sak.*
                    FROM ia_sak
                    JOIN ia_prosess ON ia_prosess.saksnummer = ia_sak.saksnummer
                    WHERE ia_sak.status = '${IASak.Status.IKKE_AKTUELL.name}'
                    AND ia_prosess.status = '${IASamarbeid.Status.AKTIV.name}'
                    """.trimIndent(),
                ).map(this::mapRowToIASak).asList,
            )
        }

    fun oppdaterEierPåSak(
        saksnummer: String,
        navIdent: String,
    ): IASakDto? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE ia_sak
                    SET eid_av = :navIdent
                    WHERE saksnummer = :saksnummer
                    RETURNING *
                    """.trimIndent(),
                    mapOf(
                        "navIdent" to navIdent,
                        "saksnummer" to saksnummer,
                    ),
                ).map { mapRowToIASakDto(it) }.asSingle,
            )
        }

    companion object {
        fun TransactionalSession.validerAtSakHarRiktigEndretAvHendelse(
            saksnummer: String,
            sistEndretAvHendelseId: String?,
        ) {
            sistEndretAvHendelseId?.let {
                run(
                    queryOf(
                        """
                        SELECT saksnummer FROM ia_sak WHERE saksnummer = :saksnummer AND endret_av_hendelse = :endret_av_hendelse
                        """.trimIndent(),
                        mapOf(
                            "saksnummer" to saksnummer,
                            "endret_av_hendelse" to sistEndretAvHendelseId,
                        ),
                    ).map { it.string("saksnummer") }.asSingle,
                ) ?: throw RuntimeException(
                    "Sak har blitt oppdatert underveis! " +
                        "Sak med saksnummer: $saksnummer " +
                        "har ikke endret_av_hendelse = $sistEndretAvHendelseId som forventet.",
                )
            }
        }
    }
}
