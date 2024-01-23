package no.nav.lydia.integrasjoner.kartlegging

import org.slf4j.Logger
import org.slf4j.LoggerFactory

class KartleggingService(
    val kartleggingRepository: KartleggingRepository
) {
    private val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun lagreSvar(karleggingSvarDtoListe: List<KartleggingSvarDto>) {
        karleggingSvarDtoListe.forEach {
            kartleggingRepository.lagreSvar(it)
            log.info("Lagret svar for kartlegging med id: '${it.kartleggingId}'")
        }
    }


}