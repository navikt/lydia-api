package no.nav.lydia.samarbeidsperiode

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import no.nav.lydia.prioritering.sykefraværsstatistikk.api.EierDTO

@Serializable
enum class SamarbeidshistorikkType {
    SAMARBEID_OPPRETTET,
    BEHOVSVURDERING_FULLFØRT,
    EVALUERING_FULLFØRT,
    SAMARBEIDSPLAN_OPPRETTET,
    SAMARBEIDSPLAN_SLETTET,
    SAMARBEID_FULLFØRT,
    SAMARBEID_AVBRUTT,
}

@Serializable
data class SamarbeidshistorikkRadDto(
    val hendelsestype: SamarbeidshistorikkType,
    val tidspunkt: LocalDateTime?,
    val aktor: EierDTO?,
)

data class SamarbeidshistorikkKandidat(
    val hendelsestype: SamarbeidshistorikkType,
    val tidspunkt: LocalDateTime?,
    val navIdent: String?,
)
