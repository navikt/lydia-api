package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.tilstand

import arrow.core.Either
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.toJavaLocalDate
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.ny.flyt.FiaKontekst
import no.nav.lydia.ia.sak.api.ny.flyt.tilVirksomhetIATilstand
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.Konsekvens
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.AngreVurderVirksomhet
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.AvsluttVurdering
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.GjørVirksomhetKlarTilNyVurdering
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.Hendelse
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.OpprettNyttSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.VurderVirksomhet
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.sideeffect.AngreVurderVirksomhetSideEffect
import no.nav.lydia.ia.årsak.domene.ÅrsakType
import java.time.LocalDate

object VirksomhetVurderes : Tilstand() { // VURDERES
    override fun utførTransisjon(
        hendelse: Hendelse,
        fiaKontekst: FiaKontekst,
    ): Konsekvens =
        when (hendelse) {
            is AngreVurderVirksomhet -> {
                val sideEffect = AngreVurderVirksomhetSideEffect(
                    orgnummer = hendelse.orgnr,
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
                val endring = fiaKontekst.nyFlytService.avsluttVurderingAvVirksomhetUtenSamarbeid(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    årsak = hendelse.årsak,
                    saksbehandler = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                ).onRight { iASakDto ->
                    fiaKontekst.tilstandVirksomhetRepository.lagreEllerOppdaterVirksomhetTilstand(
                        orgnr = iASakDto.orgnr,
                        tilstand = VirksomhetErVurdert.tilVirksomhetIATilstand(),
                    )?.also {
                        val nyTilstand = when (hendelse.årsak.type) {
                            `ÅrsakType`.VIRKSOMHETEN_SKAL_VURDERES_SENERE -> VirksomhetVurderes.tilVirksomhetIATilstand()
                            else -> VirksomhetKlarTilVurdering.tilVirksomhetIATilstand()
                        }
                        val planlagtHendelse = when (hendelse.årsak.type) {
                            `ÅrsakType`.VIRKSOMHETEN_SKAL_VURDERES_SENERE -> VurderVirksomhet::class.simpleName!!
                            else -> `GjørVirksomhetKlarTilNyVurdering`::class.simpleName!!
                        }
                        fiaKontekst.tilstandVirksomhetRepository.opprettAutomatiskOppdatering(
                            orgnr = iASakDto.orgnr,
                            startTilstand = VirksomhetErVurdert.tilVirksomhetIATilstand(),
                            planlagtHendelse = planlagtHendelse,
                            nyTilstand = nyTilstand,
                            planlagtDato = if (hendelse.årsak.dato == null) {
                                LocalDate.now().plusDays(90)
                            } else {
                                hendelse.årsak.dato.toJavaLocalDate()
                            },
                        )
                    }
                }
                Konsekvens(
                    endring = endring,
                    nyTilstand = VirksomhetErVurdert,
                )
            }

            is OpprettNyttSamarbeid -> {
                val endring = fiaKontekst.nyFlytService.opprettNyttSamarbeid(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    navn = hendelse.samarbeidsnavn,
                    saksbehandler = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                )
                Konsekvens(
                    endring = endring,
                    nyTilstand = VirksomhetHarAktiveSamarbeid,
                )
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
