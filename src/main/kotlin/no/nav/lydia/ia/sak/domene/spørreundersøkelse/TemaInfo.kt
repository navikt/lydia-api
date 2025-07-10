package no.nav.lydia.ia.sak.domene.spørreundersøkelse

data class TemaInfo(
    val id: Int,
    val navn: String,
    val rekkefølge: Int,
    val undertemaer: List<UndertemaInfo>,
)

data class UndertemaInfo(
    val id: Int,
    val navn: String,
    val rekkefølge: Int,
)
