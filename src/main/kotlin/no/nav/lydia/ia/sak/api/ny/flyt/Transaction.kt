package no.nav.lydia.ia.sak.api.ny.flyt

import com.github.guepardoapps.kulid.ULID
import kotlinx.datetime.toJavaLocalDateTime
import kotliquery.Row
import kotliquery.TransactionalSession
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.db.IASakRepository.Companion.validerAtSakHarRiktigEndretAvHendelse
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASak.Companion.tilIASakDto
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker
import java.time.LocalDateTime
import javax.sql.DataSource

class Transaction(
    val dataSource: DataSource,
) {
    fun <T> transactional(block: (TransactionalSession) -> T): T =
        using(sessionOf(dataSource)) { session ->
            session.transaction { tx ->
                block(tx)
            }
        }
}

context(tx: TransactionalSession)
fun lagreEllerOppdaterVirksomhetTilstand(
    orgnr: String,
    samarbeidsperiodeId: String,
    tilstand: VirksomhetIATilstand,
): VirksomhetTilstandDto? =
    tx.run(
        queryOf(
            """
            INSERT INTO tilstand_virksomhet (
                orgnr,
                samarbeidsperiode_id,
                tilstand
            )
            VALUES (
                :orgnr,
                :samarbeidsperiodeId,
                :tilstand
            )
            ON CONFLICT ON CONSTRAINT tilstand_virksomhet_orgnr_unique DO UPDATE SET
                samarbeidsperiode_id = :samarbeidsperiodeId,
                tilstand = :tilstand,
                sist_endret = now()
            RETURNING *
            """.trimIndent(),
            mapOf(
                "orgnr" to orgnr,
                "samarbeidsperiodeId" to samarbeidsperiodeId,
                "tilstand" to tilstand.name,
            ),
        ).map { row ->
            row.tilVirksomhetTilstandDto()
        }.asSingle,
    )

private fun Row.tilVirksomhetTilstandDto() =
    VirksomhetTilstandDto(
        orgnr = string("orgnr"),
        tilstand = VirksomhetIATilstand.valueOf(string("tilstand")),
        nesteTilstand = null, // TODO: Fiks
    )

context(tx: TransactionalSession)
fun lagreHendelse(
    hendelse: IASakshendelse,
    sistEndretAvHendelseId: String?,
    resulterendeStatus: IASak.Status,
): IASakshendelse =
    run {
        tx.validerAtSakHarRiktigEndretAvHendelse(hendelse.saksnummer, sistEndretAvHendelseId)
        tx.run(
            queryOf(
                """
                            INSERT INTO ia_sak_hendelse (
                                id,
                                saksnummer,
                                orgnr,
                                type,
                                resulterende_status,
                                opprettet_av,
                                opprettet_av_rolle,
                                opprettet,
                                nav_enhet_nummer,
                                nav_enhet_navn
                            )
                            VALUES (
                                :id,
                                :saksnummer,
                                :orgnr,
                                :type,
                                :resulterendeStatus,
                                :opprettet_av,
                                :opprettet_av_rolle,
                                :opprettet,
                                :enhetsnummer,
                                :enhetsnavn
                            ) 
                """.trimMargin(),
                mapOf(
                    "id" to hendelse.id,
                    "saksnummer" to hendelse.saksnummer,
                    "orgnr" to hendelse.orgnummer,
                    "type" to hendelse.hendelsesType.name,
                    "resulterendeStatus" to resulterendeStatus.name,
                    "opprettet_av" to hendelse.opprettetAv,
                    "opprettet_av_rolle" to hendelse.opprettetAvRolle?.toString(),
                    "opprettet" to hendelse.opprettetTidspunkt,
                    "enhetsnummer" to hendelse.navEnhet.enhetsnummer,
                    "enhetsnavn" to hendelse.navEnhet.enhetsnavn,
                ),
            ).asUpdate,
        )
        hendelse
    }

context(tx: TransactionalSession)
fun opprettSak(iaSakDto: IASakDto): IASakDto =
    tx.run(
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
        ).map { mapRowToIASakDto(it) }.asSingle,
    )!!

context(tx: TransactionalSession)
fun oppdaterStatusPåSak(
    saksnummer: String,
    status: IASak.Status,
    endretAv: String,
    endretAvHendelseId: String,
    oppdaterSistEndretPåSak: Boolean = true,
): IASakDto {
    val sistEndret: LocalDateTime = LocalDateTime.now()
    return tx.run(
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
        ).map { mapRowToIASakDto(it) }.asSingle,
    )!!
}

private fun mapRowToIASakDto(row: Row): IASakDto = row.tilIASakDto()

fun IASakDto.nyHendelseBasertPåSak(
    hendelsestype: IASakshendelseType,
    superbruker: Superbruker,
    navEnhet: NavEnhet,
) = IASakshendelse(
    id = ULID.random(),
    opprettetTidspunkt = LocalDateTime.now(),
    saksnummer = this.saksnummer,
    hendelsesType = hendelsestype,
    orgnummer = this.orgnr,
    opprettetAv = superbruker.navIdent,
    opprettetAvRolle = superbruker.rolle,
    navEnhet = navEnhet,
    resulterendeStatus = null,
)
