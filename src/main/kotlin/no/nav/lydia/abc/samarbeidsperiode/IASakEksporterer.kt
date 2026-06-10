package no.nav.lydia.abc.samarbeidsperiode

import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.util.concurrent.atomic.AtomicBoolean

class IASakEksporterer(
    val iaSakRepository: IASakRepository,
    val iaSakDtoProdusent: IASakDtoProdusent,
) {
    companion object {
        val KJØRER_SAKS_EKSPORT = AtomicBoolean(false)
    }

    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun eksporter() {
        KJØRER_SAKS_EKSPORT.set(true)
        iaSakRepository.hentAlleSaker()
            .forEach { iaSak ->
                iaSakDtoProdusent.receive(iaSak)
            }
        KJØRER_SAKS_EKSPORT.set(false)
    }
}
