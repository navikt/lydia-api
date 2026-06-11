package no.nav.lydia.tilstandsmaskin.tilstand

import arrow.core.Either
import io.ktor.http.HttpStatusCode
import no.nav.lydia.felles.Feil
import no.nav.lydia.tilstandsmaskin.FiaKontekst
import no.nav.lydia.tilstandsmaskin.Konsekvens
import no.nav.lydia.tilstandsmaskin.hendelse.AngreVurderVirksomhet
import no.nav.lydia.tilstandsmaskin.hendelse.AvsluttVurdering
import no.nav.lydia.tilstandsmaskin.hendelse.Hendelse
import no.nav.lydia.tilstandsmaskin.hendelse.OpprettNyttSamarbeid
import no.nav.lydia.tilstandsmaskin.sideeffect.AngreVurderVirksomhetSideEffect
import no.nav.lydia.tilstandsmaskin.sideeffect.AvsluttVurderingSideEffect
import no.nav.lydia.tilstandsmaskin.sideeffect.OpprettSamarbeidSideEffect
import no.nav.lydia.tilstandsmaskin.tilVirksomhetIATilstand

object VirksomhetVurderes : Tilstand() { // VURDERES
    override fun utførTransisjon(
        hendelse: Hendelse,
        fiaKontekst: FiaKontekst,
    ): Either<Feil, Konsekvens> =
        when (hendelse) {
            is AngreVurderVirksomhet -> {
                val sideEffect = AngreVurderVirksomhetSideEffect(
                    orgnummer = hendelse.orgnr,
                    superbruker = hendelse.superbruker,
                    navEnhet = hendelse.navEnhet,
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

            is AvsluttVurdering -> {
                val sideEffect = AvsluttVurderingSideEffect(
                    orgnummer = hendelse.orgnr,
                    årsak = hendelse.årsak,
                    navAnsatt = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                )
                with(receiver = fiaKontekst.nyFlytService) {
                    sideEffect.apply().map {
                        Konsekvens(
                            nyTilstand = VirksomhetErVurdert,
                            verdi = it,
                        )
                    }
                }
            }

            is OpprettNyttSamarbeid -> {
                val sideEffect = OpprettSamarbeidSideEffect(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    samarbeidsNavn = hendelse.samarbeidsnavn,
                    saksbehandler = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                )
                with(fiaKontekst.nyFlytService) {
                    sideEffect.apply().map {
                        Konsekvens(
                            nyTilstand = VirksomhetHarAktiveSamarbeid,
                            verdi = it,
                        )
                    }
                }
            }

            else -> {
                Either.Left(
                    Feil("'${hendelse.navn()}' er ikke gjennomførbar for '${VirksomhetVurderes.tilVirksomhetIATilstand()}'", HttpStatusCode.BadRequest),
                )
            }
        }
}
