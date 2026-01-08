package no.nav.lydia.ia.sak.api.ny.flyt

import arrow.core.Either
import arrow.core.getOrElse
import io.ktor.http.HttpStatusCode
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.IASamarbeidService
import no.nav.lydia.ia.sak.PlanService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.ny.flyt.SaksgangOppdatering.NySakIngenOppdatering
import no.nav.lydia.ia.sak.api.ny.flyt.SaksgangOppdatering.OppdaterSakStatus
import no.nav.lydia.ia.sak.api.ny.flyt.SaksgangOppdatering.SakenErSlettetIngenOppdatering
import no.nav.lydia.ia.sak.api.ny.flyt.SaksgangOppdatering.VurderingErFullførtIngenOppdatering
import no.nav.lydia.ia.sak.domene.IASak.Status
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
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
        // hendelse -> tilstand.valider() -> GyldigTransisjon | UGyldigTransisjon
        //  en transisjon inneholder:
        //   - nyTilstand
        //   - blokk med selve endringen (funksjon som returnerer Either<Feil, Any?>)
        //
        // utfør en gyldig transisjon -> gjør selve endringen -> Konsekvens (inneholder endringen)
        // hvis endringen var vellykket på en GyldigTransisjon
        //  --> lagre hendelse, ny kolonne "gjennomført default false" TODO: trenger vi denne nye kolonnen?
        //  --> oppdater status (oppdater hendelse, "gjennomført = true" TODO: trenger vi denne?)
        // => returner konsekvens (med ny tilstand og endring)

        val transisjon = nåværendeTilstand.valider(hendelse = hendelse, fiaKontekst = fiaKontekst)

        return when (transisjon) {
            is Transisjon.GyldigTransisjon -> {
                val konsekvensAvUtførtTransisjon = transisjon.utfør() // selve endringen

                // Hvis endringen var vellykket, lagre hendelsen + oppdater sak status
                konsekvensAvUtførtTransisjon.endring.onRight {
                    // I tilfelle av angre vurdering er saken slettet og dermed ingen oppdatering av status er nødvendig
                    when (transisjon.saksgangOppdatering) {
                        is OppdaterSakStatus -> {
                            println(
                                "[DEBUG][TEST] oppdaterer sak status i tilstandsmaskin, ønsket status: " +
                                    "${transisjon.saksgangOppdatering.getResulterendeSakStatus()}, hendelse: ${hendelse.navn()}",
                            )
                            fiaKontekst.nyFlytService.lagHendelseOppdaterStatusPåSakOgVarsleObservers(
                                orgnummer = hendelse.orgnr,
                                navAnsatt = hendelse.navAnsatt,
                                navEnhet = hendelse.navEnhet,
                                iASakshendelseType = transisjon.saksgangOppdatering.startetAvHendelse,
                                resulterendeStatus = transisjon.saksgangOppdatering.getResulterendeSakStatus(),
                            )
                        }

                        else -> { /* Do nothing */ }
                    }
                    // Oppdater tilstanden i tilstandsmaskinen
                    nåværendeTilstand = konsekvensAvUtførtTransisjon.nyTilstand
                }
                konsekvensAvUtførtTransisjon
            }

            is Transisjon.UGyldigTransisjon -> {
                transisjon.fail()
            }
        }
    }
}

data class Konsekvens(
    val nyTilstand: Tilstand,
    val endring: Either<Feil, Any?>,
)

sealed class SaksgangOppdatering {
    class SakErAlleredeOppdatertITransaksjon : SaksgangOppdatering()

    class NySakIngenOppdatering : SaksgangOppdatering()

    class SakenErSlettetIngenOppdatering : SaksgangOppdatering()

    class VurderingErFullførtIngenOppdatering : SaksgangOppdatering()

    data class OppdaterSakStatus(
        val startetAvHendelse: IASakshendelseType,
        private val resulterendeSakStatus: () -> Status,
    ) : SaksgangOppdatering() {
        fun getResulterendeSakStatus(): Status = resulterendeSakStatus()
    }
}

sealed class Transisjon {
    class GyldigTransisjon(
        val saksgangOppdatering: SaksgangOppdatering,
        val resulterendeTilstand: Tilstand,
        val block: () -> Either<Feil, Any?>,
    ) : Transisjon() {
        fun utfør(): Konsekvens {
            val endring = block()
            return Konsekvens(nyTilstand = resulterendeTilstand, endring = endring)
        }
    }

    class UGyldigTransisjon(
        val feil: Either.Left<Feil>,
    ) : Transisjon() {
        fun fail(): Konsekvens = Konsekvens(Tilstand.VirksomhetVurderes, feil)
    }
}

sealed class Tilstand {
    fun navn(): String = this.javaClass.simpleName

    abstract fun valider(
        hendelse: Hendelse,
        fiaKontekst: FiaKontekst,
    ): Transisjon

    object VirksomhetKlarTilVurdering : Tilstand() { // IKKE_AKTIV
        override fun valider(
            hendelse: Hendelse,
            fiaKontekst: FiaKontekst,
        ): Transisjon =
            when (hendelse) {
                is Hendelse.VurderVirksomhet -> {
                    Transisjon.GyldigTransisjon(
                        saksgangOppdatering = NySakIngenOppdatering(),
                        resulterendeTilstand = VirksomhetVurderes,
                    ) {
                        fiaKontekst.nyFlytService.opprettSakOgMerkSomVurderes(
                            orgnummer = hendelse.orgnr,
                            superbruker = hendelse.navAnsatt,
                            navEnhet = hendelse.navEnhet,
                        )
                    }
                }

                else -> {
                    Transisjon.UGyldigTransisjon(Either.Left(Feil("Something odd happened", HttpStatusCode.BadRequest)))
                }
            }
    }

    object VirksomhetVurderes : Tilstand() { // VURDERES
        override fun valider(
            hendelse: Hendelse,
            fiaKontekst: FiaKontekst,
        ): Transisjon =
            when (hendelse) {
                is Hendelse.AngreVurderVirksomhet -> {
                    Transisjon.GyldigTransisjon(
                        saksgangOppdatering = SakenErSlettetIngenOppdatering(),
                        resulterendeTilstand = VirksomhetErVurdert,
                    ) {
                        val sakDto = fiaKontekst.nyFlytService.hentAktivIASakDto(orgnummer = hendelse.orgnr)!!
                        val endring = fiaKontekst.nyFlytService.slettSakOgVarsleObservers(sakDto)
                        endring
                    }
                }

                is Hendelse.FullførVurdering -> {
                    Transisjon.GyldigTransisjon(
                        saksgangOppdatering = VurderingErFullførtIngenOppdatering(),
                        resulterendeTilstand = VirksomhetErVurdert,
                    ) {
                        fiaKontekst.nyFlytService.fullførVurderingAvVirksomhetUtenSamarbeid(
                            orgnummer = hendelse.orgnr,
                            saksnummer = fiaKontekst.saksnummer!!,
                            årsak = hendelse.årsak,
                            saksbehandler = hendelse.navAnsatt,
                            navEnhet = hendelse.navEnhet,
                        )
                    }
                }

                is Hendelse.OpprettNyttSamarbeid -> {
                    Transisjon.GyldigTransisjon(
                        saksgangOppdatering = OppdaterSakStatus(
                            resulterendeSakStatus = { Status.AKTIV },
                            startetAvHendelse = IASakshendelseType.NY_PROSESS,
                        ),
                        resulterendeTilstand = VirksomhetErVurdert,
                    ) {
                        fiaKontekst.nyFlytService.opprettNyttSamarbeid(
                            orgnummer = hendelse.orgnr,
                            saksnummer = fiaKontekst.saksnummer!!,
                            navn = hendelse.samarbeidsnavn,
                            saksbehandler = hendelse.navAnsatt,
                            navEnhet = hendelse.navEnhet,
                        )
                    }
                }

                else -> {
                    Transisjon.UGyldigTransisjon(
                        Either.Left(Feil("Something odd happened", HttpStatusCode.BadRequest)),
                    )
                }
            }
    }

    object VirksomhetErVurdert : Tilstand() { // VURDERT
        override fun valider(
            hendelse: Hendelse,
            fiaKontekst: FiaKontekst,
        ): Transisjon {
            TODO("Not yet implemented")
        }
    }

    // -- Virksomheten har minst ett aktivt samarbeid med en aktiv samarbeidsplan
    object VirksomhetHarAktiveSamarbeid : Tilstand() { // AKTIV
        override fun valider(
            hendelse: Hendelse,
            fiaKontekst: FiaKontekst,
        ): Transisjon =
            when (hendelse) {
                is Hendelse.OpprettNyttSamarbeid -> {
                    Transisjon.GyldigTransisjon(
                        saksgangOppdatering = OppdaterSakStatus(
                            resulterendeSakStatus = { Status.AKTIV },
                            startetAvHendelse = IASakshendelseType.NY_PROSESS,
                        ),
                        resulterendeTilstand = VirksomhetHarAktiveSamarbeid,
                    ) {
                        fiaKontekst.nyFlytService.opprettNyttSamarbeid(
                            orgnummer = hendelse.orgnr,
                            saksnummer = fiaKontekst.saksnummer!!,
                            navn = hendelse.samarbeidsnavn,
                            saksbehandler = hendelse.navAnsatt,
                            navEnhet = hendelse.navEnhet,
                        )
                    }
                }

                is Hendelse.OpprettPlanForSamarbeid -> {
                    Transisjon.GyldigTransisjon(
                        saksgangOppdatering = OppdaterSakStatus(
                            resulterendeSakStatus = { Status.AKTIV },
                            startetAvHendelse = IASakshendelseType.OPPRETT_SAMARBEIDSPLAN,
                        ),
                        resulterendeTilstand = VirksomhetHarAktiveSamarbeid,
                    ) {
                        fiaKontekst.nyFlytService.opprettNySamarbeidsplan(
                            orgnummer = hendelse.orgnr,
                            saksnummer = fiaKontekst.saksnummer!!,
                            samarbeidId = hendelse.samarbeidId,
                            plan = hendelse.plan,
                            saksbehandler = hendelse.navAnsatt,
                            navEnhet = hendelse.navEnhet,
                        )
                    }
                }

                is Hendelse.SlettPlanForSamarbeid -> {
                    Transisjon.GyldigTransisjon(
                        saksgangOppdatering = OppdaterSakStatus(
                            resulterendeSakStatus = { Status.AKTIV },
                            startetAvHendelse = IASakshendelseType.SLETT_SAMARBEIDSPLAN,
                        ),
                        resulterendeTilstand = VirksomhetHarAktiveSamarbeid,
                    ) {
                        fiaKontekst.nyFlytService.slettSamarbeidsplan(
                            orgnummer = hendelse.orgnr,
                            saksnummer = fiaKontekst.saksnummer!!,
                            samarbeidId = hendelse.samarbeidId,
                            saksbehandler = hendelse.navAnsatt,
                            navEnhet = hendelse.navEnhet,
                        )
                    }
                }

                is Hendelse.SlettSamarbeid -> {
                    Transisjon.GyldigTransisjon(
                        saksgangOppdatering = OppdaterSakStatus(
                            resulterendeSakStatus = {
                                fiaKontekst.nyFlytService.utleddSakStatusBasertPaaAntallSamarbeid(samarbeidId = hendelse.samarbeidId)
                            },
                            startetAvHendelse = IASakshendelseType.SLETT_PROSESS,
                        ),
                        resulterendeTilstand = VirksomhetHarAktiveSamarbeid, // TODO, kan endres etter sletting hvis ingen aktive samarbeid gjenstår
                    ) {
                        fiaKontekst.nyFlytService.slettSamarbeid(
                            orgnummer = hendelse.orgnr,
                            saksnummer = fiaKontekst.saksnummer!!,
                            samarbeidId = hendelse.samarbeidId,
                            saksbehandler = hendelse.navAnsatt,
                            navEnhet = hendelse.navEnhet,
                        )
                    }
                }

                is Hendelse.AvsluttSamarbeid -> {
                    val iASakshendelseType = if (hendelse.typeAvslutning == IASamarbeid.Status.FULLFØRT) {
                        IASakshendelseType.FULLFØR_PROSESS
                    } else {
                        IASakshendelseType.AVBRYT_PROSESS
                    }

                    Transisjon.GyldigTransisjon(
                        saksgangOppdatering = OppdaterSakStatus(
                            resulterendeSakStatus = {
                                fiaKontekst.nyFlytService.utleddSakStatusBasertPaaAntallSamarbeid(samarbeidId = hendelse.samarbeidId)
                            },
                            startetAvHendelse = iASakshendelseType,
                        ),
                        resulterendeTilstand = VirksomhetHarAktiveSamarbeid,
                    ) {
                        fiaKontekst.nyFlytService.avsluttSamarbeid(
                            orgnummer = hendelse.orgnr,
                            saksnummer = fiaKontekst.saksnummer!!,
                            samarbeidId = hendelse.samarbeidId,
                            typeAvslutning = hendelse.typeAvslutning,
                            saksbehandler = hendelse.navAnsatt,
                            navEnhet = hendelse.navEnhet,
                        )
                    }
                }

                else -> {
                    Transisjon.UGyldigTransisjon(Either.Left(Feil("Something odd happened", HttpStatusCode.BadRequest)))
                }
            }
    }

    // object VirksomhetHarFlereAktiveSamarbeid : Tilstand()
    object AlleSamarbeidIVirksomhetErAvsluttet : Tilstand() { // AVSLUTTET
        override fun valider(
            hendelse: Hendelse,
            fiaKontekst: FiaKontekst,
        ): Transisjon {
            TODO("Not yet implemented")
        }
    }
}

sealed class Hendelse {
    abstract val orgnr: String
    abstract val navAnsatt: NavAnsatt
    abstract val navEnhet: NavEnhet

    fun navn(): String = this.javaClass.simpleName

    data class VurderVirksomhet(
        override val orgnr: String,
        override val navAnsatt: Superbruker,
        override val navEnhet: NavEnhet,
    ) : Hendelse()

    data class AngreVurderVirksomhet(
        override val orgnr: String,
        override val navAnsatt: Superbruker,
        override val navEnhet: NavEnhet,
    ) : Hendelse()

    data class FullførVurdering(
        override val orgnr: String,
        override val navEnhet: NavEnhet,
        override val navAnsatt: NavAnsattMedSaksbehandlerRolle,
        val årsak: ValgtÅrsak,
    ) : Hendelse()

    data class OpprettNyttSamarbeid(
        override val orgnr: String,
        override val navEnhet: NavEnhet,
        override val navAnsatt: NavAnsattMedSaksbehandlerRolle,
        val samarbeidsnavn: String,
    ) : Hendelse()

    data class OpprettPlanForSamarbeid(
        override val orgnr: String,
        override val navEnhet: NavEnhet,
        override val navAnsatt: NavAnsattMedSaksbehandlerRolle,
        val samarbeidId: Int,
        val plan: PlanMalDto,
    ) : Hendelse()

    data class SlettPlanForSamarbeid(
        override val orgnr: String,
        override val navEnhet: NavEnhet,
        override val navAnsatt: NavAnsattMedSaksbehandlerRolle,
        val samarbeidId: Int,
    ) : Hendelse()

    data class SlettSamarbeid(
        override val orgnr: String,
        override val navEnhet: NavEnhet,
        override val navAnsatt: NavAnsattMedSaksbehandlerRolle,
        val samarbeidId: Int,
    ) : Hendelse()

    data class AvsluttSamarbeid(
        override val orgnr: String,
        override val navEnhet: NavEnhet,
        override val navAnsatt: NavAnsattMedSaksbehandlerRolle,
        val samarbeidId: Int,
        val typeAvslutning: IASamarbeid.Status, // FULLFØRT eller AVBRUTT
    ) : Hendelse()

    data class GjenopprettSamarbeid(
        override val orgnr: String,
        override val navEnhet: NavEnhet,
        override val navAnsatt: NavAnsattMedSaksbehandlerRolle,
        val samarbeidId: UUID,
    ) : Hendelse()

    data class GjørVirksomhetKlarTilNyVurdering(
        override val orgnr: String,
        override val navEnhet: NavEnhet,
        override val navAnsatt: NavAnsattMedSaksbehandlerRolle,
    ) : Hendelse()
}

data class FiaKontekst(
    val iaSakService: IASakService,
    val iASamarbeidService: IASamarbeidService,
    val planService: PlanService,
    val nyFlytService: NyFlytService,
    // TODO: Skal orgnr inn hit og?
    val saksnummer: String?,
)
