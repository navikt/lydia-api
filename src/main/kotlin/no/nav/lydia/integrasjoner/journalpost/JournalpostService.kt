package no.nav.lydia.integrasjoner.journalpost

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import arrow.core.right
import io.ktor.client.HttpClient
import io.ktor.client.engine.cio.CIO
import io.ktor.client.request.bearerAuth
import io.ktor.client.request.parameter
import io.ktor.client.request.post
import io.ktor.client.request.setBody
import io.ktor.client.statement.bodyAsText
import io.ktor.http.ContentType
import io.ktor.http.HttpStatusCode
import io.ktor.http.contentType
import io.ktor.http.isSuccess
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.felles.Feil
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.integrasjoner.pdfgen.PiaPdfgenService
import no.nav.lydia.kartlegging.Spørreundersøkelse
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.tilgangskontroll.obo.OboTokenUtveksler
import org.slf4j.LoggerFactory
import java.util.Base64
import java.util.UUID

class JournalpostService(
    naisEnvironment: NaisEnvironment,
    val pdfgenService: PiaPdfgenService,
    val oboTokenUtveksler: OboTokenUtveksler,
) {
    private val log = LoggerFactory.getLogger(this::class.java)
    private val url = naisEnvironment.integrasjoner.journalpostUrl
    private val scope = naisEnvironment.integrasjoner.journalpostScope
    private val json = Json {
        ignoreUnknownKeys = true
    }
    private val httpClient = HttpClient(CIO)

    fun journalfør(
        spørreundersøkelse: Spørreundersøkelse,
        navAnsatt: NavAnsatt,
        navEnhet: NavEnhet,
    ): Either<Feil, JournalpostResultatDto> =
        runBlocking {
            val base64EnkodetPdf = pdfgenService.hentPdfForJournalføring(spørreundersøkelse, navEnhet).tilBase64()

            oboTokenUtveksler.hentOboTokenForScope(navAnsatt.token, scope).flatMap { oboToken ->
                val journalpostDto = journalpostDto(spørreundersøkelse, navEnhet, base64EnkodetPdf)
                journalfør(journalpostDto, oboToken.access_token)
            }
        }

    private fun journalpostDto(
        spørreundersøkelse: Spørreundersøkelse,
        navEnhet: NavEnhet,
        pdf: String,
    ): JournalpostDto {
        val journalpostDto = JournalpostDto(
            eksternReferanseId = UUID.randomUUID().toString(), // TODO: Er dette riktig?
            tittel = "Kartleggingsresultater",
            tema = JournalpostTema.IAR,
            journalposttype = JournalpostType.UTGAAENDE,
            journalfoerendeEnhet = navEnhet.enhetsnummer,
            kanal = Kanal.L,
            avsenderMottaker = AvsenderMottaker(
                id = spørreundersøkelse.orgnummer,
                idType = IdType.ORGNR,
            ),
            bruker = Bruker(
                id = spørreundersøkelse.orgnummer,
                idType = IdType.ORGNR,
            ),
            sak = Sak(
                sakstype = Sakstype.FAGSAK,
                fagsakId = spørreundersøkelse.saksnummer,
                fagsaksystem = FagsakSystem.FIA,
            ),
            dokumenter = listOf(
                Dokument(
                    tittel = "Kartleggingsresultater",
                    dokumentvarianter = listOf(
                        DokumentVariant(
                            filtype = FilType.PDFA,
                            variantformat = Variantformat.ARKIV,
                            fysiskDokument = pdf,
                        ),
                    ),
                ),
            ),
        )
        return journalpostDto
    }

    private fun ByteArray.tilBase64() = String(Base64.getEncoder().encode(this))

    private suspend fun journalfør(
        journalpostDto: JournalpostDto,
        accessToken: String,
    ): Either<Feil, JournalpostResultatDto> {
        val response = httpClient.post(url) {
            parameter("forsoekFerdigstill", true)
            contentType(ContentType.Application.Json)
            bearerAuth(accessToken)
            setBody(Json.encodeToString<JournalpostDto>(journalpostDto))
        }
        val body = response.bodyAsText()
        return if (response.status.isSuccess()) {
            val resultat = json.decodeFromString<JournalpostResultatDto>(body)
            log.info("Journalførte $resultat")
            resultat.right()
        } else {
            log.error("Klarte ikke å journalføre: ${response.status} $body")
            JournalpostFeil.FeillendeJournalpost.left()
        }
    }

    object JournalpostFeil {
        val FeillendeJournalpost = Feil(
            feilmelding = "Klarte ikke å journalføre",
            httpStatusCode = HttpStatusCode.InternalServerError,
        )
    }
}
