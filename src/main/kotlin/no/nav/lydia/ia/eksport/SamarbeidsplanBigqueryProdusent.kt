package no.nav.lydia.ia.eksport

import ia.felles.integrasjoner.kafkameldinger.eksport.InnholdStatus
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
        val verdi: List<InnholdIPlanMelding> = input.tilKafkaMeldingPlan()
        return nøkkel to Json.encodeToString(verdi)
    }

    private fun Plan.tilKafkaMeldingPlan(): List<InnholdIPlanMelding> =
        temaer.flatMap {
            it.tilKafkaMelding(
                samarbeidId = samarbeidId,
                planId = id.toString(),
                sistEndret = sistEndret,
            )
        }

    private fun PlanTema.tilKafkaMelding(
        planId: String,
        sistEndret: LocalDateTime,
        samarbeidId: Int,
    ): List<InnholdIPlanMelding> =
        undertemaer.map {
            it.tilKafkaMelding(
                samarbeidId = samarbeidId,
                planId = planId,
                temaId = id,
                temanavn = navn,
                sistEndret = sistEndret,
            )
        }

    private fun PlanUndertema.tilKafkaMelding(
        planId: String,
        temaId: Int,
        temanavn: String,
        sistEndret: LocalDateTime,
        samarbeidId: Int,
    ): InnholdIPlanMelding =
        InnholdIPlanMelding(
            id = id,
            temaId = temaId,
            planId = planId,
            samarbeidId = samarbeidId,
            navn = navn,
            temanavn = temanavn,
            inkludert = inkludert,
            sistEndretTidspunktPlan = sistEndret,
            status = status,
            startDato = startDato,
            sluttDato = sluttDato,
        )

    @Serializable
    data class InnholdIPlanMelding(
        val id: Int,
        val temaId: Int,
        val planId: String,
        val samarbeidId: Int,
        val navn: String,
        val temanavn: String,
        val inkludert: Boolean,
        val sistEndretTidspunktPlan: LocalDateTime,
        val status: InnholdStatus?,
        val startDato: LocalDate?,
        val sluttDato: LocalDate?,
    )
}
