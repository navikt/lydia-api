package no.nav.lydia.ia.sak.api.dokument

import arrow.core.Either
import arrow.core.getOrElse
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.LocalDateTime
import no.nav.lydia.ia.sak.IASamarbeidService
import no.nav.lydia.ia.sak.SpørreundersøkelseService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringProdusent.Companion.medTilsvarendeInnhold
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.util.UUID
import kotlin.jvm.javaClass

class DokumentPubliseringService(
    val dokumentPubliseringRepository: DokumentPubliseringRepository,
    val spørreundersøkelseService: SpørreundersøkelseService,
    val samarbeidService: IASamarbeidService,
    val dokumentPubliseringProdusent: DokumentPubliseringProdusent,
) {
    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun hentDokumentPublisering(
        dokumentReferanseId: UUID,
        dokumentType: DokumentPublisering.Type,
    ): Either<Feil, DokumentPubliseringDto> =
        try {
            val liste = dokumentPubliseringRepository.hentDokument(dokumentReferanseId = dokumentReferanseId, dokumentType = dokumentType)
            liste.firstOrNull()?.right() ?: Feil(
                feilmelding = "Ingen dokument funnet for referanseId: $dokumentReferanseId og type: $dokumentType",
                httpStatusCode = HttpStatusCode.NotFound,
            ).left()
        } catch (e: Exception) {
            val melding = "Feil ved henting av en dokument til publisering"
            log.warn("$melding. Feilmelding: '${e.message}'", e)
            Feil(feilmelding = melding, httpStatusCode = HttpStatusCode.InternalServerError).left()
        }

    fun opprettOgSendTilPublisering(
        dokumentReferanseId: UUID,
        dokumentType: DokumentPublisering.Type,
        opprettetAv: NavAnsatt,
        navEnhet: NavEnhet,
    ): Either<Feil, DokumentPubliseringDto> {
        if (hentDokumentPublisering(
                dokumentReferanseId = dokumentReferanseId,
                dokumentType = dokumentType,
            ).isRight()
        ) {
            return Feil(
                feilmelding = "Dokument med referanseId: $dokumentReferanseId og type: $dokumentType finnes allerede",
                httpStatusCode = HttpStatusCode.Conflict,
            ).left()
        }

        val spørreundersøkelse = spørreundersøkelseService.hentSpørreundersøkelse(spørreundersøkelseId = dokumentReferanseId)
            .getOrElse {
                return Feil(
                    feilmelding = "Innhold dokumentet refererer til, med referanseId: '$dokumentReferanseId' og type: '${dokumentType.name}', ble ikke funnet",
                    httpStatusCode = HttpStatusCode.NotFound,
                ).left()
            }

        if (spørreundersøkelse.type != Spørreundersøkelse.Type.Behovsvurdering) {
            return Feil(
                feilmelding = "Spørreundersøkelse med id: $dokumentReferanseId er ikke av type ${dokumentType.name}",
                httpStatusCode = HttpStatusCode.BadRequest,
            ).left()
        }

        if (spørreundersøkelse.status != Spørreundersøkelse.Status.AVSLUTTET || spørreundersøkelse.fullførtTidspunkt == null) {
            return Feil(
                feilmelding = "Spørreundersøkelse med id: '$dokumentReferanseId' har status '${spørreundersøkelse.status}' " +
                    "(forventet ${Spørreundersøkelse.Status.AVSLUTTET}) og/eller mangler fullført tidspunkt, " +
                    "og dermed ikke kan lagres som dokument. ",
                httpStatusCode = HttpStatusCode.BadRequest,
            ).left()
        }

        val spørreundersøkelseResultat = spørreundersøkelseService.hentFullførtSpørreundersøkelse(spørreundersøkelseId = dokumentReferanseId)
            .getOrElse {
                return Feil(
                    feilmelding = "Ingen resultat funnet for referanseId '$dokumentReferanseId' og type: '${dokumentType.name}'",
                    httpStatusCode = HttpStatusCode.NotFound,
                ).left()
            }

        if (spørreundersøkelseResultat.spørsmålMedSvarPerTema.isEmpty()) {
            return Feil(
                feilmelding = "Spørreundersøkelse med id: '$dokumentReferanseId' har ingen resultat , og dermed ikke kan lagres som dokument. ",
                httpStatusCode = HttpStatusCode.BadRequest,
            ).left()
        }

        val fullførtTidspunkt: LocalDateTime = spørreundersøkelse.fullførtTidspunkt
        val spørreundersøkelseOpprettetAv: String = spørreundersøkelse.opprettetAv

        val samarbeid: IASamarbeid =
            samarbeidService.hentSamarbeid(saksnummer = spørreundersøkelse.saksnummer, samarbeidId = spørreundersøkelse.samarbeidId).getOrElse {
                return Feil(
                    feilmelding = "Samarbeid med id: '${spørreundersøkelse.samarbeidId}' ble ikke funnet",
                    httpStatusCode = HttpStatusCode.NotFound,
                ).left()
            }

        return dokumentPubliseringRepository.opprettDokument(
            referanseId = dokumentReferanseId,
            dokumentType = dokumentType,
            opprettetAv = opprettetAv,
        ).onRight { dokumentPubliseringDto ->
            dokumentPubliseringProdusent.sendPåKafka(
                input = dokumentPubliseringDto.medTilsvarendeInnhold(
                    orgnr = spørreundersøkelse.orgnummer,
                    virksomhetsNavn = spørreundersøkelse.virksomhetsNavn,
                    samarbeid = samarbeid,
                    navEnhet = navEnhet,
                    spørreundersøkelseOpprettetAv = spørreundersøkelseOpprettetAv,
                    spørreundersøkelseResultat = spørreundersøkelseResultat,
                    fullførtTidspunkt = fullførtTidspunkt,
                ),
            )
        }
    }
}
