package no.nav.lydia.ia.sak.api.ny.flyt

import kotlinx.datetime.LocalDate
import kotlinx.serialization.Serializable

@Serializable
class VirksomhetTilstandDto(
    val tilstand: VirksomhetIATilstand,
    val nesteTilstand: VirksomhetTilstandAutomatiskOppdateringDto? = null,
)

@Serializable
class VirksomhetTilstandAutomatiskOppdateringDto(
    val nyTilstand: VirksomhetIATilstand,
    val planlagtDato: LocalDate,
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

fun Tilstand.tilVirksomhetIATilstand(): VirksomhetIATilstand = VirksomhetIATilstand.valueOf(navn())

fun VirksomhetIATilstand.tilTilstand(): Tilstand =
    when (this) {
        VirksomhetIATilstand.VirksomhetKlarTilVurdering -> Tilstand.VirksomhetKlarTilVurdering
        VirksomhetIATilstand.VirksomhetVurderes -> Tilstand.VirksomhetVurderes
        VirksomhetIATilstand.VirksomhetErVurdert -> Tilstand.VirksomhetErVurdert
        VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid -> Tilstand.VirksomhetHarAktiveSamarbeid
        VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet -> Tilstand.AlleSamarbeidIVirksomhetErAvsluttet
    }
