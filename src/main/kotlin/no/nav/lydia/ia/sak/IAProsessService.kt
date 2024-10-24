package no.nav.lydia.ia.sak

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import no.nav.lydia.Observer
import no.nav.lydia.appstatus.ObservedPlan
import no.nav.lydia.appstatus.PlanHendelseType
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.prosess.IAProsessDto
import no.nav.lydia.ia.sak.db.PlanRepository
import no.nav.lydia.ia.sak.db.ProsessRepository
import no.nav.lydia.ia.sak.db.SpørreundersøkelseRepository
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType.ENDRE_PROSESS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.NY_PROSESS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.SLETT_PROSESS
import no.nav.lydia.ia.sak.domene.ProsessHendelse
import no.nav.lydia.ia.sak.domene.prosess.IAProsess

class IAProsessService(
    val prosessRepository: ProsessRepository,
    val spørreundersøkelseRepository: SpørreundersøkelseRepository,
    val samarbeidObservers: List<Observer<IAProsess>>,
    val planRepository: PlanRepository,
    val sendPlanPåKafkaObserver: SendPlanPåKafkaObserver,
) {
    fun hentIAProsesser(sak: IASak) =
        Either.catch {
            prosessRepository.hentProsesser(saksnummer = sak.saksnummer)
        }.mapLeft {
            IAProsessFeil.`feil ved henting av prosess`
        }

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
        planRepository.hentPlan(prosessId = samarbeid.id)?.let { plan ->
            sendPlanPåKafkaObserver.receive(
                ObservedPlan(
                    plan = plan,
                    hendelsesType = PlanHendelseType.OPPDATER,
                ),
            )
        }
        return prosessRepository.hentProsess(
            saksnummer = samarbeid.saksnummer,
            prosessId = samarbeid.id,
        )
    }

    fun kanSletteProsess(
        sak: IASak,
        iaProsess: IAProsessDto,
    ): Boolean {
        val prosess = hentIAProsess(sak, iaProsess.id).getOrNull() ?: return false

        if (spørreundersøkelseRepository.hentSpørreundersøkelser(prosess).isNotEmpty()) {
            return false
        }
        if (planRepository.hentPlan(prosessId = prosess.id) != null) {
            return false
        }

        return true
    }

    private fun slettProsess(
        sakshendelse: ProsessHendelse,
        sak: IASak,
    ): IAProsess? {
        val samarbeid = sakshendelse.prosessDto

        return if (kanSletteProsess(sak = sak, iaProsess = samarbeid)) {
            prosessRepository.oppdaterTilSlettetStatus(sakshendelse)
        } else {
            prosessRepository.hentProsess(
                saksnummer = samarbeid.saksnummer,
                prosessId = samarbeid.id,
            )
        }
    }
}

const val DEFAULT_SAMARBEID_NAVN = "Samarbeid uten navn"

object IAProsessFeil {
    val `feil ved henting av prosess` = Feil("Feil ved henting av prosess", HttpStatusCode.InternalServerError)
    val `ugyldig prosessId` = Feil("Ugyldig prosess", HttpStatusCode.BadRequest)
    val `kan ikke slette samarbeid som inneholder behovsvurdering eller samarbeidsplan` =
        Feil("kan ikke slette samarbeid som inneholder behovsvurdering eller samarbeidsplan", HttpStatusCode.BadRequest)
}
