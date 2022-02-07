package no.nav.lydia.sykefraversstatistikk.api.geografi

import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.decodeFromStream
import no.nav.lydia.sykefraversstatistikk.api.FylkeOgKommuner


class GeografiService {
    private val jsonParser = Json { ignoreUnknownKeys = true }
    val alleKommuner = hentKommuner()
    val alleFylker = hentFylker()

    @OptIn(ExperimentalSerializationApi::class)
    private fun hentFylker(): List<Fylke> {
        val resource = hentRessurs("fylker.json")
        return resource?.openStream()?.use {
            jsonParser.decodeFromStream<List<Fylke>>(it)
        } ?: listOf()
    }

    private fun hentRessurs(filnavn: String) = javaClass.classLoader.getResource(filnavn)

    @OptIn(ExperimentalSerializationApi::class)
    private fun hentKommuner(): List<Kommune> {
        val resource = hentRessurs("kommuner.json")
        return resource?.openStream()?.use {
            jsonParser.decodeFromStream<List<Kommune>>(it)
        } ?: emptyList()
    }

    fun hentFylkerOgKommuner(): List<FylkeOgKommuner> {
        return alleFylker.map { fylke -> FylkeOgKommuner(fylke, alleKommuner.filter { kommune -> kommune.nummer.take(2) == fylke.nummer }) }
    }

    fun hentKommunerFraFylkesnummer(fylkesnummer: List<String>): List<Kommune> {
        return hentFylkerOgKommuner()
            .filter { fylkesnummer.contains(it.fylke.nummer) }
            .flatMap { it.kommuner }
    }


    fun hentKommunerFraFylkerOgKommuner(
        fylkesnummerISøk: Set<String>,
        kommunenummerISøk: Set<String>
    ): Set<String> {
        val alleKommunenummer = alleKommuner.associateBy { it.nummer }
        val kommunerFraFylkesnummer = hentKommunerFraFylkesnummer(fylkesnummerISøk.toList())
        return setOf(
            *kommunenummerISøk.filter { kommunenummer -> alleKommunenummer.containsKey(kommunenummer) }.toTypedArray(),
            *kommunerFraFylkesnummer.map { it.nummer }.toTypedArray()
        )
    }
}
