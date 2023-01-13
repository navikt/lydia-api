package no.nav.lydia.ia.debug

import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.sak.domene.IASak
import java.lang.RuntimeException

val KAST_FEIL_ENDEPUNKT = "internal/kastfeil"
val KAST_FEIL_ENDEPUNKT_MELDING = "Kaster feil intensjonelt"

fun Route.debug(
    iaSakRepository: IASakRepository,
    iaSakshendelseRepository: IASakshendelseRepository
) {
    get(KAST_FEIL_ENDEPUNKT) {
        throw RuntimeException(KAST_FEIL_ENDEPUNKT_MELDING)
    }
    get("internal/tilstandsmaskin") {
        val alleSaker = iaSakRepository.hentAlleSaker()

        val sakTilHendelser = alleSaker.associateBy(
            keySelector = { it },
            valueTransform = {
                try {
                    IASak.fraHendelser(iaSakshendelseRepository.hentHendelserForSaksnummer(it.saksnummer))
                }   catch (e: Exception) {
                    null
                }
            }
        )

        val ret = mapOf(
            "feilendesaker" to sakTilHendelser.filterValues { it == null }.map { Triple(it.key.saksnummer, it.key.status, it.value?.status) },
            "forskjelligesaker" to sakTilHendelser.filter { it.key.status != it.value?.status }.map { Triple(it.key.saksnummer, it.key.status, it.value?.status) }
        )
        call.respond(HttpStatusCode.OK, ret)
    }
}