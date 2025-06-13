package no.nav.lydia.ia.sak.api.dokument

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.util.UUID
import kotlin.jvm.javaClass

class DokumentPubliseringService(
    val dokumentPubliseringRepository: DokumentPubliseringRepository,
) {
    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun hentDokumentPublisering(
        dokumentReferanseId: UUID,
        dokumentType: DokumentPublisering.Type,
    ): Either<Feil, DokumentPubliseringDto> =
        try {
            val liste = dokumentPubliseringRepository.hentDokument(dokumentReferanseId = dokumentReferanseId, dokumentType = dokumentType)
            liste.firstOrNull()
                ?.right()
                ?: Feil(
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
        navAnsatt: NavAnsatt,
    ): Either<Feil, DokumentPubliseringDto?> =
        try {
            val dokumentPublisering = DokumentPublisering(
                dokumentId = UUID.randomUUID(),
                referanseId = dokumentReferanseId,
                dokumentType = dokumentType,
                status = DokumentPublisering.Status.OPPRETTET,
                opprettetAv = navAnsatt,
            )
            dokumentPubliseringRepository.opprettDokument(dokumentPublisering = dokumentPublisering).right()
        } catch (e: Exception) {
            val melding = "Feil ved opprettelse av en dokument til publisering"
            log.warn("$melding. Feilmelding: '${e.message}'", e)
            Feil(feilmelding = melding, httpStatusCode = HttpStatusCode.InternalServerError).left()
        }
}
