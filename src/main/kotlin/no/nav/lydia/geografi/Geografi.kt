package no.nav.lydia.geografi

import kotlinx.serialization.Serializable
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json

class Geografi {
    companion object{
        fun hentFylker() : List<Fylke> {
            this::class.java.classLoader.getResource("fylker.json")?.also {
                val json = it.readText()
                return Json.decodeFromString(json)
            }
            return emptyList()
        }
        fun hentKommuner() : List<Kommune> {
            this::class.java.classLoader.getResource("kommuner.json")?.also {
                val json = it.readText()
                return Json.decodeFromString(json)
            }
            return emptyList()
        }

        fun hentFylkerOgKommuner(): Map<Fylke, List<Kommune>> {
            val fylker = hentFylker()
            val kommuner = hentKommuner()
            val fylkerOgKommuner = mutableMapOf<Fylke, List<Kommune>>()
            fylkerOgKommuner.putAll(
                fylker.map { fylke -> Pair(fylke, kommuner.filter { kommune -> kommune.kommunenummer.take(2) == fylke.fylkesnummer }) }
            )
            return fylkerOgKommuner
        }
    }
}

@Serializable
data class Fylke(val fylkesnavn : String, val fylkesnummer: String)
@Serializable
data class Kommune(val kommunenavn : String, val kommunenavnNorsk: String, val kommunenummer: String)

fun main() {
    print(Geografi.hentFylkerOgKommuner().entries.random())
}