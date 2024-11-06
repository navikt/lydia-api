package no.nav.lydia.vedlikehold

import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.integrasjoner.azure.NavEnhet
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.util.concurrent.atomic.AtomicBoolean

class IASakStatusOppdaterer(
    val iaSakService: IASakService,
) {
    companion object {
        val KJØRER_RYDDE_I_URØRTE_SAKER = AtomicBoolean(false)
        val NAV_ENHET_FOR_TILBAKEFØRING = NavEnhet(
            enhetsnummer = "2840",
            enhetsnavn = "IA- og sykefraværskontoret",
        )
    }

    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun ryddeIUrørteSaker(tørrKjør: Boolean = false) {
        KJØRER_RYDDE_I_URØRTE_SAKER.set(true)
        val antallSaker = iaSakService.tilbakeførSaker(tørrKjør = tørrKjør)
        log.info("Ferdig med å rydde opp i urørte saker. Ryddet opp i $antallSaker saker")
        KJØRER_RYDDE_I_URØRTE_SAKER.set(false)
    }
}
