package no.nav.lydia.abc.dokumentpublisering

data class DokumentPubliseringMetadata(
    val orgnummer: String,
    val virksomhetsNavn: String,
    val saksnummer: String,
    val samarbeidId: Int,
    val samarbeidsnavn: String,
)
