package no.nav.lydia.ia.eksport

import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.launch
import no.nav.lydia.ia.sak.db.IASakLeveranseRepository
import org.slf4j.Logger
import org.slf4j.LoggerFactory

class IASakLeveranseEksportør(
    val iaSakLeveranseRepository: IASakLeveranseRepository,
    val iaSakLeveranseProdusent: IASakLeveranseProdusent,
) {
    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    suspend fun eksporter() = coroutineScope {
        launch {
            val alleLeveranser = iaSakLeveranseRepository.hentAlleIASakLeveranser()
            log.info("Starter re-eksport av ${alleLeveranser.size} leveranser")
            alleLeveranser.forEach {
                iaSakLeveranseProdusent.receive(it)
            }
            log.info("Ferdig med re-eksport av ${alleLeveranser.size} leveranser")
        }
    }
}
