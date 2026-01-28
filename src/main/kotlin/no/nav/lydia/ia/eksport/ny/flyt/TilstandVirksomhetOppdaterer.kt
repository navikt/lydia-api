package no.nav.lydia.ia.eksport.ny.flyt

import no.nav.lydia.ia.sak.api.ny.flyt.NyFlytService
import org.slf4j.Logger
import org.slf4j.LoggerFactory

class TilstandVirksomhetOppdaterer(
    val nyFlytService: NyFlytService,
) {
    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun oppdaterTilstandVirksomhet() {
        log.info("Oppdaterer tilstand virksomhet...")

        // kall ny metode i nyflytservice her
        nyFlytService.prosesserPlanlagteHendelser()

        log.info("Ferdig med å oppdatere tilstand virksomhet.")
    }
}
