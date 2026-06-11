package no.nav.lydia.tilstandsmaskin.tilstand

import arrow.core.Either
import io.ktor.http.HttpStatusCode
import no.nav.lydia.felles.Feil
import no.nav.lydia.samarbeidsperiode.IASak
import no.nav.lydia.tilstandsmaskin.FiaKontekst
import no.nav.lydia.tilstandsmaskin.Konsekvens
import no.nav.lydia.tilstandsmaskin.hendelse.EndrePlanlagtDatoForNesteTilstand
import no.nav.lydia.tilstandsmaskin.hendelse.GjørVirksomhetKlarTilNyVurdering
import no.nav.lydia.tilstandsmaskin.hendelse.Hendelse
import no.nav.lydia.tilstandsmaskin.hendelse.VurderVirksomhet
import no.nav.lydia.tilstandsmaskin.sideeffect.EndrePlanlagtDatoForNesteTilstandSideEffect
import no.nav.lydia.tilstandsmaskin.sideeffect.GjørVirksomhetKlarTilNyVurderingSideEffect
import no.nav.lydia.tilstandsmaskin.sideeffect.VurderVirksomhetSideEffect
import no.nav.lydia.tilstandsmaskin.tilVirksomhetIATilstand

object AlleSamarbeidIVirksomhetErAvsluttet : Tilstand() { // AVSLUTTET
    override fun utførTransisjon(
        hendelse: Hendelse,
        fiaKontekst: FiaKontekst,
    ): Either<Feil, Konsekvens> =
        when (hendelse) {
            is VurderVirksomhet -> {
                val sideEffect = VurderVirksomhetSideEffect(
                    orgnummer = hendelse.orgnr,
                    superbruker = hendelse.superbruker,
                    navEnhet = hendelse.navEnhet,
                    valgtÅrsak = hendelse.valgtÅrsak,
                )
                with(fiaKontekst.nyFlytService) {
                    sideEffect.apply().map {
                        Konsekvens(
                            nyTilstand = VirksomhetVurderes,
                            verdi = it,
                        )
                    }
                }
            }

            is GjørVirksomhetKlarTilNyVurdering -> {
                val sideEffect = GjørVirksomhetKlarTilNyVurderingSideEffect(
                    orgnummer = hendelse.orgnr,
                )
                with(fiaKontekst.nyFlytService) {
                    sideEffect.apply().map {
                        Konsekvens(
                            nyTilstand = VirksomhetKlarTilVurdering,
                            verdi = it,
                        )
                    }
                }
            }

            is EndrePlanlagtDatoForNesteTilstand -> {
                val sideEffect = EndrePlanlagtDatoForNesteTilstandSideEffect(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    nyPlanlagtDato = hendelse.nyPlanlagtDato,
                    resulterendeSakStatus = IASak.Status.AVSLUTTET,
                    saksbehandler = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                )
                with(receiver = fiaKontekst.nyFlytService) {
                    sideEffect.apply().map {
                        Konsekvens(
                            nyTilstand = AlleSamarbeidIVirksomhetErAvsluttet,
                            verdi = it,
                        )
                    }
                }
            }

            else -> {
                Either.Left(
                    Feil(
                        "'${hendelse.navn()}' er ikke gjennomførbar for '${AlleSamarbeidIVirksomhetErAvsluttet.tilVirksomhetIATilstand()}'",
                        HttpStatusCode.BadRequest,
                    ),
                )
            }
        }
}
