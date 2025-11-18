package no.nav.lydia.ia.sak.api.ny.flyt

import no.nav.lydia.ia.sak.api.ny.flyt.Hendelse.AngreVurderVirksomhet
import no.nav.lydia.ia.sak.api.ny.flyt.Hendelse.FullførVurdering
import no.nav.lydia.ia.sak.api.ny.flyt.Hendelse.VurderVirksomhet
import no.nav.lydia.ia.sak.api.ny.flyt.Tilstand.VirksomhetErVurdert
import no.nav.lydia.ia.sak.api.ny.flyt.Tilstand.VirksomhetKlarTilVurdering
import no.nav.lydia.ia.sak.api.ny.flyt.Tilstand.VirksomhetVurderes
import java.util.UUID
import java.util.concurrent.atomic.AtomicReference

class Tilstandsmaskin(
    startTilstand: Tilstand = VirksomhetKlarTilVurdering
) {

    private val tilstandRef = AtomicReference<Tilstand>(startTilstand)

    var nåværendeTilstand: Tilstand
        get() = tilstandRef.get()
        set(value) = tilstandRef.set(value)

    fun prosessHendelse(hendelse: Hendelse): Tilstand {
        nåværendeTilstand = when (nåværendeTilstand) {
            // Her beskriver vi alle transisjoner
            VirksomhetKlarTilVurdering -> when (hendelse) {
                is VurderVirksomhet -> {
                    // Gjør noe med det
                    VirksomhetVurderes
                }

                // Uhåndterte hendelser føres til samme Tilstand
                else -> nåværendeTilstand
            }

            is VirksomhetVurderes -> when (hendelse) {
                is AngreVurderVirksomhet -> VirksomhetKlarTilVurdering
                is FullførVurdering -> VirksomhetErVurdert
                else -> nåværendeTilstand
            }

            else -> {}
        } as Tilstand
        println("Nåværrende tilstand: $nåværendeTilstand")
        return nåværendeTilstand
    }
}

sealed class Tilstand {
    fun navn(): String = this.javaClass.simpleName

    object VirksomhetKlarTilVurdering : Tilstand() // IKKE_AKTIV
    object VirksomhetVurderes : Tilstand() // VURDERES
    object VirksomhetErVurdert : Tilstand() // VURDERT
    object VirksomhetHarEttAktivtSamarbeid : Tilstand() // AKTIV

    //object VirksomhetHarFlereAktiveSamarbeid : Tilstand()
    object AlleSamarbeidIVirksomhetErAvsluttet : Tilstand() // AVSLUTTET
}

sealed class Hendelse {
    fun navn(): String = this.javaClass.simpleName

    data class VurderVirksomhet(val orgnr: String) : Hendelse()
    data class AngreVurderVirksomhet(val orgnr: String) : Hendelse()
    data class FullførVurdering(
        val orgnr: String,
        val årsak: String,
    ) : Hendelse()

    data class OpprettNyttSamarbeid(
        val orgnr: String,
    ) : Hendelse()

    data class OpprettPlanForSamarbeid(
        val orgnr: String,
        val samarbeidId: UUID,
    ) : Hendelse()

    data class FullførSamarbeid(
        val orgnr: String,
        val samarbeidId: UUID,
    ) : Hendelse()

    data class AvsluttSamarbeid(
        val orgnr: String,
        val samarbeidId: UUID,
    ) : Hendelse()

    data class GjenopprettSamarbeid(
        val orgnr: String,
        val samarbeidId: UUID,
    ) : Hendelse()

    data class GjørVirksomhetKlarTilNyVurdering(
        val orgnr: String,
    ) : Hendelse()

}
