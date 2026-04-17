package no.nav.lydia.ia.sak.api.ny.flyt

import kotlinx.datetime.toKotlinLocalDate
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import java.time.LocalDate
import javax.sql.DataSource

class TilstandVirksomhetRepository(
    val dataSource: DataSource,
) {
    fun lagreEllerOppdaterVirksomhetTilstand(
        orgnr: String,
        tilstand: VirksomhetIATilstand,
    ): VirksomhetTilstandDto? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    WITH upserted AS (
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
                    )
                    SELECT upserted.*, tao.start_tilstand, tao.planlagt_hendelse, tao.ny_tilstand, tao.planlagt_dato, tao.opprettet, tao.sist_endret
                    FROM upserted
                    LEFT JOIN tilstand_automatisk_oppdatering tao 
                        ON upserted.id = tao.tilstand_virksomhet_id
                    """.trimIndent(),
                    mapOf(
                        "orgnr" to orgnr,
                        "tilstand" to tilstand.name,
                    ),
                ).map { row ->
                    row.tilVirksomhetTilstandDtoMedAutomatiskOppdatering()
                }.asSingle,
            )
        }

    fun hentVirksomhetTilstand(orgnr: String): VirksomhetTilstandDto? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT tv.*, tao.start_tilstand, tao.planlagt_hendelse, tao.ny_tilstand, tao.planlagt_dato, tao.opprettet, tao.sist_endret
                    FROM tilstand_virksomhet tv
                    LEFT JOIN tilstand_automatisk_oppdatering tao 
                        ON tv.id = tao.tilstand_virksomhet_id
                    WHERE tv.orgnr = :orgnr
                    ORDER BY tv.sist_endret DESC
                    LIMIT 1
                    """.trimIndent(),
                    mapOf("orgnr" to orgnr),
                ).map { row ->
                    row.tilVirksomhetTilstandDtoMedAutomatiskOppdatering()
                }.asSingle,
            )
        }

    fun hentAlleVirksomhetTilstanderMedPlanlagtDatoFørEllerIDag(): List<VirksomhetTilstandDto> =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT tv.*, tao.start_tilstand, tao.planlagt_hendelse, tao.ny_tilstand, tao.planlagt_dato
                    FROM tilstand_virksomhet tv
                    INNER JOIN tilstand_automatisk_oppdatering tao 
                        ON tv.id = tao.tilstand_virksomhet_id
                    WHERE tao.planlagt_dato <= CURRENT_DATE
                    ORDER BY tv.sist_endret DESC
                    """.trimIndent(),
                ).map { row ->
                    row.tilVirksomhetTilstandDtoMedAutomatiskOppdatering()
                }.asList,
            )
        }

    fun opprettAutomatiskOppdatering(
        orgnr: String,
        startTilstand: VirksomhetIATilstand,
        planlagtHendelse: String,
        nyTilstand: VirksomhetIATilstand,
        planlagtDato: LocalDate,
    ): VirksomhetTilstandAutomatiskOppdateringDto? =
        using(sessionOf(dataSource)) { session ->
            val tilstandVirksomhetId = session.run(
                queryOf(
                    """
                    SELECT id FROM tilstand_virksomhet
                    WHERE orgnr = :orgnr
                    """.trimIndent(),
                    mapOf(
                        "orgnr" to orgnr,
                    ),
                ).map { it.int("id") }.asSingle,
            ) ?: return@using null

            session.run(
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

    fun slettVirksomhetTilstandAutomatiskOppdatering(orgnr: String): VirksomhetTilstandAutomatiskOppdateringDto? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    DELETE FROM tilstand_automatisk_oppdatering
                    WHERE orgnr = :orgnr
                    RETURNING *
                    """.trimIndent(),
                    mapOf(
                        "orgnr" to orgnr,
                    ),
                ).map { row ->
                    row.tilVirksomhetTilstandAutomatiskOppdateringDto()
                }.asSingle,
            )
        }

    fun endrePlanlagtDatoForNesteTilstand(
        orgnr: String,
        nyPlanlagtDato: LocalDate,
    ): VirksomhetTilstandAutomatiskOppdateringDto? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE tilstand_automatisk_oppdatering
                    SET planlagt_dato = :nyPlanlagtDato,                                 
                    sist_endret = now()
                    WHERE orgnr = :orgnr
                    RETURNING *
                    """.trimIndent(),
                    mapOf(
                        "orgnr" to orgnr,
                        "nyPlanlagtDato" to nyPlanlagtDato,
                    ),
                ).map { row ->
                    row.tilVirksomhetTilstandAutomatiskOppdateringDto()
                }.asSingle,
            )
        }

    private fun Row.tilVirksomhetTilstandDtoMedAutomatiskOppdatering(): VirksomhetTilstandDto =
        VirksomhetTilstandDto(
            orgnr = string("orgnr"),
            tilstand = VirksomhetIATilstand.valueOf(string("tilstand")),
            nesteTilstand = stringOrNull("ny_tilstand")?.let { nyTilstand ->
                VirksomhetTilstandAutomatiskOppdateringDto(
                    startTilstand = VirksomhetIATilstand.valueOf(string("start_tilstand")),
                    planlagtHendelse = string("planlagt_hendelse"),
                    nyTilstand = VirksomhetIATilstand.valueOf(nyTilstand),
                    planlagtDato = localDate("planlagt_dato").toKotlinLocalDate(),
                )
            },
        )

    private fun Row.tilVirksomhetTilstandAutomatiskOppdateringDto() =
        VirksomhetTilstandAutomatiskOppdateringDto(
            startTilstand = VirksomhetIATilstand.valueOf(string("start_tilstand")),
            planlagtHendelse = string("planlagt_hendelse"),
            nyTilstand = VirksomhetIATilstand.valueOf(string("ny_tilstand")),
            planlagtDato = localDate("planlagt_dato").toKotlinLocalDate(),
        )
}
