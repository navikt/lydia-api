package no.nav.lydia.ia.sak.domene.plan

import kotlinx.datetime.LocalDate
import kotlinx.datetime.toJavaLocalDate

data class PlanUndertema(
    val id: Int,
    val navn: String,
    val målsetning: String,
    val inkludert: Boolean,
    val status: Status?,
    val startDato: LocalDate?,
    val sluttDato: LocalDate?,
) {
    enum class Status {
        PLANLAGT,
        PÅGÅR,
        FULLFØRT,
        AVBRUTT
    }

    fun starterIFremtiden(): Boolean {
        val iDag = java.time.LocalDate.now()
        return startDato != null && startDato.toJavaLocalDate().isAfter(iDag)
                && sluttDato != null && sluttDato.toJavaLocalDate().isAfter(iDag)
    }
}
