package no.nav.lydia.ia.eksport

import ia.felles.integrasjoner.kafkameldinger.eksport.InnholdMelding
import ia.felles.integrasjoner.kafkameldinger.eksport.InnholdStatus
import ia.felles.integrasjoner.kafkameldinger.eksport.PlanMelding
import ia.felles.integrasjoner.kafkameldinger.eksport.TemaMelding
import kotlinx.datetime.LocalDate
import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.Observer
import no.nav.lydia.Topic
import no.nav.lydia.appstatus.ObservedPlan
import no.nav.lydia.ia.sak.domene.plan.Plan
import no.nav.lydia.ia.sak.domene.plan.PlanTema
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema

class SamarbeidsplanBigqueryProdusent(
    kafka: Kafka,
    topic: Topic = Topic.SAMARBEIDSPLAN_BIGQUERY_TOPIC,
) : KafkaProdusent<Plan>(kafka, topic),
    Observer<ObservedPlan> {
    override fun receive(input: ObservedPlan) = sendPåKafka(input = input.plan)

    fun reEksporter(plan: Plan) = sendPåKafka(input = plan)

    override fun tilKafkaMelding(input: Plan): Pair<String, String> {
        val nøkkel = input.id.toString()
        val verdi = PlanValue(
            id = input.id.toString(),
            samarbeidId = input.samarbeidId,
            sistEndret = input.sistEndret,
            temaer = input.temaer.map { it.tilKafkaMelding() },
        )
        return nøkkel to Json.encodeToString(verdi)
    }

    private fun PlanTema.tilKafkaMelding(): TemaValue =
        TemaValue(
            id = id,
            navn = navn,
            inkludert = inkludert,
            innhold = undertemaer.map { it.tilKafkaMelding() },
        )

    private fun PlanUndertema.tilKafkaMelding(): InnholdValue =
        InnholdValue(
            id = id,
            navn = navn,
            inkludert = inkludert,
            status = status,
            startDato = startDato,
            sluttDato = sluttDato,
        )

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
