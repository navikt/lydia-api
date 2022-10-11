package no.nav.lydia

import io.getunleash.DefaultUnleash
import io.getunleash.FakeUnleash
import io.getunleash.Unleash
import io.getunleash.strategy.Strategy
import io.getunleash.util.UnleashConfig
import no.nav.lydia.NaisEnvironment.Companion.Environment.`DEV-GCP`
import no.nav.lydia.NaisEnvironment.Companion.Environment.`PROD-GCP`
import no.nav.lydia.NaisEnvironment.Companion.hentMiljø


object UnleashKlient {
    private val unleash: Unleash

    init {
        val miljø = hentMiljø(getEnvVar(varName = "NAIS_CLUSTER_NAME", defaultValue = "lokal"))
        unleash = when (miljø) {
            `PROD-GCP`, `DEV-GCP` -> DefaultUnleash(
                UnleashConfig.builder()
                    .appName(NaisEnvironment.APP_NAVN)
                    .instanceId(NaisEnvironment.APP_NAVN + "_" + miljø)
                    .unleashAPI("https://unleash.nais.io/api/")
                    .build(), ClusterStrategy(miljø)
            )
            else -> FakeUnleash()
        }
    }

    fun isEnabled(toggleKey: String) = unleash.isEnabled(toggleKey, false)
    fun skruPå(toggleKey: String) = (unleash as FakeUnleash).enable(toggleKey)
    fun skruAv(toggleKey: String) = (unleash as FakeUnleash).disable(toggleKey)

    inline fun skalSjekkeFrist() = isEnabled(UnleashToggleKeys.fristTilbakeknapp)
}

object UnleashToggleKeys {
    val fristTilbakeknapp = "pia.frist-tilbakeknapp"
}

class ClusterStrategy(val miljø: NaisEnvironment.Companion.Environment) : Strategy {
    override fun getName() = "byCluster"

    override fun isEnabled(parameters: MutableMap<String, String>): Boolean {
        val clustersParameter = parameters["cluster"] ?: return false
        val alleClustere = clustersParameter.split(",").map { it.trim() }.map { it.lowercase() }.toList()
        return alleClustere.contains(miljø.name.lowercase())
    }
}

