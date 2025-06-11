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
}
