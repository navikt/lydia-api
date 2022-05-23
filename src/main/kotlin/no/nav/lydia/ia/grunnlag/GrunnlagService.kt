package no.nav.lydia.ia.grunnlag

import no.nav.lydia.sykefraversstatistikk.SykefraværsstatistikkService

class GrunnlagService(
    val grunnlagRepository: GrunnlagRepository,
    val sykefraværsstatistikkService: SykefraværsstatistikkService
) {

    fun lagreGrunnlag(orgnr: String, saksnummer: String, hendelseId: String) {
        val gjeldendeSykefravarsstatistikkForVirksomheten = sykefraværsstatistikkService.hentSykefraværForVirksomhet(orgnr = orgnr)
        grunnlagRepository.insert(
            SykefraversstatistikkGrunnlag.from(
                saksnummer = saksnummer,
                hendelseId = hendelseId,
                sykefraværsstatistikkListe = gjeldendeSykefravarsstatistikkForVirksomheten
            )
        )
    }

}