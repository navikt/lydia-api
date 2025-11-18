package no.nav.lydia.ia.sak.api.ny.flyt

import arrow.core.Either
import io.ktor.http.HttpStatusCode
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.IASamarbeidService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker
import java.util.UUID
import java.util.concurrent.atomic.AtomicReference

class TilstandsmaskinBuilder private constructor(
    private val fiaKontekst: FiaKontekst,
) {
    companion object {
        fun init(fiaKontekst: FiaKontekst): TilstandsmaskinBuilder = TilstandsmaskinBuilder(fiaKontekst)
    }

    fun utledFraTilstand(orgnr: String): Tilstandsmaskin {
        val tilstandTilVirksomhet = hentTilstandForVirksomhet(orgnr = orgnr)
        return Tilstandsmaskin(
            fraTilstand = tilstandTilVirksomhet,
            fiaKontekst = fiaKontekst,
        )
    }

    private fun hentTilstandForVirksomhet(orgnr: String): Tilstand =
        fiaKontekst.iaSakService.hentAktivSak(orgnummer = orgnr)?.let {
            val aktiveSamarbeid = fiaKontekst.iASamarbeidService.hentAktiveSamarbeid(it)

            when (it.status) {
                IASak.Status.NY,
                IASak.Status.IKKE_AKTIV,
                IASak.Status.IKKE_AKTUELL,
                IASak.Status.SLETTET,
                IASak.Status.FULLFØRT,
                -> Tilstand.VirksomhetKlarTilVurdering

                IASak.Status.VURDERES,
                -> Tilstand.VirksomhetVurderes

                IASak.Status.KONTAKTES,
                IASak.Status.KARTLEGGES,
                IASak.Status.VI_BISTÅR,
                -> if (aktiveSamarbeid.isNotEmpty()) {
                    Tilstand.VirksomhetHarEttAktivtSamarbeid
                } else {
                    Tilstand.VirksomhetKlarTilVurdering
                }
            }
        } ?: Tilstand.VirksomhetKlarTilVurdering
}

class Tilstandsmaskin(
    fraTilstand: Tilstand = Tilstand.VirksomhetKlarTilVurdering,
    private val fiaKontekst: FiaKontekst,
) {
    private val tilstandRef = AtomicReference<Tilstand>(fraTilstand)

    var nåværendeTilstand: Tilstand
        get() = tilstandRef.get()
        set(value) = tilstandRef.set(value)

    fun prosessHendelse(hendelse: Hendelse): Pair<Tilstand, Either<Feil, Any?>> {
        var resultatAvUtførtTransisjon: Pair<Tilstand, Either<Feil, Any?>> = when (nåværendeTilstand) {
            // Her beskriver vi alle transisjoner for hver tilstand

            // Tilstand: Virksomhet er klar til vurdering (IKKE_AKTIV)
            Tilstand.VirksomhetKlarTilVurdering -> when (hendelse) {
                is Hendelse.VurderVirksomhet -> {
                    return nåværendeTilstand.utførTransisjon(hendelse, fiaKontekst)
                }

                // Uhåndterte hendelser føres til samme Tilstand + Feil
                else -> {
                    Pair(
                        nåværendeTilstand,
                        Either.Left(
                            Feil("Something odd happened", HttpStatusCode.BadRequest),
                        ),
                    )
                }
                /*
                TODO: Bytt Pair med Konsekvens(val nyTilstand: Tilstand, endring: Either<Feil, Any?>)
                 * */
            }
            /*
            is VirksomhetVurderes -> when (hendelse) {
                is AngreVurderVirksomhet -> VirksomhetKlarTilVurdering
                is FullførVurdering -> VirksomhetErVurdert
                else -> nåværendeTilstand
            }*/

            // Tilstand: Alle de andre tilstandene som vi ikke håndterer enda
            else -> {
                Pair(
                    nåværendeTilstand,
                    Either.Left(
                        Feil("Something odd happened", HttpStatusCode.BadRequest),
                    ),
                )
            }
        }
        nåværendeTilstand = resultatAvUtførtTransisjon.first

        println("Nåværrende tilstand: $nåværendeTilstand")
        return resultatAvUtførtTransisjon
    }
}

sealed class Tilstand {
    fun navn(): String = this.javaClass.simpleName

    abstract fun utførTransisjon(
        hendelse: Hendelse,
        fiaKontekst: FiaKontekst,
    ): Pair<Tilstand, Either<Feil, Any?>>

    object VirksomhetKlarTilVurdering : Tilstand() { // IKKE_AKTIV
        override fun utførTransisjon(
            hendelse: Hendelse,
            fiaKontekst: FiaKontekst,
        ): Pair<Tilstand, Either<Feil, IASak>> {
            val resultat: Either<Feil, IASak> = when (hendelse) {
                is Hendelse.VurderVirksomhet -> {
                    fiaKontekst.iaSakService.opprettSakOgMerkSomVurdert(
                        orgnummer = hendelse.orgnr,
                        superbruker = hendelse.superbruker,
                        navEnhet = hendelse.navEnhet,
                    )
                }
                else -> {
                    Either.Left(Feil("Something odd happened", HttpStatusCode.BadRequest))
                }
            }

            return Pair(
                first = if (resultat.isRight()) VirksomhetVurderes else VirksomhetKlarTilVurdering,
                second = resultat,
            )
        }
    }

    object VirksomhetVurderes : Tilstand() { // VURDERES
        override fun utførTransisjon(
            hendelse: Hendelse,
            fiaKontekst: FiaKontekst,
        ): Pair<Tilstand, Either<Feil, Any?>> {
            TODO("Not yet implemented")
        }
    }

    object VirksomhetErVurdert : Tilstand() { // VURDERT
        override fun utførTransisjon(
            hendelse: Hendelse,
            fiaKontekst: FiaKontekst,
        ): Pair<Tilstand, Either<Feil, Any?>> {
            TODO("Not yet implemented")
        }
    }

    object VirksomhetHarEttAktivtSamarbeid : Tilstand() { // AKTIV
        override fun utførTransisjon(
            hendelse: Hendelse,
            fiaKontekst: FiaKontekst,
        ): Pair<Tilstand, Either<Feil, Any?>> {
            TODO("Not yet implemented")
        }
    }

    // object VirksomhetHarFlereAktiveSamarbeid : Tilstand()
    object AlleSamarbeidIVirksomhetErAvsluttet : Tilstand() { // AVSLUTTET
        override fun utførTransisjon(
            hendelse: Hendelse,
            fiaKontekst: FiaKontekst,
        ): Pair<Tilstand, Either<Feil, Any?>> {
            TODO("Not yet implemented")
        }
    }
}

sealed class Hendelse {
    fun navn(): String = this.javaClass.simpleName

    data class VurderVirksomhet(
        val orgnr: String,
        val superbruker: Superbruker,
        val navEnhet: NavEnhet,
    ) : Hendelse()

    data class AngreVurderVirksomhet(
        val orgnr: String,
    ) : Hendelse()

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

data class FiaKontekst(
    val iaSakService: IASakService,
    val iASamarbeidService: IASamarbeidService,
)
