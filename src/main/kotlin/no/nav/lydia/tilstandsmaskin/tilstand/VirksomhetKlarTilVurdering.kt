package no.nav.lydia.tilstandsmaskin.tilstand

import arrow.core.Either
import arrow.core.left
import io.ktor.http.HttpStatusCode
import no.nav.lydia.felles.Feil
import no.nav.lydia.tilstandsmaskin.FiaKontekst
import no.nav.lydia.tilstandsmaskin.Konsekvens
import no.nav.lydia.tilstandsmaskin.hendelse.AngreVurderVirksomhet
import no.nav.lydia.tilstandsmaskin.hendelse.AvsluttSamarbeid
import no.nav.lydia.tilstandsmaskin.hendelse.AvsluttVurdering
import no.nav.lydia.tilstandsmaskin.hendelse.EndrePlanlagtDatoForNesteTilstand
import no.nav.lydia.tilstandsmaskin.hendelse.EndreSamarbeidsNavn
import no.nav.lydia.tilstandsmaskin.hendelse.EndreStatusPåUndertemaISamarbeidsplan
import no.nav.lydia.tilstandsmaskin.hendelse.FullførKartleggingForSamarbeid
import no.nav.lydia.tilstandsmaskin.hendelse.GjørVirksomhetKlarTilNyVurdering
import no.nav.lydia.tilstandsmaskin.hendelse.Hendelse
import no.nav.lydia.tilstandsmaskin.hendelse.OppdaterPlanForSamarbeid
import no.nav.lydia.tilstandsmaskin.hendelse.OppdaterTemaIPlanForSamarbeid
import no.nav.lydia.tilstandsmaskin.hendelse.OpprettKartleggingForSamarbeid
import no.nav.lydia.tilstandsmaskin.hendelse.OpprettNyttSamarbeid
import no.nav.lydia.tilstandsmaskin.hendelse.OpprettPlanForSamarbeid
import no.nav.lydia.tilstandsmaskin.hendelse.SlettKartleggingForSamarbeid
import no.nav.lydia.tilstandsmaskin.hendelse.SlettPlanForSamarbeid
import no.nav.lydia.tilstandsmaskin.hendelse.SlettSamarbeid
import no.nav.lydia.tilstandsmaskin.hendelse.StartKartleggingForSamarbeid
import no.nav.lydia.tilstandsmaskin.hendelse.VirksomhetErSlettetIBrreg
import no.nav.lydia.tilstandsmaskin.hendelse.VurderVirksomhet
import no.nav.lydia.tilstandsmaskin.sideeffect.VurderVirksomhetSideEffect
import no.nav.lydia.tilstandsmaskin.tilVirksomhetIATilstand

object VirksomhetKlarTilVurdering : Tilstand() { // IKKE_AKTIV
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

            is VirksomhetErSlettetIBrreg -> {
                with(fiaKontekst.nyFlytService) {
                    hendelse.sideEffect.apply().map { Konsekvens(nyTilstand = VirksomhetErSlettet, verdi = it) }
                }
            }

            is AngreVurderVirksomhet, is AvsluttSamarbeid, is AvsluttVurdering, is EndrePlanlagtDatoForNesteTilstand, is EndreSamarbeidsNavn,
            is EndreStatusPåUndertemaISamarbeidsplan, is FullførKartleggingForSamarbeid, is GjørVirksomhetKlarTilNyVurdering, is OppdaterPlanForSamarbeid,
            is OppdaterTemaIPlanForSamarbeid, is OpprettKartleggingForSamarbeid, is OpprettNyttSamarbeid, is OpprettPlanForSamarbeid,
            is SlettKartleggingForSamarbeid, is SlettPlanForSamarbeid, is SlettSamarbeid, is StartKartleggingForSamarbeid,
            -> {
                Feil(
                    "'${hendelse.navn()}' er ikke gjennomførbar for '${VirksomhetKlarTilVurdering.tilVirksomhetIATilstand()}'",
                    HttpStatusCode.BadRequest,
                ).left()
            }
        }
}
