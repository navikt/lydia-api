package no.nav.lydia.ia.sak

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus
import io.ktor.http.HttpStatusCode
import no.nav.lydia.Observer
import no.nav.lydia.appstatus.ObservedPlan
import no.nav.lydia.appstatus.PlanHendelseType
import no.nav.lydia.ia.sak.IAProsessService.StatusendringBegrunnelser.AKTIV_BEHOVSVURDERING
import no.nav.lydia.ia.sak.IAProsessService.StatusendringBegrunnelser.AKTIV_EVALUERING
import no.nav.lydia.ia.sak.IAProsessService.StatusendringBegrunnelser.FINNES_BEHOVSVURDERING
import no.nav.lydia.ia.sak.IAProsessService.StatusendringBegrunnelser.FINNES_EVALUERING
import no.nav.lydia.ia.sak.IAProsessService.StatusendringBegrunnelser.FINNES_SALESFORCE_AKTIVITET
import no.nav.lydia.ia.sak.IAProsessService.StatusendringBegrunnelser.FINNES_SAMARBEIDSPLAN
import no.nav.lydia.ia.sak.IAProsessService.StatusendringBegrunnelser.INGEN_EVALUERING
import no.nav.lydia.ia.sak.IAProsessService.StatusendringBegrunnelser.INGEN_PLAN
import no.nav.lydia.ia.sak.IAProsessService.StatusendringBegrunnelser.SAK_I_FEIL_STATUS
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.KanGjennomføreStatusendring
import no.nav.lydia.ia.sak.api.prosess.IAProsessDto
import no.nav.lydia.ia.sak.db.PlanRepository
import no.nav.lydia.ia.sak.db.ProsessRepository
import no.nav.lydia.ia.sak.db.SpørreundersøkelseRepository
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType.*
import no.nav.lydia.ia.sak.domene.ProsessHendelse
import no.nav.lydia.ia.sak.domene.prosess.IAProsess
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse.Companion.Type.Behovsvurdering
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse.Companion.Type.Evaluering

class IAProsessService(
    val prosessRepository: ProsessRepository,
    val spørreundersøkelseRepository: SpørreundersøkelseRepository,
    val samarbeidObservers: List<Observer<IAProsess>>,
    val planRepository: PlanRepository,
    val planObservers: List<Observer<ObservedPlan>>,
) {
    fun hentIAProsesser(sak: IASak) =
        Either.catch {
            prosessRepository.hentProsesser(saksnummer = sak.saksnummer)
        }.mapLeft {
            IAProsessFeil.`feil ved henting av prosess`
        }

    fun hentAktiveIAProsesser(sak: IASak): List<IAProsess> = prosessRepository.hentAktiveProsesser(saksnummer = sak.saksnummer)

    fun hentIAProsess(
        sak: IASak,
        prosessId: Int,
    ) = prosessRepository.hentProsess(saksnummer = sak.saksnummer, prosessId = prosessId)?.right()
        ?: IAProsessFeil.`ugyldig prosessId`.left()

    fun oppdaterSamarbeid(
        sakshendelse: IASakshendelse,
        sak: IASak,
    ) {
        when (sakshendelse) {
            is ProsessHendelse -> {
                when (sakshendelse.hendelsesType) {
                    FULLFØR_PROSESS -> fullførProsess(sakshendelse, sak)?.let { samarbeid ->
                        samarbeidObservers.forEach { it.receive(samarbeid) }
                    }
                    AVBRYT_PROSESS -> avbrytProsess(sakshendelse, sak)?.let { samarbeid ->
                        samarbeidObservers.forEach { it.receive(samarbeid) }
                    }
                    ENDRE_PROSESS -> oppdaterNavnPåProsess(sakshendelse.prosessDto)
                        ?.let { samarbeid -> samarbeidObservers.forEach { it.receive(samarbeid) } }
                    SLETT_PROSESS -> slettProsess(sakshendelse, sak)
                        ?.let { samarbeid -> samarbeidObservers.forEach { it.receive(samarbeid) } }
                    NY_PROSESS -> prosessRepository.opprettNyProsess(
                        saksnummer = sakshendelse.saksnummer,
                        navn = sakshendelse.prosessDto.navn,
                    ).also { samarbeid ->
                        samarbeidObservers.forEach { it.receive(samarbeid) }
                    }
                    else -> {}
                }
            }
            else -> {}
        }
    }

    private fun oppdaterNavnPåProsess(samarbeid: IAProsessDto): IAProsess? {
        prosessRepository.oppdaterNavnPåProsess(samarbeid)
        return prosessRepository.hentProsess(
            saksnummer = samarbeid.saksnummer,
            prosessId = samarbeid.id,
        )
    }

    enum class StatusendringBegrunnelser {
        // -- fullføre
        INGEN_EVALUERING,
        INGEN_PLAN,
        AKTIV_EVALUERING,
        AKTIV_BEHOVSVURDERING,
        SAK_I_FEIL_STATUS,

        // -- slette
        FINNES_SALESFORCE_AKTIVITET,
        FINNES_BEHOVSVURDERING,
        FINNES_SAMARBEIDSPLAN,
        FINNES_EVALUERING,
    }

    fun kanFullføreProsess(
        sak: IASak,
        samarbeidsId: Int,
    ): KanGjennomføreStatusendring {
        val prosess = hentIAProsess(sak, samarbeidsId).getOrNull() ?: throw IllegalStateException("Fant ikke samarbeid")
        val behovsvurderinger = spørreundersøkelseRepository.hentSpørreundersøkelser(prosess, Behovsvurdering)
        val evalueringer = spørreundersøkelseRepository.hentSpørreundersøkelser(prosess, Evaluering)
        val blokkerende = mutableListOf<StatusendringBegrunnelser>()
        val advarsler = mutableListOf<StatusendringBegrunnelser>()

        if (sak.status != no.nav.lydia.ia.sak.domene.IAProsessStatus.VI_BISTÅR) {
            blokkerende.add(SAK_I_FEIL_STATUS)
        }

        if (behovsvurderinger.any { it.status != SpørreundersøkelseStatus.AVSLUTTET }) {
            blokkerende.add(AKTIV_BEHOVSVURDERING)
        }

        if (evalueringer.isEmpty()) {
            advarsler.add(INGEN_EVALUERING)
        }

        if (evalueringer.any { it.status != SpørreundersøkelseStatus.AVSLUTTET }) {
            blokkerende.add(AKTIV_EVALUERING)
        }

        val plan = planRepository.hentPlan(prosessId = prosess.id)
        if (plan == null) {
            blokkerende.add(INGEN_PLAN)
        }

        return KanGjennomføreStatusendring(
            kanGjennomføres = blokkerende.isEmpty(),
            advarsler = advarsler.toList(),
            blokkerende = blokkerende.toList(),
        )
    }

    fun kanSletteProsess(
        sak: IASak,
        samarbeidsId: Int,
    ): KanGjennomføreStatusendring {
        val prosess = hentIAProsess(sak, samarbeidsId).getOrNull() ?: throw IllegalStateException("Fant ikke samarbeid")
        val blokkerende = mutableListOf<StatusendringBegrunnelser>()
        val advarsler = mutableListOf<StatusendringBegrunnelser>()

        if (spørreundersøkelseRepository.hentSpørreundersøkelser(prosess, Behovsvurdering).isNotEmpty()) {
            blokkerende.add(FINNES_BEHOVSVURDERING)
        }
        if (spørreundersøkelseRepository.hentSpørreundersøkelser(prosess, Evaluering).isNotEmpty()) {
            blokkerende.add(FINNES_EVALUERING)
        }
        if (planRepository.hentPlan(prosessId = prosess.id) != null) {
            blokkerende.add(FINNES_SAMARBEIDSPLAN)
        }
        if (prosessRepository.hentSalesforceAktiviteter(sak.saksnummer, prosess.id).isNotEmpty()) {
            blokkerende.add(FINNES_SALESFORCE_AKTIVITET)
        }

        return KanGjennomføreStatusendring(
            kanGjennomføres = blokkerende.isEmpty(),
            blokkerende = blokkerende,
            advarsler = advarsler,
        )
    }

    fun kanAvbryteSamarbeid(
        sak: IASak,
        samarbeidsId: Int,
    ): KanGjennomføreStatusendring {
        val prosess = hentIAProsess(sak, samarbeidsId).getOrNull() ?: throw IllegalStateException("Fant ikke samarbeid")
        val blokkerende = mutableListOf<StatusendringBegrunnelser>()

        if (spørreundersøkelseRepository.hentSpørreundersøkelser(prosess, Behovsvurdering).isNotEmpty()) {
            blokkerende.add(FINNES_BEHOVSVURDERING)
        }
        if (spørreundersøkelseRepository.hentSpørreundersøkelser(prosess, Evaluering).isNotEmpty()) {
            blokkerende.add(FINNES_EVALUERING)
        }

        return KanGjennomføreStatusendring(
            kanGjennomføres = blokkerende.isEmpty(),
            blokkerende = blokkerende,
            advarsler = emptyList(),
        )
    }

    private fun fullførProsess(
        sakshendelse: ProsessHendelse,
        sak: IASak,
    ): IAProsess? {
        val samarbeid = sakshendelse.prosessDto

        return if (kanFullføreProsess(sak = sak, samarbeidsId = samarbeid.id).kanGjennomføres) {
            planRepository.hentPlan(samarbeid.id)?.let { plan ->
                planRepository.settPlanTilFullført(plan)
                planRepository.hentPlan(samarbeid.id)?.let { oppdatertPlan ->
                    planObservers.forEach {
                        it.receive(
                            ObservedPlan(
                                plan = oppdatertPlan,
                                hendelsesType = PlanHendelseType.ENDRE_STATUS,
                            ),
                        )
                    }
                }
            }
            prosessRepository.fullførSamarbeid(samarbeid)
        } else {
            prosessRepository.hentProsess(
                saksnummer = samarbeid.saksnummer,
                prosessId = samarbeid.id,
            )
        }
    }

    private fun avbrytProsess(
        sakshendelse: ProsessHendelse,
        sak: IASak,
    ): IAProsess? {
        val samarbeid = sakshendelse.prosessDto

        return if (kanAvbryteSamarbeid(sak = sak, samarbeidsId = samarbeid.id).kanGjennomføres) {
            prosessRepository.avbrytSamarbeid(samarbeid)
        } else {
            prosessRepository.hentProsess(
                saksnummer = samarbeid.saksnummer,
                prosessId = samarbeid.id,
            )
        }
    }

    private fun slettProsess(
        sakshendelse: ProsessHendelse,
        sak: IASak,
    ): IAProsess? {
        val samarbeid = sakshendelse.prosessDto

        return if (kanSletteProsess(sak = sak, samarbeidsId = samarbeid.id).kanGjennomføres) {
            prosessRepository.slettSamarbeid(samarbeid)
        } else {
            prosessRepository.hentProsess(
                saksnummer = samarbeid.saksnummer,
                prosessId = samarbeid.id,
            )
        }
    }
}

const val DEFAULT_SAMARBEID_NAVN = "Samarbeid uten navn"
const val MAKS_ANTALL_TEGN_I_SAMARBEIDSNAVN = 50

object IAProsessFeil {
    val `ugyldig samarbeidsnavn` = Feil("Ugyldig samarbeidsnavn", HttpStatusCode.BadRequest)
    val `samarbeidsnavn finnes allerede` = Feil("Samarbeidsnavn finnes allerede", HttpStatusCode.Conflict)
    val `feil ved henting av prosess` = Feil("Feil ved henting av prosess", HttpStatusCode.InternalServerError)
    val `ugyldig prosessId` = Feil("Ugyldig prosess", HttpStatusCode.BadRequest)
    val `kan ikke slette samarbeid som inneholder behovsvurdering eller samarbeidsplan` =
        Feil("kan ikke slette samarbeid som inneholder behovsvurdering eller samarbeidsplan", HttpStatusCode.BadRequest)
    val `kan ikke fullføre samarbeid` =
        Feil("kan ikke fullføre samarbeid", HttpStatusCode.BadRequest)
    val `kan ikke avbryte samarbeid` =
        Feil("kan ikke avbryte samarbeid", HttpStatusCode.BadRequest)
}
