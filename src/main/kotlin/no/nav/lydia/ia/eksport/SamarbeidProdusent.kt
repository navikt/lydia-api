package no.nav.lydia.ia.eksport

import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic

class SamarbeidProdusent(
    private val produsent: KafkaProdusent,
) {
    fun sendPåKafka(samarbeidIVirksomhetDto: SamarbeidIVirksomhetDto) {
        produsent.sendMelding(
            topic = Topic.SAMARBEIDSPLAN_TOPIC.navn,
            nøkkel = samarbeidIVirksomhetDto.tilKey(),
            verdi = samarbeidIVirksomhetDto.tilValue(),
        )
    }

    private fun SamarbeidIVirksomhetDto.tilKey() = "${this.saksnummer}-${this.samarbeid.id}"

    private fun SamarbeidIVirksomhetDto.tilValue() =
        Json.encodeToString<SamarbeidKafkaMeldingValue>(
            SamarbeidKafkaMeldingValue(
                orgnr = this.orgnr,
                saksnummer = this.saksnummer,
                samarbeid = this.samarbeid,
            ),
        )
}

data class SamarbeidIVirksomhetDto(
    val orgnr: String,
    val saksnummer: String,
    val samarbeid: SamarbeidDto,
)

@Serializable
data class SamarbeidKafkaMeldingValue(
    val orgnr: String,
    val saksnummer: String,
    val samarbeid: SamarbeidDto,
)
