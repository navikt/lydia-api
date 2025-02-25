package no.nav.lydia.integrasjoner.salesforce

import kotlinx.serialization.Serializable

/**
 * Dokumentert på confluence https://confluence.adeo.no/display/PTC/Deling+av+data+via+Kafka
 */
@Serializable
data class SalesforceAktivitet(
    val Id__c: String, // -- Id til aktivitet i SF
    val ActivityCreatedDate__c: String?, // -- Når aktiviteten ble opprettet i SF
    val EventObject__c: String, // -- Objekttype i SF (Task ; Event)
    val TaskEvent__c: String, // -- Hva slags aktivitet (Møte ; Oppgave)
    val EventType__c: String, // -- Type hendelse (Created ; Updated ; Deleted ; Undeleted)
    val Type__c: String?, // -- Hvilken kanal er brukt (Call ; Email ; SMS ; Meeting ; Other)
    val ActivityDate__c: String?, // -- Planlagt tid for aktivitet
    val Status__c: String?, // -- Status på aktivitet (Åpen ; Fullført)
//    val Subject__c: String?, // -- Fritekst emne for aktivitet
    val AccountOrgNumber__c: String?, // -- Orgnummer aktiviteten gjelder
    val ActivityType__c: String?, // -- Aktivitetstype
    val IACaseNumber__c: String?, // -- IA saksnummer
    val IACooperationId__c: String?, // -- Samarbeidsid
    val Service__c: String?, // -- Plan - Tema
    val IASubtheme__c: String?, // -- Plan - Undertema
)
