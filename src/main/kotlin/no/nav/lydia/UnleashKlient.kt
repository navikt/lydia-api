package no.nav.lydia

import io.getunleash.DefaultUnleash
import io.getunleash.FakeUnleash
import io.getunleash.util.UnleashConfig
import no.nav.lydia.NaisEnvironment.Companion.Environment.*

fun lagUnleashKlient(naisEnvironment: NaisEnvironment) = when (naisEnvironment.miljø) {
    PROD_GCP, DEV_GCP -> {
        val config: UnleashConfig = UnleashConfig.builder()
            .appName(NaisEnvironment.APP_NAVN)
            .instanceId(NaisEnvironment.APP_NAVN + "_" + naisEnvironment.miljø.name)
            .unleashAPI("https://unleash.nais.io/api/")
            .build()
        DefaultUnleash(config)
    }
    LOKALT -> FakeUnleash().apply { enableAll() }
}
