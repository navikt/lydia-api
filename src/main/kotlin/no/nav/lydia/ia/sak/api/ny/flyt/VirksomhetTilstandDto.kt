package no.nav.lydia.ia.sak.api.ny.flyt

import kotlinx.serialization.Serializable

@Serializable
class VirksomhetTilstandDto(
    val tilstand: VirksomhetIATilstand,
)

enum class VirksomhetIATilstand {
    VirksomhetKlarTilVurdering,
    VirksomhetVurderes,
    VirksomhetErVurdert,
    VirksomhetHarAktiveSamarbeid,
    AlleSamarbeidIVirksomhetErAvsluttet,
}

fun Tilstand.tilVirksomhetTilstandDto() =
    VirksomhetTilstandDto(
        tilstand = VirksomhetIATilstand.valueOf(navn()),
    )
