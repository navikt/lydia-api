package no.nav.lydia.tilstandsmaskin.sideeffect.transactional

import kotliquery.TransactionalSession
import kotliquery.queryOf
import no.nav.lydia.samarbeid.DEFAULT_SAMARBEID_NAVN
import no.nav.lydia.samarbeid.IASamarbeid
import no.nav.lydia.samarbeid.IASamarbeidDto
import no.nav.lydia.samarbeid.mapRowToIASamarbeid
import java.time.LocalDateTime
import java.util.UUID

class SamarbeidTransactional {
    companion object {
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
        fun hentSamarbeidSomIkkeErSlettet(saksnummer: String): List<IASamarbeid> =
            tx.run(
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
                ).map { it.mapRowToIASamarbeid() }.asList,
            )

        context(tx: TransactionalSession)
        fun slettSamarbeid(samarbeidDto: IASamarbeidDto): IASamarbeid =
            tx.run(
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
                ).map { it.mapRowToIASamarbeid() }.asSingle,
            )!!

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

        context(tx: TransactionalSession)
        fun fullførSamarbeid(samarbeidDto: IASamarbeidDto): IASamarbeid =
            tx.run(
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
                ).map { it.mapRowToIASamarbeid() }.asSingle,
            )!!

        context(tx: TransactionalSession)
        fun avbrytSamarbeid(samarbeidDto: IASamarbeidDto): IASamarbeid =
            tx.run(
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
                ).map { it.mapRowToIASamarbeid() }.asSingle,
            )!!

        private fun String?.nullIfEmpty(): String? = this?.trim()?.takeIf { it.isNotEmpty() }
    }
}
