package no.nav.lydia.ia.sak.api.ny.flyt

import kotlinx.datetime.LocalDate
import kotlinx.serialization.Serializable
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.tilstand.AlleSamarbeidIVirksomhetErAvsluttet
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.tilstand.Tilstand
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.tilstand.VirksomhetErVurdert
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.tilstand.VirksomhetHarAktiveSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.tilstand.VirksomhetKlarTilVurdering
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.tilstand.VirksomhetVurderes

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
}

fun Tilstand.tilVirksomhetIATilstand(): VirksomhetIATilstand = VirksomhetIATilstand.valueOf(navn())

fun VirksomhetIATilstand.tilTilstand(): Tilstand =
    when (this) {
        VirksomhetIATilstand.VirksomhetKlarTilVurdering -> VirksomhetKlarTilVurdering
        VirksomhetIATilstand.VirksomhetVurderes -> VirksomhetVurderes
        VirksomhetIATilstand.VirksomhetErVurdert -> VirksomhetErVurdert
        VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid -> VirksomhetHarAktiveSamarbeid
        VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet -> AlleSamarbeidIVirksomhetErAvsluttet
    }
