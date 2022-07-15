package no.nav.lydia.sykefraversstatistikk

import no.nav.lydia.sykefraversstatistikk.api.SykefraværsstatistikkListResponse
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere
import no.nav.lydia.sykefraversstatistikk.domene.SykefraversstatistikkVirksomhet
import no.nav.lydia.sykefraversstatistikk.import.SykefraversstatistikkImportDto
import org.slf4j.LoggerFactory

class SykefraværsstatistikkService(val sykefraversstatistikkRepository: SykefraversstatistikkRepository) {
    val log = LoggerFactory.getLogger(this.javaClass)

    fun lagre(sykefraværsstatistikkListe: List<SykefraversstatistikkImportDto>) {
        val start = System.currentTimeMillis()
        sykefraversstatistikkRepository.insert(sykefraværsStatistikkListe = sykefraværsstatistikkListe)
        log.info("Brukte ${System.currentTimeMillis() - start} ms på å lagre statistikk for ${sykefraværsstatistikkListe.size} virksomheter")
    }

    fun hentSykefravær(
        søkeparametere: Søkeparametere
    ): SykefraværsstatistikkListResponse {
        val start = System.currentTimeMillis()
        val sykefravær = sykefraversstatistikkRepository.hentSykefravær(søkeparametere = søkeparametere)
        log.info("Brukte ${System.currentTimeMillis() - start} ms på å hente statistikk for virksomheter, total: ${sykefravær.total}")
        return sykefravær
    }

    fun hentSykefraværForVirksomhet(orgnr: String): List<SykefraversstatistikkVirksomhet> {
        val start = System.currentTimeMillis()
        val sykefraværForVirksomhet = sykefraversstatistikkRepository.hentSykefraværForVirksomhet(orgnr = orgnr)
        log.info("Brukte ${System.currentTimeMillis() - start} ms på å hente statistikk for en virksomhet")
        return sykefraværForVirksomhet
    }

}