package no.nav.lydia.ia.grunnlag

import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.sykefraversstatistikk.SykefraværsstatistikkService

class GrunnlagService(
    val grunnlagRepository: GrunnlagRepository,
    val sykefraværsstatistikkService: SykefraværsstatistikkService
) {
    fun lagreGrunnlag(iaSak: IASak) {
        val gjeldendeSykefravarsstatistikkForVirksomheten =
            sykefraværsstatistikkService.hentSykefraværForVirksomhet(orgnr = iaSak.orgnr)
        grunnlagRepository.insert(
            SykefraversstatistikkGrunnlag.from(
                saksnummer = iaSak.saksnummer,
                hendelseId = iaSak.endretAvHendelseId,
                sykefraværsstatistikkListe = gjeldendeSykefravarsstatistikkForVirksomheten
            )
        )
    }
}
