package no.nav.lydia.ia.sak.domene.plan

import kotlinx.datetime.LocalDate

data class PlanUndertema(
    val id: Int,
    val navn: String,
    val målsetning: String,
    val beskrivelse: String,
    val planlagt: Boolean,
    val status: Status?,
    val startDato: LocalDate?,
    val sluttDato: LocalDate?,
) {
    enum class Status {
        PLANLAGT,
        PÅGÅR,
        FULLFØRT
    }
}
