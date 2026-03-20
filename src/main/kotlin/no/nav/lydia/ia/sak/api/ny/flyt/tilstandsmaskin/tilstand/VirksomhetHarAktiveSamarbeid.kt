package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.tilstand

import arrow.core.Either
import io.ktor.http.HttpStatusCode
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringDto.Companion.tilDokumentTilPubliseringType
import no.nav.lydia.ia.sak.api.ny.flyt.FiaKontekst
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.Konsekvens
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.TilstandsmaskinBuilder
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.AvsluttSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.EndreSamarbeidsNavn
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.FullførKartleggingForSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.Hendelse
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.OpprettKartleggingForSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.OpprettNyttSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.OpprettPlanForSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.SlettKartleggingForSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.SlettPlanForSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.SlettSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.StartKartleggingForSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.sideeffect.OpprettSamarbeidSideEffect
import no.nav.lydia.ia.sak.api.spørreundersøkelse.tilDto

// -- Virksomheten har minst ett aktivt samarbeid med en aktiv samarbeidsplan
object VirksomhetHarAktiveSamarbeid : Tilstand() { // AKTIV
    override fun utførTransisjon(
        hendelse: Hendelse,
        fiaKontekst: FiaKontekst,
    ): Konsekvens =
        when (hendelse) {
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

            is OpprettKartleggingForSamarbeid -> {
                val endring = fiaKontekst.nyFlytService.opprettNyKartlegging(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    samarbeidId = hendelse.samarbeidId,
                    type = hendelse.type,
                    saksbehandler = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                ).map {
                    it.tilDto(
                        fiaKontekst.dokumentPubliseringService.hentPubliseringStatus(
                            referanseId = it.id,
                            type = it.type.name.tilDokumentTilPubliseringType(),
                        ),
                    )
                }
                Konsekvens(
                    endring = endring,
                    nyTilstand = VirksomhetHarAktiveSamarbeid,
                )
            }

            is StartKartleggingForSamarbeid -> {
                val endring = fiaKontekst.nyFlytService.startNyKartlegging(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    spørreundersøkelseId = hendelse.spørreundersøkelseId,
                    saksbehandler = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                ).map {
                    it.tilDto(
                        fiaKontekst.dokumentPubliseringService.hentPubliseringStatus(
                            referanseId = it.id,
                            type = it.type.name.tilDokumentTilPubliseringType(),
                        ),
                    )
                }
                Konsekvens(
                    endring = endring,
                    nyTilstand = VirksomhetHarAktiveSamarbeid,
                )
            }

            is `FullførKartleggingForSamarbeid` -> {
                val endring = fiaKontekst.nyFlytService.fullførNyKartlegging(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    spørreundersøkelseId = hendelse.spørreundersøkelseId,
                    saksbehandler = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                ).map {
                    it.tilDto(
                        fiaKontekst.dokumentPubliseringService.hentPubliseringStatus(
                            referanseId = it.id,
                            type = it.type.name.tilDokumentTilPubliseringType(),
                        ),
                    )
                }
                Konsekvens(
                    endring = endring,
                    nyTilstand = VirksomhetHarAktiveSamarbeid,
                )
            }

            is SlettKartleggingForSamarbeid -> {
                val endring = fiaKontekst.nyFlytService.slettNyKartlegging(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    spørreundersøkelseId = hendelse.spørreundersøkelseId,
                    saksbehandler = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                ).map {
                    it.tilDto(
                        fiaKontekst.dokumentPubliseringService.hentPubliseringStatus(
                            referanseId = it.id,
                            type = it.type.name.tilDokumentTilPubliseringType(),
                        ),
                    )
                }
                Konsekvens(
                    endring = endring,
                    nyTilstand = VirksomhetHarAktiveSamarbeid,
                )
            }

            is OpprettPlanForSamarbeid -> {
                val endring = fiaKontekst.nyFlytService.opprettNySamarbeidsplan(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    samarbeidId = hendelse.samarbeidId,
                    plan = hendelse.plan,
                    saksbehandler = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                )
                Konsekvens(
                    endring = endring,
                    nyTilstand = VirksomhetHarAktiveSamarbeid,
                )
            }

            is SlettPlanForSamarbeid -> {
                val endring = fiaKontekst.nyFlytService.slettSamarbeidsplan(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    samarbeidId = hendelse.samarbeidId,
                    saksbehandler = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                )
                Konsekvens(
                    endring = endring,
                    nyTilstand = VirksomhetHarAktiveSamarbeid,
                )
            }

            is SlettSamarbeid -> {
                val endring = fiaKontekst.nyFlytService.slettSamarbeid(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    samarbeidId = hendelse.samarbeidId,
                    saksbehandler = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                )

                val harAktiveSamarbeid = TilstandsmaskinBuilder.harAktiveSamarbeid(
                    fiaKontekst = fiaKontekst,
                    saksnummer = fiaKontekst.saksnummer,
                )
                val harSamarbeidOgAlleErAvsluttet = TilstandsmaskinBuilder.harSamarbeidOgAlleErAvsluttet(
                    fiaKontekst = fiaKontekst,
                    saksnummer = fiaKontekst.saksnummer,
                )

                if (harSamarbeidOgAlleErAvsluttet && endring.isRight()) {
                    TilstandsmaskinBuilder.oppdaterTilAlleSamarbeidAvsluttetMedAutomatiskOppdatering(
                        orgnr = hendelse.orgnr,
                        fiaKontekst = fiaKontekst,
                    )
                }

                Konsekvens(
                    endring = endring,
                    nyTilstand = when {
                        harAktiveSamarbeid -> VirksomhetHarAktiveSamarbeid
                        harSamarbeidOgAlleErAvsluttet -> AlleSamarbeidIVirksomhetErAvsluttet
                        else -> VirksomhetVurderes
                    },
                )
            }

            is AvsluttSamarbeid -> {
                val endring = fiaKontekst.nyFlytService.avsluttSamarbeid(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    samarbeidId = hendelse.samarbeidId,
                    typeAvslutning = hendelse.typeAvslutning,
                    saksbehandler = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                )
                // Når hendelsen mottas, har vi minst ett aktivt samarbeid, men nå som endringen er påført må vi sjekke det igjen
                val harIkkeLengerAktiveSamarbeid = !TilstandsmaskinBuilder.harAktiveSamarbeid(
                    fiaKontekst = fiaKontekst,
                    saksnummer = fiaKontekst.saksnummer,
                )

                if (harIkkeLengerAktiveSamarbeid && endring.isRight()) {
                    TilstandsmaskinBuilder.oppdaterTilAlleSamarbeidAvsluttetMedAutomatiskOppdatering(
                        orgnr = hendelse.orgnr,
                        fiaKontekst = fiaKontekst,
                    )
                }

                Konsekvens(
                    endring = endring,
                    nyTilstand = if (harIkkeLengerAktiveSamarbeid) AlleSamarbeidIVirksomhetErAvsluttet else VirksomhetHarAktiveSamarbeid,
                )
            }

            is EndreSamarbeidsNavn -> {
                val endring = fiaKontekst.nyFlytService.endreSamarbeidsNavn(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    samarbeidId = hendelse.samarbeidId,
                    nyttNavn = hendelse.navn,
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
