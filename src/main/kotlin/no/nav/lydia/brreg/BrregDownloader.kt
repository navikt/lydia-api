package no.nav.lydia.brreg

import com.github.kittinunf.fuel.core.Headers
import com.github.kittinunf.fuel.httpGet
import org.slf4j.LoggerFactory
import java.nio.charset.StandardCharsets.UTF_8
import java.util.zip.GZIPInputStream
import kotlin.io.path.*

// Ref: https://data.brreg.no/enhetsregisteret/api/docs/index.html#enheter-lastned
class BrregDownloader {
    val url = "https://data.brreg.no/enhetsregisteret/api/enheter/lastned"
    val log = LoggerFactory.getLogger(this.javaClass)

    fun lastNed() {
        val request =
            url.httpGet()
        request[Headers.ACCEPT] = "application/vnd.brreg.enhetsregisteret.enhet.v1+gzip;charset=UTF-8"
        val (_, _, result) = request.response()
        result.fold(success = {
            val file = createTempFile(prefix = "${System.currentTimeMillis()}", suffix = "brreg-nedlasting.json");
            GZIPInputStream(it.inputStream())
                .bufferedReader(UTF_8)
                .useLines { lines ->
                    file.bufferedWriter().use { bw ->
                        lines.forEach {
                            bw.write(it)
                        }
                    }

                }

            log.info("Lastet ned decompressed fil med størrelse ${file.fileSize()} og path ${file.pathString}")
            // TODO: Gjør json deserializering og lagre i db.
        }, failure = {
            println("Error :( ${it.message}")
        })

    }
}

fun main(args: Array<String>) {
    BrregDownloader().lastNed()
}