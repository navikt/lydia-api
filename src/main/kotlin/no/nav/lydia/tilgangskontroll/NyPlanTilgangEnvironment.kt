package no.nav.lydia.tilgangskontroll

import no.nav.lydia.NaisEnvironment
import no.nav.lydia.NaisEnvironment.Companion.Environment

class NyPlanTilgangEnvironment(
    naisEnvironment: NaisEnvironment,
) {
    val navenheterMedNyPlanTilgang = when (naisEnvironment.miljø) {
        Environment.`PROD-GCP` -> setOf()
        Environment.`DEV-GCP` -> setOf()
        Environment.LOKAL -> setOf(NAVENHET_TEST_SAKSBEHANDLER2)
    }

    companion object {
        const val NAVENHET_TEST_SAKSBEHANDLER2 = "0220"
    }
}
