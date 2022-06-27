package no.nav.lydia

import io.getunleash.DefaultUnleash
import io.getunleash.FakeUnleash
import io.getunleash.Unleash
import io.getunleash.util.UnleashConfig
import no.nav.lydia.NaisEnvironment.Companion.Environment
import no.nav.lydia.NaisEnvironment.Companion.Environment.*


object UnleashKlient {
    private lateinit var unleash: Unleash

    fun init(miljø : Environment) = when(miljø) {
        PROD_GCP, DEV_GCP -> {
            val config: UnleashConfig = UnleashConfig.builder()
                .appName(NaisEnvironment.APP_NAVN)
                .instanceId(NaisEnvironment.APP_NAVN + "_" + miljø.name)
                .unleashAPI("https://unleash.nais.io/api/")
                .build()
            this.unleash = DefaultUnleash(config)
        }
        LOKALT -> this.unleash = FakeUnleash().also { it.enable(UnleashToggleKeys.testToggle) }
    }

    fun isEnabled(toggleKey: String) = unleash.isEnabled(toggleKey, false)
    fun skruPåToggle(toggleKey: String) = (unleash as FakeUnleash).enable(toggleKey)
    fun skruAvToggle(toggleKey: String) = (unleash as FakeUnleash).disable(toggleKey)
}

object UnleashToggleKeys {
    const val testToggle = "pia.tester-unleash"
    const val nyeStatuserToggle = "pia.nye-statuser"
}

fun skalBrukeNyeStatuser() = UnleashKlient.isEnabled(UnleashToggleKeys.nyeStatuserToggle)
