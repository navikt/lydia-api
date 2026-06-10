package no.nav.lydia.abc.api

import arrow.core.flatMap
import arrow.core.left
import io.ktor.http.ContentDisposition
import io.ktor.http.HttpHeaders
import io.ktor.http.HttpStatusCode
import io.ktor.server.request.receive
import io.ktor.server.response.header
import io.ktor.server.response.respond
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import io.ktor.server.routing.put
import kotlinx.coroutines.runBlocking
import kotlinx.datetime.toJavaLocalDateTime
import no.nav.lydia.ADGrupper
import no.nav.lydia.AuditLog
import no.nav.lydia.AuditType
import no.nav.lydia.abc.dokumentpublisering.DokumentPubliseringDto.Companion.tilDokumentTilPubliseringType
import no.nav.lydia.abc.dokumentpublisering.DokumentPubliseringService
import no.nav.lydia.abc.kartlegging.OppdaterBehovsvurderingDto
import no.nav.lydia.abc.kartlegging.Spørreundersøkelse
import no.nav.lydia.abc.kartlegging.SpørreundersøkelseService
import no.nav.lydia.abc.kartlegging.tilDto
import no.nav.lydia.abc.kartlegging.tilResultatDto
import no.nav.lydia.abc.kartlegging.tilUtenInnholdDto
import no.nav.lydia.abc.samarbeid.IASamarbeidFeil
import no.nav.lydia.abc.samarbeidsperiode.IASakService
import no.nav.lydia.abc.team.IATeamService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.extensions.orgnummer
import no.nav.lydia.ia.sak.api.extensions.prosessId
import no.nav.lydia.ia.sak.api.extensions.saksnummer
import no.nav.lydia.ia.sak.api.extensions.sendFeil
import no.nav.lydia.ia.sak.api.extensions.spørreundersøkelseId
import no.nav.lydia.ia.sak.api.extensions.type
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.integrasjoner.journalpost.JournalpostService
import no.nav.lydia.integrasjoner.pdfgen.PiaPdfgenService
import no.nav.lydia.tilgangskontroll.fia.objectId
import no.nav.lydia.tilgangskontroll.somLesebruker
import no.nav.lydia.tilgangskontroll.somSaksbehandler
import java.time.format.DateTimeFormatter

const val SPØRREUNDERSØKELSE_BASE_ROUTE = "$IA_SAK_RADGIVER_PATH/kartlegging"

fun Route.iaSakSpørreundersøkelse(
    iaSakService: IASakService,
    spørreundersøkelseService: SpørreundersøkelseService,
    dokumentPubliseringService: DokumentPubliseringService,
    iaTeamService: IATeamService,
    pdfgenService: PiaPdfgenService,
    journalpostService: JournalpostService,
    azureService: AzureService,
    adGrupper: ADGrupper,
    auditLog: AuditLog,
) {
    get("$SPØRREUNDERSØKELSE_BASE_ROUTE/{orgnummer}/{saksnummer}/prosess/{prosessId}/") {
        // hent alle spørreundersøkelser i et samarbeid
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)
        val orgnummer = call.orgnummer ?: return@get call.sendFeil(IASakError.`ugyldig orgnummer`)
        val prosessId = call.prosessId ?: return@get call.sendFeil(IASamarbeidFeil.`ugyldig samarbeidId`)

        call.somLesebruker(adGrupper = adGrupper) { _ ->
            iaSakService.hentIASakDto(saksnummer = saksnummer).flatMap { iaSak ->
                spørreundersøkelseService.hentSpørreundersøkelser(
                    sak = iaSak,
                    prosessId = prosessId,
                )
            }
        }.also { spørreundersøkelseEither ->
            auditLog.auditloggEither(
                call = call,
                either = spørreundersøkelseEither,
                orgnummer = orgnummer,
                auditType = AuditType.access,
                saksnummer = saksnummer,
            )
        }.map { liste ->
            call.respond(
                HttpStatusCode.OK,
                liste.map {
                    val publiseringStatus = dokumentPubliseringService.hentPubliseringStatus(it.id, it.type.name.tilDokumentTilPubliseringType())
                    it.tilUtenInnholdDto(publiseringStatus)
                },
            )
        }.mapLeft {
            call.respond(it.httpStatusCode, it.feilmelding)
        }
    }

    get("$SPØRREUNDERSØKELSE_BASE_ROUTE/{orgnummer}/{saksnummer}/prosess/{prosessId}/type/{type}") {
        // hent alle spørreundersøkelser av en gitt type
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)
        val orgnummer = call.orgnummer ?: return@get call.sendFeil(IASakError.`ugyldig orgnummer`)
        val prosessId = call.prosessId ?: return@get call.sendFeil(IASamarbeidFeil.`ugyldig samarbeidId`)
        val type = call.type ?: return@get call.sendFeil(IASakSpørreundersøkelseError.`ugyldig type`)

        call.somLesebruker(adGrupper = adGrupper) { _ ->
            spørreundersøkelseService.hentSpørreundersøkelser(
                saksnummer = saksnummer,
                prosessId = prosessId,
                type = type,
            )
        }.also { spørreundersøkelseEither ->
            auditLog.auditloggEither(
                call = call,
                either = spørreundersøkelseEither,
                orgnummer = orgnummer,
                auditType = AuditType.access,
                saksnummer = saksnummer,
            )
        }.map { liste ->
            call.respond(
                HttpStatusCode.OK,
                liste.map {
                    val publiseringStatus = dokumentPubliseringService.hentPubliseringStatus(it.id, it.type.name.tilDokumentTilPubliseringType())
                    it.tilUtenInnholdDto(publiseringStatus)
                },
            )
        }.mapLeft {
            call.respond(it.httpStatusCode, it.feilmelding)
        }
    }

    get("$SPØRREUNDERSØKELSE_BASE_ROUTE/{orgnummer}/{saksnummer}/prosess/{prosessId}/type/{type}/{sporreundersokelseId}") {
        val id = call.spørreundersøkelseId ?: return@get call.sendFeil(IASakSpørreundersøkelseError.`ugyldig id`)
        val saksnummer = call.saksnummer ?: return@get call.sendFeil(IASakError.`ugyldig saksnummer`)
        val orgnummer = call.orgnummer ?: return@get call.sendFeil(IASakError.`ugyldig orgnummer`)
        call.type ?: return@get call.sendFeil(IASakSpørreundersøkelseError.`ugyldig type`)

        call.somLesebruker(adGrupper = adGrupper) { _ ->
            iaSakService.hentIASakDto(saksnummer = saksnummer).flatMap { _ ->
                spørreundersøkelseService.hentSpørreundersøkelse(spørreundersøkelseId = id)
            }
        }.also { spørreundersøkelseEither ->
            auditLog.auditloggEither(
                call = call,
                either = spørreundersøkelseEither,
                orgnummer = orgnummer,
                auditType = AuditType.access,
                saksnummer = saksnummer,
            )
        }.map {
            val publiseringStatus = dokumentPubliseringService.hentPubliseringStatus(it.id, it.type.name.tilDokumentTilPubliseringType())
            call.respond(HttpStatusCode.OK, it.tilDto(publiseringStatus))
        }.mapLeft {
            call.respond(it.httpStatusCode, it.feilmelding)
        }
    }

    get("$SPØRREUNDERSØKELSE_BASE_ROUTE/{orgnummer}/{saksnummer}/{sporreundersokelseId}") {
        val id = call.spørreundersøkelseId ?: return@get call.sendFeil(IASakSpørreundersøkelseError.`ugyldig id`)

        call.somLesebruker(adGrupper = adGrupper) { _ ->
            spørreundersøkelseService.hentFullførtSpørreundersøkelse(spørreundersøkelseId = id)
        }.also { spørreundersøkelseResultatEither ->
            auditLog.auditloggEither(
                call = call,
                either = spørreundersøkelseResultatEither,
                orgnummer = call.orgnummer,
                auditType = AuditType.access,
                saksnummer = call.saksnummer,
            )
        }.map {
            call.respond(HttpStatusCode.OK, it.tilResultatDto())
        }.mapLeft {
            call.respond(it.httpStatusCode, it.feilmelding)
        }
    }

    put("$SPØRREUNDERSØKELSE_BASE_ROUTE/{sporreundersokelseId}") {
        val id = call.spørreundersøkelseId ?: return@put call.sendFeil(IASakSpørreundersøkelseError.`ugyldig id`)
        val input = call.receive<OppdaterBehovsvurderingDto>()

        call.somSaksbehandler(adGrupper) { saksbehandler ->
            val iaSak = iaSakService.hentIASakDto(saksnummer = input.saksnummer).getOrNull()
                ?: return@somSaksbehandler IASakError.`ugyldig saksnummer`.left()

            if (!iaTeamService.erEierEllerFølgerAvSak(
                    saksnummer = iaSak.saksnummer,
                    eierAvSak = iaSak.eidAv,
                    saksbehandler = saksbehandler,
                )
            ) {
                return@somSaksbehandler IASakError.`er ikke følger eller eier av sak`.left()
            }
            spørreundersøkelseService.oppdaterSamarbeidIdISpørreundersøkelse(
                spørreundersøkelseId = id,
                oppdaterSpørreundersøkelseDto = input,
            )
        }.also { spørreundersøkelseEither ->
            auditLog.auditloggEither(
                call = call,
                either = spørreundersøkelseEither,
                orgnummer = input.orgnummer,
                auditType = AuditType.update,
                saksnummer = input.saksnummer,
            )
        }.map {
            val publiseringStatus = dokumentPubliseringService.hentPubliseringStatus(it.id, it.type.name.tilDokumentTilPubliseringType())
            call.respond(HttpStatusCode.OK, it.tilDto(publiseringStatus))
        }.mapLeft {
            call.sendFeil(it)
        }
    }

    get("$SPØRREUNDERSØKELSE_BASE_ROUTE/{orgnummer}/{saksnummer}/{sporreundersokelseId}/pdf") {
        val spørreundersøkelseId = call.spørreundersøkelseId ?: return@get call.sendFeil(IASakSpørreundersøkelseError.`ugyldig id`)

        call.somLesebruker(adGrupper) { navansatt ->
            spørreundersøkelseService.hentFullførtSpørreundersøkelse(spørreundersøkelseId)
                .flatMap { spørreundersøkelse ->

                    runBlocking {
                        azureService.hentNavenhet(call.objectId()).map { navenhet ->
                            call.response.header(
                                name = HttpHeaders.ContentDisposition,
                                value = ContentDisposition.Attachment.withParameter(
                                    key = ContentDisposition.Parameters.FileName,
                                    value = spørreundersøkelse.filnavn(),
                                ).toString(),
                            )

                            // lag en pdf for deling til arbeidsgiver
                            val delePdf = pdfgenService.hentPdfForKartleggingresultater(spørreundersøkelse, navenhet)

                            // send journalpost til joark
                            journalpostService.journalfør(spørreundersøkelse, navansatt, navenhet)

                            // returner "dele pdf"
                            delePdf
                        }
                    }
                }
        }.also { spørreundersøkelseEither ->
            auditLog.auditloggEither(
                call = call,
                either = spørreundersøkelseEither,
                orgnummer = call.orgnummer,
                auditType = AuditType.access,
                saksnummer = call.saksnummer,
            )
        }.mapLeft {
            call.sendFeil(it)
        }.map {
            call.respond(message = it, status = HttpStatusCode.OK)
        }
    }
}

private fun Spørreundersøkelse.filnavn(): String {
    val gjennomført =
        (
            fullførtTidspunkt
                ?: endretTidspunkt
                ?: opprettetTidspunkt
        ).toJavaLocalDateTime().toLocalDate().format(DateTimeFormatter.ISO_DATE)
    val filnavn =
        """
        ${type.name.lowercase().replaceFirstChar { it.uppercase() }}-$gjennomført.pdf
        """.trimIndent()
    return filnavn
}

object IASakSpørreundersøkelseError {
    val `ikke støttet statusendring` = Feil(
        "Ikke en støttet statusendring",
        HttpStatusCode.Forbidden,
    )
    val `ikke påbegynt` = Feil(
        "Spørreundersøkelse er ikke i status '${Spørreundersøkelse.Status.PÅBEGYNT.name}', kan ikke avslutte",
        HttpStatusCode.Forbidden,
    )
    val `feil status kan ikke starte` = Feil(
        "Kan ikke starte spørreundersøkelse, feil status",
        HttpStatusCode.Forbidden,
    )
    val `kan ikke slettes` = Feil(
        "Kan ikke slette spørreundersøkelse. Har minst ett svar",
        HttpStatusCode.Forbidden,
    )
    val `publisert, kan ikke slettes` = Feil(
        "Kan ikke slette spørreundersøkelse. Den er publisert",
        HttpStatusCode.Forbidden,
    )
    val `allerede slettet` = Feil(
        "Kan ikke slette spørreundersøkelse. Den er allerede slettet",
        HttpStatusCode.Forbidden,
    )
    val `ikke avsluttet` = Feil(
        "Spørreundersøkelse er ikke i forventet status: '${Spørreundersøkelse.Status.AVSLUTTET.name}'",
        HttpStatusCode.Forbidden,
    )
    val `ikke avsluttet, kan ikke bytte samarbeid` = Feil(
        "Spørreundersøkelse er ikke i status '${Spørreundersøkelse.Status.AVSLUTTET.name}', kan ikke bytte samarbeid",
        HttpStatusCode.BadRequest,
    )
    val `publisert, kan ikke bytte samarbeid` = Feil(
        "Spørreundersøkelse er publisert, kan ikke bytte samarbeid",
        HttpStatusCode.BadRequest,
    )
    val `generell feil under uthenting` = Feil(
        "Generell feil under uthenting av en spørreundersøkelse",
        HttpStatusCode.InternalServerError,
    )
    val `feil under oppdatering` = Feil(
        "Feil under oppdatering av spørreundersøkelse",
        HttpStatusCode.InternalServerError,
    )
    val `sak ikke i rett status` = Feil(
        "Sak er ikke i rett status",
        HttpStatusCode.Forbidden,
    )
    val `ugyldig id` = Feil(
        "Ugyldig spørreundersøkelse",
        HttpStatusCode.BadRequest,
    )
    val `ugyldig temaId` = Feil(
        "Ugyldig tema",
        HttpStatusCode.BadRequest,
    )
    val `ugyldig type` = Feil(
        "Ugyldig type spørreundersøkelse",
        HttpStatusCode.BadRequest,
    )
}
