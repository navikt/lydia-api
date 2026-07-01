package no.nav.lydia.tilstandsmaskin.hendelse

import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.prioritering.virksomhet.domene.VirksomhetStatus
import no.nav.lydia.tilstandsmaskin.sideeffect.VirksomhetErAvregistrertIBrregSideEffect

data class VirksomhetErAvregistrertIBrreg(
    override val orgnr: String,
    val navEnhet: NavEnhet,
    val oppdateringsid: Long,
    val avregistrering: Avregistrering,
) : Hendelse() {
    val sideEffect
        get() = VirksomhetErAvregistrertIBrregSideEffect(
            orgnr = orgnr,
            navEnhet = navEnhet,
            oppdateringsid = oppdateringsid,
            avregistrering = avregistrering,
        )
}

enum class Avregistrering(
    val virksomhetStatus: VirksomhetStatus,
) {
    FJERNET(virksomhetStatus = VirksomhetStatus.FJERNET),
    SLETTET(virksomhetStatus = VirksomhetStatus.SLETTET),
}
