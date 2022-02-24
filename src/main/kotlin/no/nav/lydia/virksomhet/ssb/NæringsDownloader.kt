package no.nav.lydia.virksomhet.ssb

import com.github.kittinunf.fuel.httpGet
import com.google.gson.GsonBuilder
import com.google.gson.stream.JsonReader
import io.ktor.util.*
import org.slf4j.LoggerFactory
import java.io.ByteArrayInputStream
import java.io.InputStreamReader

class NæringsDownloader(
    val url: String,
    val næringsRepository: NæringsRepository
) {

    private val log = LoggerFactory.getLogger(this.javaClass)

    fun lastNedNæringer() {
        url.httpGet()
            .response().third
            .fold(success = { bytes ->
                val gson = GsonBuilder().serializeNulls().create()

                try {
                    JsonReader(InputStreamReader(ByteArrayInputStream(bytes))).use { reader ->
                        reader.beginObject()
                        while (reader.hasNext() && !reader.nextName().equals("classificationItems"))
                            reader.skipValue()
                        reader.beginArray()
                        while (reader.hasNext()) {
                            val næringsDto = gson.fromJson<NæringsDto>(reader, NæringsDto::class.java)
                            næringsRepository.settInn(næringsDto)
                        }
                    }
                } catch (e: Exception) {
                    log.error(exception = e)
                }
            }, failure = {
                log.error("Feil ved nedlastning av næringer (${it.message})", it.exception)
            })
    }
}

