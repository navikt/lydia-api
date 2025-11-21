package no.nav.lydia.ia.sak.api.ny.flyt

import arrow.core.Either
import io.ktor.http.HttpStatusCode
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.IASamarbeidService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.domene.IASak.Status
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker
import java.util.UUID
import java.util.concurrent.atomic.AtomicReference

class TilstandsmaskinBuilder private constructor(
    private val fiaKontekst: FiaKontekst,
) {
    companion object {
        fun medKontekst(fiaKontekst: FiaKontekst): TilstandsmaskinBuilder = TilstandsmaskinBuilder(fiaKontekst)
    }

    fun build(orgnr: String): Tilstandsmaskin {
        val tilstandTilVirksomhet = hentTilstandForVirksomhet(orgnr = orgnr)
        return Tilstandsmaskin(
            startTilstand = tilstandTilVirksomhet,
            fiaKontekst = fiaKontekst,
        )
    }

    private fun hentTilstandForVirksomhet(orgnr: String): Tilstand =
        fiaKontekst.nyFlytService.hentAktivIASakDto(orgnummer = orgnr)?.let { iASakDto ->
            val aktiveSamarbeid = fiaKontekst.iASamarbeidService.hentAktiveSamarbeid(iASakDto.saksnummer)

            when (iASakDto.status) {
                Status.NY,
                Status.IKKE_AKTIV,
                Status.IKKE_AKTUELL,
                Status.SLETTET,
                Status.FULLFØRT,
                -> Tilstand.VirksomhetKlarTilVurdering

                Status.VURDERES,
                -> Tilstand.VirksomhetVurderes

                Status.VURDERT,
                -> Tilstand.VirksomhetErVurdert

                Status.KONTAKTES,
                Status.KARTLEGGES,
                Status.VI_BISTÅR,
                -> if (aktiveSamarbeid.isNotEmpty()) {
                    Tilstand.VirksomhetHarEttAktivtSamarbeid
                } else {
                    Tilstand.VirksomhetKlarTilVurdering
                }
            }
        } ?: Tilstand.VirksomhetKlarTilVurdering
}

class Tilstandsmaskin(
    startTilstand: Tilstand = Tilstand.VirksomhetKlarTilVurdering,
    private val fiaKontekst: FiaKontekst,
) {
    private val tilstandRef = AtomicReference(startTilstand)

    var nåværendeTilstand: Tilstand
        get() = tilstandRef.get()
        set(value) = tilstandRef.set(value)

    fun prosesserHendelse(hendelse: Hendelse): Konsekvens {
        val konsekvensAvUtførtTransisjon: Konsekvens = nåværendeTilstand.utførTransisjon(hendelse, fiaKontekst)
        nåværendeTilstand = konsekvensAvUtførtTransisjon.nyTilstand
        return konsekvensAvUtførtTransisjon
    }
}

data class Konsekvens(
    val nyTilstand: Tilstand,
    val endring: Either<Feil, Any?>,
)

sealed class Tilstand {
    fun navn(): String = this.javaClass.simpleName

    abstract fun utførTransisjon(
        hendelse: Hendelse,
        fiaKontekst: FiaKontekst,
    ): Konsekvens

    object VirksomhetKlarTilVurdering : Tilstand() { // IKKE_AKTIV
        override fun utførTransisjon(
            hendelse: Hendelse,
            fiaKontekst: FiaKontekst,
        ): Konsekvens {
            val endring: Either<Feil, IASakDto> = when (hendelse) {
                is Hendelse.VurderVirksomhet -> {
                    // TODO: lag en nyFlytService.opprettSakOgMerkSomVurdert()
                    fiaKontekst.nyFlytService.opprettSakOgMerkSomVurdert(
                        orgnummer = hendelse.orgnr,
                        superbruker = hendelse.superbruker,
                        navEnhet = hendelse.navEnhet,
                    )
                }
                else -> {
                    Either.Left(Feil("Something odd happened", HttpStatusCode.BadRequest))
                }
            }

            return Konsekvens(
                nyTilstand = if (endring.isRight()) VirksomhetVurderes else VirksomhetKlarTilVurdering,
                endring = endring,
            )
        }
    }

    object VirksomhetVurderes : Tilstand() { // VURDERES
        override fun utførTransisjon(
            hendelse: Hendelse,
            fiaKontekst: FiaKontekst,
        ): Konsekvens {
            val endring = when (hendelse) {
                is Hendelse.AngreVurderVirksomhet -> {
                    val sakDto = fiaKontekst.nyFlytService.hentAktivIASakDto(orgnummer = hendelse.orgnr)!!
                    fiaKontekst.nyFlytService.slettSak(sakDto)
                }
                is Hendelse.FullførVurdering -> {
                    fiaKontekst.nyFlytService.fullførVurderingAvVirksomhetUtenSamarbeid(
                        orgnummer = hendelse.orgnr,
                        årsak = hendelse.årsak,
                        saksbehandler = hendelse.saksbehandler,
                        navEnhet = hendelse.navEnhet,
                    )
                }
                else -> {
                    Either.Left(Feil("Something odd happened", HttpStatusCode.BadRequest))
                }
            }
            return Konsekvens(
                nyTilstand = VirksomhetKlarTilVurdering,
                endring = endring,
            )
        }
    }

    object VirksomhetErVurdert : Tilstand() { // VURDERT
        override fun utførTransisjon(
            hendelse: Hendelse,
            fiaKontekst: FiaKontekst,
        ): Konsekvens {
            TODO("Not yet implemented")
        }
    }

    object VirksomhetHarEttAktivtSamarbeid : Tilstand() { // AKTIV
        override fun utførTransisjon(
            hendelse: Hendelse,
            fiaKontekst: FiaKontekst,
        ): Konsekvens {
            TODO("Not yet implemented")
        }
    }

    // object VirksomhetHarFlereAktiveSamarbeid : Tilstand()
    object AlleSamarbeidIVirksomhetErAvsluttet : Tilstand() { // AVSLUTTET
        override fun utførTransisjon(
            hendelse: Hendelse,
            fiaKontekst: FiaKontekst,
        ): Konsekvens {
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
        val årsak: ValgtÅrsak,
        val saksbehandler: NavAnsattMedSaksbehandlerRolle,
        val navEnhet: NavEnhet,
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
    val nyFlytService: NyFlytService,
)
