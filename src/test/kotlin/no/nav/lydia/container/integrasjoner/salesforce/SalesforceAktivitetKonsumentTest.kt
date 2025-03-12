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
import java.time.ZonedDateTime
import java.time.format.DateTimeFormatter
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
            "Lagrer IKKE aktivitet:.*id=${dto.Id__c},.* type=${dto.TaskEvent__c}, saksnummer=${dto.IACaseNumber__c}".toRegex()
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
    fun `skal ikke lagre aktiviteter dersom planId er feil`() {
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

    @Test
    fun `skal kun oppdatere aktivitet dersom den har nyere sistEndret`() {
        val sak = nySakIViBistår()
        val samarbeid = sak.hentAlleSamarbeid().first()
        val aktivitet = salesforceAktivitetDto(
            saksnummer = sak.saksnummer,
            orgnummer = sak.orgnr,
            samarbeidId = samarbeid.id,
            type = "Møte",
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = aktivitet.Id__c,
            melding = Json.encodeToString(aktivitet),
            topic = Topic.SALESFORCE_AKTIVITET_TOPIC,
        )
        postgresContainer.hentEnkelKolonne<String?>("SELECT plan_id FROM salesforce_aktiviteter WHERE id = '${aktivitet.Id__c}'") shouldBe null

        val planId = sak.opprettEnPlan(samarbeidId = samarbeid.id).id
        val sistEndretISalesforce = ZonedDateTime.now()
        val oppdatertAktivitet = aktivitet.copy(
            LastModifiedDate__c = sistEndretISalesforce.format(DateTimeFormatter.ISO_DATE_TIME),
            IAPlanId__c = planId,
            EventType__c = "Updated",
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = aktivitet.Id__c,
            melding = Json.encodeToString(oppdatertAktivitet),
            topic = Topic.SALESFORCE_AKTIVITET_TOPIC,
        )
        postgresContainer.hentEnkelKolonne<String>("SELECT plan_id FROM salesforce_aktiviteter WHERE id = '${aktivitet.Id__c}'") shouldBe planId

        kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = aktivitet.Id__c,
            melding = Json.encodeToString(
                oppdatertAktivitet.copy(
                    TaskEvent__c = "Oppgave",
                    LastModifiedDate__c = sistEndretISalesforce.minusHours(12).format(DateTimeFormatter.ISO_DATE_TIME),
                ),
            ),
            topic = Topic.SALESFORCE_AKTIVITET_TOPIC,
        )
        postgresContainer.hentEnkelKolonne<String>(
            "SELECT type FROM salesforce_aktiviteter WHERE id = '${aktivitet.Id__c}'",
        ) shouldBe "Møte"
    }

    private fun salesforceAktivitetDto(
        hendelsesType: String = "Created",
        saksnummer: String? = null,
        orgnummer: String? = null,
        samarbeidId: Int? = null,
        planId: String? = null,
        type: String = "Møte",
        sistEndret: ZonedDateTime = ZonedDateTime.now(),
    ) = SalesforceAktivitetDto(
        Id__c = UUID.randomUUID().toString(),
        LastModifiedDate__c = sistEndret.format(DateTimeFormatter.ISO_DATE_TIME),
        EventType__c = hendelsesType,
        TaskEvent__c = type,
        IACaseNumber__c = saksnummer,
        IACooperationId__c = "${samarbeidId ?: ""}",
        IAPlanId__c = planId ?: "",
        Service__c = "Sykefraværsarbeid",
        IASubtheme__c = "Sykefraværsrutiner",
        ActivityDate__c = "2025-03-04T00:00:00Z",
        CompletedDate__c = null,
        StartDateTime__c = "2025-03-04T13:00:00Z",
        EndDateTime__c = "2025-03-04T14:00:00Z",
        Status__c = "",
        AccountOrgNumber__c = orgnummer,
    )
}
