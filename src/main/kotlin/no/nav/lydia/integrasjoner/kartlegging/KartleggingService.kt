package no.nav.lydia.integrasjoner.kartlegging

import arrow.core.Either
import arrow.core.right
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.db.IASakRepository
import org.slf4j.Logger
import org.slf4j.LoggerFactory

class KartleggingService(
    val kartleggingRepository: KartleggingRepository,
    val iaSakRepository: IASakRepository,
) {
    private val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun lagreSvar(karleggingSvarDtoListe: List<SpørreundersøkelseSvarDto>) {
        karleggingSvarDtoListe.forEach {
            val kartlegging = iaSakRepository.hentKartleggingEtterId(it.spørreundersøkelseId)

            if (kartlegging == null) {
                log.error("Fant ikke kartlegging på denne iden: ${it.spørreundersøkelseId}, hopper over")
                return@forEach
            }

            kartleggingRepository.lagreSvar(it)
            log.info("Lagret svar for kartlegging med id: '${it.spørreundersøkelseId}'")
        }
    }

    fun hentKartleggingMedSvar(kartleggingId: String, saksnummer: String): Either<Feil, KartleggingMedSvar> {
        val kartlegginger = iaSakRepository.hentKartlegginger(saksnummer = saksnummer)
        val iaSakKartlegging = kartlegginger.first { it.kartleggingId.toString() == kartleggingId }
        val alleSvar = kartleggingRepository.hentAlleSvar(kartleggingId = kartleggingId)

        return KartleggingMedSvar(iaSakKartlegging, alleSvar).right()
    }
}
