package no.nav.lydia.integrasjoner.pdfgen

import io.ktor.client.HttpClient
import io.ktor.client.engine.cio.CIO
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.client.request.accept
import io.ktor.client.request.post
import io.ktor.client.request.setBody
import io.ktor.client.request.url
import io.ktor.client.statement.HttpResponse
import io.ktor.client.statement.readRawBytes
import io.ktor.http.ContentType
import io.ktor.http.HttpStatusCode
import io.ktor.http.contentType
import io.ktor.serialization.kotlinx.json.json
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.encodeToJsonElement
import kotlinx.serialization.json.jsonObject
import no.nav.fia.dokument.publisering.pdfgen.PdfDokumentDto
import no.nav.fia.dokument.publisering.pdfgen.PdfType
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.NaisEnvironment.Companion.Environment.`DEV-GCP`
import no.nav.lydia.NaisEnvironment.Companion.Environment.`PROD-GCP`
import no.nav.lydia.ia.sak.IASamarbeidService
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringSakDto
import no.nav.lydia.ia.sak.api.dokument.SamarbeidDto
import no.nav.lydia.ia.sak.api.dokument.VirksomhetDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.tilResultatDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.tilSpørreundersøkelseInnholdDto
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.integrasjoner.azure.NavEnhet
import org.productivity.java.syslog4j.util.Base64
import java.time.LocalDateTime

class PiaPdfgenService(
    val iaSamarbeidService: IASamarbeidService,
    val naisEnvironment: NaisEnvironment,
) {
    val piaPdfgenUrl = naisEnvironment.integrasjoner.piaPdfgenUrl

    private val httpClient = HttpClient(CIO) {
        install(ContentNegotiation) {
            json(
                Json {
                    ignoreUnknownKeys = true
                    encodeDefaults = true
                    isLenient = true
                    allowSpecialFloatingPointValues = true
                    allowStructuredMapKeys = true
                    prettyPrint = false
                    useArrayPolymorphism = false
                },
            )
        }
    }

    suspend fun hentPdfForKartleggingresultater(
        spørreundersøkelse: Spørreundersøkelse,
        navEnhet: NavEnhet,
    ): ByteArray {
        val samarbeidsnavn = iaSamarbeidService.hentSamarbeid(spørreundersøkelse.samarbeidId)?.navn
        return genererPdfDokument(
            pdfType = PdfType.KARTLEGGINGRESULTAT,
            pdfDokumentDto = spørreundersøkelse.tilPdfDokumentDto(samarbeidsnavn, navEnhet),
        )
    }

    private suspend fun genererPdfDokument(
        pdfType: PdfType,
        pdfDokumentDto: PdfDokumentDto,
    ): ByteArray =
        when (naisEnvironment.miljø) {
            `PROD-GCP`, `DEV-GCP` -> {
                val response: HttpResponse = httpClient.post {
                    url("$piaPdfgenUrl/api/v1/genpdf/pia/${pdfType.pathIPiaPdfgen}")
                    contentType(ContentType.Application.Json)
                    accept(ContentType.Application.Json)
                    setBody(Json.encodeToString<PdfDokumentDto>(pdfDokumentDto))
                }

                when (response.status) {
                    HttpStatusCode.OK -> response.readRawBytes()
                    else -> throw RuntimeException("Klarte ikke å generere Pdf. Status: ${response.status}")
                }
            }

            else -> {
                lokalTestPdf
            }
        }
}

private fun Spørreundersøkelse.tilPdfDokumentDto(
    samarbeidsnavn: String?,
    navEnhet: NavEnhet,
) = PdfDokumentDto(
    type = type.tilPdftype(),
    referanseId = id.toString(),
    publiseringsdato = LocalDateTime.now().toKotlinLocalDateTime(),
    virksomhet = VirksomhetDto(
        orgnummer = orgnummer,
        navn = virksomhetsNavn,
    ),
    sak = DokumentPubliseringSakDto(
        saksnummer = saksnummer,
        navenhet = navEnhet,
    ),
    samarbeid = SamarbeidDto(
        id = samarbeidId,
        navn = samarbeidsnavn ?: "",
    ),
    innhold = Json.encodeToJsonElement(
        tilResultatDto().tilSpørreundersøkelseInnholdDto(
            fullførtTidspunkt = fullførtTidspunkt ?: endretTidspunkt ?: opprettetTidspunkt,
        ),
    ).jsonObject,
)

private fun Spørreundersøkelse.Type.tilPdftype() =
    when (this) {
        Spørreundersøkelse.Type.Evaluering -> PdfType.EVALUERING
        Spørreundersøkelse.Type.Behovsvurdering -> PdfType.BEHOVSVURDERING
    }

val lokalTestPdf = Base64.decode(
    """
    JVBERi0xLjQKMSAwIG9iago8PC9UeXBlL0NhdGFsb2cvUGFnZXMgMiAwIFI+PgplbmRvYmoKMiAw
    IG9iago8PC9UeXBlL1BhZ2VzL0tpZHMgWzMgMCBSXS9Db3VudCAxPj4KZW5kb2JqCjMgMCBvYmoK
    PDwvVHlwZS9QYWdlL1BhcmVudCAyIDAgUi9NZWRpYUJveFswIDAgMzAwIDMwMF0vQ29udGVudHMg
    NCAwIFIvUmVzb3VyY2VzPDwvRm9udDw8L0YxIDUgMCBSPj4+Pj4+CmVuZG9iago0IDAgb2JqCjw8
    L0xlbmd0aCA0ND4+CnN0cmVhbQpCVCAvRjEgMjQgVGYgMTAwIDE1MCBUZCAodGVzdCBwZGYpIFRq
    IEVUCmVuZHN0cmVhbQplbmRvYmoKNSAwIG9iago8PC9UeXBlL0ZvbnQvU3VidHlwZS9UeXBlMS9O
    YW1lL0YxL0Jhc2VGb250L0hlbHZldGljYT4+CmVuZG9iagp4cmVmCjAgNgowMDAwMDAwMDAwIDY1
    NTM1IGYgCjAwMDAwMDAwMTAgMDAwMDAgbiAKMDAwMDAwMDA2MCAwMDAwMCBuIAowMDAwMDAwMTI4
    IDAwMDAwIG4gCjAwMDAwMDAyMzAgMDAwMDAgbiAKMDAwMDAwMDMyMCAwMDAwMCBuIAp0cmFpbGVy
    Cjw8L1Jvb3QgMSAwIFIvU2l6ZSA2Pj4Kc3RhcnR4cmVmCjM0NQolJUVPRg==
    """.trimIndent(),
)
