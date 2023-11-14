package no.nav.lydia.statusoversikt

import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere
import org.slf4j.LoggerFactory

class StatusoversiktService(
    val statusoversiktRepository: StatusoversiktRepository,
) {
    val log = LoggerFactory.getLogger(this.javaClass)

    fun søkEtterStatusoversikt(
        søkeparametere: Søkeparametere,
    ): List<Statusoversikt> {
        val start = System.currentTimeMillis()
        val statusoversikts = statusoversiktRepository.hentStatusoversikt(søkeparametere = søkeparametere)

        log.info("Brukte ${System.currentTimeMillis() - start} ms på å hente statusoversikt.")

        return slåSammenTalleneForNullOgIkkeAktiv(statusoversikts)
    }

    private fun slåSammenTalleneForNullOgIkkeAktiv(statusoversikt: List<Statusoversikt>): MutableList<Statusoversikt> {
        val nullStatus = statusoversikt.firstOrNull { it.status == null }
        val ikkeAktivStatus = statusoversikt.firstOrNull { it.status == IAProsessStatus.IKKE_AKTIV }

        val ikkeAktiveAntall = (nullStatus?.antall ?: 0) + (ikkeAktivStatus?.antall ?: 0)

        val modifisertListe = mutableListOf<Statusoversikt>()
        modifisertListe.addAll(statusoversikt.filter { it.status != null && it.status != IAProsessStatus.IKKE_AKTIV })
        modifisertListe.add(Statusoversikt(IAProsessStatus.IKKE_AKTIV, ikkeAktiveAntall))
        return modifisertListe
    }
}
