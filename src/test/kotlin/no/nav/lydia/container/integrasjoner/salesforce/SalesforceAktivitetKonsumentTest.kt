package no.nav.lydia.container.integrasjoner.salesforce

import io.kotest.matchers.shouldBe
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.PlanHelper.Companion.opprettEnPlan
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldNotContainLog
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.integrasjoner.salesforce.aktiviteter.SalesforceAktivitetDto
import java.sql.Timestamp
import java.time.LocalDate
import java.time.ZoneId
import java.time.ZonedDateTime
import java.time.format.DateTimeFormatter
import java.util.UUID
import kotlin.test.Ignore
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
        applikasjon shouldNotContainLog "Lagrer.*aktivitet:.*id=${dto.Id__c}".toRegex()
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

        applikasjon shouldContainLog
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

        postgresContainerHelper.hentEnkelKolonne<String>("SELECT saksnummer FROM salesforce_aktiviteter WHERE id = '${dto.Id__c}'") shouldBe sak.saksnummer
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
        postgresContainerHelper.hentEnkelKolonne<Boolean>("SELECT slettet FROM salesforce_aktiviteter WHERE id = '${aktivitet.Id__c}'") shouldBe false

        kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = aktivitet.Id__c,
            melding = Json.encodeToString(aktivitet.copy(EventType__c = "Deleted")),
            topic = Topic.SALESFORCE_AKTIVITET_TOPIC,
        )
        postgresContainerHelper.hentEnkelKolonne<Boolean>("SELECT slettet FROM salesforce_aktiviteter WHERE id = '${aktivitet.Id__c}'") shouldBe true

        kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = aktivitet.Id__c,
            melding = Json.encodeToString(aktivitet.copy(EventType__c = "Undeleted")),
            topic = Topic.SALESFORCE_AKTIVITET_TOPIC,
        )
        postgresContainerHelper.hentEnkelKolonne<Boolean>("SELECT slettet FROM salesforce_aktiviteter WHERE id = '${aktivitet.Id__c}'") shouldBe false
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
        postgresContainerHelper.hentEnkelKolonne<String?>("SELECT plan_id FROM salesforce_aktiviteter WHERE id = '${aktivitet.Id__c}'") shouldBe null

        val planId = sak.opprettEnPlan(samarbeidId = samarbeid.id).id
        val sistEndretISalesforce = ZonedDateTime.now()
        val oppdatertAktivitet = aktivitet.copy(
            LastModifiedDate__c = sistEndretISalesforce.format(utcFormat),
            IAPlanId__c = planId,
            EventType__c = "Updated",
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = aktivitet.Id__c,
            melding = Json.encodeToString(oppdatertAktivitet),
            topic = Topic.SALESFORCE_AKTIVITET_TOPIC,
        )
        postgresContainerHelper.hentEnkelKolonne<String>("SELECT plan_id FROM salesforce_aktiviteter WHERE id = '${aktivitet.Id__c}'") shouldBe planId

        kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = aktivitet.Id__c,
            melding = Json.encodeToString(
                oppdatertAktivitet.copy(
                    TaskEvent__c = "Oppgave",
                    LastModifiedDate__c = sistEndretISalesforce.minusHours(12).format(utcFormat),
                ),
            ),
            topic = Topic.SALESFORCE_AKTIVITET_TOPIC,
        )
        postgresContainerHelper.hentEnkelKolonne<String>(
            "SELECT type FROM salesforce_aktiviteter WHERE id = '${aktivitet.Id__c}'",
        ) shouldBe "Møte"
    }

    @Test
    @Ignore("Det er noen problemer med tidsoner i github runneren som gjør at denne feiler ved bygg :O")
    fun `skal lagre tider i riktig lokal dato`() {
        val sak = nySakIViBistår()
        val samarbeidId = sak.hentAlleSamarbeid().first().id

        val møteStart = ZonedDateTime.now(atUTC)
        val møteSlutt = ZonedDateTime.now(atUTC).plusHours(1)
        val oppgavePlanlagt = ZonedDateTime.of(LocalDate.now().atStartOfDay(), ZoneId.of("Europe/Oslo")).withZoneSameInstant(atUTC)
        val oppgaveFullført = null

        val aktivitet = salesforceAktivitetDto(
            saksnummer = sak.saksnummer,
            samarbeidId = samarbeidId,
            møteStart = møteStart.format(utcFormat),
            møteSlutt = møteSlutt.format(utcFormat),
            oppgavePlanlagt = oppgavePlanlagt.format(utcFormat),
            oppgaveFullført = oppgaveFullført,
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = aktivitet.Id__c,
            melding = Json.encodeToString(aktivitet),
            topic = Topic.SALESFORCE_AKTIVITET_TOPIC,
        )

        postgresContainerHelper.hentEnkelKolonne<Timestamp>(
            "SELECT mote_start FROM salesforce_aktiviteter WHERE id = '${aktivitet.Id__c}'",
        ).time shouldBe møteStart.toEpochSecond() * 1000
        postgresContainerHelper.hentEnkelKolonne<Timestamp>(
            "SELECT mote_slutt FROM salesforce_aktiviteter WHERE id = '${aktivitet.Id__c}'",
        ).time shouldBe møteSlutt.toEpochSecond() * 1000
        postgresContainerHelper.hentEnkelKolonne<Timestamp>(
            "SELECT oppgave_planlagt FROM salesforce_aktiviteter WHERE id = '${aktivitet.Id__c}'",
        ).time shouldBe oppgavePlanlagt.toEpochSecond() * 1000
        postgresContainerHelper.hentEnkelKolonne<Timestamp?>(
            "SELECT oppgave_fullfort FROM salesforce_aktiviteter WHERE id = '${aktivitet.Id__c}'",
        ) shouldBe null
    }

    private val atUTC = ZoneId.of("UTC")
    private val utcFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss'Z'")

    private fun salesforceAktivitetDto(
        hendelsesType: String = "Created",
        saksnummer: String? = null,
        orgnummer: String? = null,
        samarbeidId: Int? = null,
        planId: String? = null,
        type: String = "Møte",
        sistEndretSalesforce: String = ZonedDateTime.now(atUTC).format(utcFormat),
        møteStart: String? = ZonedDateTime.now(atUTC).format(utcFormat),
        møteSlutt: String? = ZonedDateTime.now(atUTC).plusHours(1).format(utcFormat),
        oppgavePlanlagt: String? = ZonedDateTime.of(LocalDate.now().atStartOfDay(), ZoneId.of("Europe/Oslo")).withZoneSameInstant(atUTC).format(utcFormat),
        oppgaveFullført: String? = null,
    ) = SalesforceAktivitetDto(
        Id__c = UUID.randomUUID().toString(),
        LastModifiedDate__c = sistEndretSalesforce,
        EventType__c = hendelsesType,
        TaskEvent__c = type,
        IACaseNumber__c = saksnummer,
        IACooperationId__c = "${samarbeidId ?: ""}",
        IAPlanId__c = planId ?: "",
        Service__c = "Sykefraværsarbeid",
        IASubtheme__c = "Sykefraværsrutiner",
        ActivityDate__c = oppgavePlanlagt,
        CompletedDate__c = oppgaveFullført,
        StartDateTime__c = møteStart,
        EndDateTime__c = møteSlutt,
        Status__c = "",
        AccountOrgNumber__c = orgnummer,
    )
}
