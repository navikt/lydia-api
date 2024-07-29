package no.nav.lydia.ia.sak.domene.spørreundersøkelse

import ia.felles.integrasjoner.kafkameldinger.Temanavn
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

