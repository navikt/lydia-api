package no.nav.lydia.tilstandsmaskin

import kotlinx.datetime.LocalDate
import kotlinx.serialization.Serializable
import no.nav.lydia.tilstandsmaskin.tilstand.AlleSamarbeidIVirksomhetErAvsluttet
import no.nav.lydia.tilstandsmaskin.tilstand.Tilstand
import no.nav.lydia.tilstandsmaskin.tilstand.VirksomhetErSlettet
import no.nav.lydia.tilstandsmaskin.tilstand.VirksomhetErVurdert
import no.nav.lydia.tilstandsmaskin.tilstand.VirksomhetHarAktiveSamarbeid
import no.nav.lydia.tilstandsmaskin.tilstand.VirksomhetKlarTilVurdering
import no.nav.lydia.tilstandsmaskin.tilstand.VirksomhetVurderes

@Serializable
class VirksomhetTilstandDto(
    val orgnr: String,
    val tilstand: VirksomhetIATilstand,
    val nesteTilstand: VirksomhetTilstandAutomatiskOppdateringDto? = null,
)

@Serializable
class VirksomhetTilstandAutomatiskOppdateringDto(
    val startTilstand: VirksomhetIATilstand,
    val planlagtHendelse: String,
    val nyTilstand: VirksomhetIATilstand,
    val planlagtDato: LocalDate,
)

enum class VirksomhetIATilstand {
    VirksomhetKlarTilVurdering,
    VirksomhetVurderes,
    VirksomhetErVurdert,
    VirksomhetHarAktiveSamarbeid,
    AlleSamarbeidIVirksomhetErAvsluttet,
    VirksomhetErSlettet,
}

fun Tilstand.tilVirksomhetIATilstand(): VirksomhetIATilstand = VirksomhetIATilstand.valueOf(navn())

fun VirksomhetIATilstand.tilTilstand(): Tilstand =
    when (this) {
        VirksomhetIATilstand.VirksomhetKlarTilVurdering -> VirksomhetKlarTilVurdering
        VirksomhetIATilstand.VirksomhetVurderes -> VirksomhetVurderes
        VirksomhetIATilstand.VirksomhetErVurdert -> VirksomhetErVurdert
        VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid -> VirksomhetHarAktiveSamarbeid
        VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet -> AlleSamarbeidIVirksomhetErAvsluttet
        VirksomhetIATilstand.VirksomhetErSlettet -> VirksomhetErSlettet
    }
