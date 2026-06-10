package no.nav.lydia.tilstandsmaskin.hendelse

data class GjørVirksomhetKlarTilNyVurdering(
    override val orgnr: String,
) : Hendelse()
