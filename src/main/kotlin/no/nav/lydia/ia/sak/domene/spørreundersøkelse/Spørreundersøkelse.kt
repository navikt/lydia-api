package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import kotlinx.datetime.LocalDateTime
import java.util.UUID

data class Spørreundersøkelse(
    val id: UUID,
    val saksnummer: String,
    val samarbeidId: Int,
    val orgnummer: String,
    val virksomhetsNavn: String,
    val status: Status,
    val type: Type,
    val opprettetAv: String,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
    val påbegyntTidspunkt: LocalDateTime?,
    val fullførtTidspunkt: LocalDateTime?,
    val temaer: List<Tema>,
    val gyldigTilTidspunkt: LocalDateTime,
) {
    companion object {
        const val ANTALL_TIMER_EN_SPØRREUNDERSØKELSE_ER_TILGJENGELIG = 24L
        const val MINIMUM_ANTALL_DELTAKERE = 3
    }

    enum class Status {
        OPPRETTET,
        PÅBEGYNT,
        AVSLUTTET,
        SLETTET,
    }

    enum class Type {
        Evaluering,
        Behovsvurdering,
    }

    fun harMinstEttResultat(): Boolean =
        status == Status.AVSLUTTET &&
            temaer.flatMap { it.undertemaer }.flatMap { it.spørsmål }
                .any { it.antallSvar >= MINIMUM_ANTALL_DELTAKERE }

    fun alleTemaErFullført(): Boolean = temaer.all { it.stengtForSvar }

    fun finnSpørsmål(spørsmålId: UUID): Spørsmål? = temaer.flatMap { it.undertemaer }.flatMap { it.spørsmål }.firstOrNull { it.id == spørsmålId }
}
