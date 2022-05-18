package no.nav.lydia.integrasjoner.brreg

import com.github.kittinunf.fuel.core.Headers
import com.github.kittinunf.fuel.httpGet
import com.google.gson.GsonBuilder
import com.google.gson.stream.JsonReader
import no.nav.lydia.virksomhet.VirksomhetRepository
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.io.IOException
import java.io.InputStreamReader
import java.nio.charset.StandardCharsets.UTF_8
import java.nio.file.Path
import java.util.concurrent.atomic.AtomicBoolean
import java.util.zip.GZIPInputStream
import kotlin.io.path.*

// Ref: https://data.brreg.no/enhetsregisteret/api/docs/index.html#enheter-lastned
class BrregDownloader(
    val url: String = "https://data.brreg.no/enhetsregisteret/api/underenheter/lastned",
    val virksomhetRepository: VirksomhetRepository
) {
    companion object {
        const val underEnhetApplicationType = "application/vnd.brreg.enhetsregisteret.underenhet.v1+gzip;charset=UTF-8"
        var KJØRER_IMPORT = AtomicBoolean(false)
    }

    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun lastNed() {
        KJØRER_IMPORT.set(true)
        val brregKomprimert = lagreTilFil(lastNedUnderEnheterSomZip(), "brreg-nedlasting.json.gz")
        val brregUkomprimert = unzipFil(brregKomprimert)
        brregKomprimert.deleteIfExists()
        importerVirksomheterFraFil(brregUkomprimert)
        brregUkomprimert.deleteIfExists()
        KJØRER_IMPORT.set(false)
    }

    private fun lastNedUnderEnheterSomZip(): ByteArray {
        val request = url.httpGet()
        request[Headers.ACCEPT] = underEnhetApplicationType
        val (_, _, result) = request.response()
        return result.fold(success = { bytes ->
            log.info("Lastet ned komprimert fil med størrelse ${bytes.size / 1024 / 1024} MB")
            bytes
        }, failure = {
            val feilmelding = "Kall mot BRREG feilet"
            log.error("$feilmelding: $it")
            throw IOException(feilmelding)
        })
    }

    private fun importerVirksomheterFraFil(brregUkomprimert: Path) {
        var importerteBedrifter = 0
        var feilendeBedrifter = 0
        var ikkeRelevanteBedrifter = 0
        log.info("Starter å importere bedrifter fra temporær fil")
        val gson = GsonBuilder().serializeNulls().create()
        JsonReader(InputStreamReader(brregUkomprimert.inputStream())).use { reader ->
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
        log.info("Bedriftsimport ferdig! Importerte bedrifter: $importerteBedrifter, Feilende bedrifter: $feilendeBedrifter, Ikke relevante bedrifter: $ikkeRelevanteBedrifter")
    }

    private fun unzipFil(komprimertFil: Path): Path {
        log.info("Unzipper ${komprimertFil.fileName} med størrelse ${komprimertFil.sizeInMb()} MB")
        val ukomprimertFil = createTempFile(prefix = "${System.currentTimeMillis()}", suffix = "brreg-nedlasting.json")
        GZIPInputStream(komprimertFil.inputStream())
            .bufferedReader(UTF_8)
            .useLines { lines ->
                ukomprimertFil.bufferedWriter().use { bw ->
                    lines.forEach {
                        bw.write(it)
                    }
                }
            }
        log.info("Unzippet ${ukomprimertFil.fileName} til størrelse ${ukomprimertFil.sizeInMb()} MB")
        return ukomprimertFil
    }

    private fun lagreTilFil(filinnhold: ByteArray, filnavn: String) =
        createTempFile(
            prefix = "${System.currentTimeMillis()}",
            suffix = filnavn
        ).also { file -> file.writeBytes(filinnhold) }

}


fun Path.sizeInMb() = this.fileSize() / 1024 / 1024
