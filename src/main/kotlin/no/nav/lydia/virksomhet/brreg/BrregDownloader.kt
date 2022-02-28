package no.nav.lydia.virksomhet.brreg

import com.github.kittinunf.fuel.core.Headers
import com.github.kittinunf.fuel.httpGet
import com.google.gson.GsonBuilder
import com.google.gson.stream.JsonReader
import no.nav.lydia.virksomhet.VirksomhetRepository
import org.slf4j.LoggerFactory
import java.io.InputStreamReader
import java.nio.charset.StandardCharsets.UTF_8
import java.util.zip.GZIPInputStream
import kotlin.io.path.bufferedWriter
import kotlin.io.path.createTempFile
import kotlin.io.path.fileSize
import kotlin.io.path.inputStream
import kotlin.io.path.pathString

// Ref: https://data.brreg.no/enhetsregisteret/api/docs/index.html#enheter-lastned
class BrregDownloader(
    val url: String = "https://data.brreg.no/enhetsregisteret/api/underenheter/lastned",
    val virksomhetRepository: VirksomhetRepository
) {
    companion object {
        const val underEnhetApplicationType = "application/vnd.brreg.enhetsregisteret.underenhet.v1+gzip;charset=UTF-8"
    }

    val log = LoggerFactory.getLogger(this.javaClass)

    fun lastNed() {
        val request =
            url.httpGet()
        request[Headers.ACCEPT] = underEnhetApplicationType
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
            val gson = GsonBuilder().serializeNulls().create()
            JsonReader(InputStreamReader(file.inputStream())).use { reader ->
                reader.beginArray()
                while (reader.hasNext()) {
                    val virksomhet = gson.fromJson<VirksomhetDto>(reader, VirksomhetDto::class.java)
                    try {
                        if (virksomhet.beliggenhetsadresse.postnummer == null) {
                            log.info("Virksomhet ${virksomhet.navn} med informasjon ${virksomhet}")
                            continue
                        }
                        virksomhetRepository.insert(virksomhet = virksomhet)
                    } catch (e: NullPointerException) {
                        log.warn("Nullpointer et eller annet sted her er årsaken: ${e.cause?.message} og her er feilen: ${e.message} ${e.stackTraceToString()}")
                    }
                    catch (e: Exception) {
                        log.error("Lagring av virksomhet feilet", e)
                    }
                }
                reader.endArray()
            }
            log.info("Ferdig å importere virksomheter")
        }, failure = {
            log.error("Kall mot BRREG feilet: $it")
        })

    }
}