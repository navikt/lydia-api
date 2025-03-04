package no.nav.lydia.container.integrasjoner.salesforce

import io.kotest.matchers.shouldBe
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldNotContainLog
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.integrasjoner.salesforce.aktiviteter.SalesforceAktivitetDto
import java.util.UUID
import kotlin.test.Test

class SalesforceAktivitetKonsumentTest {
    @Test
    fun `konsumerer meldinger på sf-aktivitet topic`() {
        TestContainerHelper.kafkaContainerHelper.sendOgVentTilKonsumert(
            "nøkkel",
            melding(id = "id", saksnummer = "saksnummer"),
            Topic.SALESFORCE_AKTIVITET_TOPIC,
        )

        TestContainerHelper.lydiaApiContainer shouldContainLog "Lagrer.*aktivitet:.*id=id, type=Oppgave, saksnummer=saksnummer".toRegex()
    }

    @Test
    fun `kan lagre sf-aktiviteter`() {
        val sak = nySakIViBistår()
        val samarbeidId = sak.hentAlleSamarbeid().first().id

        val dto = salesforceAktivitetDto(sak, samarbeidId)
        TestContainerHelper.kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = dto.Id__c,
            melding = Json.encodeToString(dto),
            topic = Topic.SALESFORCE_AKTIVITET_TOPIC,
        )

        postgresContainer.hentEnkelKolonne<String>("SELECT saksnummer FROM salesforce_aktiviteter WHERE id = '${dto.Id__c}'") shouldBe sak.saksnummer
    }

    private fun salesforceAktivitetDto(
        sak: IASakDto,
        samarbeidId: Int,
    ): SalesforceAktivitetDto {
        val dto =
            SalesforceAktivitetDto(
                Id__c = UUID.randomUUID().toString(),
                EventType__c = "Created",
                TaskEvent__c = "Møte",
                IACaseNumber__c = sak.saksnummer,
                IACooperationId__c = "$samarbeidId",
                Service__c = "Sykefraværsarbeid",
                IASubtheme__c = "Sykefraværsrutiner",
                ActivityDate__c = "2025-03-04T00:00:00Z",
                CompletedDate__c = null,
                EndDateTime__c = "2025-03-04T14:00:00Z",
                Status__c = "",
                AccountOrgNumber__c = sak.orgnr,
            )
        return dto
    }

    @Test
    fun `skal ikke behandle meldinger uten ia-saksnummer`() {
        TestContainerHelper.kafkaContainerHelper.sendOgVentTilKonsumert(
            "nøkkel",
            melding(id = "id2", saksnummer = null),
            Topic.SALESFORCE_AKTIVITET_TOPIC,
        )

        TestContainerHelper.lydiaApiContainer shouldNotContainLog "Lagrer.*aktivitet:.*id=id2, type=Oppgave".toRegex()
    }

    @Test
    fun `skal konsumere meldinger med manglende felt`() {
        TestContainerHelper.kafkaContainerHelper.sendOgVentTilKonsumert(
            "nøkkel",
            meldingMedManglendeFelt(id = "id3"),
            Topic.SALESFORCE_AKTIVITET_TOPIC,
        )

        TestContainerHelper.lydiaApiContainer shouldContainLog "Lagrer.*aktivitet:.*id=id3, type=Oppgave, saksnummer=saksnummer".toRegex()
    }

    private fun melding(
        id: String,
        saksnummer: String? = "saksnummer",
    ) = """
        {
          "CreatedDate": "2025-02-24T18:07:47.467Z",
          "CreatedById": "createdbyid",
          "EventObject__c": "Task",
          "EventType__c": "Created",
          "AccountNavUnit__c": "",
          "AccountOrgNumber__c": "123456789",
          "AccountOrgType__c": "",
          "AccountParentId__c": "",
          "AccountParentOrgNumber__c": "987654321",
          "ActivityDate__c": "2025-02-26T00:00:00Z",
          "ActivityType__c": "Prioritert IA (Fia)",
          "DurationInMinutes__c": null,
          "EndDateTime__c": null,
          "IACaseNumber__c": ${nullOrStringWithQuotes(saksnummer)},
          "IACooperationId__c": "",
          "IASubtheme__c": "Sykefraværsrutiner",
          "Id__c": "$id",
          "LastModifiedDate__c": "2025-02-24T18:07:47Z",
          "Priority__c": "Normal",
          "RecordTypeId__c": "rectypid",
          "RecordTypeName__c": "IA_task",
          "Region__c": "Oslo",
          "ReminderDateTime__c": "2025-02-26T07:00:00Z",
          "Service__c": "Sykefraværsarbeid",
          "StartDateTime__c": null,
          "Status__c": "",
          "Subject__c": "Test for Pia",
          "TaskEvent__c": "Oppgave",
          "CompletedDate__c": null,
          "Type__c": "",
          "Unit__c": "NAV IT",
          "UserNavUnit__c": "2940",
          "WhatId__c": "what",
          "WhoId__c": "",
          "ActivityCreatedDate__c": "2025-02-24T18:07:44Z",
          "DeletedDate__c": null,
          "LastModifiedById__c": "00xxx",
          "OwnerId__c": "00xxx"
        }
        """.trimIndent()

    private fun meldingMedManglendeFelt(
        id: String,
        saksnummer: String? = "saksnummer",
    ) = """
        {
          "CreatedDate": "2025-02-24T18:07:47.467Z",
          "CreatedById": "createdbyid",
          "EventObject__c": "Task",
          "EventType__c": "Created",
          "AccountNavUnit__c": "",
          "AccountOrgNumber__c": "123456789",
          "AccountOrgType__c": "",
          "AccountParentId__c": "",
          "AccountParentOrgNumber__c": "987654321",
          "ActivityDate__c": "2025-02-26T00:00:00Z",
          "ActivityType__c": "Prioritert IA (Fia)",
          "DurationInMinutes__c": null,
          "EndDateTime__c": null,
          "IACaseNumber__c": ${nullOrStringWithQuotes(saksnummer)},
          "IACooperationId__c": "",
          "IASubtheme__c": "Sykefraværsrutiner",
          "Id__c": "$id",
          "LastModifiedDate__c": "2025-02-24T18:07:47Z",
          "Priority__c": "Normal",
          "RecordTypeId__c": "rectypid",
          "RecordTypeName__c": "IA_task",
          "Region__c": "Oslo",
          "ReminderDateTime__c": "2025-02-26T07:00:00Z",
          "Service__c": "Sykefraværsarbeid",
          "StartDateTime__c": null,
          "Status__c": "Fullført",
          "Subject__c": "Test for Pia",
          "TaskEvent__c": "Oppgave",
          "CompletedDate__c": null,
          "Type__c": "",
          "Unit__c": "NAV IT",
          "UserNavUnit__c": "2940",
          "WhatId__c": "what",
          "WhoId__c": "",
          "DeletedDate__c": null,
          "LastModifiedById__c": "00xxx",
          "OwnerId__c": "00xxx"
        }
        """.trimIndent()

    private fun nullOrStringWithQuotes(value: String?): String? = if (value != null) """"$value"""" else null
}
