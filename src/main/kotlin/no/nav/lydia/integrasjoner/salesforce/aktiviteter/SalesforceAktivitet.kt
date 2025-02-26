package no.nav.lydia.integrasjoner.salesforce.aktiviteter

data class SalesforceAktivitet(
    val salesforceId: String,
    val aktivitetsType: String, // "Møte" / "Oppgave"
    val hendelsesType: String, // "Created" / "Updated" / "Deleted" / "Undeleted"
    val kanal: String? = null,
    val planlagtTid: String? = null,
    val status: String? = null, // "Åpen" / "Fullført"
//    val tittel: String? = null,
    val aktivitetsTema: String? = null,
    val orgnr: String? = null,
    val saksnummer: String? = null,
    val samarbeidsId: String? = null,
    // --
    val planTema: String? = null,
    val planUndertema: String? = null,
)
