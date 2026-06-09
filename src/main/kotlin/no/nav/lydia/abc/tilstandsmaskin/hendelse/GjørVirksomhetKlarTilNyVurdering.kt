package no.nav.lydia.abc.tilstandsmaskin.hendelse

data class GjørVirksomhetKlarTilNyVurdering(
    override val orgnr: String,
) : no.nav.lydia.abc.tilstandsmaskin.hendelse.Hendelse()
