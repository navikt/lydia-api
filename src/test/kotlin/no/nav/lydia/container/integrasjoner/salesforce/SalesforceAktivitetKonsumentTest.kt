package no.nav.lydia.container.integrasjoner.salesforce

import io.kotest.matchers.shouldBe
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.PlanHelper.Companion.opprettEnPlan
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldNotContainLog
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.integrasjoner.salesforce.aktiviteter.SalesforceAktivitetDto
import java.util.UUID
import kotlin.test.Test

class SalesforceAktivitetKonsumentTest {
    @Test
    fun `skal ikke behandle meldinger uten ia-saksnummer`() {
        val dto = salesforceAktivitetDto()
        kafkaContainerHelper.sendOgVentTilKonsumert(
            dto.Id__c,
            Json.encodeToString(dto),
            Topic.SALESFORCE_AKTIVITET_TOPIC,
        )
        TestContainerHelper.lydiaApiContainer shouldNotContainLog "Lagrer.*aktivitet:.*id=${dto.Id__c}".toRegex()
    }

    @Test
    fun `skal ikke lagre meldinger på sf-aktivitet topic hvis det mangler samarbeids-id`() {
        val sak = nySakIViBistår()
        val dto = salesforceAktivitetDto(saksnummer = sak.saksnummer, orgnummer = sak.orgnr)
        kafkaContainerHelper.sendOgVentTilKonsumert(
            dto.Id__c,
            Json.encodeToString(dto),
            Topic.SALESFORCE_AKTIVITET_TOPIC,
        )

        TestContainerHelper.lydiaApiContainer shouldContainLog
            "Lagrer IKKE aktivitet:.*id=${dto.Id__c}, type=${dto.TaskEvent__c}, saksnummer=${dto.IACaseNumber__c}".toRegex()
    }

    @Test
    fun `kan lagre sf-aktiviteter`() {
        val sak = nySakIViBistår()
        val samarbeidId = sak.hentAlleSamarbeid().first().id

        val dto = salesforceAktivitetDto(
            saksnummer = sak.saksnummer,
            orgnummer = sak.orgnr,
            samarbeidId = samarbeidId,
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = dto.Id__c,
            melding = Json.encodeToString(dto),
            topic = Topic.SALESFORCE_AKTIVITET_TOPIC,
        )

        postgresContainer.hentEnkelKolonne<String>("SELECT saksnummer FROM salesforce_aktiviteter WHERE id = '${dto.Id__c}'") shouldBe sak.saksnummer
    }

    @Test
    fun `skal ikke lagre aktivitetr dersom planId er feil`() {
        val sak = nySakIViBistår()
        val samarbeid = sak.hentAlleSamarbeid().first()
        val aktivitetMedFeilPlanId = salesforceAktivitetDto(
            saksnummer = sak.saksnummer,
            orgnummer = sak.orgnr,
            samarbeidId = samarbeid.id,
            planId = UUID.randomUUID().toString(),
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = aktivitetMedFeilPlanId.Id__c,
            melding = Json.encodeToString(aktivitetMedFeilPlanId),
            topic = Topic.SALESFORCE_AKTIVITET_TOPIC,
        )
        postgresContainer.hentEnkelKolonne<Int>("select count(*) from salesforce_aktiviteter where id = '${aktivitetMedFeilPlanId.Id__c}'") shouldBe 0L

        val plan = sak.opprettEnPlan(samarbeidId = samarbeid.id)
        val aktivitetMedRiktigPlanId = salesforceAktivitetDto(
            saksnummer = sak.saksnummer,
            orgnummer = sak.orgnr,
            samarbeidId = samarbeid.id,
            planId = plan.id,
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = aktivitetMedFeilPlanId.Id__c,
            melding = Json.encodeToString(aktivitetMedRiktigPlanId),
            topic = Topic.SALESFORCE_AKTIVITET_TOPIC,
        )

        postgresContainer.hentEnkelKolonne<Int>("select count(*) from salesforce_aktiviteter where id = '${aktivitetMedRiktigPlanId.Id__c}'") shouldBe 1L
    }

    @Test
    fun `kan slette og gjenopprette sf-aktiviteter`() {
        val sak = nySakIViBistår()
        val samarbeidId = sak.hentAlleSamarbeid().first().id

        val aktivitet = salesforceAktivitetDto(
            saksnummer = sak.saksnummer,
            orgnummer = sak.orgnr,
            samarbeidId = samarbeidId,
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = aktivitet.Id__c,
            melding = Json.encodeToString(aktivitet),
            topic = Topic.SALESFORCE_AKTIVITET_TOPIC,
        )
        postgresContainer.hentEnkelKolonne<Boolean>("SELECT slettet FROM salesforce_aktiviteter WHERE id = '${aktivitet.Id__c}'") shouldBe false

        kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = aktivitet.Id__c,
            melding = Json.encodeToString(aktivitet.copy(EventType__c = "Deleted")),
            topic = Topic.SALESFORCE_AKTIVITET_TOPIC,
        )
        postgresContainer.hentEnkelKolonne<Boolean>("SELECT slettet FROM salesforce_aktiviteter WHERE id = '${aktivitet.Id__c}'") shouldBe true

        kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = aktivitet.Id__c,
            melding = Json.encodeToString(aktivitet.copy(EventType__c = "Undeleted")),
            topic = Topic.SALESFORCE_AKTIVITET_TOPIC,
        )
        postgresContainer.hentEnkelKolonne<Boolean>("SELECT slettet FROM salesforce_aktiviteter WHERE id = '${aktivitet.Id__c}'") shouldBe false
    }

    private fun salesforceAktivitetDto(
        saksnummer: String? = null,
        orgnummer: String? = null,
        samarbeidId: Int? = null,
        planId: String? = null,
    ) = SalesforceAktivitetDto(
        Id__c = UUID.randomUUID().toString(),
        EventType__c = "Created",
        TaskEvent__c = "Møte",
        IACaseNumber__c = saksnummer,
        IACooperationId__c = "${samarbeidId ?: ""}",
        IAPlanId__c = planId ?: "",
        Service__c = "Sykefraværsarbeid",
        IASubtheme__c = "Sykefraværsrutiner",
        ActivityDate__c = "2025-03-04T00:00:00Z",
        CompletedDate__c = null,
        EndDateTime__c = "2025-03-04T14:00:00Z",
        Status__c = "",
        AccountOrgNumber__c = orgnummer,
    )
}
