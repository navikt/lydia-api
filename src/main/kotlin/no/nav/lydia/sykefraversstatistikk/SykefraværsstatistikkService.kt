package no.nav.lydia.sykefraversstatistikk

import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.sykefraversstatistikk.api.SykefraværsstatistikkListResponse
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere
import no.nav.lydia.sykefraversstatistikk.domene.SykefraversstatistikkVirksomhet
import no.nav.lydia.sykefraversstatistikk.import.BehandletImportStatistikk
import org.slf4j.LoggerFactory

class SykefraværsstatistikkService(
    val sykefraversstatistikkRepository: SykefraversstatistikkRepository,
    val iaSakRepository: IASakRepository
) {
    val log = LoggerFactory.getLogger(this.javaClass)

    fun lagre(sykefraværsstatistikkListe: List<BehandletImportStatistikk>) {
        val start = System.currentTimeMillis()
        sykefraversstatistikkRepository.insert(behandletImportStatistikkListe = sykefraværsstatistikkListe)
        log.info("Brukte ${System.currentTimeMillis() - start} ms på å lagre statistikk for ${sykefraværsstatistikkListe.size} virksomheter")
    }

    fun hentSykefravær(
        søkeparametere: Søkeparametere
    ): SykefraværsstatistikkListResponse {
        val start = System.currentTimeMillis()
        val sykefravær = sykefraversstatistikkRepository.hentSykefravær(søkeparametere = søkeparametere)

        if (sykefravær.data.isEmpty()) {
            return sykefravær
        }

        val sistEndretDatoer = iaSakRepository.hentSistEndretDatoer(sykefravær.data.map { it.orgnr })
            .toMap().filterValues { it != null }

         val dataMedSistEndret = sykefravær.data.map {
             if (sistEndretDatoer.containsKey(it.orgnr)) {
                 it.copy(sistEndret = sistEndretDatoer[it.orgnr]?.date)
             } else
                 it
         }

        log.info("Brukte ${System.currentTimeMillis() - start} ms på å hente statistikk for virksomheter.")
        return SykefraværsstatistikkListResponse(data = dataMedSistEndret)
    }

    fun hentSykefraværForVirksomhet(orgnr: String): List<SykefraversstatistikkVirksomhet> {
        val start = System.currentTimeMillis()
        val sykefraværForVirksomhet = sykefraversstatistikkRepository.hentSykefraværForVirksomhet(orgnr = orgnr)
        log.info("Brukte ${System.currentTimeMillis() - start} ms på å hente statistikk for en virksomhet")
        return sykefraværForVirksomhet
    }

}
