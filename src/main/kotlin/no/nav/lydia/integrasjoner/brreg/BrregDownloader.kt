package no.nav.lydia.integrasjoner.brreg

import com.github.kittinunf.fuel.core.Headers
import com.github.kittinunf.fuel.httpGet
import com.google.gson.GsonBuilder
import com.google.gson.stream.JsonReader
import no.nav.lydia.virksomhet.VirksomhetRepository
import org.slf4j.LoggerFactory
import java.io.InputStreamReader
import java.nio.charset.StandardCharsets.UTF_8
import java.util.zip.GZIPInputStream
import kotlin.io.path.*

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
        val temporærFil = result.fold(success = {
            val file = createTempFile(prefix = "${System.currentTimeMillis()}", suffix = "brreg-nedlasting.json")
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
            file
        }, failure = {
            log.error("Kall mot BRREG feilet: $it")
            null
        })

        temporærFil?.let { file ->
            var importerteBedrifter = 0
            var feilendeBedrifter = 0
            var ikkeRelevanteBedrifter = 0
            log.info("Starter å importere bedrifter fra temporær fil")
            val gson = GsonBuilder().serializeNulls().create()
            JsonReader(InputStreamReader(file.inputStream())).use { reader ->
                reader.beginArray()
                while (reader.hasNext()) {
                    val virksomhet = gson.fromJson<BrregVirksomhetDto>(reader, BrregVirksomhetDto::class.java)
                    when (virksomhet) {
                        null -> {
                            log.debug("Skipper lagring av virksomhet da den er null fra JsonReader")
                            feilendeBedrifter++
                        }
                        else -> {
                            try {
                                virksomhet.beliggenhetsadresse?.let { adresse ->
                                    if (adresse.erRelevant()) {
                                        virksomhetRepository.insert(virksomhet = virksomhet)
                                        importerteBedrifter++
                                    } else {
                                        ikkeRelevanteBedrifter++
                                    }
                                }
                            } catch (e: Exception) {
                                feilendeBedrifter++
                                log.error("Lagring av virksomhet feilet", e)
                            }
                        }
                    }

                    if ((importerteBedrifter + feilendeBedrifter + ikkeRelevanteBedrifter) % 1000 == 0) {
                        log.info("Bedriftsimport fremdrift: Importerte bedrifter: $importerteBedrifter, Feilende bedrifter: $feilendeBedrifter, Ikke relevante bedrifter: $ikkeRelevanteBedrifter")
                    }
                }
                reader.endArray()
            }

            log.info("Bedriftsimport ferig! Importerte bedrifter: $importerteBedrifter, Feilende bedrifter: $feilendeBedrifter, Ikke relevante bedrifter: $ikkeRelevanteBedrifter")
            file.deleteIfExists()
        }
    }
}