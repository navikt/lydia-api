package no.nav.lydia.tilgangskontroll

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
            lokal = MengdeBryter(setOf(NAVENHET_TEST_SAKSBEHANDLER2)),
        ),
    )

    fun erSkruddPå(
        togglenavn: String,
        verdi: String,
    ): Boolean = toggles[togglenavn]?.bryter?.erPåFor(verdi) ?: false

    fun hentBrytere(): Map<String, Set<String>> = toggles.mapValues { it.value.bryter.skruddPåFor }

    companion object {
        const val NAVENHETER_MED_NY_PLAN_TILGANG = "pia.nyplan"
        const val NAVENHET_TEST_SAKSBEHANDLER2 = "0220"
    }
}
