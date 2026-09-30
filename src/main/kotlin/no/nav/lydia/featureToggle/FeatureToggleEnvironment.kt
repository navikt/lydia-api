package no.nav.lydia.featureToggle

import no.nav.lydia.getEnvVar

/**
 * Leser feature-toggles dynamisk fra miljøvariabler på formen FEATURE_TOGGLE_<TOGGELNAVN>,
 * satt opp per miljø i .nais/dev.yaml og .nais/prod.yaml og injisert via .nais/nais.yaml.
 * Verdien er en kommaseparert liste, f.eks. "1456,0220".
 */
class FeatureToggleEnvironment {
    private val toggles: Map<String, Set<String>> = getEnvList("FEATURE_TOGGLE_NAMES")
        .associate { toggle -> toggle.removePrefix(PREFIX).lowercase() to getEnvList(toggle).toSet() }

    fun erSkruddPå(
        togglenavn: String,
        verdi: String,
    ): Boolean? = toggles[togglenavn]?.contains(verdi)

    fun hentVerdier(togglenavn: String): Set<String>? = toggles[togglenavn]

    private fun getEnvList(name: String) = getEnvVar(name, "").split(",").map { it.trim() }.filter { it.isNotBlank() }

    companion object {
        private const val PREFIX = "FEATURE_TOGGLE_"
    }
}
