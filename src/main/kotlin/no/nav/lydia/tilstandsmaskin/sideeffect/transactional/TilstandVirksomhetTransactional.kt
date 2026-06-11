package no.nav.lydia.tilstandsmaskin.sideeffect.transactional

import kotlinx.datetime.toKotlinLocalDate
import kotliquery.Row
import kotliquery.TransactionalSession
import kotliquery.queryOf
import no.nav.lydia.tilstandsmaskin.VirksomhetIATilstand
import no.nav.lydia.tilstandsmaskin.VirksomhetTilstandAutomatiskOppdateringDto
import no.nav.lydia.tilstandsmaskin.VirksomhetTilstandDto
import java.time.LocalDate

class TilstandVirksomhetTransactional {
    companion object {
        context(tx: TransactionalSession)
        fun lagreEllerOppdaterVirksomhetTilstand(
            orgnr: String,
            tilstand: VirksomhetIATilstand,
        ): VirksomhetTilstandDto? =
            tx.run(
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
        fun opprettAutomatiskOppdatering(
            orgnr: String,
            startTilstand: VirksomhetIATilstand,
            planlagtHendelse: String,
            nyTilstand: VirksomhetIATilstand,
            planlagtDato: LocalDate,
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

        context(tx: TransactionalSession)
        fun endrePlanlagtDatoForNesteTilstand(
            orgnr: String,
            nyPlanlagtDato: LocalDate,
        ): VirksomhetTilstandAutomatiskOppdateringDto? =
            tx.run(
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

        // Row-mappers
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

        private fun Row.tilVirksomhetTilstandDto() =
            VirksomhetTilstandDto(
                orgnr = string("orgnr"),
                tilstand = VirksomhetIATilstand.valueOf(string("tilstand")),
                nesteTilstand = null, // TODO: Fiks
            )

        private fun Row.tilVirksomhetTilstandAutomatiskOppdateringDto() =
            VirksomhetTilstandAutomatiskOppdateringDto(
                startTilstand = VirksomhetIATilstand.valueOf(string("start_tilstand")),
                planlagtHendelse = string("planlagt_hendelse"),
                nyTilstand = VirksomhetIATilstand.valueOf(string("ny_tilstand")),
                planlagtDato = localDate("planlagt_dato").toKotlinLocalDate(),
            )
    }
}
