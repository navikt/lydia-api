package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus
import kotlinx.datetime.LocalDateTime
import java.util.UUID

data class Spørreundersøkelse(
    val id: UUID,
    val saksnummer: String,
    val samarbeidId: Int,
    val orgnummer: String,
    val virksomhetsNavn: String,
    val status: SpørreundersøkelseStatus,
    val type: String,
    val opprettetAv: String,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
    val påbegyntTidspunkt: LocalDateTime?,
    val fullførtTidspunkt: LocalDateTime?,
    val temaer: List<Tema>,
    val gyldigTilTidspunkt: LocalDateTime,
) {
    companion object {
        val ANTALL_TIMER_EN_SPØRREUNDERSØKELSE_ER_TILGJENGELIG = 24L
    }
}
