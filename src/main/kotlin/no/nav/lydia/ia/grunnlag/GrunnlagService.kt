package no.nav.lydia.ia.grunnlag

import no.nav.lydia.sykefraversstatistikk.SykefraversstatistikkRepository

class GrunnlagService(
    val sykefraversstatistikkGrunnlagRepository: SykefraversstatistikkGrunnlagRepository,
    val sykefraversstatistikkRepository: SykefraversstatistikkRepository
) {

    fun lagreGrunnlag(orgnr: String, saksnummer: String, hendelseId: String) {
        val gjeldendeSykefravarsstatistikkForVirksomheten = sykefraversstatistikkRepository.hentSykefraværForVirksomhet(orgnr = orgnr)
        sykefraversstatistikkGrunnlagRepository.insert(
            SykefraversstatistikkGrunnlag.from(
                saksnummer = saksnummer,
                hendelseId = hendelseId,
                sykefraværsstatistikkListe = gjeldendeSykefravarsstatistikkForVirksomheten
            )
        )
    }

}