package no.nav.lydia.ia.sak

import arrow.core.Either
import io.ktor.http.HttpStatusCode
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.db.ProsessRepository
import no.nav.lydia.ia.sak.domene.IASak

class IAProsessService(
    val prosessRepository: ProsessRepository
) {
    fun hentEllerOpprettIAProsess(sak: IASak) =
        Either.catch {
            prosessRepository.hentProsess(saksnummer = sak.saksnummer)
                ?: prosessRepository.opprettNyProsess(saksnummer = sak.saksnummer)
        }.mapLeft {
            IAProsessFeil.`feil ved henting av prosess`
        }

    fun hentIAProsesser(sak: IASak) =
        Either.catch {
            prosessRepository.hentProsess(saksnummer = sak.saksnummer)?.let {
                listOf(it)
            } ?: emptyList()
        }.mapLeft {
            IAProsessFeil.`feil ved henting av prosess`
        }
}

object IAProsessFeil {
    val `feil ved henting av prosess` = Feil("Feil ved henting av prosess", HttpStatusCode.InternalServerError)
}