package no.nav.lydia.integrasjoner.ssb

import com.google.gson.GsonBuilder
import com.google.gson.stream.JsonReader
import io.ktor.client.HttpClient
import io.ktor.client.engine.cio.CIO
import io.ktor.client.request.get
import io.ktor.client.statement.readRawBytes
import org.slf4j.LoggerFactory
import java.io.ByteArrayInputStream
import java.io.File
import java.io.InputStreamReader

class NæringsDownloader(
    val url: String,
    val næringsRepository: NæringsRepository,
) {
    private val log = LoggerFactory.getLogger(this.javaClass)
    private val httpClient = HttpClient(CIO)

    fun lastInnNæringerFraFil() {
        // denne er lastet ned fra ssb sitt api (url ligger i nais.yaml)
        File("src/test/resources/næringer.json").inputStream().use { stream ->
            val gson = GsonBuilder().serializeNulls().create()
            JsonReader(InputStreamReader(stream)).use { reader ->
                reader.beginObject()
                while (reader.hasNext() && !reader.nextName().equals("classificationItems")) {
                    reader.skipValue()
                }
                reader.beginArray()
                while (reader.hasNext()) {
                    val næringsDto = gson.fromJson<NæringsDto>(reader, NæringsDto::class.java)
                    næringsRepository.settInn(næringsDto)
                }
            }
        }
    }

    suspend fun lastNedNæringer() {
        val start = System.currentTimeMillis()
        log.info("Starter å importere næringer fra ssb")
        try {
            val bytes = httpClient.get(url).readRawBytes()
            val gson = GsonBuilder().serializeNulls().create()
            try {
                JsonReader(InputStreamReader(ByteArrayInputStream(bytes))).use { reader ->
                    reader.beginObject()
                    while (reader.hasNext() && !reader.nextName().equals("classificationItems")) {
                        reader.skipValue()
                    }
                    reader.beginArray()
                    while (reader.hasNext()) {
                        val næringsDto = gson.fromJson<NæringsDto>(reader, NæringsDto::class.java)
                        næringsRepository.settInn(næringsDto)
                    }
                    log.info("Ferdig med å importere næringer fra ssb etter ${System.currentTimeMillis() - start}ms")
                }
            } catch (e: Exception) {
                log.error("Noe gikk galt under nedlasting av næringer", e)
            }
        } catch (e: Exception) {
            log.error("Feil ved nedlastning av næringer (${e.message})", e)
        }
    }
}
