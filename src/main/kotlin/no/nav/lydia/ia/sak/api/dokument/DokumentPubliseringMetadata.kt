package no.nav.lydia.ia.sak.api.dokument

data class DokumentPubliseringMetadata(
    val orgnummer: String,
    val virksomhetsNavn: String,
    val saksnummer: String,
    val samarbeidsId: Int,
    val samarbeidsNavn: String,
)
