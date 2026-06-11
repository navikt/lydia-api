package no.nav.lydia.tilstandsmaskin.sideeffect

import arrow.core.Either
import com.github.guepardoapps.kulid.ULID
import no.nav.lydia.appstatus.PlanHendelseType
import no.nav.lydia.felles.Feil
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.samarbeidsperiode.IASakDto
import no.nav.lydia.samarbeidsperiode.IASakshendelse
import no.nav.lydia.samarbeidsperiode.IASakshendelseType
import no.nav.lydia.samarbeidsplan.Plan
import no.nav.lydia.samarbeidsplan.PlanDto
import no.nav.lydia.samarbeidsplan.PlanMalDto
import no.nav.lydia.samarbeidsplan.tilDtoMedPubliseringStatus
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle
import no.nav.lydia.tilstandsmaskin.NyFlytService
import no.nav.lydia.tilstandsmaskin.Transaction
import no.nav.lydia.tilstandsmaskin.VirksomhetIATilstand
import no.nav.lydia.tilstandsmaskin.opprettSamarbeidsplan
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidsperiodeTransactional.Companion.hentSisteIASakDto
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidsperiodeTransactional.Companion.lagreHendelse
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidsperiodeTransactional.Companion.oppdaterStatusPåSak
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.TilstandVirksomhetTransactional.Companion.lagreEllerOppdaterVirksomhetTilstand
import java.time.LocalDateTime
import java.util.UUID

class OpprettPlanForSamarbeidSideEffect(
    val orgnummer: String,
    val saksnummer: String,
    val samarbeidId: Int,
    val plan: PlanMalDto,
    val saksbehandler: NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
) : SideEffect<PlanDto>() {
    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, PlanDto> {
        val nyPlanId = UUID.randomUUID()

        return nyFlytService.validerOpprettelseAvSamarbeidsplan(
            samarbeidId = samarbeidId,
            mal = plan,
        ).map { planMalDto ->
            Transaction(nyFlytService.dataSource).transactional { tx ->
                with(receiver = tx) {
                    val sakDto = hentSisteIASakDto(orgnummer = orgnummer)!!

                    val opprettetSamarbeidsplan: Plan = opprettSamarbeidsplan(
                        planId = nyPlanId,
                        samarbeidId = samarbeidId,
                        saksbehandler = saksbehandler,
                        mal = planMalDto,
                    ) ?: error("Kunne ikke opprette samarbeidsplan for samarbeid $samarbeidId i sak $saksnummer")

                    val planDto: PlanDto =
                        opprettetSamarbeidsplan.tilDtoMedPubliseringStatus()

                    val opprettPlanHendelse = lagreHendelse(
                        hendelse = IASakshendelse(
                            id = ULID.random(),
                            opprettetTidspunkt = LocalDateTime.now(),
                            saksnummer = saksnummer,
                            hendelsesType = IASakshendelseType.OPPRETT_SAMARBEIDSPLAN,
                            orgnummer = orgnummer,
                            opprettetAv = saksbehandler.navIdent,
                            opprettetAvRolle = saksbehandler.rolle,
                            navEnhet = navEnhet,
                            resulterendeStatus = null,
                        ),
                        sistEndretAvHendelseId = null,
                        resulterendeStatus = sakDto.status,
                    )
                    val oppdatertSakDto = oppdaterStatusPåSak(
                        saksnummer = saksnummer,
                        status = sakDto.status,
                        endretAvHendelseId = opprettPlanHendelse.id,
                        endretAv = saksbehandler.navIdent,
                        oppdaterSistEndretPåSak = false,
                    )
                    lagreEllerOppdaterVirksomhetTilstand(
                        orgnr = orgnummer,
                        tilstand = VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid,
                    )
                    Triple(opprettetSamarbeidsplan, planDto, oppdatertSakDto)
                }
            }.also { planOgIASak: Triple<Plan, PlanDto, IASakDto> ->
                nyFlytService.varsleIASakObservers(sakDto = planOgIASak.third)
                nyFlytService.planService.varslePlanObservers(planOgIASak.first, PlanHendelseType.OPPRETT)
            }.second
        }
    }
}
