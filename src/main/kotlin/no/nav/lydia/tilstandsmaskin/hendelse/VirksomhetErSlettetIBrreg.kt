package no.nav.lydia.tilstandsmaskin.hendelse

import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilstandsmaskin.sideeffect.VirksomhetErSlettetIBrregSideEffect

data class VirksomhetErSlettetIBrreg(
    override val orgnr: String,
    val navEnhet: NavEnhet,
    val oppdateringsid: Long,
) : Hendelse() {
    val sideEffect
        get() = VirksomhetErSlettetIBrregSideEffect(
            orgnr = orgnr,
            navEnhet = navEnhet,
            oppdateringsid = oppdateringsid,
        )
}
