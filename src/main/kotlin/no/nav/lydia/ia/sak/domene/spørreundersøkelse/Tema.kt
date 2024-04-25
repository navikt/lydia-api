package no.nav.lydia.ia.sak.domene.spørreundersøkelse

data class Tema(
    val tema: TemaInfo,
    val stengtForSvar: Boolean,
    val spørsmål: List<Spørsmål>,
)