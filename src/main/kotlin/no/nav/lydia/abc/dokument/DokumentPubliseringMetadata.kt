package no.nav.lydia.abc.dokument

data class DokumentPubliseringMetadata(
    val orgnummer: String,
    val virksomhetsNavn: String,
    val saksnummer: String,
    val samarbeidId: Int,
    val samarbeidsnavn: String,
)
