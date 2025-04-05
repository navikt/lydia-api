package no.nav.lydia.integrasjoner.pdfgen

import arrow.core.left
import arrow.core.right
import com.github.kittinunf.fuel.core.extensions.jsonBody
import com.github.kittinunf.fuel.httpPost
import io.ktor.http.HttpStatusCode
import kotlinx.serialization.json.Json
import no.nav.lydia.NaisEnvironment
import no.nav.lydia.ia.sak.api.Feil
import java.util.Base64

class PiaPdfgenService(
    val naisEnvironment: NaisEnvironment,
) {
    val url = naisEnvironment.integrasjoner.piaPdfgenUrl

    fun genererBase64EnkodetBistandPdf(iaSamarbeidDto: IASamarbeidDto) =
        when (naisEnvironment.miljø) {
            NaisEnvironment.Companion.Environment.`PROD-GCP`, NaisEnvironment.Companion.Environment.`DEV-GCP` -> genererPdfDokument(
                PdfType.IA_SAMARBEID,
                Json.encodeToString<IASamarbeidDto>(iaSamarbeidDto),
            ).map { it.tilBase64() }
            else -> "".right()
        }

    private fun genererPdfDokument(
        pdfType: PdfType,
        json: String,
    ) = "$url/api/v1/genpdf/pia/${pdfType.type}".httpPost()
        .jsonBody(json)
        .response().third.fold(
            success = { it.right() },
            failure = { Feil(it.localizedMessage, HttpStatusCode.InternalServerError).left() },
        )

    private fun ByteArray.tilBase64() = String(Base64.getEncoder().encode(this))
}
