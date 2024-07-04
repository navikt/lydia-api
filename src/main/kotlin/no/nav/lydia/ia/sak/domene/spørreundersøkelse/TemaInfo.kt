package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import kotlinx.datetime.LocalDateTime


data class TemaInfo(
    val id: Int,
    val rekkefølge: Int,
    val navn: Temanavn,
    val beskrivelse: String,
    val introtekst: String,
    val status: TemaStatus,
    val sistEndret: LocalDateTime,
)

enum class Temanavn {
    UTVIKLE_PARTSSAMARBEID, REDUSERE_SYKEFRAVÆR, ARBEIDSMILJØ
}

enum class TemaStatus {
    AKTIV, INAKTIV
}
