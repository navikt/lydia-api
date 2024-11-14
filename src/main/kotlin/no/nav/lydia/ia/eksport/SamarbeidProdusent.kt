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
            Topic.SAMARBEIDSPLAN_TOPIC.navn,
            samarbeidIVirksomhetDto.tilKey(),
            samarbeidIVirksomhetDto.tilValue()
        )
    }


    private fun SamarbeidIVirksomhetDto.tilKey() =
        Json.encodeToString<SamarbeidKafkaMeldingKey>(
            SamarbeidKafkaMeldingKey(
                saksnummer = this.saksnummer,
                samarbeidId = this.samarbeid.id
            )
        )

    private fun SamarbeidIVirksomhetDto.tilValue() =
        Json.encodeToString<SamarbeidKafkaMeldingValue>(
            SamarbeidKafkaMeldingValue(
                orgnr = this.orgnr,
                saksnummer = this.saksnummer,
                samarbeid = this.samarbeid,
            )
        )
}


data class SamarbeidIVirksomhetDto(
    val orgnr: String,
    val saksnummer: String,
    val samarbeid: SamarbeidDto,
)

@Serializable
data class SamarbeidKafkaMeldingKey(
    val saksnummer: String,
    val samarbeidId: Int,
)

@Serializable
data class SamarbeidKafkaMeldingValue(
    val orgnr: String,
    val saksnummer: String,
    val samarbeid: SamarbeidDto,
)
