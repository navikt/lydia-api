package no.nav.lydia.sykefraversstatistikk.api.geografi

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class Kommune(
    val navn: String,
    @SerialName("navnNorsk")
    val alternativtNavn: String? = null,
    val nummer: String
)