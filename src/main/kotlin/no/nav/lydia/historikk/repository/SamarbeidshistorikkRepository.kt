package no.nav.lydia.historikk.repository

import kotlinx.datetime.toKotlinLocalDateTime
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import no.nav.lydia.historikk.model.SamarbeidshistorikkKandidat
import no.nav.lydia.historikk.model.SamarbeidshistorikkType
import no.nav.lydia.kartlegging.Spørreundersøkelse
import no.nav.lydia.samarbeid.IASamarbeid
import no.nav.lydia.samarbeidsperiode.IASakshendelseType
import javax.sql.DataSource

class SamarbeidshistorikkRepository(
    val dataSource: DataSource,
) {
    fun hentEkteHendelser(samarbeidId: Int): List<SamarbeidshistorikkKandidat> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    statement =
                        """
                        SELECT
                            hendelse.type,
                            kartlegging.type AS kartleggingstype,
                            hendelse.opprettet,
                            hendelse.opprettet_av
                        FROM hendelser_til_samarbeid
                        JOIN ia_sak_hendelse hendelse ON (hendelse.id = hendelser_til_samarbeid.hendelse_id)
                        LEFT JOIN hendelser_til_kartlegging ON (hendelser_til_kartlegging.hendelse_id = hendelse.id)
                        LEFT JOIN ia_sak_kartlegging kartlegging
                            ON (kartlegging.kartlegging_id = hendelser_til_kartlegging.kartlegging_id)
                        WHERE hendelser_til_samarbeid.samarbeid_id = :samarbeidId
                        """.trimIndent(),
                    paramMap = mapOf("samarbeidId" to samarbeidId),
                ).map { row -> row.tilEkteHendelseKandidat() }.asList,
            )
        }

    fun hentRekonstruerteHendelser(samarbeidId: Int): List<SamarbeidshistorikkKandidat> =
        hentFraSamarbeid(samarbeidId = samarbeidId) +
            hentFraKartlegginger(samarbeidId = samarbeidId) +
            hentFraPlaner(samarbeidId = samarbeidId)

    private fun hentFraSamarbeid(samarbeidId: Int): List<SamarbeidshistorikkKandidat> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    statement =
                        """
                        SELECT opprettet, fullfort_tidspunkt, avbrutt_tidspunkt
                        FROM ia_prosess
                        WHERE id = :samarbeidId
                        """.trimIndent(),
                    paramMap = mapOf("samarbeidId" to samarbeidId),
                ).map { row ->
                    listOfNotNull(
                        row.localDateTimeOrNull("opprettet")?.let {
                            SamarbeidshistorikkKandidat(
                                hendelsestype = SamarbeidshistorikkType.SAMARBEID_OPPRETTET,
                                tidspunkt = it.toKotlinLocalDateTime(),
                                navIdent = null,
                            )
                        },
                        row.localDateTimeOrNull("fullfort_tidspunkt")?.let {
                            SamarbeidshistorikkKandidat(
                                hendelsestype = SamarbeidshistorikkType.SAMARBEID_FULLFØRT,
                                tidspunkt = it.toKotlinLocalDateTime(),
                                navIdent = null,
                            )
                        },
                        row.localDateTimeOrNull("avbrutt_tidspunkt")?.let {
                            SamarbeidshistorikkKandidat(
                                hendelsestype = SamarbeidshistorikkType.SAMARBEID_AVBRUTT,
                                tidspunkt = it.toKotlinLocalDateTime(),
                                navIdent = null,
                            )
                        },
                    )
                }.asSingle,
            )
        } ?: emptyList()

    private fun hentFraKartlegginger(samarbeidId: Int): List<SamarbeidshistorikkKandidat> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    statement =
                        """
                        SELECT type, fullfort
                        FROM ia_sak_kartlegging
                        WHERE ia_prosess = :samarbeidId
                          AND status = :statusAvsluttet
                          AND fullfort IS NOT NULL
                        """.trimIndent(),
                    paramMap = mapOf(
                        "samarbeidId" to samarbeidId,
                        "statusAvsluttet" to Spørreundersøkelse.Status.AVSLUTTET.name,
                    ),
                ).map { row ->
                    row.string("type").tilFullførtKartleggingType()?.let { hendelsestype ->
                        SamarbeidshistorikkKandidat(
                            hendelsestype = hendelsestype,
                            tidspunkt = row.localDateTime("fullfort").toKotlinLocalDateTime(),
                            navIdent = null,
                        )
                    }
                }.asList,
            )
        }

    private fun hentFraPlaner(samarbeidId: Int): List<SamarbeidshistorikkKandidat> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    statement =
                        """
                        SELECT status, sist_endret, opprettet_av
                        FROM ia_sak_plan
                        WHERE ia_prosess = :samarbeidId
                        ORDER BY sist_endret DESC
                        """.trimIndent(),
                    paramMap = mapOf("samarbeidId" to samarbeidId),
                ).map { row ->
                    val slettet = row.string("status") == IASamarbeid.Status.SLETTET.name
                    listOfNotNull(
                        SamarbeidshistorikkKandidat(
                            hendelsestype = SamarbeidshistorikkType.SAMARBEIDSPLAN_OPPRETTET,
                            tidspunkt = null,
                            navIdent = row.stringOrNull("opprettet_av"),
                        ),
                        // -- sist_endret oppdateres ved alle planendringer, og en slettet plan kan ikke endres.
                        // -- Derfor er sist_endret slettetidspunktet når status er SLETTET.
                        if (slettet) {
                            row.localDateTimeOrNull("sist_endret")?.let {
                                SamarbeidshistorikkKandidat(
                                    hendelsestype = SamarbeidshistorikkType.SAMARBEIDSPLAN_SLETTET,
                                    tidspunkt = it.toKotlinLocalDateTime(),
                                    navIdent = null,
                                )
                            }
                        } else {
                            null
                        },
                    )
                }.asList,
            )
        }.flatten()

    companion object {
        private fun String.tilFullførtKartleggingType(): SamarbeidshistorikkType? =
            when (Spørreundersøkelse.Type.entries.firstOrNull { it.name == this }) {
                Spørreundersøkelse.Type.Behovsvurdering -> SamarbeidshistorikkType.BEHOVSVURDERING_FULLFØRT
                Spørreundersøkelse.Type.Evaluering -> SamarbeidshistorikkType.EVALUERING_FULLFØRT
                null -> null
            }

        private fun Row.tilEkteHendelseKandidat(): SamarbeidshistorikkKandidat? {
            val type = string("type")
            val hendelsestype = when (IASakshendelseType.entries.firstOrNull { it.name == type }) {
                IASakshendelseType.NY_PROSESS -> SamarbeidshistorikkType.SAMARBEID_OPPRETTET

                IASakshendelseType.FULLFØR_PROSESS,
                IASakshendelseType.FULLFØR_PROSESS_MASKINELT_PÅ_EN_FULLFØRT_SAK,
                -> SamarbeidshistorikkType.SAMARBEID_FULLFØRT

                IASakshendelseType.AVBRYT_PROSESS -> SamarbeidshistorikkType.SAMARBEID_AVBRUTT

                IASakshendelseType.OPPRETT_SAMARBEIDSPLAN -> SamarbeidshistorikkType.SAMARBEIDSPLAN_OPPRETTET

                IASakshendelseType.SLETT_SAMARBEIDSPLAN -> SamarbeidshistorikkType.SAMARBEIDSPLAN_SLETTET

                IASakshendelseType.FULLFØR_KARTLEGGING -> stringOrNull("kartleggingstype")?.tilFullførtKartleggingType()

                else -> null
            } ?: return null

            return SamarbeidshistorikkKandidat(
                hendelsestype = hendelsestype,
                tidspunkt = localDateTime("opprettet").toKotlinLocalDateTime(),
                navIdent = stringOrNull("opprettet_av"),
            )
        }
    }
}
