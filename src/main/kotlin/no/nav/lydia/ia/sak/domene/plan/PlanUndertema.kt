package no.nav.lydia.ia.sak.domene.plan

import kotlinx.datetime.LocalDate
import kotlinx.datetime.toJavaLocalDate
import no.nav.lydia.integrasjoner.salesforce.aktiviteter.SalesforceAktivitet

data class PlanUndertema(
    val id: Int,
    val navn: String,
    val målsetning: String,
    val inkludert: Boolean,
    val status: Status?,
    val startDato: LocalDate?,
    val sluttDato: LocalDate?,
    val aktiviteterISalesforce: List<SalesforceAktivitet>,
) {
    fun starterIFremtiden(): Boolean {
        val iDag = java.time.LocalDate.now()
        return startDato != null &&
            startDato.toJavaLocalDate().isAfter(iDag) &&
            sluttDato != null &&
            sluttDato.toJavaLocalDate().isAfter(iDag)
    }

    enum class Status {
        PLANLAGT,
        PÅGÅR,
        FULLFØRT,
        AVBRUTT,
    }
}
