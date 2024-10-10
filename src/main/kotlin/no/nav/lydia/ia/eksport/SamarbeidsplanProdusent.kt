package no.nav.lydia.ia.eksport

import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.api.plan.PlanDto
import no.nav.lydia.ia.sak.api.plan.tilDto
import no.nav.lydia.ia.sak.domene.plan.Plan

class SamarbeidsplanProdusent(
    private val produsent: KafkaProdusent,
) {

    fun sendPåKafka(samarbeidsplan: Plan) {
        val (nøkkel, melding) = samarbeidsplan.tilKafkamelding()
        produsent.sendMelding(
            topic = Topic.SAMARBEIDSPLAN_TOPIC.navn,
            nøkkel = nøkkel,
            verdi = melding
        )
    }

    private fun Plan.tilKafkamelding() =
        this.id.toString() to Json.encodeToString<PlanDto>(this.tilDto())

}
