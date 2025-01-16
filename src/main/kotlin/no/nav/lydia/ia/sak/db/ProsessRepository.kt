package no.nav.lydia.ia.sak.db

import kotlinx.datetime.toKotlinLocalDateTime
import kotliquery.Row
import kotliquery.Session
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.eksport.SamarbeidDto
import no.nav.lydia.ia.eksport.SamarbeidIVirksomhetDto
import no.nav.lydia.ia.sak.DEFAULT_SAMARBEID_NAVN
import no.nav.lydia.ia.sak.api.prosess.IAProsessDto
import no.nav.lydia.ia.sak.domene.ProsessHendelse
import no.nav.lydia.ia.sak.domene.prosess.IAProsess
import no.nav.lydia.ia.sak.domene.prosess.IAProsessStatus
import java.time.LocalDateTime
import javax.sql.DataSource

class ProsessRepository(
    val dataSource: DataSource,
) {
    fun hentProsess(
        saksnummer: String,
        prosessId: Int,
    ) = using(sessionOf(dataSource)) { session ->
        session.run(
            queryOf(
                """
                SELECT *
                FROM ia_prosess
                WHERE saksnummer = :saksnummer
                AND id = :prosessId
                AND status = 'AKTIV'
                """.trimIndent(),
                mapOf(
                    "saksnummer" to saksnummer,
                    "prosessId" to prosessId,
                ),
            ).map(this::mapRowToIaProsessDto).asSingle,
        )
    }

    fun hentProsesser(saksnummer: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT *
                    FROM ia_prosess
                    WHERE saksnummer = :saksnummer
                    AND status = 'AKTIV'
                    """.trimIndent(),
                    mapOf(
                        "saksnummer" to saksnummer,
                    ),
                ).map(this::mapRowToIaProsessDto).asList,
            )
        }

    fun hentAlleProsesser() =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT *
                    FROM ia_prosess
                    """.trimIndent(),
                ).map(this::mapRowToIaProsessDto).asList,
            )
        }

    fun opprettNyProsess(
        saksnummer: String,
        navn: String? = DEFAULT_SAMARBEID_NAVN,
    ): IAProsess =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    INSERT INTO ia_prosess (saksnummer, navn) 
                    values (:saksnummer, :navn)
                     returning *
                    """.trimIndent(),
                    mapOf(
                        "saksnummer" to saksnummer,
                        "navn" to navn.nullIfEmpty(),
                    ),
                ).map(this::mapRowToIaProsessDto).asSingle,
            )!!
        }

    fun oppdaterNavnPåProsess(prosessDto: IAProsessDto) {
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE ia_prosess SET navn = :navn, endret_tidspunkt = :endret_tidspunkt 
                    WHERE id = :prosessId
                    """.trimIndent(),
                    mapOf(
                        "navn" to prosessDto.navn.nullIfEmpty(),
                        "prosessId" to prosessDto.id,
                        "endret_tidspunkt" to LocalDateTime.now(),
                    ),
                ).asUpdate,
            )
        }
    }

    private fun String?.nullIfEmpty() = this?.trim()?.takeIf { it.isNotEmpty() }

    private fun mapRowToIaProsessDto(row: Row) =
        IAProsess(
            id = row.int("id"),
            saksnummer = row.string("saksnummer"),
            navn = row.stringOrNull("navn"),
            status = row.stringOrNull("status")?.let { IAProsessStatus.valueOf(it) },
            opprettet = row.localDateTime("opprettet").toKotlinLocalDateTime(),
            sistEndret = row.localDateTime("endret_tidspunkt").toKotlinLocalDateTime(),
        )

    fun oppdaterTilSlettetStatus(prosessHendelse: ProsessHendelse) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE ia_prosess
                     SET status = 'SLETTET', endret_tidspunkt = :endret_tidspunkt
                     WHERE id = :prosessId
                     AND saksnummer = :saksnummer
                     returning *
                    """.trimIndent(),
                    mapOf(
                        "prosessId" to prosessHendelse.prosessDto.id,
                        "saksnummer" to prosessHendelse.saksnummer,
                        "endret_tidspunkt" to LocalDateTime.now(),
                    ),
                ).map(this::mapRowToIaProsessDto).asSingle,
            )!!
        }

    fun hentSamarbeidIVirksomhetDto(prosessId: Int): SamarbeidIVirksomhetDto? =
        using(sessionOf(dataSource)) { session: Session ->
            session.run(
                queryOf(
                    """
                        SELECT 
                          ia_prosess.id as ia_prosess_id,
                          ia_prosess.navn as navn,
                          ia_prosess.status as status,
                          ia_prosess.endret_tidspunkt as endret_tidspunkt,
                          ia_sak.saksnummer as saksnummer,
                          ia_sak.orgnr as orgnr
                          from ia_prosess 
                        JOIN ia_sak on ia_sak.saksnummer = ia_prosess.saksnummer 
                        WHERE id = :prosessId
                    """.trimMargin(),
                    mapOf(
                        "prosessId" to prosessId,
                    ),
                ).map(this::mapTilSamarbeidVirksomhetDto).asSingle,
            )
        }

    fun hentAlleSamarbeidIVirksomhetDto(): List<SamarbeidIVirksomhetDto> =
        using(sessionOf(dataSource)) { session: Session ->
            session.run(
                queryOf(
                    """
                        SELECT 
                          ia_prosess.id as ia_prosess_id,
                          ia_prosess.navn as navn,
                          ia_prosess.status as status,
                          ia_prosess.endret_tidspunkt as endret_tidspunkt,
                          ia_sak.saksnummer as saksnummer,
                          ia_sak.orgnr as orgnr
                          from ia_prosess 
                        JOIN ia_sak on ia_sak.saksnummer = ia_prosess.saksnummer 
                    """.trimMargin(),
                ).map(this::mapTilSamarbeidVirksomhetDto).asList,
            )
        }

    private fun mapTilSamarbeidVirksomhetDto(row: Row): SamarbeidIVirksomhetDto =
        SamarbeidIVirksomhetDto(
            orgnr = row.string("orgnr"),
            saksnummer = row.string("saksnummer"),
            samarbeid = SamarbeidDto(
                id = row.int("ia_prosess_id"),
                navn = row.stringOrNull("navn"),
                status = row.stringOrNull("status")?.let { IAProsessStatus.valueOf(it) },
                endretTidspunkt = row.localDateTimeOrNull("endret_tidspunkt")?.toKotlinLocalDateTime(),
            ),
        )
}
