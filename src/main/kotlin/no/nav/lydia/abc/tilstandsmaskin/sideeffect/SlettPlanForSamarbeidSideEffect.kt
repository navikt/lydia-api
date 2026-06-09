package no.nav.lydia.abc.tilstandsmaskin.sideeffect

import arrow.core.Either
import com.github.guepardoapps.kulid.ULID
import no.nav.lydia.abc.tilstandsmaskin.NyFlytService
import no.nav.lydia.abc.tilstandsmaskin.Transaction
import no.nav.lydia.abc.tilstandsmaskin.VirksomhetIATilstand
import no.nav.lydia.abc.tilstandsmaskin.lagreEllerOppdaterVirksomhetTilstand
import no.nav.lydia.abc.tilstandsmaskin.lagreHendelse
import no.nav.lydia.abc.tilstandsmaskin.oppdaterStatusPåSak
import no.nav.lydia.abc.tilstandsmaskin.settPlanTilSlettet
import no.nav.lydia.appstatus.PlanHendelseType
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.domene.IASak.Status.AKTIV
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.plan.Plan
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle
import java.time.LocalDateTime

class SlettPlanForSamarbeidSideEffect(
    val orgnummer: String,
    val saksnummer: String,
    val samarbeidId: Int,
    val saksbehandler: NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
) : SideEffect<Plan>() {
    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, Plan> =
        nyFlytService.validerSlettingAvSamarbeidsplan(
            samarbeidId = samarbeidId,
        ).map { plan ->
            Transaction(nyFlytService.dataSource).transactional { tx ->
                with(receiver = tx) {
                    val slettetPlan = settPlanTilSlettet(planId = plan.id)

                    val slettPlanHendelse = lagreHendelse(
                        hendelse = IASakshendelse(
                            id = ULID.random(),
                            opprettetTidspunkt = LocalDateTime.now(),
                            saksnummer = saksnummer,
                            hendelsesType = IASakshendelseType.SLETT_SAMARBEIDSPLAN,
                            orgnummer = orgnummer,
                            opprettetAv = saksbehandler.navIdent,
                            opprettetAvRolle = saksbehandler.rolle,
                            navEnhet = navEnhet,
                            resulterendeStatus = null,
                        ),
                        sistEndretAvHendelseId = null,
                        resulterendeStatus = AKTIV,
                    )

                    val iaSakDto = oppdaterStatusPåSak(
                        saksnummer = saksnummer,
                        status = AKTIV,
                        endretAvHendelseId = slettPlanHendelse.id,
                        endretAv = saksbehandler.navIdent,
                    )

                    lagreEllerOppdaterVirksomhetTilstand(
                        orgnr = orgnummer,
                        tilstand = VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid,
                    )

                    Pair(slettetPlan, iaSakDto)
                }
            }.also { (slettetPlan, iaSakDto) ->
                nyFlytService.varsleIASakObservers(iaSakDto)
                nyFlytService.planService.varslePlanObservers(slettetPlan, PlanHendelseType.ENDRE_STATUS)
            }.first
        }
}
