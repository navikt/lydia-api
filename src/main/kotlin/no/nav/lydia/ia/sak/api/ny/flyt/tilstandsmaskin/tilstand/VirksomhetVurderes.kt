package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.tilstand

import arrow.core.Either
import io.ktor.http.HttpStatusCode
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.ny.flyt.FiaKontekst
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.Konsekvens
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.AngreVurderVirksomhet
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.AvsluttVurdering
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.Hendelse
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.OpprettNyttSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.sideeffect.AngreVurderVirksomhetSideEffect
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.sideeffect.AvsluttVurderingSideEffect
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.sideeffect.OpprettSamarbeidSideEffect

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
                        sideEffect = sideEffect,
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
                        sideEffect = sideEffect,
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
                        sideEffect = sideEffect,
                    )
                }
            }

            else -> {
                val endring = Either.Left(Feil("Something odd happened", HttpStatusCode.BadRequest))
                Konsekvens(
                    endring = endring,
                    nyTilstand = VirksomhetVurderes,
                )
            }
        }
}
