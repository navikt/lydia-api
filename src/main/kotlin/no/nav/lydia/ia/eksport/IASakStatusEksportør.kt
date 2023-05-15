package no.nav.lydia.ia.eksport

import no.nav.lydia.ia.sak.db.IASakRepository
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.util.concurrent.atomic.AtomicBoolean

class IASakStatusEksportør(
    val iaSakRepository: IASakRepository,
    val iaSakStatusProdusent: IASakStatusProdusent,
) {
    companion object {
        val KJØRER_STATUS_EKSPORT = AtomicBoolean(false)
    }

    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun eksporter() {
        KJØRER_STATUS_EKSPORT.set(true)
        val alleSaker = iaSakRepository.hentAlleSaker()
        log.info("Starter re-eksport av ${alleSaker.size} statuser")
        try {

            alleSaker.forEach { nåværendeIaSak ->
                    iaSakStatusProdusent.receive(nåværendeIaSak)
            }
        } catch (e: Exception) {
            KJØRER_STATUS_EKSPORT.set(false)
            log.error("Klarte ikke å kjøre eksport av status", e)
            throw e
        }
        log.info("Ferdig med re-eksport av ${alleSaker.size} statuser")
        KJØRER_STATUS_EKSPORT.set(false)
    }
}
