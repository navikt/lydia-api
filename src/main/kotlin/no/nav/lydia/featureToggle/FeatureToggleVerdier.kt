package no.nav.lydia.featureToggle

import kotlinx.serialization.Serializable

@Serializable
data class FeatureToggleVerdier(
    val verdier: Set<String>,
)
