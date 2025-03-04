package no.nav.lydia.integrasjoner.salesforce.aktiviteter

import kotlinx.serialization.Serializable

/**
 * Dokumentert på confluence https://confluence.adeo.no/display/PTC/Deling+av+data+via+Kafka
 */
@Serializable
data class SalesforceAktivitetDto(
    val Id__c: String, // -- Id til aktivitet i SF
    val EventType__c: String, // -- Hva slags hendelse (Created ; Updated ; Deleted ; Undeleted)
    val TaskEvent__c: String, // -- Hva slags aktivitet (Møte ; Oppgave)
    val IACaseNumber__c: String? = null, // -- IA saksnummer
    val IACooperationId__c: String? = null, // -- Samarbeidsid
    val Service__c: String? = null, // -- Plan - Tema
    val IASubtheme__c: String? = null, // -- Plan - Undertema
    val ActivityDate__c: String? = null, // -- Planlagt tid for aktivitet
    val CompletedDate__c: String? = null, // -- Når en oppdage ble fullført
    val EndDateTime__c: String? = null, // -- Når et møte er planlagt ferdig
    val Status__c: String? = null, // -- Status på aktivitet (Åpen ; Fullført)
    val AccountOrgNumber__c: String? = null, // -- Orgnummer aktiviteten gjelder
)
