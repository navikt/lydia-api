package no.nav.lydia.ia.sak.domene.spørreundersøkelse

data class Undertema(
    val id: Int,
    val navn: String,
    val status: Status,
    val rekkefølge: Int,
    val spørsmål: List<Spørsmål>,
) {
    enum class Status {
        AKTIV,
        INAKTIV,
    }
}
