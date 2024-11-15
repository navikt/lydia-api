package no.nav.lydia.ia.sak.domene.plan

import ia.felles.integrasjoner.kafkameldinger.eksport.InnholdStatus
import kotlinx.datetime.LocalDate
import kotlinx.datetime.toJavaLocalDate

data class PlanUndertema(
    val id: Int,
    val navn: String,
    val målsetning: String,
    val inkludert: Boolean,
    val status: InnholdStatus?,
    val startDato: LocalDate?,
    val sluttDato: LocalDate?,
) {
    fun starterIFremtiden(): Boolean {
        val iDag = java.time.LocalDate.now()
        return startDato != null &&
            startDato.toJavaLocalDate().isAfter(iDag) &&
            sluttDato != null &&
            sluttDato.toJavaLocalDate().isAfter(iDag)
    }
}
