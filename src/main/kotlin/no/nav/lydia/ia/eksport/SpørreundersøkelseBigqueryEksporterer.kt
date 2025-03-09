package no.nav.lydia.ia.eksport

import no.nav.lydia.ia.sak.db.SpørreundersøkelseRepository
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.util.concurrent.atomic.AtomicBoolean

class SpørreundersøkelseBigqueryEksporterer(
    val spørreundersøkelseBigqueryProdusent: SpørreundersøkelseBigqueryProdusent,
    val spørreundersøkelseRepository: SpørreundersøkelseRepository,
) {
    companion object {
        val KJØRER_STATISTIKK_EKSPORT = AtomicBoolean(false)
    }

    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun eksporter() {
        KJØRER_STATISTIKK_EKSPORT.set(true)

        val alleSpørreundersøkelser: List<Spørreundersøkelse> = spørreundersøkelseRepository.hentAlleSpørreundersøkelser()
        log.info("Starter re-eksport av ${alleSpørreundersøkelser.size} spørreudnersøkelser")

        try {
            alleSpørreundersøkelser.forEach { gjeldendeSpørreundersøkelse ->
                spørreundersøkelseBigqueryProdusent.receive(gjeldendeSpørreundersøkelse)
            }
        } catch (e: Exception) {
            KJØRER_STATISTIKK_EKSPORT.set(false)
            log.error("Klarte ikke å kjøre eksport av spørreundersøkelse", e)
            throw e
        }
        log.info("Ferdig med re-eksport av ${alleSpørreundersøkelser.size} spørreundersøkelser")
        KJØRER_STATISTIKK_EKSPORT.set(false)
    }
}
