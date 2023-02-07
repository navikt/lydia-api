package no.nav.lydia.lederstatistikk

import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere
import org.slf4j.LoggerFactory

class LederstatistikkService(
    val lederstatistikkRepository: LederstatistikkRepository,
) {
    val log = LoggerFactory.getLogger(this.javaClass)

    fun søkEtterLederstatistikk(
        søkeparametere: Søkeparametere,
    ): List<Lederstatistikk> {
        val start = System.currentTimeMillis()
        val lederstatistikk = lederstatistikkRepository.hentLederstatistikk(søkeparametere = søkeparametere)

        log.info("Brukte ${System.currentTimeMillis() - start} ms på å hente lederstatistikk.")

        return slåSammenTalleneForNullOgIkkeAktiv(lederstatistikk)
    }

    private fun slåSammenTalleneForNullOgIkkeAktiv(lederstatistikk: List<Lederstatistikk>): MutableList<Lederstatistikk> {
        val nullStatus = lederstatistikk.firstOrNull { it.status == null }
        val ikkeAktivStatus = lederstatistikk.firstOrNull { it.status == IAProsessStatus.IKKE_AKTIV }

        val ikkeAktiveAntall = (nullStatus?.antall ?: 0) + (ikkeAktivStatus?.antall ?: 0)

        val modifisertListe = mutableListOf<Lederstatistikk>()
        modifisertListe.addAll(lederstatistikk.filter { it.status != null && it.status != IAProsessStatus.IKKE_AKTIV })
        modifisertListe.add(Lederstatistikk(IAProsessStatus.IKKE_AKTIV, ikkeAktiveAntall))
        return modifisertListe
    }
}
