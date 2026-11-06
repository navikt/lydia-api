package no.nav.lydia.api.v1

import arrow.core.raise.either
import arrow.core.raise.ensure
import io.ktor.http.HttpStatusCode
import io.ktor.server.request.receive
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import io.ktor.server.routing.put
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.api.orgnummer
import no.nav.lydia.api.saksnummer
import no.nav.lydia.api.samarbeidId
import no.nav.lydia.api.sendFeil
import no.nav.lydia.mål.MålDto
import no.nav.lydia.mål.MålFeil
import no.nav.lydia.mål.MålService
import no.nav.lydia.mål.valider
import no.nav.lydia.samarbeid.IASamarbeid
import no.nav.lydia.samarbeid.IASamarbeidFeil
import no.nav.lydia.samarbeid.IASamarbeidService
import no.nav.lydia.samarbeidsperiode.IASakError
import no.nav.lydia.samarbeidsperiode.IASakService
import no.nav.lydia.team.IATeamService
import no.nav.lydia.tilgangskontroll.eierEllerFølgerAvSak
import no.nav.lydia.tilgangskontroll.somLesebruker

const val MÅL_PATH =
    "$NY_FLYT_API_PATH/virksomhet/{orgnummer}/samarbeidsperiode/{saksnummer}/samarbeid/{samarbeidId}/maal"

fun Route.mål(
    målService: MålService,
    iaSakService: IASakService,
    iaSamarbeidService: IASamarbeidService,
    iaTeamService: IATeamService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
) {
    get(MÅL_PATH) {
        val orgnummer = call.orgnummer ?: return@get call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)
        val samarbeidId = call.samarbeidId ?: return@get call.sendFeil(IASamarbeidFeil.`ugyldig samarbeidId`)

        call.somLesebruker(adGrupper = adGrupper) { _ ->
            either {
                val iaSak = iaSakService.hentIASakDto(saksnummer = saksnummer).bind()
                ensure(iaSak.orgnr == orgnummer) { IASakError.`ugyldig orgnummer` }
                iaSamarbeidService.hentSamarbeid(saksnummer = saksnummer, samarbeidId = samarbeidId).bind()
                målService.hent(samarbeidId = samarbeidId).bind()
            }
        }.also {
            auditLog.auditloggEither(
                call = call,
                either = it,
                orgnummer = orgnummer,
                auditType = AuditType.access,
                saksnummer = saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    put(MÅL_PATH) {
        val orgnummer = call.orgnummer ?: return@put call.sendFeil(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@put call.sendFeil(IASakError.`ugyldig saksnummer`)
        val samarbeidId = call.samarbeidId ?: return@put call.sendFeil(IASamarbeidFeil.`ugyldig samarbeidId`)
        val mål = call.receive<MålDto>()

        either {
            val saksbehandler = call.eierEllerFølgerAvSak(
                adGrupper = adGrupper,
                iaSakService = iaSakService,
                iaTeamService = iaTeamService,
            ).bind()
            val iaSak = iaSakService.hentIASakDto(saksnummer = saksnummer).bind()
            ensure(iaSak.orgnr == orgnummer) { IASakError.`ugyldig orgnummer` }
            val samarbeid = iaSamarbeidService.hentSamarbeid(saksnummer = saksnummer, samarbeidId = samarbeidId).bind()
            ensure(samarbeid.status == IASamarbeid.Status.AKTIV) { MålFeil.`samarbeidet er ikke aktivt` }
            val gyldigeMål = mål.valider().bind()

            målService.lagre(
                samarbeidId = samarbeidId,
                mål = gyldigeMål,
                endretAv = saksbehandler.navIdent,
            ).bind()
        }.also {
            auditLog.auditloggEither(
                call = call,
                either = it,
                orgnummer = orgnummer,
                auditType = AuditType.update,
                saksnummer = saksnummer,
            )
        }.map {
            call.respond(status = HttpStatusCode.OK, message = it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }
}
