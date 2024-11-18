package no.nav.lydia.ia.eksport

import ia.felles.integrasjoner.kafkameldinger.eksport.InnholdMelding
import ia.felles.integrasjoner.kafkameldinger.eksport.InnholdStatus
import ia.felles.integrasjoner.kafkameldinger.eksport.PlanMelding
import ia.felles.integrasjoner.kafkameldinger.eksport.TemaMelding
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
        override val id: String,
        override val samarbeidId: Int,
        override val sistEndret: LocalDateTime,
        override val temaer: List<TemaValue>,
    ) : PlanMelding

    @Serializable
    data class TemaValue(
        override val id: Int,
        override val navn: String,
        override val inkludert: Boolean,
        override val innhold: List<InnholdValue>,
    ) : TemaMelding

    @Serializable
    data class InnholdValue(
        override val id: Int,
        override val navn: String,
        override val inkludert: Boolean,
        override val status: InnholdStatus?,
        override val startDato: LocalDate?,
        override val sluttDato: LocalDate?,
    ) : InnholdMelding
}
