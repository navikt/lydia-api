package no.nav.lydia.ia.sak.domene.spørreundersøkelse

data class TemaMedSpørsmålOgSvaralternativer(
    val tema: TemaInfo,
    val stengtForSvar: Boolean,
    val spørsmål: List<Spørsmål>,
)