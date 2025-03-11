package no.nav.lydia.integrasjoner.salesforce.aktiviteter

import java.time.ZonedDateTime

data class SalesforceAktivitet(
    val id: String,
    val type: AktivitetsType,
    val saksnummer: String,
    val samarbeidsId: Int?,
    val planId: String?,
    val tema: String?,
    val undertema: String?,
    val planlagt: ZonedDateTime?,
    val fullført: ZonedDateTime?,
    val møteStart: ZonedDateTime?,
    val møteSlutt: ZonedDateTime?,
    val status: AktivitetsStatus?,
) {
    companion object {
        enum class AktivitetsType {
            Møte,
            Oppgave,
        }

        enum class AktivitetsStatus {
            Åpen,
            Fullført,
        }
    }
}

internal fun SalesforceAktivitetDto.tilDomene() =
    SalesforceAktivitet(
        id = Id__c,
        type = SalesforceAktivitet.Companion.AktivitetsType.valueOf(TaskEvent__c),
        saksnummer = IACaseNumber__c ?: throw IllegalStateException("mangler saksnummer"),
        samarbeidsId = IACooperationId__c?.let { if (it.isBlank()) null else it.toInt() },
        planId = IAPlanId__c?.let { it.ifBlank { null } },
        tema = Service__c,
        undertema = IASubtheme__c,
        planlagt = ActivityDate__c?.let { ZonedDateTime.parse(it) },
        fullført = CompletedDate__c?.let { ZonedDateTime.parse(it) },
        møteStart = ActivityDate__c?.let { ZonedDateTime.parse(it) },
        møteSlutt = EndDateTime__c?.let { ZonedDateTime.parse(it) },
        status = Status__c?.let {
            if (it.isBlank()) null else SalesforceAktivitet.Companion.AktivitetsStatus.valueOf(it)
        },
    )
