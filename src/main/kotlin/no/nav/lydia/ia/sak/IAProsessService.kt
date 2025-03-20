package no.nav.lydia.ia.sak

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus
import io.ktor.http.HttpStatusCode
import no.nav.lydia.Observer
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
import java.lang.IllegalStateException

class IAProsessService(
    val prosessRepository: ProsessRepository,
    val spørreundersøkelseRepository: SpørreundersøkelseRepository,
    val samarbeidObservers: List<Observer<IAProsess>>,
    val planRepository: PlanRepository,
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
        return prosessRepository.hentProsess(
            saksnummer = samarbeid.saksnummer,
            prosessId = samarbeid.id,
        )
    }

    enum class FullføreBegrunneler {
        INGEN_EVALUERING,
        INGEN_PLAN,
        AKTIV_EVALUERING,
        AKTIV_BEHOVSVURDERING,
    }

    fun kanFullføreProsess(
        sak: IASak,
        iaProsess: IAProsessDto,
    ): List<FullføreBegrunneler> {
        val prosess = hentIAProsess(sak, iaProsess.id).getOrNull() ?: throw IllegalStateException("Fant ikke samarbeid")
        val behovsvurderinger = spørreundersøkelseRepository.hentSpørreundersøkelser(prosess, "Behovsvurdering")
        val evalueringer = spørreundersøkelseRepository.hentSpørreundersøkelser(prosess, "Evaluering")
        val liste = mutableListOf<FullføreBegrunneler>()

        if (behovsvurderinger.filter { it.status != SpørreundersøkelseStatus.AVSLUTTET }.isNotEmpty()) {
            liste.add(FullføreBegrunneler.AKTIV_BEHOVSVURDERING)
        }

        if (evalueringer.isEmpty()) {
            liste.add(FullføreBegrunneler.INGEN_EVALUERING)
        }

        if (evalueringer.filter { it.status != SpørreundersøkelseStatus.AVSLUTTET }.isNotEmpty()) {
            liste.add(FullføreBegrunneler.AKTIV_EVALUERING)
        }

        val plan = planRepository.hentPlan(prosessId = prosess.id)
        if (plan == null) {
            liste.add(FullføreBegrunneler.INGEN_PLAN)
        }

        return liste
    }

    enum class SletteBegrunnelser {
        FINNES_SALESFORCE_AKTIVITET,
        FINNES_BEHOVSVURDERING,
        FINNES_SAMARBEIDSPLAN,
        FINNES_EVALUERING,
    }

    fun kanSletteProsess(
        sak: IASak,
        iaProsess: IAProsessDto,
    ): List<SletteBegrunnelser> {
        val prosess = hentIAProsess(sak, iaProsess.id).getOrNull() ?: throw IllegalStateException("Fant ikke samarbeid")
        val liste = mutableListOf<SletteBegrunnelser>()

        if (spørreundersøkelseRepository.hentSpørreundersøkelser(prosess, "Behovsvurdering").isNotEmpty()) {
            liste.add(SletteBegrunnelser.FINNES_BEHOVSVURDERING)
        }
        if (spørreundersøkelseRepository.hentSpørreundersøkelser(prosess, "Evaluering").isNotEmpty()) {
            liste.add(SletteBegrunnelser.FINNES_EVALUERING)
        }
        if (planRepository.hentPlan(prosessId = prosess.id) != null) {
            liste.add(SletteBegrunnelser.FINNES_SAMARBEIDSPLAN)
        }
        if (prosessRepository.hentSalesforceAktiviteter(sak.saksnummer, iaProsess.id).isNotEmpty()) {
            liste.add(SletteBegrunnelser.FINNES_SALESFORCE_AKTIVITET)
        }

        return liste
    }

    private fun slettProsess(
        sakshendelse: ProsessHendelse,
        sak: IASak,
    ): IAProsess? {
        val samarbeid = sakshendelse.prosessDto

        return if (kanSletteProsess(sak = sak, iaProsess = samarbeid).isEmpty()) {
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
const val MAKS_ANTALL_TEGN_I_SAMARBEIDSNAVN = 50

object IAProsessFeil {
    val `ugyldig samarbeidsnavn` = Feil("Ugyldig samarbeidsnavn", HttpStatusCode.BadRequest)
    val `samarbeidsnavn finnes allerede` = Feil("Samarbeidsnavn finnes allerede", HttpStatusCode.Conflict)
    val `feil ved henting av prosess` = Feil("Feil ved henting av prosess", HttpStatusCode.InternalServerError)
    val `ugyldig prosessId` = Feil("Ugyldig prosess", HttpStatusCode.BadRequest)
    val `kan ikke slette samarbeid som inneholder behovsvurdering eller samarbeidsplan` =
        Feil("kan ikke slette samarbeid som inneholder behovsvurdering eller samarbeidsplan", HttpStatusCode.BadRequest)
}
