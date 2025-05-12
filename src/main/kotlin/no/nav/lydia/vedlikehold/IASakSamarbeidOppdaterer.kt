package no.nav.lydia.vedlikehold

import no.nav.lydia.ia.sak.IASakService
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.util.concurrent.atomic.AtomicBoolean

class IASakSamarbeidOppdaterer(
    val iaSakService: IASakService,
) {
    companion object {
        val KJØRER_FULLFØRE_SAMARBEID_I_FULLFØRTE_IA_SAKER = AtomicBoolean(false)
    }

    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun fullføreSamarbeidForFullførteIASaker(tørrKjør: Boolean = false) {
        KJØRER_FULLFØRE_SAMARBEID_I_FULLFØRTE_IA_SAKER.set(true)
        val antallSaker = iaSakService.fullførMaskineltSamarbeidIFulførteSaker(tørrKjør = tørrKjør)
        log.info("Ferdig med å fullføre samarbeid i fullførte IA saker. Ryddet opp i $antallSaker saker")
        KJØRER_FULLFØRE_SAMARBEID_I_FULLFØRTE_IA_SAKER.set(false)
    }
}
