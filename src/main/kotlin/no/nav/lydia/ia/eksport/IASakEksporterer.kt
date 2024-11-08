package no.nav.lydia.ia.eksport

import no.nav.lydia.ia.sak.db.IASakRepository
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.util.concurrent.atomic.AtomicBoolean

class IASakEksporterer(
    val iaSakRepository: IASakRepository,
    val iaSakProdusent: IASakProdusent,
) {
    companion object {
        val KJØRER_SAKS_EKSPORT = AtomicBoolean(false)
    }

    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun eksporter() {
        KJØRER_SAKS_EKSPORT.set(true)
        iaSakRepository.hentAlleSaker()
            .forEach { iaSak ->
                iaSakProdusent.receive(iaSak)
            }
        KJØRER_SAKS_EKSPORT.set(false)
    }

    fun eksporterEnkelSak(saksnummer: String) {
        KJØRER_SAKS_EKSPORT.set(true)
        log.info("Starter eksport av enkel sak, med saksnummer: '$saksnummer'")

        iaSakRepository.hentIASak(saksnummer = saksnummer)?.let { iaSak ->
            iaSakProdusent.receive(iaSak)
        } ?: log.warn("Eksport av enkel sak, med saksnummer: '$saksnummer' feilet. Sak ikke funnet")

        KJØRER_SAKS_EKSPORT.set(false)
        log.info("Eksport av enkel sak er ferdig")
    }
}
