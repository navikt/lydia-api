package no.nav.lydia.ia.eksport

import no.nav.lydia.ia.sak.db.IASakRepository
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.util.concurrent.atomic.AtomicBoolean

class IASakEksporterer(
    val iaSakRepository: IASakRepository,
    val iaSakProdusent: IASakProdusent?
) {
    companion object {
        val KJØRER_SAKS_EKSPORT = AtomicBoolean(false)
    }

    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun eksporter() {
        KJØRER_SAKS_EKSPORT.set(true)
        iaSakRepository.hentAlleSaker()
            .forEach { iaSak ->
                iaSakProdusent?.receive(iaSak)
            }
        KJØRER_SAKS_EKSPORT.set(false)
    }

}
