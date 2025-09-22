package no.nav.lydia.ia.sak.db

import kotlinx.datetime.toKotlinLocalDateTime
import kotliquery.Row
import kotliquery.Session
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.arbeidsgiver.DokumentMetadata
import no.nav.lydia.ia.eksport.SamarbeidDto
import no.nav.lydia.ia.sak.DEFAULT_SAMARBEID_NAVN
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering
import no.nav.lydia.ia.sak.api.extensions.tilUUID
import no.nav.lydia.ia.sak.api.samarbeid.IASamarbeidDto
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.integrasjoner.salesforce.aktiviteter.SalesforceAktivitet
import no.nav.lydia.integrasjoner.salesforce.aktiviteter.mapTilSalesforceAktivitet
import java.time.LocalDateTime
import java.util.UUID
import javax.sql.DataSource

class IASamarbeidRepository(
    val dataSource: DataSource,
) {
    fun hentSamarbeid(
        saksnummer: String,
        samarbeidId: Int,
    ): IASamarbeid? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT *
                    FROM ia_prosess
                    WHERE saksnummer = :saksnummer
                    AND id = :prosessId
                    """.trimIndent(),
                    mapOf(
                        "saksnummer" to saksnummer,
                        "prosessId" to samarbeidId,
                    ),
                ).map(this::mapRowToIASamarbeid).asSingle,
            )
        }

    fun hentSamarbeid(saksnummer: String): List<IASamarbeid> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT *
                    FROM ia_prosess
                    WHERE saksnummer = :saksnummer
                    AND status != :slettetStatus
                    """.trimIndent(),
                    mapOf(
                        "saksnummer" to saksnummer,
                        "slettetStatus" to IASamarbeid.Status.SLETTET.name,
                    ),
                ).map(this::mapRowToIASamarbeid).asList,
            )
        }

    fun hentAktiveSamarbeid(saksnummer: String): List<IASamarbeid> =
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
                ).map(this::mapRowToIASamarbeid).asList,
            )
        }

    fun hentSamarbeidForOrgnr(orgnr: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT 
                        ia_prosess.*
                    FROM ia_sak 
                      JOIN ia_prosess using (saksnummer)
                    WHERE orgnr = :orgnr
                    AND ia_prosess.status != :slettetStatus
                    """.trimIndent(),
                    mapOf(
                        "orgnr" to orgnr,
                        "slettetStatus" to IASamarbeid.Status.SLETTET.name,
                    ),
                ).map { mapRowToIASamarbeid(it) }.asList,
            )
        }

    fun hentSpørreundersøkelseDokumenterForSamarbeid(samarbeidId: Int) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT dok.dokument_id, dok.type, isk.fullfort
                    FROM dokument_til_publisering dok
                    JOIN ia_sak_kartlegging isk on (isk.kartlegging_id = dok.referanse_id)
                    WHERE
                        dok.dokument_id IS NOT NULL  
                        AND dok.status = :publisertStatus
                        AND dok.ia_prosess = :samarbeidId
                    """.trimIndent(),
                    mapOf(
                        "samarbeidId" to samarbeidId,
                        "publisertStatus" to DokumentPublisering.Status.PUBLISERT.name,
                    ),
                ).map {
                    DokumentMetadata(
                        dokumentId = it.string("dokument_id"),
                        type = it.string("type"),
                        dato = it.localDateTime("fullfort").toKotlinLocalDateTime(),
                    )
                }.asList,
            )
        }

    fun hentSamarbeidsplanDokumenterForSamarbeid(samarbeidId: Int) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT dok.dokument_id, dok.type, isp.sist_publisert
                    FROM dokument_til_publisering dok
                    JOIN ia_sak_plan isp on (isp.plan_id = dok.referanse_id)
                    WHERE
                        dok.dokument_id IS NOT NULL  
                        AND dok.status = :publisertStatus
                        AND dok.ia_prosess = :samarbeidId
                    """.trimIndent(),
                    mapOf(
                        "samarbeidId" to samarbeidId,
                        "publisertStatus" to DokumentPublisering.Status.PUBLISERT.name,
                    ),
                ).map {
                    DokumentMetadata(
                        dokumentId = it.string("dokument_id"),
                        type = it.string("type"),
                        dato = it.localDateTime("sist_publisert").toKotlinLocalDateTime(),
                    )
                }.asList,
            )
        }

    fun hentAlleSamarbeid(): List<IASamarbeid> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT *
                    FROM ia_prosess
                    """.trimIndent(),
                ).map(this::mapRowToIASamarbeid).asList,
            )
        }

    fun opprettNyttSamarbeid(
        offentligId: UUID = UUID.randomUUID(),
        saksnummer: String,
        navn: String? = DEFAULT_SAMARBEID_NAVN,
    ): IASamarbeid =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    INSERT INTO ia_prosess (offentlig_id, saksnummer, navn) 
                    values (:offentligId, :saksnummer, :navn)
                     returning *
                    """.trimIndent(),
                    mapOf(
                        "offentligId" to offentligId,
                        "saksnummer" to saksnummer,
                        "navn" to navn.nullIfEmpty(),
                    ),
                ).map(this::mapRowToIASamarbeid).asSingle,
            )!!
        }

    fun oppdaterNavnPåSamarbeid(samarbeidDto: IASamarbeidDto) {
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE ia_prosess SET navn = :navn, endret_tidspunkt = :endret_tidspunkt 
                    WHERE id = :prosessId
                    """.trimIndent(),
                    mapOf(
                        "navn" to samarbeidDto.navn,
                        "prosessId" to samarbeidDto.id,
                        "endret_tidspunkt" to LocalDateTime.now(),
                    ),
                ).asUpdate,
            )
        }
    }

    private fun String?.nullIfEmpty(): String? = this?.trim()?.takeIf { it.isNotEmpty() }

    private fun mapRowToIASamarbeid(row: Row): IASamarbeid =
        IASamarbeid(
            id = row.int("id"),
            offentligId = row.string("offentlig_id").tilUUID("offentlig_id"),
            saksnummer = row.string("saksnummer"),
            navn = row.string("navn"),
            status = row.stringOrNull("status")?.let { IASamarbeid.Status.valueOf(it) },
            opprettet = row.localDateTime("opprettet").toKotlinLocalDateTime(),
            avbrutt = row.localDateTimeOrNull("avbrutt_tidspunkt")?.toKotlinLocalDateTime(),
            fullført = row.localDateTimeOrNull("fullfort_tidspunkt")?.toKotlinLocalDateTime(),
            sistEndret = row.localDateTimeOrNull("endret_tidspunkt")?.toKotlinLocalDateTime(),
        )

    fun slettSamarbeid(samarbeidDto: IASamarbeidDto): IASamarbeid =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE ia_prosess
                     SET status = :status, endret_tidspunkt = :endret_tidspunkt
                     WHERE id = :prosessId
                     AND saksnummer = :saksnummer
                     returning *
                    """.trimIndent(),
                    mapOf(
                        "prosessId" to samarbeidDto.id,
                        "saksnummer" to samarbeidDto.saksnummer,
                        "status" to IASamarbeid.Status.SLETTET.name,
                        "endret_tidspunkt" to LocalDateTime.now(),
                    ),
                ).map(this::mapRowToIASamarbeid).asSingle,
            )!!
        }

    fun fullførSamarbeid(samarbeidDto: IASamarbeidDto): IASamarbeid =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE ia_prosess
                     SET status = :status, endret_tidspunkt = :tidspunkt, fullfort_tidspunkt = :tidspunkt
                     WHERE id = :prosessId
                     AND saksnummer = :saksnummer
                     returning *
                    """.trimIndent(),
                    mapOf(
                        "prosessId" to samarbeidDto.id,
                        "saksnummer" to samarbeidDto.saksnummer,
                        "status" to IASamarbeid.Status.FULLFØRT.name,
                        "tidspunkt" to LocalDateTime.now(),
                    ),
                ).map(this::mapRowToIASamarbeid).asSingle,
            )!!
        }

    fun avbrytSamarbeid(samarbeidDto: IASamarbeidDto): IASamarbeid =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE ia_prosess
                     SET status = :status, endret_tidspunkt = :tidspunkt, avbrutt_tidspunkt = :tidspunkt
                     WHERE id = :prosessId
                     AND saksnummer = :saksnummer
                     returning *
                    """.trimIndent(),
                    mapOf(
                        "prosessId" to samarbeidDto.id,
                        "saksnummer" to samarbeidDto.saksnummer,
                        "status" to IASamarbeid.Status.AVBRUTT.name,
                        "tidspunkt" to LocalDateTime.now(),
                    ),
                ).map(this::mapRowToIASamarbeid).asSingle,
            )!!
        }

    fun hentSamarbeidIVirksomhetDto(samarbeidId: Int): SamarbeidIVirksomhetDto? =
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
                        "prosessId" to samarbeidId,
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

    fun hentSalesforceAktiviteter(
        saksnummer: String,
        samarbeidId: Int,
    ): List<SalesforceAktivitet> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT * FROM salesforce_aktiviteter
                    WHERE saksnummer = :saksnummer 
                    AND samarbeid = :samarbeidId
                    AND slettet = false
                    """.trimIndent(),
                    mapOf(
                        "saksnummer" to saksnummer,
                        "samarbeidId" to samarbeidId,
                    ),
                ).map(Row::mapTilSalesforceAktivitet).asList,
            )
        }

    private fun mapTilSamarbeidVirksomhetDto(row: Row): SamarbeidIVirksomhetDto =
        SamarbeidIVirksomhetDto(
            orgnr = row.string("orgnr"),
            saksnummer = row.string("saksnummer"),
            samarbeid = SamarbeidDto(
                id = row.int("ia_prosess_id"),
                navn = row.stringOrNull("navn"),
                status = row.stringOrNull("status")?.let { IASamarbeid.Status.valueOf(it) },
                endretTidspunkt = row.localDateTimeOrNull("endret_tidspunkt")?.toKotlinLocalDateTime(),
            ),
        )

    data class SamarbeidIVirksomhetDto(
        val orgnr: String,
        val saksnummer: String,
        val samarbeid: SamarbeidDto,
    )
}
