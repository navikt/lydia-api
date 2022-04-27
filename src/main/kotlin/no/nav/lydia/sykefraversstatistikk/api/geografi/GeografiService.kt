package no.nav.lydia.sykefraversstatistikk.api.geografi

import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.decodeFromStream
import no.nav.lydia.sykefraversstatistikk.api.FylkeOgKommuner

class GeografiService {
    companion object {
        private val jsonParser = Json { ignoreUnknownKeys = true }
        private val alleKommuner = hentKommuner()
        private val alleFylker = hentFylker()
        private val VEST_VIKEN_KOMMUNENR = listOf(
            "3025", //ASKER
            "3024", //BÆRUM
            "3005", //DRAMMEN
            "3050", //FLESBERG
            "3039", //FLÅ
            "3041", //GOL
            "3042", //HEMSEDAL
            "3044", //HOL
            "3038", //HOLE
            "3053", //JEVNAKER
            "3006", //KONGSBERG
            "3046", //KRØDSHERAD
            "3049", //LIER
            "3047", //MODUM
            "3040", //NESBYEN
            "3052", //NORE OG UVDAL
            "3007", //RINGERIKE
            "3051", //ROLLAG
            "3045", //SIGDAL
            "3048", //ØVRE EIKER
            "3043"  //ÅL
        )
        private val ØST_VIKEN_KOMMUNENR = listOf(
            "3012", // AREMARK
            "3026", // AURSKOG-HØLAND
            "3035", // EIDSVOLL
            "3028", // ENEBAKK
            "3004", // FREDRIKSTAD
            "3022", // FROGN
            "3032", // GJERDRUM
            "3001", // HALDEN
            "3037", // HURDAL
            "3011", // HVALER
            "3014", // INDRE ØSTFOLD
            "3030", // LILLESTRØM
            "3029", // LØRENSKOG
            "3013", // MARKER
            "3002", // MOSS
            "3036", // NANNESTAD
            "3034", // NES
            "3023", // NESODDEN
            "3031", // NITTEDAL
            "3020", // NORDRE FOLLO
            "3016", // RAKKESTAD
            "3027", // RÆLINGEN
            "3017", // RÅDE
            "3003", // SARPSBORG
            "3015", // SKIPTVET
            "3033", // ULLENSAKER
            "3019", // VESTBY
            "3018", // VÅLER
            "3021", // ÅS
            "3054" // LUNNER
        )

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
        val fylkerMappetMedKommuner = alleFylker
            .filter { fylke -> fylke.nummer != "30" } // Filtrer ut Viken-kommune, de skilles ut i Øst-Viken og Vest-Viken
            .map { fylke -> FylkeOgKommuner(fylke, alleKommuner.filter { kommune -> kommune.nummer.take(2) == fylke.nummer }) }
            .toMutableList()
        return fylkerMappetMedKommuner
            .apply {
                add(FylkeOgKommuner(Fylke("Øst-Viken", "30"), alleKommuner.filter { ØST_VIKEN_KOMMUNENR.contains(it.nummer) }))
                add(FylkeOgKommuner(Fylke("Vest-Viken", "30"), alleKommuner.filter { VEST_VIKEN_KOMMUNENR.contains(it.nummer) }))
            }
    }

    fun hentKommunerFraFylkesnummer(fylkesnummer: List<String>): List<Kommune> {
        return alleFylker
            .map { fylke -> FylkeOgKommuner(fylke, alleKommuner.filter { kommune -> kommune.nummer.take(2) == fylke.nummer }) }
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
