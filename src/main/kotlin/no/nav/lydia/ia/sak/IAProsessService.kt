package no.nav.lydia.ia.sak

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.db.PlanRepository
import no.nav.lydia.ia.sak.db.ProsessRepository
import no.nav.lydia.ia.sak.db.SpørreundersøkelseRepository
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType.ENDRE_PROSESS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.NY_PROSESS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.SLETT_PROSESS
import no.nav.lydia.ia.sak.domene.ProsessHendelse

class IAProsessService(
    val prosessRepository: ProsessRepository,
    val spørreundersøkelseRepository: SpørreundersøkelseRepository,
    val planRepository: PlanRepository,
) {
    fun hentEllerOpprettIAProsesser(sak: IASak) =
        Either.catch {
            prosessRepository.hentProsesser(saksnummer = sak.saksnummer).ifEmpty {
                listOf(prosessRepository.opprettNyProsess(saksnummer = sak.saksnummer))
            }
        }.mapLeft {
            IAProsessFeil.`feil ved henting av prosess`
        }

    fun hentIAProsesser(sak: IASak) =
        Either.catch {
            prosessRepository.hentProsesser(saksnummer = sak.saksnummer)
        }.mapLeft {
            IAProsessFeil.`feil ved henting av prosess`
        }

    fun hentIAProsess(sak: IASak, prosessId: Int) =
        prosessRepository.hentProsess(saksnummer = sak.saksnummer, prosessId = prosessId)?.right()
            ?: IAProsessFeil.`ugyldig prosessId`.left()

    fun oppdaterProsess(sakshendelse: IASakshendelse, sak: IASak) {
        when (sakshendelse) {
            is ProsessHendelse -> {
                when (sakshendelse.hendelsesType) {
                    ENDRE_PROSESS -> prosessRepository.oppdaterNavnPåProsess(sakshendelse.prosessDto)
                    SLETT_PROSESS -> slettProsess(sakshendelse, sak)
                    else -> {}
                }

            }
            else -> {
                when (sakshendelse.hendelsesType) {
                    NY_PROSESS -> prosessRepository.opprettNyProsess(saksnummer = sakshendelse.saksnummer)
                    else -> {}
                }
            }
        }
    }

    private fun slettProsess(sakshendelse: ProsessHendelse, sak: IASak) {
        val prosess = hentIAProsess(sak, sakshendelse.prosessDto.id).getOrNull()
            ?: throw IllegalStateException("Fant ikke prosess")

        val behovsvurderinger = spørreundersøkelseRepository.hentSpørreundersøkelser(
            prosess
        )
        if (behovsvurderinger.isNotEmpty())
            throw IllegalStateException("Kan ikke slette prosess som har tilknyttede behovsvurderinger")

        val plan = planRepository.hentPlan(prosessId = prosess.id)
        if (plan != null)
            throw IllegalStateException("Kan ikke slette prosess som har tilknyttet plan")

        prosessRepository.oppdaterTilSlettetStatus(sakshendelse)
    }
}

object IAProsessFeil {
    val `feil ved henting av prosess` = Feil("Feil ved henting av prosess", HttpStatusCode.InternalServerError)
    val `ugyldig prosessId` = Feil("Ugyldig prosess", HttpStatusCode.BadRequest)
}