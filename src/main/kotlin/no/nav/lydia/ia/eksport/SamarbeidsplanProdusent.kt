package no.nav.lydia.ia.eksport

import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.api.plan.PlanTilSalesforceDto

class SamarbeidsplanProdusent(
    private val produsent: KafkaProdusent,
) {

    fun sendPåKafka(samarbeidsplan: PlanTilSalesforceDto) {
        val (nøkkel, melding) = samarbeidsplan.tilKafkamelding()
        produsent.sendMelding(
            topic = Topic.SAMARBEIDSPLAN_TOPIC.navn,
            nøkkel = nøkkel,
            verdi = melding
        )
    }

    private fun PlanTilSalesforceDto.tilKafkamelding() =
        "${this.saksnummer}-${this.samarbeid.id}-${this.plan.id}" to Json.encodeToString<PlanTilSalesforceDto>(this)

}
