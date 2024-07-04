package no.nav.lydia.sykefraværsstatistikk.api.geografi

import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.decodeFromStream
import no.nav.lydia.sykefraværsstatistikk.api.FylkeOgKommuner

class GeografiService {
    companion object {
        private val jsonParser = Json { ignoreUnknownKeys = true }
        private val alleKommuner = hentKommuner()
        private val alleFylker = hentFylker()

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
    }

    fun hentFylkerOgKommuner(): List<FylkeOgKommuner> {
        return alleFylker
            .map { fylke ->
                FylkeOgKommuner(
                    fylke,
                    alleKommuner.filter { kommune -> kommune.nummer.take(2) == fylke.nummer })
            }
            .toMutableList()
    }

    fun hentKommunerFraFylkesnummer(fylkesnummer: List<String>): List<Kommune> {
        return hentFylkerOgKommuner()
            .filter { fylkesnummer.contains(it.fylke.nummer) }.flatMap { it.kommuner }
    }


    fun hentKommunerFraFylkerOgKommuner(
        fylkesnummerISøk: Set<String>,
        kommunenummerISøk: Set<String>
    ): Set<String> {
        val alleFylkerOgKommuner = hentFylkerOgKommuner()
        val fylkesnummerFraKommunenummerISøk = alleFylkerOgKommuner.filter { fylke ->
            val kommunerIFylke = fylke.kommuner.map { it.nummer }
            kommunenummerISøk.any { kommunerIFylke.contains(it) }
        }.map { it.fylke.nummer }


        val kommunenummerFraFylkesnummerISøk = alleFylkerOgKommuner
            .filterNot { fylkesnummerFraKommunenummerISøk.contains(it.fylke.nummer) }
            .filter { fylkesnummerISøk.contains(it.fylke.nummer) }
            .flatMap { it.kommuner }
            .map { it.nummer }

        return setOf(
            *kommunenummerFraFylkesnummerISøk.toTypedArray(),
            *kommunenummerISøk.toTypedArray()
        )
    }

    fun finnFylke(kommunenummer: String): Fylke? =
        hentFylkerOgKommuner().firstOrNull { it.harKommune(kommunenummer) }?.fylke

    private fun FylkeOgKommuner.harKommune(kommunenummer: String) =
        kommuner.map { it.nummer }.contains(kommunenummer)
}
