package no.nav.lydia.integrasjoner.kartlegging

import no.nav.lydia.ia.sak.db.IASakRepository
import org.slf4j.Logger
import org.slf4j.LoggerFactory

class KartleggingService(
    val kartleggingRepository: KartleggingRepository,
    val iaSakRepository: IASakRepository,
) {
    private val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun lagreSvar(karleggingSvarDtoListe: List<KartleggingSvarDto>) {
        karleggingSvarDtoListe.forEach {
            val kartlegging = iaSakRepository.hentKartleggingEtterId(it.kartleggingId)

            if (kartlegging == null) {
                log.error("Fant ikke kartlegging på denne iden: ${it.kartleggingId}, hopper over")
                return@forEach
            }

            kartleggingRepository.lagreSvar(it)
            log.info("Lagret svar for kartlegging med id: '${it.kartleggingId}'")
        }
    }
}
