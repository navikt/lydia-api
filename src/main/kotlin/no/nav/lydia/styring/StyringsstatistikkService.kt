package no.nav.lydia.styring

import no.nav.lydia.ia.sak.domene.IAProsessStatus
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

        return slåSammenTalleneForNullOgIkkeAktiv(styringsstatistikk)
    }

    private fun slåSammenTalleneForNullOgIkkeAktiv(styringsstatistikk: List<Styringsstatistikk>): MutableList<Styringsstatistikk> {
        val nullStatus = styringsstatistikk.firstOrNull { it.status == null }
        val ikkeAktivStatus = styringsstatistikk.firstOrNull { it.status == IAProsessStatus.IKKE_AKTIV }

        val ikkeAktiveAntall = (nullStatus?.antall ?: 0) + (ikkeAktivStatus?.antall ?: 0)

        val modifisertListe = mutableListOf<Styringsstatistikk>()
        modifisertListe.addAll(styringsstatistikk.filter { it.status != null && it.status != IAProsessStatus.IKKE_AKTIV })
        modifisertListe.add(Styringsstatistikk(IAProsessStatus.IKKE_AKTIV, ikkeAktiveAntall))
        return modifisertListe
    }
}
