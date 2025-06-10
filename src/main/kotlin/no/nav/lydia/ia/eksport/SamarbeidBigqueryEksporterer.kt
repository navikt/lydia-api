package no.nav.lydia.ia.eksport

import no.nav.lydia.ia.sak.db.ProsessRepository
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.util.concurrent.atomic.AtomicBoolean

class SamarbeidBigqueryEksporterer(
    val samarbeidBigqueryProdusent: SamarbeidBigqueryProdusent,
    val samarbeidRepository: ProsessRepository,
) {
    companion object {
        val KJØRER_STATISTIKK_EKSPORT = AtomicBoolean(false)
    }

    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun eksporter() {
        KJØRER_STATISTIKK_EKSPORT.set(true)

        val alleSamarbeid: List<IASamarbeid> = samarbeidRepository.hentAlleProsesser()
        log.info("Starter re-eksport av ${alleSamarbeid.size} samarbeid")

        try {
            alleSamarbeid.forEach { nåværendeSamarbeid -> samarbeidBigqueryProdusent.receive(nåværendeSamarbeid) }
        } catch (e: Exception) {
            KJØRER_STATISTIKK_EKSPORT.set(false)
            log.error("Klarte ikke å kjøre eksport av samarbeid", e)
            throw e
        }
        log.info("Ferdig med re-eksport av ${alleSamarbeid.size} samarbeid")
        KJØRER_STATISTIKK_EKSPORT.set(false)
    }
}
