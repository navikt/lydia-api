package no.nav.lydia.tilstandsmaskin.sideeffect.transactional

import kotliquery.TransactionalSession
import kotliquery.queryOf
import no.nav.lydia.prioritering.virksomhet.domene.VirksomhetStatus
import no.nav.lydia.samarbeidsperiode.IASak

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

    class AlleSakerErSlettetPåVirksomhet private constructor(
        val orgnr: String,
    ) {
        companion object {
            context(tx: TransactionalSession)
            fun alleSakerErSlettetEllerKast(
                orgnr: String,
                feilmelding: () -> String,
            ): AlleSakerErSlettetPåVirksomhet {
                val harSakerSomIkkeErSlettet = tx.run(
                    queryOf(
                        """
                        SELECT EXISTS(SELECT 1 FROM ia_sak_alle
                        WHERE orgnr = :orgnr AND status <> :iaSakSlettetStatus)
                        """.trimIndent(),
                        mapOf("orgnr" to orgnr, "iaSakSlettetStatus" to IASak.Status.SLETTET.name),
                    ).map { it.boolean("exists") }.asSingle,
                ) ?: true
                require(!harSakerSomIkkeErSlettet, feilmelding)
                return AlleSakerErSlettetPåVirksomhet(orgnr)
            }
        }
    }

    context(tx: TransactionalSession, _: AlleSakerErSlettetPåVirksomhet)
    fun slettVirksomhet(orgnr: String) {
        tx.run(
            queryOf(
                """
                DELETE FROM tilstand_automatisk_oppdatering tao
                USING tilstand_virksomhet tv
                WHERE tao.tilstand_virksomhet_id = tv.id
                AND tv.orgnr = :orgnr;
                
                DELETE FROM tilstand_virksomhet
                WHERE orgnr = :orgnr;
                
                DELETE FROM virksomhet_naringsundergrupper vn
                USING virksomhet v
                WHERE vn.virksomhet = v.id AND orgnr = :orgnr;
                
                DELETE FROM virksomhet
                WHERE orgnr = :orgnr;
                """.trimIndent(),
                mapOf("orgnr" to orgnr),
            ).asUpdate,
        )
    }
}
