package no.nav.lydia.ia.sak

import arrow.core.Either
import io.ktor.http.HttpStatusCode
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.db.ProsessRepository
import no.nav.lydia.ia.sak.domene.IASak

class IAProsessService(
    val prosessRepository: ProsessRepository
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
}

object IAProsessFeil {
    val `feil ved henting av prosess` = Feil("Feil ved henting av prosess", HttpStatusCode.InternalServerError)
}