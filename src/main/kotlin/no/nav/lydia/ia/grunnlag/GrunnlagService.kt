package no.nav.lydia.ia.grunnlag

import no.nav.lydia.sykefraversstatistikk.SykefraversstatistikkRepository

class GrunnlagService(
    val grunnlagRepository: GrunnlagRepository,
    val sykefraversstatistikkRepository: SykefraversstatistikkRepository
) {

    fun lagreGrunnlag(orgnr: String, saksnummer: String, hendelseId: String) {
        val gjeldendeSykefravarsstatistikkForVirksomheten = sykefraversstatistikkRepository.hentSykefraværForVirksomhet(orgnr = orgnr)
        grunnlagRepository.insert(
            SykefraversstatistikkGrunnlag.from(
                saksnummer = saksnummer,
                hendelseId = hendelseId,
                sykefraværsstatistikkListe = gjeldendeSykefravarsstatistikkForVirksomheten
            )
        )
    }

}