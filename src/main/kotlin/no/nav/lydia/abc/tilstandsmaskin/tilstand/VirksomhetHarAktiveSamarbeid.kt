package no.nav.lydia.abc.tilstandsmaskin.tilstand

import arrow.core.Either
import io.ktor.http.HttpStatusCode
import no.nav.lydia.abc.dokument.DokumentPubliseringDto.Companion.tilDokumentTilPubliseringType
import no.nav.lydia.abc.kartlegging.tilDto
import no.nav.lydia.abc.tilstandsmaskin.FiaKontekst
import no.nav.lydia.abc.tilstandsmaskin.Konsekvens
import no.nav.lydia.abc.tilstandsmaskin.TilstandsmaskinBuilder
import no.nav.lydia.abc.tilstandsmaskin.hendelse.AvsluttSamarbeid
import no.nav.lydia.abc.tilstandsmaskin.hendelse.EndreSamarbeidsNavn
import no.nav.lydia.abc.tilstandsmaskin.hendelse.EndreStatusPåUndertemaISamarbeidsplan
import no.nav.lydia.abc.tilstandsmaskin.hendelse.FullførKartleggingForSamarbeid
import no.nav.lydia.abc.tilstandsmaskin.hendelse.Hendelse
import no.nav.lydia.abc.tilstandsmaskin.hendelse.OppdaterPlanForSamarbeid
import no.nav.lydia.abc.tilstandsmaskin.hendelse.OppdaterTemaIPlanForSamarbeid
import no.nav.lydia.abc.tilstandsmaskin.hendelse.OpprettKartleggingForSamarbeid
import no.nav.lydia.abc.tilstandsmaskin.hendelse.OpprettNyttSamarbeid
import no.nav.lydia.abc.tilstandsmaskin.hendelse.OpprettPlanForSamarbeid
import no.nav.lydia.abc.tilstandsmaskin.hendelse.SlettKartleggingForSamarbeid
import no.nav.lydia.abc.tilstandsmaskin.hendelse.SlettPlanForSamarbeid
import no.nav.lydia.abc.tilstandsmaskin.hendelse.SlettSamarbeid
import no.nav.lydia.abc.tilstandsmaskin.hendelse.StartKartleggingForSamarbeid
import no.nav.lydia.abc.tilstandsmaskin.sideeffect.AvsluttSamarbeidSideEffect
import no.nav.lydia.abc.tilstandsmaskin.sideeffect.EndreSamarbeidsnavnSideEffect
import no.nav.lydia.abc.tilstandsmaskin.sideeffect.EndreStatusPåUndertemaISamarbeidsplanSideEffect
import no.nav.lydia.abc.tilstandsmaskin.sideeffect.FullførKartleggingSideEffect
import no.nav.lydia.abc.tilstandsmaskin.sideeffect.OppdaterPlanForSamarbeidSideEffect
import no.nav.lydia.abc.tilstandsmaskin.sideeffect.OppdaterTemaIPlanForSamarbeidSideEffect
import no.nav.lydia.abc.tilstandsmaskin.sideeffect.OpprettKartleggingSideEffect
import no.nav.lydia.abc.tilstandsmaskin.sideeffect.OpprettPlanForSamarbeidSideEffect
import no.nav.lydia.abc.tilstandsmaskin.sideeffect.OpprettSamarbeidSideEffect
import no.nav.lydia.abc.tilstandsmaskin.sideeffect.SlettKartleggingSideEffect
import no.nav.lydia.abc.tilstandsmaskin.sideeffect.SlettPlanForSamarbeidSideEffect
import no.nav.lydia.abc.tilstandsmaskin.sideeffect.SlettSamarbeidSideEffect
import no.nav.lydia.abc.tilstandsmaskin.sideeffect.StartKartleggingSideEffect
import no.nav.lydia.abc.tilstandsmaskin.tilVirksomhetIATilstand
import no.nav.lydia.ia.sak.api.Feil

// -- Virksomheten har minst ett aktivt samarbeid
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
                    )
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
                    val resultat = sideEffect.apply()
                    Konsekvens(
                        nyTilstand = VirksomhetHarAktiveSamarbeid,
                        endring = resultat.map {
                            it.tilDto(
                                fiaKontekst.dokumentPubliseringService.hentPubliseringStatus(
                                    referanseId = it.id,
                                    type = it.type.name.tilDokumentTilPubliseringType(),
                                ),
                            )
                        },
                    )
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
                    val resultat = sideEffect.apply()
                    Konsekvens(
                        nyTilstand = VirksomhetHarAktiveSamarbeid,
                        endring = resultat.map {
                            it.tilDto(
                                fiaKontekst.dokumentPubliseringService.hentPubliseringStatus(
                                    referanseId = it.id,
                                    type = it.type.name.tilDokumentTilPubliseringType(),
                                ),
                            )
                        },
                    )
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
                    val resultat = sideEffect.apply()
                    Konsekvens(
                        nyTilstand = VirksomhetHarAktiveSamarbeid,
                        endring = resultat.map {
                            it.tilDto(
                                fiaKontekst.dokumentPubliseringService.hentPubliseringStatus(
                                    referanseId = it.id,
                                    type = it.type.name.tilDokumentTilPubliseringType(),
                                ),
                            )
                        },
                    )
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
                    val resultat = sideEffect.apply()
                    Konsekvens(
                        nyTilstand = VirksomhetHarAktiveSamarbeid,
                        endring = resultat.map {
                            it.tilDto(
                                fiaKontekst.dokumentPubliseringService.hentPubliseringStatus(
                                    referanseId = it.id,
                                    type = it.type.name.tilDokumentTilPubliseringType(),
                                ),
                            )
                        },
                    )
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
                    val resultat = sideEffect.apply()
                    Konsekvens(
                        nyTilstand = VirksomhetHarAktiveSamarbeid,
                        endring = resultat,
                    )
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
                    val resultat = sideEffect.apply()
                    Konsekvens(
                        nyTilstand = VirksomhetHarAktiveSamarbeid,
                        endring = resultat,
                    )
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
                    val resultat = sideEffect.apply()
                    Konsekvens(
                        nyTilstand = VirksomhetHarAktiveSamarbeid,
                        endring = resultat,
                    )
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
                    val resultat = sideEffect.apply()
                    Konsekvens(
                        nyTilstand = VirksomhetHarAktiveSamarbeid,
                        endring = resultat,
                    )
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
                    val resultat = sideEffect.apply()
                    Konsekvens(
                        nyTilstand = VirksomhetHarAktiveSamarbeid,
                        endring = resultat,
                    )
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
                    val resultat = sideEffect.apply()
                    val harAktiveSamarbeid = TilstandsmaskinBuilder.harAktiveSamarbeid(
                        fiaKontekst = fiaKontekst,
                        saksnummer = fiaKontekst.saksnummer,
                    )
                    val harSamarbeidOgAlleErAvsluttet = TilstandsmaskinBuilder.harSamarbeidOgAlleErAvsluttet(
                        fiaKontekst = fiaKontekst,
                        saksnummer = fiaKontekst.saksnummer,
                    )

                    if (harSamarbeidOgAlleErAvsluttet && resultat.isRight()) {
                        TilstandsmaskinBuilder.oppdaterTilAlleSamarbeidAvsluttetMedAutomatiskOppdatering(
                            orgnr = hendelse.orgnr,
                            fiaKontekst = fiaKontekst,
                            planlagtDato = hendelse.dato,
                        )
                    }

                    Konsekvens(
                        endring = resultat,
                        nyTilstand = when {
                            harAktiveSamarbeid -> VirksomhetHarAktiveSamarbeid
                            harSamarbeidOgAlleErAvsluttet -> AlleSamarbeidIVirksomhetErAvsluttet
                            else -> VirksomhetVurderes
                        },
                    )
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
                    val resultat = sideEffect.apply()
                    Konsekvens(
                        nyTilstand = if (resultat.isRight()) VirksomhetHarAktiveSamarbeid else VirksomhetVurderes,
                        endring = resultat,
                    )
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
                    val resultat = sideEffect.apply()
                    Konsekvens(
                        nyTilstand = VirksomhetHarAktiveSamarbeid,
                        endring = resultat,
                    )
                }
            }

            else -> {
                val endring = Either.Left(
                    Feil(
                        "'${hendelse.navn()}' er ikke gjennomførbar for '${VirksomhetHarAktiveSamarbeid.tilVirksomhetIATilstand()}'",
                        HttpStatusCode.BadRequest,
                    ),
                )
                Konsekvens(
                    endring = endring,
                    nyTilstand = VirksomhetVurderes,
                )
            }
        }
}
