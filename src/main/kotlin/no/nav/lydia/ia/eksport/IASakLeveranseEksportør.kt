package no.nav.lydia.ia.eksport

import no.nav.lydia.ia.sak.db.IASakLeveranseRepository
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.util.concurrent.atomic.AtomicBoolean

class IASakLeveranseEksportør(
    val iaSakLeveranseRepository: IASakLeveranseRepository,
    val iaSakLeveranseProdusent: IASakLeveranseProdusent,
) {
    companion object {
        val KJØRER_LEVERANSE_EKSPORT = AtomicBoolean(false)
    }

    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun eksporter() {
        KJØRER_LEVERANSE_EKSPORT.set(true)
        val alleLeveranser = iaSakLeveranseRepository.hentAlleIASakLeveranser()
        log.info("Starter re-eksport av ${alleLeveranser.size} leveranser")
        alleLeveranser.forEach {
            iaSakLeveranseProdusent.receive(it)
        }
        log.info("Ferdig med re-eksport av ${alleLeveranser.size} leveranser")
        KJØRER_LEVERANSE_EKSPORT.set(false)
    }
}
