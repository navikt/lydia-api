package no.nav.lydia.integrasjoner.journalpost

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.left
import arrow.core.right
import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.core.extensions.jsonBody
import com.github.kittinunf.fuel.httpPost
import io.ktor.http.HttpStatusCode
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.integrasjoner.pdfgen.PiaPdfgenService
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

    private fun journalfør(
        journalpostDto: JournalpostDto,
        accessToken: String,
    ) = url.httpPost(listOf("forsoekFerdigstill" to true))
        .jsonBody(Json.encodeToString<JournalpostDto>(journalpostDto))
        .authentication().bearer(accessToken)
        .response().third.fold(
            success = {
                val resultat = json.decodeFromString<JournalpostResultatDto>(it.toString(charset = Charsets.UTF_8))
                log.info("Journalførte $resultat")
                resultat.right()
            },
            failure = {
                log.error("Klarte ikke å journalføre", it)
                JournalpostFeil.FeillendeJournalpost.left()
            },
        )

    object JournalpostFeil {
        val FeillendeJournalpost = Feil(
            feilmelding = "Klarte ikke å journalføre",
            httpStatusCode = HttpStatusCode.InternalServerError,
        )
    }
}
