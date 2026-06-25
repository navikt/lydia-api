package no.nav.lydia.tilstandsmaskin.sideeffect.transactional

import kotliquery.TransactionalSession
import kotliquery.queryOf
import no.nav.lydia.prioritering.virksomhet.domene.VirksomhetStatus

object VirksomhetTransactional {
    context(tx: TransactionalSession)
    fun oppdaterStatus(
        orgnr: String,
        status: VirksomhetStatus,
        oppdatertAvBrregOppdateringsId: Long?,
    ) {
        val sql =
            """
            UPDATE virksomhet SET
            status = :status,
            oppdatertAvBrregOppdateringsId = :oppdatertAvBrregOppdateringsId,
            sistEndretTidspunkt = now()
            WHERE orgnr = :orgnr
            """.trimIndent()
        val params = mapOf(
            "orgnr" to orgnr,
            "status" to status.name,
            "oppdatertAvBrregOppdateringsId" to oppdatertAvBrregOppdateringsId,
        )
        tx.run(
            queryOf(
                statement = sql,
                paramMap = params,
            ).asUpdate,
        )
    }
}
