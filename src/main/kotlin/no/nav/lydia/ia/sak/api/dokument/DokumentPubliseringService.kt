package no.nav.lydia.ia.sak.api.dokument

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import no.nav.lydia.ia.sak.SpørreundersøkelseService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringProdusent.Companion.medTilsvarendeInnhold
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.util.UUID
import kotlin.jvm.javaClass

class DokumentPubliseringService(
    val dokumentPubliseringRepository: DokumentPubliseringRepository,
    val spørreundersøkelseService: SpørreundersøkelseService,
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

    fun opprettDokumentPublisering(
        dokumentReferanseId: UUID,
        dokumentType: DokumentPublisering.Type,
        opprettetAv: NavAnsatt,
    ): Either<Feil, DokumentPubliseringDto?> {
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

        val spørreundersøkelse = spørreundersøkelseService.hentSpørreundersøkelse(spørreundersøkelseId = dokumentReferanseId).onRight {
            if (it.type != Spørreundersøkelse.Type.Behovsvurdering) {
                return Feil(
                    feilmelding = "Spørreundersøkelse med id: $dokumentReferanseId er ikke av type ${dokumentType.name}",
                    httpStatusCode = HttpStatusCode.BadRequest,
                ).left()
            }
            if (it.status != Spørreundersøkelse.Status.AVSLUTTET) {
                return Feil(
                    feilmelding = "Spørreundersøkelse med id: '$dokumentReferanseId' har ikke status AVSLUTTET, " +
                        "og dermed ikke kan lagres som dokument. Status var: '${it.status.name}'",
                    httpStatusCode = HttpStatusCode.BadRequest,
                ).left()
            }
        }.getOrNull() ?: return Feil(
            feilmelding = "Innhold dokumentet refererer til, med referanseId: '$dokumentReferanseId' og type: '${dokumentType.name}', ble ikke funnet",
            httpStatusCode = HttpStatusCode.NotFound,
        ).left()

        return dokumentPubliseringRepository.opprettDokument(
            referanseId = dokumentReferanseId,
            dokumentType = dokumentType,
            opprettetAv = opprettetAv,
        ).onRight { dokumentPubliseringDto ->
            dokumentPubliseringProdusent.sendPåKafka(dokumentPubliseringDto.medTilsvarendeInnhold(spørreundersøkelse = spørreundersøkelse))
        }
    }
}
