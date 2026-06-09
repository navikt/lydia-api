package no.nav.lydia.abc.tilstandsmaskin.sideeffect

import arrow.core.Either
import com.github.guepardoapps.kulid.ULID
import no.nav.lydia.abc.samarbeid.IASamarbeid
import no.nav.lydia.abc.samarbeidsperiode.IASak.Status
import no.nav.lydia.abc.samarbeidsperiode.IASakshendelse
import no.nav.lydia.abc.samarbeidsperiode.IASakshendelseType
import no.nav.lydia.abc.tilstandsmaskin.NyFlytService
import no.nav.lydia.abc.tilstandsmaskin.Transaction
import no.nav.lydia.abc.tilstandsmaskin.VirksomhetIATilstand
import no.nav.lydia.abc.tilstandsmaskin.avbrytSamarbeid
import no.nav.lydia.abc.tilstandsmaskin.fullførSamarbeid
import no.nav.lydia.abc.tilstandsmaskin.hendelse.GjørVirksomhetKlarTilNyVurdering
import no.nav.lydia.abc.tilstandsmaskin.hentPlan
import no.nav.lydia.abc.tilstandsmaskin.hentSamarbeid
import no.nav.lydia.abc.tilstandsmaskin.hentSamarbeidSomIkkeErSlettet
import no.nav.lydia.abc.tilstandsmaskin.lagreEllerOppdaterVirksomhetTilstand
import no.nav.lydia.abc.tilstandsmaskin.lagreHendelse
import no.nav.lydia.abc.tilstandsmaskin.oppdaterStatusPåSak
import no.nav.lydia.abc.tilstandsmaskin.opprettAutomatiskOppdatering
import no.nav.lydia.abc.tilstandsmaskin.settPlanTilFullført
import no.nav.lydia.appstatus.ObservedPlan
import no.nav.lydia.appstatus.PlanHendelseType
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.samarbeid.IASamarbeidDto
import no.nav.lydia.ia.sak.api.samarbeid.tilDto
import no.nav.lydia.ia.sak.domene.plan.Plan
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle
import java.time.LocalDate
import java.time.LocalDateTime

class AvsluttSamarbeidSideEffect(
    val orgnummer: String,
    val saksnummer: String,
    val samarbeidId: Int,
    val typeAvslutning: IASamarbeid.Status, // Burde ha sin egen type
    val avsluttetTil: LocalDate?,
    val saksbehandler: NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
) : SideEffect<IASamarbeidDto>() {
    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, IASamarbeidDto> =
        nyFlytService.validerAvslutningAvSamarbeid(
            saksnummer = saksnummer,
            samarbeidId = samarbeidId,
            typeAvslutning = typeAvslutning,
        ).map { validert ->
            Transaction(nyFlytService.dataSource).transactional { tx ->
                with(tx) {
                    if (typeAvslutning == IASamarbeid.Status.AVBRUTT) {
                        avbrytSamarbeid(samarbeidDto = validert.first)
                    } else {
                        validert.second?.let { settPlanTilFullført(plan = it) }
                        fullførSamarbeid(samarbeidDto = validert.first)
                    }

                    val harIkkeLengerAktiveSamarbeid = hentSamarbeidSomIkkeErSlettet(saksnummer = saksnummer).none {
                        it.status == IASamarbeid.Status.AKTIV
                    }
                    val resulterendeStatus = if (harIkkeLengerAktiveSamarbeid) {
                        Status.AVSLUTTET
                    } else {
                        Status.AKTIV
                    }

                    val iASakshendelse = IASakshendelse(
                        id = ULID.random(),
                        opprettetTidspunkt = LocalDateTime.now(),
                        saksnummer = saksnummer,
                        hendelsesType = if (typeAvslutning == IASamarbeid.Status.AVBRUTT) {
                            IASakshendelseType.AVBRYT_PROSESS
                        } else {
                            IASakshendelseType.FULLFØR_PROSESS
                        },
                        orgnummer = orgnummer,
                        opprettetAv = saksbehandler.navIdent,
                        opprettetAvRolle = saksbehandler.rolle,
                        navEnhet = navEnhet,
                        resulterendeStatus = resulterendeStatus,
                    )
                    lagreHendelse(
                        hendelse = iASakshendelse,
                        sistEndretAvHendelseId = null, // forvirrende
                        resulterendeStatus = resulterendeStatus,
                    )

                    val oppdatertSak = oppdaterStatusPåSak(
                        saksnummer = saksnummer,
                        status = resulterendeStatus,
                        endretAv = saksbehandler.navIdent,
                        endretAvHendelseId = iASakshendelse.id,
                    )
                    val nyTilstand = when (oppdatertSak.status) {
                        Status.AKTIV -> VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
                        Status.AVSLUTTET -> VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet
                        else -> VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
                    }
                    lagreEllerOppdaterVirksomhetTilstand(
                        orgnr = oppdatertSak.orgnr,
                        tilstand = nyTilstand,
                    ).also {
                        if (it?.tilstand == VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet) {
                            opprettAutomatiskOppdatering(
                                orgnr = orgnummer,
                                startTilstand = it.tilstand,
                                planlagtHendelse = GjørVirksomhetKlarTilNyVurdering::class.simpleName!!,
                                nyTilstand = VirksomhetIATilstand.VirksomhetKlarTilVurdering,
                                planlagtDato = avsluttetTil ?: LocalDate.now().plusDays(90),
                            )
                        }
                    }

                    val oppdatertSamarbeid: IASamarbeid = hentSamarbeid(samarbeidId = samarbeidId)!!
                    val oppdatertPlanHvisFullfør: Plan? = hentPlan(samarbeidId = samarbeidId)
                    oppdatertSamarbeid.tilDto()

                    Pair(oppdatertSamarbeid, oppdatertPlanHvisFullfør)
                }
            }.also { samarbeidOgPlan ->
                nyFlytService.iaSamarbeidObservers.forEach { it.receive(samarbeidOgPlan.first) }
                nyFlytService.iaSakRepository.hentIASakDto(saksnummer)!!.also {
                    nyFlytService.varsleIASakObservers(it)
                }
                samarbeidOgPlan.second?.let { oppdatertPlan ->
                    nyFlytService.planService.planObservers.forEach {
                        it.receive(
                            input = ObservedPlan(
                                plan = oppdatertPlan,
                                hendelsesType = PlanHendelseType.ENDRE_STATUS,
                            ),
                        )
                    }
                }
            }.first.tilDto()
        }
}
