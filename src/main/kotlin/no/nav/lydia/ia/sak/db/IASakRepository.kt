package no.nav.lydia.ia.sak.db

import arrow.core.Either
import arrow.core.rightIfNotNull
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASak.Companion.tilIASak
import no.nav.lydia.sykefraversstatistikk.api.geografi.NavEnheter
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

    fun oppdaterSak(iaSak: IASak) : Either<Feil, IASak> =
        using(sessionOf(dataSource)) { session ->
            session.run(
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
            ).rightIfNotNull { IASakError.`fikk ikke oppdatert sak` }
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
                    AND orgnr NOT in ${NavEnheter.enheterSomSkalSkjermes.joinToString(prefix = "(", postfix = ")", separator = ",") { s -> "\'$s\'"}}
                """.trimMargin(),
                    mapOf(
                        "orgnr" to orgnummer,
                    )
                ).map(this::mapRowToIASak).asList
            )
        }
}

