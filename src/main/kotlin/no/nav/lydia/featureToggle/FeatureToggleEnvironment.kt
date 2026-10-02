package no.nav.lydia.featureToggle

import no.nav.lydia.NaisEnvironment
import no.nav.lydia.NaisEnvironment.Companion.Environment

private data class MengdeBryter(
    val skruddPåFor: Set<String>,
) {
    fun erPåFor(verdi: String) = skruddPåFor.contains(verdi)
}

class FeatureToggleEnvironment(
    private val naisEnvironment: NaisEnvironment,
) {
    private inner class EnvBryter(
        lokal: MengdeBryter = MengdeBryter(emptySet()),
        dev: MengdeBryter = MengdeBryter(emptySet()),
        prod: MengdeBryter = MengdeBryter(emptySet()),
    ) {
        val bryter = when (naisEnvironment.miljø) {
            Environment.`PROD-GCP` -> prod
            Environment.`DEV-GCP` -> dev
            Environment.LOKAL -> lokal
        }
    }

    private val toggles = mapOf(
        NAVENHETER_MED_NY_PLAN_TILGANG to EnvBryter(
            lokal = MengdeBryter(skruddPåFor = setOf(NavEnheter.Dev.NAV_IKT_DRIFT.enhetsnummer, NavEnheter.Lokal.IT_AVDELINGEN.enhetsnummer)),
            dev = MengdeBryter(skruddPåFor = setOf(NavEnheter.Dev.NAV_IKT_DRIFT.enhetsnummer)),
        ),
    )

    fun erSkruddPå(
        togglenavn: String,
        verdi: String,
    ): Boolean? = toggles[togglenavn]?.bryter?.erPåFor(verdi)

    fun hentVerdier(togglenavn: String): Set<String>? = toggles[togglenavn]?.bryter?.skruddPåFor

    companion object {
        const val NAVENHETER_MED_NY_PLAN_TILGANG = "enheter_til_nyplan"
    }
}
