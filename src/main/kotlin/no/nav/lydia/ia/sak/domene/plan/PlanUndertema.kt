package no.nav.lydia.ia.sak.domene.plan

import kotlinx.datetime.LocalDate
import kotlinx.datetime.toJavaLocalDate
import kotlinx.datetime.toKotlinLocalDate
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema.Status.AVBRUTT

data class PlanUndertema(
    val id: Int,
    val navn: String,
    val målsetning: String,
    val planlagt: Boolean,
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

    fun copyMedNyStatus(nyStatus: Status): PlanUndertema {
        val iDag = java.time.LocalDate.now()
        var nySluttDato = sluttDato

        if (nyStatus == AVBRUTT
            && startDato != null && startDato.toJavaLocalDate().isBefore(iDag)
            && sluttDato != null && sluttDato.toJavaLocalDate().isAfter(iDag)
        ) {
            nySluttDato = iDag.toKotlinLocalDate()
        }

        return copy(
            status = nyStatus,
            sluttDato = nySluttDato
        )
    }
}
