package no.nav.lydia.integrasjoner.kartlegging

import javax.sql.DataSource
import kotliquery.Row
import kotliquery.queryOf
import kotliquery.sessionOf
import kotliquery.using

class KartleggingRepository(val dataSource: DataSource) {
    fun hentAlleSvar(kartleggingId: String) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        SELECT *
                        FROM ia_sak_kartlegging_svar
                        WHERE kartlegging_id = :kartleggingId
                    """.trimMargin(),
                    mapOf(
                        "kartleggingId" to kartleggingId,
                    )
                ).map(this::mapRowToKartleggingSvarDto).asList
            )
        }

    private fun mapRowToKartleggingSvarDto(row: Row): KartleggingSvarDto {
        return row.tilKartleggingSvarDto()
    }

    fun Row.tilKartleggingSvarDto(): KartleggingSvarDto =
        KartleggingSvarDto(
            kartleggingId = this.string("kartlegging_id"),
            sesjonId = this.string("sesjon_id"),
            spørsmålId = this.string("sporsmal_id"),
            svarId = this.string("svar_id")
        )
    
    fun lagreSvar(karleggingSvarDto: KartleggingSvarDto) =
        using(sessionOf(dataSource)) { session ->
            session.run(
                queryOf(
                    """
                        INSERT INTO ia_sak_kartlegging_svar (
                            kartlegging_id,
                            sesjon_id,
                            sporsmal_id,
                            svar_id
                        )
                        VALUES (
                            :kartleggingId,
                            :sesjonId,
                            :sporsmalId,
                            :svarId
                        )
                        ON CONFLICT ON CONSTRAINT ia_sak_kartlegging_svar_kartlegging_sesjon_spm DO UPDATE SET
                            svar_id = :svarId,
                            endret = now()
                        """.trimMargin(),
                    mapOf(
                        "kartleggingId" to karleggingSvarDto.kartleggingId,
                        "sesjonId" to karleggingSvarDto.sesjonId,
                        "sporsmalId" to karleggingSvarDto.spørsmålId,
                        "svarId" to karleggingSvarDto.svarId
                    )
                ).asUpdate
            )
        }
}
