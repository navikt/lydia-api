package no.nav.lydia.ia.sak.db

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import kotliquery.Row
import kotliquery.TransactionalSession
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASak.Companion.tilIASak
import java.time.LocalDateTime
import javax.sql.DataSource

class IASakRepository(val dataSource: DataSource) {

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
                        "endret_av_hendelse" to iaSak.endretAvHendelseId
                    )
                ).map(this::mapRowToIASak).asSingle
            )!!
        }

    fun oppdaterSak(iaSak: IASak, sistOppdatertAvHendelseId: String?): Either<Feil, IASak> =
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.validerAtSakHarRiktigEndretAvHendelse(iaSak.saksnummer, sistOppdatertAvHendelseId)
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
                            "endret_av_hendelse" to iaSak.endretAvHendelseId
                        )
                    ).map(this::mapRowToIASak).asSingle
                )?.right() ?: IASakError.`fikk ikke oppdatert sak`.left()
            }
        }

    fun slettSak(saksnummer: String, sistEndretAvHendelseId: String?) {
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                tx.validerAtSakHarRiktigEndretAvHendelse(saksnummer, sistEndretAvHendelseId)
                tx.run(
                    queryOf(
                        """
                            DELETE FROM ia_sak 
                            WHERE saksnummer = :saksnummer
                        """.trimIndent(), mapOf(
                            "saksnummer" to saksnummer,
                        )
                    ).asUpdate
                )
                tx.run(
                    queryOf(
                        """
                            DELETE FROM ia_sak_hendelse 
                            WHERE saksnummer = :saksnummer
                        """.trimIndent(), mapOf(
                            "saksnummer" to saksnummer,
                        )
                    ).asUpdate
                )
            }
        }
    }

    private fun mapRowToIASak(row: Row): IASak {
        return row.tilIASak()
    }

    fun hentSaker(orgnummer: String): List<IASak> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT *
                    FROM ia_sak
                    WHERE orgnr = :orgnr
                """.trimMargin(),
                    mapOf(
                        "orgnr" to orgnummer,
                    )
                ).map(this::mapRowToIASak).asList
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
                    )
                ).map(this::mapRowToIASak).asSingle
            )
        }

    fun hentAlleSaker(): List<IASak> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf("SELECT * FROM ia_sak").map(this::mapRowToIASak).asList
            )
        }

    fun oppdaterSistEndret(iaSak: IASak, sistEndret: LocalDateTime = LocalDateTime.now()) {
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    "UPDATE ia_sak SET endret = :sistEndret WHERE saksnummer = :saksnummer",
                    mapOf("sistEndret" to sistEndret, "saksnummer" to iaSak.saksnummer)
                ).asUpdate
            )
        }
    }

    fun hentUrørteSakerIVurderesUtenEier() =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT * FROM ia_sak 
                     WHERE eid_av IS NULL
                     AND status = '${IAProsessStatus.VURDERES.name}'
                     AND endret < (now() - INTERVAL '6 MONTH')
                    """.trimIndent()
                ).map(this::mapRowToIASak).asList
            )
        }

    companion object {
        fun TransactionalSession.validerAtSakHarRiktigEndretAvHendelse(
            saksnummer: String,
            sistEndretAvHendelseId: String?
        ) {
            sistEndretAvHendelseId?.let {
                run(
                    queryOf(
                        """
                        SELECT saksnummer FROM ia_sak WHERE saksnummer = :saksnummer AND endret_av_hendelse = :endret_av_hendelse
                    """.trimIndent(),
                        mapOf(
                            "saksnummer" to saksnummer,
                            "endret_av_hendelse" to sistEndretAvHendelseId
                        )
                    ).map { it.string("saksnummer") }.asSingle
                ) ?: throw RuntimeException(
                    "Sak har blitt oppdatert underveis! " +
                            "Sak med saksnummer: $saksnummer " +
                            "har ikke endret_av_hendelse = $sistEndretAvHendelseId som forventet."
                )
            }
        }
    }
}
