package no.nav.lydia.ia.eksport

import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.sak.domene.IASak
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.util.concurrent.atomic.AtomicBoolean

class IASakStatistikkEksporterer(
    val iaSakRepository: IASakRepository,
    val iaSakshendelseRepository: IASakshendelseRepository,
    val iaSakStatistikkProdusent: IASakStatistikkProdusent,
) {
    companion object {
        val KJØRER_STATISTIKK_EKSPORT = AtomicBoolean(false)
    }

    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun eksporter() {
        KJØRER_STATISTIKK_EKSPORT.set(true)
        val alleSaker = iaSakRepository.hentAlleSaker()
        log.info("Starter re-eksport av ${alleSaker.size} saker")

        try {
            alleSaker.forEach { nåværendeIaSak ->
                val hendelser = iaSakshendelseRepository.hentHendelserForSaksnummer(nåværendeIaSak.saksnummer)

                List(hendelser.size) { index ->
                    IASak.fraHendelser(hendelser.subList(0, index + 1))
                }.forEach { historiskIaSak ->
                    iaSakStatistikkProdusent.receive(historiskIaSak)
                }
            }
        } catch (e: Exception) {
            KJØRER_STATISTIKK_EKSPORT.set(false)
            log.error("Klarte ikke å kjøre eksport av statistikk", e)
            throw e
        }
        log.info("Ferdig med re-eksport av ${alleSaker.size} saker")
        KJØRER_STATISTIKK_EKSPORT.set(false)
    }
}
