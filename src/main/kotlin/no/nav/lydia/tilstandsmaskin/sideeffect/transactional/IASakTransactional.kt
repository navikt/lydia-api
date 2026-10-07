package no.nav.lydia.tilstandsmaskin.sideeffect.transactional

import kotliquery.TransactionalSession
import kotliquery.queryOf
import no.nav.lydia.samarbeidsperiode.IASak
import no.nav.lydia.samarbeidsperiode.IASak.Companion.tilIASak

object IASakTransactional {
    context(tx: TransactionalSession)
    fun hentAlleUslettedeIAsaker(orgnummer: String) =
        tx.run(
            queryOf(
                """
                    SELECT *
                    FROM ia_sak
                    WHERE orgnr = :orgnr
                    AND status <> :slettetStatus
                    order by endret
                """.trimMargin(),
                mapOf(
                    "orgnr" to orgnummer,
                    "slettetStatus" to IASak.Status.SLETTET.name,
                ),
            ).map { it.tilIASak() }.asList,
        )

    context(tx: TransactionalSession, _: VirksomhetTransactional.AlleSakerErSlettetPåVirksomhet)
    fun slettSlettedeSaker(orgnummer: String) {
        tx.run(
            queryOf(
                """
                DELETE FROM salesforce_aktiviteter sa
                USING ia_sak_alle s
                WHERE s.orgnr = :orgnr;
                
                DELETE FROM ia_sak_team t
                USING ia_sak_alle s
                WHERE t.saksnummer = s.saksnummer
                  AND s.orgnr = :orgnr;
                
                DELETE FROM aarsak_begrunnelse ab
                USING hendelse_aarsak ha, ia_sak_hendelse h
                WHERE ab.aarsak_id = ha.id
                  AND ha.hendelse_id = h.id
                  AND h.orgnr = :orgnr;
                  
                DELETE FROM hendelse_aarsak ha
                USING ia_sak_hendelse h
                WHERE ha.hendelse_id = h.id
                  AND h.orgnr = :orgnr;
                
                DELETE FROM ia_sak_alle WHERE orgnr = :orgnr;
                
                DELETE FROM ia_sak_hendelse WHERE orgnr = :orgnr;
                """.trimIndent(),
                mapOf("orgnr" to orgnummer),
            ).asUpdate,
        )
    }
}
