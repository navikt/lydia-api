package no.nav.lydia

import io.getunleash.DefaultUnleash
import io.getunleash.FakeUnleash
import io.getunleash.Unleash
import io.getunleash.util.UnleashConfig


object UnleashKlient {
    private val unleash: Unleash

    init {
        val miljø = getEnvVar(varName = "NAIS_CLUSTER_NAME", defaultValue = "lokal")
        unleash = when (miljø) {
            "prod-gcp", "dev-gcp" -> DefaultUnleash(
                UnleashConfig.builder()
                    .appName(NaisEnvironment.APP_NAVN)
                    .instanceId(NaisEnvironment.APP_NAVN + "_" + miljø)
                    .unleashAPI("https://unleash.nais.io/api/")
                    .build()
            )
            else -> FakeUnleash()
        }
    }

    fun isEnabled(toggleKey: String) = unleash.isEnabled(toggleKey, false)
    fun skruPåToggle(toggleKey: String) = (unleash as FakeUnleash).enable(toggleKey)
    fun skruAvToggle(toggleKey: String) = (unleash as FakeUnleash).disable(toggleKey)
}

object UnleashToggleKeys {
    const val nyeStatuserToggle = "pia.nye-statuser"
}

fun skalBrukeNyeStatuser() = UnleashKlient.isEnabled(UnleashToggleKeys.nyeStatuserToggle)
