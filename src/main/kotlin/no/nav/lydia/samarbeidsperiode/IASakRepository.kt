package no.nav.lydia.samarbeidsperiode

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import kotliquery.Row
import kotliquery.TransactionalSession
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.felles.Feil
import no.nav.lydia.kartlegging.Spørreundersøkelse
import no.nav.lydia.samarbeidsperiode.IASak.Companion.tilIASak
import no.nav.lydia.samarbeidsperiode.IASak.Companion.tilIASakDto
import java.time.LocalDateTime
import javax.sql.DataSource

class IASakRepository(
    val dataSource: DataSource,
) {
    fun oppdaterStatusPåSak(
        saksnummer: String,
        status: IASak.Status,
        endretAv: String,
        endretAvHendelseId: String,
        oppdaterSistEndretPåSak: Boolean = true,
    ): Either<Feil, IASakDto> {
        val sistEndret: LocalDateTime = LocalDateTime.now()
        return using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.run(
                    queryOf(
                        """
                        UPDATE ia_sak 
                        SET
                            status = :status,
                            endret_av = :endret_av,
                            endret_av_hendelse = :endret_av_hendelse ${if (oppdaterSistEndretPåSak) ", endret = :endret" else ""}                           
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

    fun hentAlleSaker(): List<IASakDto> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf("SELECT * FROM ia_sak").map(this::mapRowToIASakDto).asList,
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
