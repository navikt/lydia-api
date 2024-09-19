package no.nav.lydia.ia.sak.api

import kotlinx.serialization.Serializable

@Serializable
data class ÅrsakTilAtSakIkkeKanAvsluttes(
    val samarbeidsId: Int,
    val samarbeidsNavn: String,
    val type: ÅrsaksType,
    val id: String
)


enum class ÅrsaksType {
    BEHOVSVURDERING_IKKE_FULLFØRT,
    INGEN_FULLFØRT_BEHOVSVURDERING,
    SAMARBEIDSPLAN_IKKE_FULLFØRT,
    INGEN_FULLFØRT_SAMARBEIDSPLAN,
}

@Serializable
data class SaksStatusDto(
    val kanFullføres: Boolean,
    val årsaker: List<ÅrsakTilAtSakIkkeKanAvsluttes>
)
