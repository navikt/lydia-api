package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import ia.felles.integrasjoner.kafkameldinger.SpørreundersøkelseStatus
import java.time.LocalDateTime
import java.util.UUID

data class Spørreundersøkelse(
    val id: UUID,
    val vertId: UUID?,
    val saksnummer: String,
    val orgnummer: String,
    val virksomhetsNavn: String,
    val status: SpørreundersøkelseStatus,
    val tema: List<Tema>,
    val opprettetAv: String,
    val opprettetTidspunkt: LocalDateTime,
    val endretTidspunkt: LocalDateTime?,
)