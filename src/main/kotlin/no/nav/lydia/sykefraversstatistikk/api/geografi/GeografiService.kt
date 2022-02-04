package no.nav.lydia.sykefraversstatistikk.api.geografi

import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.decodeFromStream
import no.nav.lydia.sykefraversstatistikk.api.FylkeOgKommuner


class GeografiService {
    val JSON_PARSER = Json { ignoreUnknownKeys = true }

    @OptIn(ExperimentalSerializationApi::class)
    fun hentFylker(): List<Fylke> {
        val resource = hentRessurs("fylker.json")
        return resource?.openStream()?.use {
            JSON_PARSER.decodeFromStream<List<Fylke>>(it)
        } ?: listOf()
    }

    private fun hentRessurs(filnavn: String) = javaClass.classLoader.getResource(filnavn)

    @OptIn(ExperimentalSerializationApi::class)
    fun hentKommuner(): List<Kommune> {
        val resource = hentRessurs("kommuner.json")
        return resource?.openStream()?.use {
            JSON_PARSER.decodeFromStream<List<Kommune>>(it)
        } ?: emptyList()
    }

    fun hentFylkerOgKommuner(): List<FylkeOgKommuner> {
        val fylker = hentFylker()
        val kommuner = hentKommuner()
        return fylker.map { fylke -> FylkeOgKommuner(fylke, kommuner.filter { kommune -> kommune.nummer.take(2) == fylke.nummer }) }
    }
}
