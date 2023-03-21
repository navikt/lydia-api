package no.nav.lydia.ia.eksport

import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import kotlinx.coroutines.launch

val IA_SAK_EKSPORT_PATH = "internal/iasakeksport"
val IA_SAK_STATISTIKK_EKSPORT_PATH = "$IA_SAK_EKSPORT_PATH/statistikk"
val IA_SAK_LEVERANSE_EKSPORT_PATH = "$IA_SAK_EKSPORT_PATH/leveranse"

fun Route.iaSakEksporterer(
    iaSakEksporterer: IASakEksporterer,
    iaSakStatistikkEksporterer: IASakStatistikkEksporterer,
    iaSakLeveranseEksportør: IASakLeveranseEksportør,
) {
    get(IA_SAK_EKSPORT_PATH) {
        if (IASakEksporterer.KJØRER_SAKS_EKSPORT.get()) {
            call.application.log.warn("Kjører allerede eksport av ia-saker.")
            return@get call.respond(HttpStatusCode.Conflict)
        }
        launch {
            iaSakEksporterer.eksporter()
        }
        call.respond(HttpStatusCode.OK)
    }

    get(IA_SAK_STATISTIKK_EKSPORT_PATH) {
        if (IASakStatistikkEksporterer.KJØRER_STATISTIKK_EKSPORT.get()) {
            call.application.log.warn("Kjører allerede eksport av ia-sak-statistikk.")
            return@get call.respond(HttpStatusCode.Conflict)
        }

        iaSakStatistikkEksporterer.eksporter()

        call.respond(HttpStatusCode.OK)
    }

    get(IA_SAK_LEVERANSE_EKSPORT_PATH) {
        if (IASakLeveranseEksportør.KJØRER_LEVERANSE_EKSPORT.get()) {
            call.application.log.warn("Kjører allerede eksport av ia-sak-leveranse.")
            return@get call.respond(HttpStatusCode.Conflict)
        }

        iaSakLeveranseEksportør.eksporter()

        call.respond(HttpStatusCode.OK)
    }
}
