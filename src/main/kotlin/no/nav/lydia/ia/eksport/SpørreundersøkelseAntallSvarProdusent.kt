package no.nav.lydia.ia.eksport

import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.api.kartlegging.toDto
import no.nav.lydia.ia.sak.domene.SpørreundersøkelseAntallSvar

class SpørreundersøkelseAntallSvarProdusent(
    private val produsent: KafkaProdusent,
) {
    fun sendPåKafka(antallSvar: SpørreundersøkelseAntallSvar) {
        produsent.sendMelding(
            topic = Topic.SPORREUNDERSOKELSE_ANTALL_SVAR_TOPIC.navn,
            nøkkel = antallSvar.spørreundersøkelseId.toString(),
            verdi = Json.encodeToString(antallSvar.toDto()),
        )
    }
}
