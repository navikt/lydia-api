package no.nav.lydia.featureToggle

import no.nav.lydia.integrasjoner.azure.NavEnhet

object NavEnheter {
    object Dev {
        val NAV_IKT_DRIFT = NavEnhet(
            enhetsnummer = "2970",
            enhetsnavn = "NAV IKT DRIFT",
        )
    }

    object Lokal {
        val IT_AVDELINGEN = NavEnhet(
            enhetsnummer = "2900",
            enhetsnavn = "IT-avdelingen",
        )
    }
}
