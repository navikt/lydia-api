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
import kotlinx.serialization.json.Json
import no.nav.fia.dokument.publisering.pdfgen.PdfDokumentDto
import no.nav.fia.dokument.publisering.pdfgen.PdfType
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.NaisEnvironment.Companion.Environment.`DEV-GCP`
import no.nav.lydia.NaisEnvironment.Companion.Environment.`PROD-GCP`
import org.productivity.java.syslog4j.util.Base64

class PiaPdfgenService(
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

    suspend fun genererPdfDokument(
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
