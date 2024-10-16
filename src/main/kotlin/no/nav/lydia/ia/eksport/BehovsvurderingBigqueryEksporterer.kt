package no.nav.lydia.ia.eksport

import no.nav.lydia.ia.sak.db.SpørreundersøkelseRepository
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.util.concurrent.atomic.AtomicBoolean

class BehovsvurderingBigqueryEksporterer(
    val behovsvurderingBigqueryProdusent: BehovsvurderingBigqueryProdusent,
    val behovsvurderingRepository: SpørreundersøkelseRepository,
) {
    companion object {
        val KJØRER_STATISTIKK_EKSPORT = AtomicBoolean(false)
    }

    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun eksporter() {
        KJØRER_STATISTIKK_EKSPORT.set(true)

        val alleBehovsvurderinger: List<Spørreundersøkelse> = behovsvurderingRepository.hentAlleSpørreundersøkelser()
        log.info("Starter re-eksport av ${alleBehovsvurderinger.size} behovsvurderinger")

        try {
            alleBehovsvurderinger.forEach { nåværendeBehovsvurdering ->
                behovsvurderingBigqueryProdusent.reEksporter(nåværendeBehovsvurdering)
            }
        } catch (e: Exception) {
            KJØRER_STATISTIKK_EKSPORT.set(false)
            log.error("Klarte ikke å kjøre eksport av behovsvurderinger", e)
            throw e
        }
        log.info("Ferdig med re-eksport av ${alleBehovsvurderinger.size} saker")
        KJØRER_STATISTIKK_EKSPORT.set(false)
    }
}
