package no.nav.lydia.ia.sak.api.ny.flyt

import com.github.guepardoapps.kulid.ULID
import kotlinx.datetime.toJavaLocalDateTime
import kotlinx.datetime.toKotlinLocalDate
import kotliquery.Row
import kotliquery.TransactionalSession
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.ia.sak.DEFAULT_SAMARBEID_NAVN
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.samarbeid.IASamarbeidDto
import no.nav.lydia.ia.sak.db.IASakRepository.Companion.validerAtSakHarRiktigEndretAvHendelse
import no.nav.lydia.ia.sak.db.mapRowToIASamarbeid
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASak.Companion.tilIASakDto
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker
import java.time.LocalDateTime
import java.util.UUID
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
fun opprettAutomatiskOppdatering(
    orgnr: String,
    startTilstand: VirksomhetIATilstand,
    planlagtHendelse: String,
    nyTilstand: VirksomhetIATilstand,
    planlagtDato: java.time.LocalDate,
): VirksomhetTilstandAutomatiskOppdateringDto? {
    val tilstandVirksomhetId = tx.run(
        queryOf(
            """
            SELECT id FROM tilstand_virksomhet
            WHERE orgnr = :orgnr
            """.trimIndent(),
            mapOf(
                "orgnr" to orgnr,
            ),
        ).map { it.int("id") }.asSingle,
    ) ?: return null

    return tx.run(
        queryOf(
            """
            INSERT INTO tilstand_automatisk_oppdatering (
                orgnr,
                tilstand_virksomhet_id,
                start_tilstand,
                planlagt_hendelse,
                ny_tilstand,
                planlagt_dato
            )
            VALUES (
                :orgnr,
                :tilstandVirksomhetId,
                :startTilstand,
                :planlagtHendelse,
                :nyTilstand,
                :planlagtDato
            )
            RETURNING *
            """.trimIndent(),
            mapOf(
                "orgnr" to orgnr,
                "tilstandVirksomhetId" to tilstandVirksomhetId,
                "startTilstand" to startTilstand.name,
                "planlagtHendelse" to planlagtHendelse,
                "nyTilstand" to nyTilstand.name,
                "planlagtDato" to planlagtDato,
            ),
        ).map { row ->
            row.tilVirksomhetTilstandAutomatiskOppdateringDto()
        }.asSingle,
    )
}

private fun Row.tilVirksomhetTilstandAutomatiskOppdateringDto() =
    VirksomhetTilstandAutomatiskOppdateringDto(
        startTilstand = VirksomhetIATilstand.valueOf(string("start_tilstand")),
        planlagtHendelse = string("planlagt_hendelse"),
        nyTilstand = VirksomhetIATilstand.valueOf(string("ny_tilstand")),
        planlagtDato = localDate("planlagt_dato").toKotlinLocalDate(),
    )

context(tx: TransactionalSession)
fun slettVirksomhetTilstandAutomatiskOppdatering(orgnr: String) =
    tx.run(
        queryOf(
            """
            DELETE FROM tilstand_automatisk_oppdatering
            WHERE orgnr = :orgnr
            """.trimIndent(),
            mapOf(
                "orgnr" to orgnr,
            ),
        ).asUpdate,
    )

context(tx: TransactionalSession)
fun lagreEllerOppdaterVirksomhetTilstand(
    orgnr: String,
    tilstand: VirksomhetIATilstand,
): VirksomhetTilstandDto? =
    tx.run(
        queryOf(
            """
            INSERT INTO tilstand_virksomhet (
                orgnr,
                tilstand
            )
            VALUES (
                :orgnr,
                :tilstand
            )
            ON CONFLICT ON CONSTRAINT tilstand_virksomhet_orgnr_unique DO UPDATE SET
                tilstand = :tilstand,
                sist_endret = now()
            RETURNING *
            """.trimIndent(),
            mapOf(
                "orgnr" to orgnr,
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
fun lagreÅrsakForHendelse(
    hendelseId: String,
    valgtÅrsak: ValgtÅrsak,
) = run {
    valgtÅrsak.begrunnelser.forEach { begrunnelse ->
        tx.run(
            queryOf(
                """
                            INSERT INTO hendelse_begrunnelse (
                                hendelse_id,
                                aarsak,
                                begrunnelse,
                                aarsak_enum,
                                begrunnelse_enum
                            )
                            VALUES (
                                :hendelse_id,
                                :aarsak,
                                :begrunnelse,
                                :aarsak_enum,
                                :begrunnelse_enum
                            ) 
                            ON CONFLICT DO NOTHING  
                """.trimMargin(),
                mapOf(
                    "hendelse_id" to hendelseId,
                    "aarsak" to valgtÅrsak.type.navn,
                    "begrunnelse" to begrunnelse.navn,
                    "aarsak_enum" to valgtÅrsak.type.name,
                    "begrunnelse_enum" to begrunnelse.name,
                ),
            ).asUpdate,
        )
    }
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

context(tx: TransactionalSession)
fun hentSisteIASakDto(orgnummer: String): IASakDto? =
    tx.run(
        queryOf(
            """
            SELECT * FROM ia_sak
            WHERE orgnr = :orgnr
            ORDER BY opprettet DESC
            LIMIT 1
            """.trimIndent(),
            mapOf("orgnr" to orgnummer),
        ).map { mapRowToIASakDto(it) }.asSingle,
    )

context(tx: TransactionalSession)
fun hentAlleSakerDtoForVirksomhet(orgnummer: String): List<IASakDto> =
    tx.run(
        queryOf(
            """
            SELECT * FROM ia_sak
            WHERE orgnr = :orgnr
            ORDER BY opprettet DESC
            """.trimIndent(),
            mapOf("orgnr" to orgnummer),
        ).map { mapRowToIASakDto(it) }.asList,
    )

context(tx: TransactionalSession)
fun slettVirksomhetTilstand(orgnr: String): VirksomhetTilstandDto? =
    tx.run(
        queryOf(
            """
            DELETE FROM tilstand_virksomhet
            WHERE orgnr = :orgnr
            RETURNING *
            """.trimIndent(),
            mapOf("orgnr" to orgnr),
        ).map { row -> row.tilVirksomhetTilstandDto() }.asSingle,
    )

context(tx: TransactionalSession)
fun oppdaterVirksomhetTilstand(
    orgnr: String,
    tilstand: VirksomhetIATilstand,
): VirksomhetTilstandDto? =
    tx.run(
        queryOf(
            """
            UPDATE tilstand_virksomhet
            SET tilstand = :tilstand,
                sist_endret = current_timestamp
            WHERE orgnr = :orgnr
            RETURNING *
            """.trimIndent(),
            mapOf(
                "orgnr" to orgnr,
                "tilstand" to tilstand.name,
            ),
        ).map { row -> row.tilVirksomhetTilstandDto() }.asSingle,
    )

context(tx: TransactionalSession)
fun settSakTilSlettet(
    saksnummer: String,
    hendelse: IASakshendelse,
) {
    tx.run(
        queryOf(
            """
                        UPDATE ia_sak 
                        SET
                            status = :statusSlettet,
                            endret_av = :endret_av,
                            endret_av_hendelse = :endret_av_hendelse,
                            endret = :endret                           
                        WHERE saksnummer = :saksnummer
            """.trimMargin(),
            mapOf(
                "saksnummer" to saksnummer,
                "statusSlettet" to IASak.Status.SLETTET.name,
                "endret_av" to hendelse.opprettetAv,
                "endret_av_hendelse" to hendelse.id,
                "endret" to hendelse.opprettetTidspunkt,
            ),
        ).asUpdate,
    )
}

context(tx: TransactionalSession)
fun hentSamarbeid(samarbeidId: Int) =
    tx.run(
        queryOf(
            """
            SELECT *
            FROM ia_prosess
            WHERE id = :prosessId
            """.trimIndent(),
            mapOf(
                "prosessId" to samarbeidId,
            ),
        ).map { it.mapRowToIASamarbeid() }.asSingle,
    )

context(tx: TransactionalSession)
fun oppdaterNavnPåSamarbeid(samarbeidDto: IASamarbeidDto) {
    tx.run(
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

context(tx: TransactionalSession)
fun opprettNyttSamarbeid(
    offentligId: UUID = UUID.randomUUID(),
    saksnummer: String,
    navn: String? = DEFAULT_SAMARBEID_NAVN,
): IASamarbeid =
    tx.run(
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
        ).map { it.mapRowToIASamarbeid() }.asSingle,
    )!!

private fun String?.nullIfEmpty(): String? = this?.trim()?.takeIf { it.isNotEmpty() }

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
