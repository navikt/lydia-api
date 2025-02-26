package no.nav.lydia.integrasjoner.salesforce.aktiviteter

import kotlinx.serialization.Serializable

/**
 * Dokumentert på confluence https://confluence.adeo.no/display/PTC/Deling+av+data+via+Kafka
 */
@Serializable
data class SalesforceAktivitetDto(
    val Id__c: String, // -- Id til aktivitet i SF
    val ActivityCreatedDate__c: String? = null, // -- Når aktiviteten ble opprettet i SF
    val EventObject__c: String, // -- Objekttype i SF (Task ; Event)
    val TaskEvent__c: String, // -- Hva slags aktivitet (Møte ; Oppgave)
    val EventType__c: String, // -- Type hendelse (Created ; Updated ; Deleted ; Undeleted)
    val Type__c: String? = null, // -- Hvilken kanal er brukt (Call ; Email ; SMS ; Meeting ; Other)
    val ActivityDate__c: String? = null, // -- Planlagt tid for aktivitet
    val Status__c: String? = null, // -- Status på aktivitet (Åpen ; Fullført)
//    val Subject__c: String? = null, // -- Fritekst emne for aktivitet
    val AccountOrgNumber__c: String? = null, // -- Orgnummer aktiviteten gjelder
    val ActivityType__c: String? = null, // -- Aktivitetstype
    val IACaseNumber__c: String? = null, // -- IA saksnummer
    val IACooperationId__c: String? = null, // -- Samarbeidsid
    val Service__c: String? = null, // -- Plan - Tema
    val IASubtheme__c: String? = null, // -- Plan - Undertema
) {
    fun tilLog() =
        "id: '$Id__c'," +
            " type: '$TaskEvent__c'," +
            " saksnummer: '$IACaseNumber__c'," +
            " samarbeid: '$IACooperationId__c'," +
            " tema: '$Service__c'," +
            " undertema: '$IASubtheme__c',"
}
