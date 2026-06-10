package no.nav.lydia.abc.api

import arrow.core.getOrElse
import arrow.core.right
import io.ktor.http.HttpStatusCode
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.abc.samarbeid.IASamarbeidService
import no.nav.lydia.abc.samarbeidsperiode.IASakError
import no.nav.lydia.abc.samarbeidsperiode.IASakService
import no.nav.lydia.abc.samarbeidsperiode.tilIASakLeveranserPerTjenesteDto
import no.nav.lydia.abc.samarbeidsperiode.tilSakshistorikk
import no.nav.lydia.ia.sak.api.samarbeid.tilDto
import no.nav.lydia.tilgangskontroll.somHøyestTilgang
import no.nav.lydia.tilgangskontroll.somLesebruker

const val IA_SAK_RADGIVER_PATH = "iasak/radgiver"
const val SAMARBEIDSHISTORIKK_PATH = "historikk"
const val IA_SAK_LEVERANSE_PATH = "leveranse"

fun Route.iaSakRådgiver(
    iaSakService: IASakService,
    samarbeidService: IASamarbeidService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
) {
    get("$IA_SAK_RADGIVER_PATH/{orgnummer}/{saksnummer}") {
        val orgnummer = call.orgnummer ?: return@get call.respond(IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@get call.respond(IASakError.`ugyldig saksnummer`)
        call.somHøyestTilgang(adGrupper = adGrupper) { _ ->
            if (saksnummer == "aktiv") {
                iaSakService.hentAktivSak(orgnummer = orgnummer).right()
            } else {
                iaSakService.hentIASakDto(saksnummer)
            }
        }.also { either ->
            auditLog.auditloggEither(
                call = call,
                either = either,
                orgnummer = orgnummer,
                auditType = AuditType.access,
            )
        }.map {
            val response = it ?: HttpStatusCode.NoContent
            call.respond(response)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    get("$IA_SAK_RADGIVER_PATH/{orgnummer}/{saksnummer}/status") {
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(feil = IASakError.`ugyldig saksnummer`)
        call.somLesebruker(adGrupper = adGrupper) { _ ->
            iaSakService.hentSaksStatus(saksnummer)
        }.map {
            call.respond(it)
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    get("$IA_SAK_RADGIVER_PATH/$SAMARBEIDSHISTORIKK_PATH/{orgnummer}") {
        val orgnummer = call.orgnummer ?: return@get call.respond(IASakError.`ugyldig orgnummer`)
        call.somLesebruker(adGrupper = adGrupper) { _ ->
            val hendelser = iaSakService.hentHendelserForOrgnummer(orgnr = orgnummer)
            iaSakService.hentSakerForOrgnummer(orgnummer = orgnummer)
                .map { sak ->
                    sak.addHendelser(hendelser = hendelser.filter { hendelse -> hendelse.saksnummer == sak.saksnummer })
                }
                .sortedByDescending { it.opprettetTidspunkt }
                .map { sak ->
                    val samarbeid = samarbeidService.hentSamarbeidSomIkkeErSlettet(sak.saksnummer).getOrElse { emptyList() }
                    sak.tilSakshistorikk(samarbeid = samarbeid.tilDto())
                }
                .right()
        }.also { either ->
            if (either.isLeft()) {
                auditLog.auditloggEither(
                    call = call,
                    either = either,
                    orgnummer = orgnummer,
                    auditType = AuditType.access,
                )
            } else {
                val iaSaker = either.getOrElse { listOf() }
                iaSaker.forEach { iaSak ->
                    auditLog.auditloggEither(
                        call = call,
                        either = either,
                        orgnummer = orgnummer,
                        auditType = AuditType.access,
                        saksnummer = iaSak.saksnummer,
                    )
                }
            }
        }.map { historikk ->
            call.respond(historikk).right()
        }.mapLeft {
            call.respond(status = it.httpStatusCode, message = it.feilmelding)
        }
    }

    get("$IA_SAK_RADGIVER_PATH/$IA_SAK_LEVERANSE_PATH/{orgnummer}/{saksnummer}") {
        val orgnr = call.orgnummer ?: return@get call.sendFeil(feil = IASakError.`ugyldig orgnummer`)
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(feil = IASakError.`ugyldig saksnummer`)
        call.somLesebruker(adGrupper = adGrupper) { _ ->
            iaSakService.hentIASakLeveranser(saksnummer = saksnummer)
        }.also {
            auditLog.auditloggEither(
                call = call,
                either = it,
                orgnummer = orgnr,
                auditType = AuditType.access,
                saksnummer = saksnummer,
            )
        }.map {
            call.respond(it.tilIASakLeveranserPerTjenesteDto().sorted())
        }.mapLeft {
            call.respond(message = it.feilmelding, status = it.httpStatusCode)
        }
    }
}
