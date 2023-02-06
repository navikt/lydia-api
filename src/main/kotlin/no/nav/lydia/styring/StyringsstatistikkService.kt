package no.nav.lydia.styring

import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere
import org.slf4j.LoggerFactory

class StyringsstatistikkService(
    val styringsstatistikkRepository: StyringsstatistikkRepository,
) {
    val log = LoggerFactory.getLogger(this.javaClass)

    fun søkEtterStyringsstatistikk(
        søkeparametere: Søkeparametere,
    ): List<Styringsstatistikk> {
        val start = System.currentTimeMillis()
        val styringsstatistikk = styringsstatistikkRepository.hentStyringsstatistikk(søkeparametere = søkeparametere)

        log.info("Brukte ${System.currentTimeMillis() - start} ms på å hente styringsstatistikk.")
        return styringsstatistikk
    }
}
