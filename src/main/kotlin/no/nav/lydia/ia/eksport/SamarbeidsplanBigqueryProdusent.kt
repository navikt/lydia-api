package no.nav.lydia.ia.eksport

import kotlinx.datetime.LocalDate
import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Observer
import no.nav.lydia.Topic
import no.nav.lydia.appstatus.ObservedPlan
import no.nav.lydia.ia.sak.domene.plan.Plan
import no.nav.lydia.ia.sak.domene.plan.PlanTema
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema

class SamarbeidsplanBigqueryProdusent(
    private val produsent: KafkaProdusent,
) : Observer<ObservedPlan> {
    override fun receive(input: ObservedPlan) {
        sendTilKafka(samarbeidsplan = input.plan)
    }

    fun reEksporter(input: Plan) {
        sendTilKafka(input)
    }

    private fun sendTilKafka(samarbeidsplan: Plan) {
        val kafkaMelding = samarbeidsplan.tilKafkaMelding()
        produsent.sendMelding(Topic.SAMARBEIDSPLAN_BIGQUERY_TOPIC.navn, kafkaMelding.first, kafkaMelding.second)
    }

    companion object {
        fun Plan.tilKafkaMelding(): Pair<String, String> {
            val key = this.id.toString()
            val value = PlanValue(
                id = this.id.toString(),
                samarbeidId = this.samarbeidId,
                sistEndret = this.sistEndret,
                temaer = this.temaer.map { it.tilKafkaMelding() },
            )
            return key to Json.encodeToString(value)
        }

        fun PlanTema.tilKafkaMelding(): TemaValue =
            TemaValue(
                id = id,
                navn = navn,
                inkludert = inkludert,
                innhold = undertemaer.map { it.tilKafkaMelding() },
            )

        fun PlanUndertema.tilKafkaMelding(): InnholdValue =
            InnholdValue(
                id = id,
                navn = navn,
                inkludert = inkludert,
                status = status,
                startDato = startDato,
                sluttDato = sluttDato,
            )
    }

    @Serializable
    data class PlanValue(
        val id: String,
        val samarbeidId: Int,
        val sistEndret: LocalDateTime,
        val temaer: List<TemaValue>,
    )

    @Serializable
    data class TemaValue(
        val id: Int,
        val navn: String,
        val inkludert: Boolean,
        val innhold: List<InnholdValue>,
    )

    @Serializable
    data class InnholdValue(
        val id: Int,
        val navn: String,
        val inkludert: Boolean,
        val status: PlanUndertema.Status?,
        val startDato: LocalDate?,
        val sluttDato: LocalDate?,
    )
}
