package no.nav.lydia.ia.sak.api.ny.flyt

import kotlinx.datetime.toKotlinLocalDate
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using
import javax.sql.DataSource

class TilstandVirksomhetRepository(
    val dataSource: DataSource,
) {
    fun lagreVirksomhetTilstand(
        orgnr: String,
        samarbeidsperiodeId: String,
        tilstand: VirksomhetIATilstand,
    ): VirksomhetTilstandDto? =
        using(sessionOf(dataSource)) { session ->
            session.run(
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
        }

    fun hentVirksomhetTilstand(orgnr: String): VirksomhetTilstandDto? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT tv.*, tao.ny_tilstand, tao.planlagt_dato
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

    fun oppdaterVirksomhetTilstand(
        orgnr: String,
        samarbeidsperiodeId: String,
        nyTilstand: VirksomhetIATilstand,
    ): VirksomhetTilstandDto? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    UPDATE tilstand_virksomhet
                    SET tilstand = :tilstand,
                        sist_endret = current_timestamp
                    WHERE orgnr = :orgnr
                      AND samarbeidsperiode_id = :samarbeidsperiodeId
                    RETURNING *
                    """.trimIndent(),
                    mapOf(
                        "orgnr" to orgnr,
                        "samarbeidsperiodeId" to samarbeidsperiodeId,
                        "tilstand" to nyTilstand.name,
                    ),
                ).map { row ->
                    row.tilVirksomhetTilstandDto()
                }.asSingle,
            )
        }

    fun slettVirksomhetTilstand(orgnr: String): VirksomhetTilstandDto? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    DELETE FROM tilstand_virksomhet 
                    WHERE orgnr = :orgnr
                    """.trimIndent(),
                    mapOf(
                        "orgnr" to orgnr,
                    ),
                ).map { row ->
                    VirksomhetTilstandDto(
                        tilstand = VirksomhetIATilstand.valueOf(row.string("tilstand")),
                        nesteTilstand = null, // TODO: Fiks
                    )
                }.asSingle,
            )
        }

    fun opprettAutomatiskOppdatering(
        orgnr: String,
        samarbeidsperiodeId: String,
        nyTilstand: VirksomhetIATilstand,
        planlagtDato: java.time.LocalDate,
    ): VirksomhetTilstandAutomatiskOppdateringDto? =
        using(sessionOf(dataSource)) { session ->
            val tilstandVirksomhetId = session.run(
                queryOf(
                    """
                    SELECT id FROM tilstand_virksomhet
                    WHERE orgnr = :orgnr AND samarbeidsperiode_id = :samarbeidsperiodeId
                    """.trimIndent(),
                    mapOf(
                        "orgnr" to orgnr,
                        "samarbeidsperiodeId" to samarbeidsperiodeId,
                    ),
                ).map { it.int("id") }.asSingle,
            ) ?: return@using null

            session.run(
                queryOf(
                    """
                    INSERT INTO tilstand_automatisk_oppdatering (
                        orgnr,
                        tilstand_virksomhet_id,
                        ny_tilstand,
                        planlagt_dato
                    )
                    VALUES (
                        :orgnr,
                        :tilstandVirksomhetId,
                        :nyTilstand,
                        :planlagtDato
                    )
                    RETURNING *
                    """.trimIndent(),
                    mapOf(
                        "orgnr" to orgnr,
                        "tilstandVirksomhetId" to tilstandVirksomhetId,
                        "nyTilstand" to nyTilstand.name,
                        "planlagtDato" to planlagtDato,
                    ),
                ).map { row ->
                    row.tilVirksomhetTilstandAutomatiskOppdateringDto()
                }.asSingle,
            )
        }

    fun hentAutomatiskOppdateringForVirksomhet(
        orgnr: String,
        samarbeidsperiodeId: String,
    ): VirksomhetTilstandAutomatiskOppdateringDto? =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                    SELECT tao.*
                    FROM tilstand_automatisk_oppdatering tao
                    JOIN tilstand_virksomhet tv ON tao.tilstand_virksomhet_id = tv.id
                    WHERE tv.orgnr = :orgnr
                      AND tv.samarbeidsperiode_id = :samarbeidsperiodeId
                    ORDER BY tao.planlagt_dato DESC
                    LIMIT 1
                    """.trimIndent(),
                    mapOf(
                        "orgnr" to orgnr,
                        "samarbeidsperiodeId" to samarbeidsperiodeId,
                    ),
                ).map { row ->
                    row.tilVirksomhetTilstandAutomatiskOppdateringDto()
                }.asSingle,
            )
        }

    private fun kotliquery.Row.tilVirksomhetTilstandDto() =
        VirksomhetTilstandDto(
            tilstand = VirksomhetIATilstand.valueOf(string("tilstand")),
            nesteTilstand = null,
        )

    private fun kotliquery.Row.tilVirksomhetTilstandDtoMedAutomatiskOppdatering() =
        VirksomhetTilstandDto(
            tilstand = VirksomhetIATilstand.valueOf(string("tilstand")),
            nesteTilstand = stringOrNull("ny_tilstand")?.let { nyTilstand ->
                VirksomhetTilstandAutomatiskOppdateringDto(
                    nyTilstand = VirksomhetIATilstand.valueOf(nyTilstand),
                    planlagtDato = localDate("planlagt_dato").toKotlinLocalDate(),
                )
            },
        )

    private fun kotliquery.Row.tilVirksomhetTilstandAutomatiskOppdateringDto() =
        VirksomhetTilstandAutomatiskOppdateringDto(
            nyTilstand = VirksomhetIATilstand.valueOf(string("ny_tilstand")),
            planlagtDato = localDate("planlagt_dato").toKotlinLocalDate(),
        )
}
