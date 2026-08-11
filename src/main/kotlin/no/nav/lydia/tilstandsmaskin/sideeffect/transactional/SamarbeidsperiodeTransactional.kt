package no.nav.lydia.tilstandsmaskin.sideeffect.transactional

import com.github.guepardoapps.kulid.ULID
import kotlinx.datetime.toJavaLocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotliquery.Row
import kotliquery.TransactionalSession
import kotliquery.queryOf
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.samarbeidsperiode.IASak
import no.nav.lydia.samarbeidsperiode.IASak.Companion.tilIASakDto
import no.nav.lydia.samarbeidsperiode.IASakDto
import no.nav.lydia.samarbeidsperiode.IASakRepository.Companion.validerAtSakHarRiktigEndretAvHendelse
import no.nav.lydia.samarbeidsperiode.IASakshendelse
import no.nav.lydia.samarbeidsperiode.IASakshendelseType
import no.nav.lydia.samarbeidsperiode.SamarbeidshendelseDto
import no.nav.lydia.samarbeidsperiode.ValgtÅrsak
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker
import java.time.LocalDateTime

class SamarbeidsperiodeTransactional {
    companion object {
        context(tx: TransactionalSession)
        fun lagreHendelseTilSamarbeid(
            samarbeidId: Int,
            hendelseId: String,
        ): SamarbeidshendelseDto? {
            tx.run(
                action = queryOf(
                    statement =
                        """
                        INSERT INTO hendelser_til_samarbeid (
                            samarbeid_id, 
                            hendelse_id
                        )
                        VALUES (
                            :samarbeid_id, 
                            :hendelse_id
                        )
                        ON CONFLICT (hendelse_id) DO NOTHING
                        """.trimIndent(),
                    paramMap = mapOf(
                        "samarbeid_id" to samarbeidId,
                        "hendelse_id" to hendelseId,
                    ),
                ).asUpdate,
            )

            return samarbeidshendelseDto(hendelseId)
        }

        context(tx: TransactionalSession)
        private fun samarbeidshendelseDto(hendelseId: String): SamarbeidshendelseDto? =
            tx.run(
                queryOf(
                    """
                     SELECT 
                        hendelser_til_samarbeid.samarbeid_id,
                        ia_sak_hendelse.saksnummer,
                        ia_sak_hendelse.type, 
                        ia_sak_hendelse.opprettet, 
                        ia_sak_hendelse.opprettet_av
                    FROM hendelser_til_samarbeid
                    JOIN ia_sak_hendelse ON (ia_sak_hendelse.id = hendelser_til_samarbeid.hendelse_id)
                    WHERE ia_sak_hendelse.id = :hendelse_id
                    """.trimIndent(),
                    mapOf("hendelse_id" to hendelseId),
                ).map { row ->
                    SamarbeidshendelseDto(
                        samarbeidId = row.int("samarbeid_id"),
                        saksnummer = row.string("saksnummer"),
                        hendelsestype = IASakshendelseType.valueOf(row.string("type")),
                        tidspunkt = row.localDateTime("opprettet").toKotlinLocalDateTime(),
                        opprettetAv = row.string("opprettet_av"),
                    )
                }.asSingle,
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

        // Utils
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

        // Row-mappers
        private fun mapRowToIASakDto(row: Row): IASakDto = row.tilIASakDto()
    }
}
