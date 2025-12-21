package no.nav.lydia.ia.sak.api.ny.flyt

import arrow.core.Either
import arrow.core.getOrElse
import io.ktor.http.HttpStatusCode
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.IASamarbeidService
import no.nav.lydia.ia.sak.PlanService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringDto.Companion.tilDokumentTilPubliseringType
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringService
import no.nav.lydia.ia.sak.api.spørreundersøkelse.tilDto
import no.nav.lydia.ia.sak.domene.IASak.Status
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
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
            val harAktivSamarbeidsplan = aktiveSamarbeid.any { samarbeid ->
                fiaKontekst.planService.hentPlan(samarbeid.id)
                    .map { plan ->
                        plan.status == IASamarbeid.Status.AKTIV
                    }.getOrElse { false }
            }

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
                -> if (harAktivSamarbeidsplan) {
                    Tilstand.VirksomhetHarAktiveSamarbeid
                } else {
                    Tilstand.VirksomhetVurderes
                }

                Status.AKTIV,
                -> Tilstand.VirksomhetHarAktiveSamarbeid

                Status.AVSLUTTET,
                -> Tilstand.AlleSamarbeidIVirksomhetErAvsluttet
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

    val saksnummer: String?
        get() = fiaKontekst.saksnummer

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
        ): Konsekvens =
            when (hendelse) {
                is Hendelse.AngreVurderVirksomhet -> {
                    val sakDto = fiaKontekst.nyFlytService.hentAktivIASakDto(orgnummer = hendelse.orgnr)!!
                    val endring = fiaKontekst.nyFlytService.slettSakOgVarsleObservers(sakDto)
                    Konsekvens(
                        endring = endring,
                        nyTilstand = VirksomhetKlarTilVurdering,
                    )
                }

                is Hendelse.FullførVurdering -> {
                    val endring = fiaKontekst.nyFlytService.fullførVurderingAvVirksomhetUtenSamarbeid(
                        orgnummer = hendelse.orgnr,
                        saksnummer = fiaKontekst.saksnummer!!,
                        årsak = hendelse.årsak,
                        saksbehandler = hendelse.saksbehandler,
                        navEnhet = hendelse.navEnhet,
                    )
                    Konsekvens(
                        endring = endring,
                        nyTilstand = VirksomhetErVurdert,
                    )
                }

                is Hendelse.OpprettNyttSamarbeid -> {
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

    object VirksomhetErVurdert : Tilstand() { // VURDERT
        override fun utførTransisjon(
            hendelse: Hendelse,
            fiaKontekst: FiaKontekst,
        ): Konsekvens {
            TODO("Not yet implemented")
        }
    }

    // -- Virksomheten har minst ett aktivt samarbeid med en aktiv samarbeidsplan
    object VirksomhetHarAktiveSamarbeid : Tilstand() { // AKTIV
        override fun utførTransisjon(
            hendelse: Hendelse,
            fiaKontekst: FiaKontekst,
        ): Konsekvens =
            when (hendelse) {
                is Hendelse.OpprettNyttSamarbeid -> {
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

                is Hendelse.OpprettKartleggingForSamarbeid -> {
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

                is Hendelse.StartKartleggingForSamarbeid -> {
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

                is Hendelse.FullførKartleggingForSamarbeid -> {
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

                is Hendelse.SlettKartleggingForSamarbeid -> {
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

                is Hendelse.OpprettPlanForSamarbeid -> {
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

                is Hendelse.SlettPlanForSamarbeid -> {
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

                is Hendelse.SlettSamarbeid -> {
                    val endring = fiaKontekst.nyFlytService.slettSamarbeid(
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

                is Hendelse.AvsluttSamarbeid -> {
                    val endring = fiaKontekst.nyFlytService.avsluttSamarbeid(
                        orgnummer = hendelse.orgnr,
                        saksnummer = fiaKontekst.saksnummer!!,
                        samarbeidId = hendelse.samarbeidId,
                        typeAvslutning = hendelse.typeAvslutning,
                        saksbehandler = hendelse.saksbehandler,
                        navEnhet = hendelse.navEnhet,
                    )
                    Konsekvens(
                        endring = endring,
                        nyTilstand = AlleSamarbeidIVirksomhetErAvsluttet,
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
        val samarbeidsnavn: String,
        val saksbehandler: NavAnsattMedSaksbehandlerRolle,
        val navEnhet: NavEnhet,
    ) : Hendelse()

    data class OpprettKartleggingForSamarbeid(
        val orgnr: String,
        val samarbeidId: Int,
        val type: Spørreundersøkelse.Type,
        val saksbehandler: NavAnsattMedSaksbehandlerRolle,
        val navEnhet: NavEnhet,
    ) : Hendelse()

    data class StartKartleggingForSamarbeid(
        val orgnr: String,
        val spørreundersøkelseId: UUID,
        val saksbehandler: NavAnsattMedSaksbehandlerRolle,
        val navEnhet: NavEnhet,
    ) : Hendelse()

    data class FullførKartleggingForSamarbeid(
        val orgnr: String,
        val spørreundersøkelseId: UUID,
        val saksbehandler: NavAnsattMedSaksbehandlerRolle,
        val navEnhet: NavEnhet,
    ) : Hendelse()

    data class SlettKartleggingForSamarbeid(
        val orgnr: String,
        val spørreundersøkelseId: UUID,
        val saksbehandler: NavAnsattMedSaksbehandlerRolle,
        val navEnhet: NavEnhet,
    ) : Hendelse()

    data class OpprettPlanForSamarbeid(
        val orgnr: String,
        val samarbeidId: Int,
        val plan: PlanMalDto,
        val saksbehandler: NavAnsattMedSaksbehandlerRolle,
        val navEnhet: NavEnhet,
    ) : Hendelse()

    data class SlettPlanForSamarbeid(
        val orgnr: String,
        val samarbeidId: Int,
        val saksbehandler: NavAnsattMedSaksbehandlerRolle,
        val navEnhet: NavEnhet,
    ) : Hendelse()

    data class SlettSamarbeid(
        val orgnr: String,
        val samarbeidId: Int,
        val saksbehandler: NavAnsattMedSaksbehandlerRolle,
        val navEnhet: NavEnhet,
    ) : Hendelse()

    data class AvsluttSamarbeid(
        val orgnr: String,
        val samarbeidId: Int,
        val typeAvslutning: IASamarbeid.Status, // FULLFØRT eller AVBRUTT
        val saksbehandler: NavAnsattMedSaksbehandlerRolle,
        val navEnhet: NavEnhet,
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
    val dokumentPubliseringService: DokumentPubliseringService,
    val planService: PlanService,
    val nyFlytService: NyFlytService,
    // TODO: Skal orgnr inn hit og?
    val saksnummer: String?,
)
