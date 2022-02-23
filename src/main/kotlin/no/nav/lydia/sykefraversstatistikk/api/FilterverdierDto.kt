package no.nav.lydia.sykefraversstatistikk.api

import kotlinx.serialization.Serializable
import no.nav.lydia.sykefraversstatistikk.api.geografi.Fylke
import no.nav.lydia.sykefraversstatistikk.api.geografi.Kommune

@Serializable
data class FilterverdierDto(
    val fylker: List<FylkeOgKommuner>,
    val næringsgrupper: List<Næringsgruppe> = emptyList(),
    val sorteringsnokler: List<String> = Sorteringsnøkkel.alleSorteringsNøkler()
)

@Serializable
data class FylkeOgKommuner (val fylke: Fylke, val kommuner: List<Kommune>)


@Serializable
data class Næringsgruppe(val navn: String, val kode: String)