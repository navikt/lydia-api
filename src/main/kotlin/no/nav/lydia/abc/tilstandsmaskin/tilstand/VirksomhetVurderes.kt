package no.nav.lydia.abc.tilstandsmaskin.tilstand

import arrow.core.Either
import io.ktor.http.HttpStatusCode
import no.nav.lydia.abc.felles.Feil
import no.nav.lydia.abc.tilstandsmaskin.FiaKontekst
import no.nav.lydia.abc.tilstandsmaskin.Konsekvens
import no.nav.lydia.abc.tilstandsmaskin.hendelse.AngreVurderVirksomhet
import no.nav.lydia.abc.tilstandsmaskin.hendelse.AvsluttVurdering
import no.nav.lydia.abc.tilstandsmaskin.hendelse.Hendelse
import no.nav.lydia.abc.tilstandsmaskin.hendelse.OpprettNyttSamarbeid
import no.nav.lydia.abc.tilstandsmaskin.sideeffect.AngreVurderVirksomhetSideEffect
import no.nav.lydia.abc.tilstandsmaskin.sideeffect.AvsluttVurderingSideEffect
import no.nav.lydia.abc.tilstandsmaskin.sideeffect.OpprettSamarbeidSideEffect
import no.nav.lydia.abc.tilstandsmaskin.tilVirksomhetIATilstand

object VirksomhetVurderes : Tilstand() { // VURDERES
    override fun utførTransisjon(
        hendelse: Hendelse,
        fiaKontekst: FiaKontekst,
    ): Konsekvens =
        when (hendelse) {
            is AngreVurderVirksomhet -> {
                val sideEffect = AngreVurderVirksomhetSideEffect(
                    orgnummer = hendelse.orgnr,
                    superbruker = hendelse.superbruker,
                    navEnhet = hendelse.navEnhet,
                )
                with(fiaKontekst.nyFlytService) {
                    val resultat = sideEffect.apply()
                    Konsekvens(
                        nyTilstand = if (resultat.isRight()) VirksomhetKlarTilVurdering else VirksomhetVurderes,
                        endring = resultat,
                    )
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
                    val resultat = sideEffect.apply()
                    Konsekvens(
                        nyTilstand = VirksomhetErVurdert,
                        endring = resultat,
                    )
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
                    val resultat = sideEffect.apply()
                    Konsekvens(
                        nyTilstand = if (resultat.isRight()) VirksomhetHarAktiveSamarbeid else VirksomhetVurderes,
                        endring = resultat,
                    )
                }
            }

            else -> {
                val endring = Either.Left(
                    Feil("'${hendelse.navn()}' er ikke gjennomførbar for '${VirksomhetVurderes.tilVirksomhetIATilstand()}'", HttpStatusCode.BadRequest),
                )
                Konsekvens(
                    endring = endring,
                    nyTilstand = VirksomhetVurderes,
                )
            }
        }
}
