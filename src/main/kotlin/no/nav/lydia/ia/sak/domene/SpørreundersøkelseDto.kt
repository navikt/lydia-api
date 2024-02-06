package no.nav.lydia.ia.sak.domene

import kotlinx.datetime.LocalDate
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.api.kartlegging.SpørsmålOgSvaralternativerDto

@Serializable
data class SpørreundersøkelseDto (
    val spørreundersøkelseId: String,
    val vertId: String,
    val status: KartleggingStatus,
    val type: String,
    val spørsmålOgSvaralternativer: List<SpørsmålOgSvaralternativerDto>,
    val avslutningsdato: LocalDate
)