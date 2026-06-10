package no.nav.lydia.tilstandsmaskin.tilstand

import arrow.core.Either
import io.ktor.http.HttpStatusCode
import no.nav.lydia.dokumentpublisering.DokumentPubliseringDto.Companion.tilDokumentTilPubliseringType
import no.nav.lydia.felles.Feil
import no.nav.lydia.kartlegging.tilDto
import no.nav.lydia.tilstandsmaskin.FiaKontekst
import no.nav.lydia.tilstandsmaskin.Konsekvens
import no.nav.lydia.tilstandsmaskin.TilstandsmaskinBuilder
import no.nav.lydia.tilstandsmaskin.hendelse.AvsluttSamarbeid
import no.nav.lydia.tilstandsmaskin.hendelse.EndreSamarbeidsNavn
import no.nav.lydia.tilstandsmaskin.hendelse.EndreStatusPåUndertemaISamarbeidsplan
import no.nav.lydia.tilstandsmaskin.hendelse.FullførKartleggingForSamarbeid
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
import no.nav.lydia.tilstandsmaskin.sideeffect.AvsluttSamarbeidSideEffect
import no.nav.lydia.tilstandsmaskin.sideeffect.EndreSamarbeidsnavnSideEffect
import no.nav.lydia.tilstandsmaskin.sideeffect.EndreStatusPåUndertemaISamarbeidsplanSideEffect
import no.nav.lydia.tilstandsmaskin.sideeffect.FullførKartleggingSideEffect
import no.nav.lydia.tilstandsmaskin.sideeffect.OppdaterPlanForSamarbeidSideEffect
import no.nav.lydia.tilstandsmaskin.sideeffect.OppdaterTemaIPlanForSamarbeidSideEffect
import no.nav.lydia.tilstandsmaskin.sideeffect.OpprettKartleggingSideEffect
import no.nav.lydia.tilstandsmaskin.sideeffect.OpprettPlanForSamarbeidSideEffect
import no.nav.lydia.tilstandsmaskin.sideeffect.OpprettSamarbeidSideEffect
import no.nav.lydia.tilstandsmaskin.sideeffect.SlettKartleggingSideEffect
import no.nav.lydia.tilstandsmaskin.sideeffect.SlettPlanForSamarbeidSideEffect
import no.nav.lydia.tilstandsmaskin.sideeffect.SlettSamarbeidSideEffect
import no.nav.lydia.tilstandsmaskin.sideeffect.StartKartleggingSideEffect
import no.nav.lydia.tilstandsmaskin.tilVirksomhetIATilstand

// -- Virksomheten har minst ett aktivt samarbeid
object VirksomhetHarAktiveSamarbeid : Tilstand() { // AKTIV
    override fun utførTransisjon(
        hendelse: Hendelse,
        fiaKontekst: FiaKontekst,
    ): Either<Feil, Konsekvens> =
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
                    sideEffect.apply().map {
                        Konsekvens(
                            nyTilstand = VirksomhetHarAktiveSamarbeid,
                            endring = it,
                        )
                    }
                }
            }

            is OpprettKartleggingForSamarbeid -> {
                val sideEffect = OpprettKartleggingSideEffect(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    samarbeidId = hendelse.samarbeidId,
                    type = hendelse.type,
                    saksbehandler = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                )
                with(fiaKontekst.nyFlytService) {
                    sideEffect.apply().map {
                        Konsekvens(
                            nyTilstand = VirksomhetHarAktiveSamarbeid,
                            endring = it.tilDto(
                                fiaKontekst.dokumentPubliseringService.hentPubliseringStatus(
                                    referanseId = it.id,
                                    type = it.type.name.tilDokumentTilPubliseringType(),
                                ),
                            ),
                        )
                    }
                }
            }

            is StartKartleggingForSamarbeid -> {
                val sideEffect = StartKartleggingSideEffect(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    spørreundersøkelseId = hendelse.spørreundersøkelseId,
                    saksbehandler = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                )
                with(fiaKontekst.nyFlytService) {
                    sideEffect.apply().map {
                        Konsekvens(
                            nyTilstand = VirksomhetHarAktiveSamarbeid,
                            endring =
                                it.tilDto(
                                    fiaKontekst.dokumentPubliseringService.hentPubliseringStatus(
                                        referanseId = it.id,
                                        type = it.type.name.tilDokumentTilPubliseringType(),
                                    ),
                                ),
                        )
                    }
                }
            }

            is FullførKartleggingForSamarbeid -> {
                val sideEffect = FullførKartleggingSideEffect(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    spørreundersøkelseId = hendelse.spørreundersøkelseId,
                    saksbehandler = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                )
                with(fiaKontekst.nyFlytService) {
                    sideEffect.apply().map {
                        Konsekvens(
                            nyTilstand = VirksomhetHarAktiveSamarbeid,
                            endring =
                                it.tilDto(
                                    fiaKontekst.dokumentPubliseringService.hentPubliseringStatus(
                                        referanseId = it.id,
                                        type = it.type.name.tilDokumentTilPubliseringType(),
                                    ),
                                ),
                        )
                    }
                }
            }

            is SlettKartleggingForSamarbeid -> {
                val sideEffect = SlettKartleggingSideEffect(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    spørreundersøkelseId = hendelse.spørreundersøkelseId,
                    saksbehandler = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                )
                with(fiaKontekst.nyFlytService) {
                    sideEffect.apply().map {
                        Konsekvens(
                            nyTilstand = VirksomhetHarAktiveSamarbeid,
                            endring =
                                it.tilDto(
                                    fiaKontekst.dokumentPubliseringService.hentPubliseringStatus(
                                        referanseId = it.id,
                                        type = it.type.name.tilDokumentTilPubliseringType(),
                                    ),
                                ),
                        )
                    }
                }
            }

            is OpprettPlanForSamarbeid -> {
                val sideEffect = OpprettPlanForSamarbeidSideEffect(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    samarbeidId = hendelse.samarbeidId,
                    plan = hendelse.plan,
                    saksbehandler = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                )
                with(fiaKontekst.nyFlytService) {
                    sideEffect.apply().map {
                        Konsekvens(
                            nyTilstand = VirksomhetHarAktiveSamarbeid,
                            endring = it,
                        )
                    }
                }
            }

            is OppdaterPlanForSamarbeid -> {
                val sideEffect = OppdaterPlanForSamarbeidSideEffect(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    samarbeidId = hendelse.samarbeidId,
                    planId = hendelse.planId,
                    endringer = hendelse.endringer,
                )
                with(fiaKontekst.nyFlytService) {
                    sideEffect.apply().map {
                        Konsekvens(
                            nyTilstand = VirksomhetHarAktiveSamarbeid,
                            endring = it,
                        )
                    }
                }
            }

            is OppdaterTemaIPlanForSamarbeid -> {
                val sideEffect = OppdaterTemaIPlanForSamarbeidSideEffect(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    samarbeidId = hendelse.samarbeidId,
                    planId = hendelse.planId,
                    temaId = hendelse.temaId,
                    endringer = hendelse.endringer,
                )
                with(fiaKontekst.nyFlytService) {
                    sideEffect.apply().map {
                        Konsekvens(
                            nyTilstand = VirksomhetHarAktiveSamarbeid,
                            endring = it,
                        )
                    }
                }
            }

            is EndreStatusPåUndertemaISamarbeidsplan -> {
                val sideEffect = EndreStatusPåUndertemaISamarbeidsplanSideEffect(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    samarbeidId = hendelse.samarbeidId,
                    planId = hendelse.planId,
                    temaId = hendelse.temaId,
                    undertemaId = hendelse.undertemaId,
                    nyStatus = hendelse.nyStatus,
                )
                with(fiaKontekst.nyFlytService) {
                    sideEffect.apply().map {
                        Konsekvens(
                            nyTilstand = VirksomhetHarAktiveSamarbeid,
                            endring = it,
                        )
                    }
                }
            }

            is SlettPlanForSamarbeid -> {
                val sideEffect = SlettPlanForSamarbeidSideEffect(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    samarbeidId = hendelse.samarbeidId,
                    saksbehandler = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                )
                with(fiaKontekst.nyFlytService) {
                    sideEffect.apply().map {
                        Konsekvens(
                            nyTilstand = VirksomhetHarAktiveSamarbeid,
                            endring = it,
                        )
                    }
                }
            }

            is SlettSamarbeid -> {
                val sideEffect = SlettSamarbeidSideEffect(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    samarbeidId = hendelse.samarbeidId,
                    saksbehandler = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                )

                with(fiaKontekst.nyFlytService) {
                    sideEffect.apply().map {
                        val harAktiveSamarbeid = TilstandsmaskinBuilder.harAktiveSamarbeid(
                            fiaKontekst = fiaKontekst,
                            saksnummer = fiaKontekst.saksnummer,
                        )
                        val harSamarbeidOgAlleErAvsluttet = TilstandsmaskinBuilder.harSamarbeidOgAlleErAvsluttet(
                            fiaKontekst = fiaKontekst,
                            saksnummer = fiaKontekst.saksnummer,
                        )

                        // TODO: flyt automatisk oppdatering i SideEffekt
                        if (harSamarbeidOgAlleErAvsluttet) {
                            TilstandsmaskinBuilder.oppdaterTilAlleSamarbeidAvsluttetMedAutomatiskOppdatering(
                                orgnr = hendelse.orgnr,
                                fiaKontekst = fiaKontekst,
                                planlagtDato = hendelse.dato,
                            )
                        }

                        Konsekvens(
                            endring = it,
                            nyTilstand = when {
                                harAktiveSamarbeid -> VirksomhetHarAktiveSamarbeid
                                harSamarbeidOgAlleErAvsluttet -> AlleSamarbeidIVirksomhetErAvsluttet
                                else -> VirksomhetVurderes
                            },
                        )
                    }
                }
            }

            is AvsluttSamarbeid -> {
                val sideEffect = AvsluttSamarbeidSideEffect(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    samarbeidId = hendelse.samarbeidId,
                    typeAvslutning = hendelse.typeAvslutning,
                    avsluttetTil = hendelse.dato,
                    saksbehandler = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                )
                with(receiver = fiaKontekst.nyFlytService) {
                    sideEffect.apply().map {
                        Konsekvens(
                            nyTilstand = VirksomhetHarAktiveSamarbeid,
                            endring = it,
                        )
                    }
                }
            }

            is EndreSamarbeidsNavn -> {
                val sideEffect = EndreSamarbeidsnavnSideEffect(
                    orgnummer = hendelse.orgnr,
                    saksnummer = fiaKontekst.saksnummer!!,
                    samarbeidId = hendelse.samarbeidId,
                    nyttNavn = hendelse.navn,
                    saksbehandler = hendelse.saksbehandler,
                    navEnhet = hendelse.navEnhet,
                )
                with(fiaKontekst.nyFlytService) {
                    sideEffect.apply().map {
                        Konsekvens(
                            nyTilstand = VirksomhetHarAktiveSamarbeid,
                            endring = it,
                        )
                    }
                }
            }

            else -> {
                Either.Left(
                    Feil(
                        "'${hendelse.navn()}' er ikke gjennomførbar for '${VirksomhetHarAktiveSamarbeid.tilVirksomhetIATilstand()}'",
                        HttpStatusCode.BadRequest,
                    ),
                )
            }
        }
}
