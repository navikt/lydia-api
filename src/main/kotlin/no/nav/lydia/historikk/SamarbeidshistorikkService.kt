package no.nav.lydia.historikk

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import no.nav.lydia.felles.Feil
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.prioritering.sykefraværsstatistikk.api.EierDTO
import no.nav.lydia.samarbeid.IASamarbeidService
import no.nav.lydia.samarbeidsperiode.IASakService

class SamarbeidshistorikkService(
    private val samarbeidshistorikkRepository: SamarbeidshistorikkRepository,
    private val samarbeidService: IASamarbeidService,
    private val iaSakService: IASakService,
    private val azureService: AzureService,
) {
    suspend fun hentHistorikkForSamarbeid(
        orgnr: String,
        saksnummer: String,
        samarbeidId: Int,
    ): Either<Feil, List<SamarbeidshistorikkRadDto>> {
        val sak = iaSakService.hentIASakDto(saksnummer).getOrNull()
        if (sak == null || sak.orgnr != orgnr) {
            return `fant ikke samarbeid`.left()
        }
        samarbeidService.hentSamarbeid(saksnummer = saksnummer, samarbeidId = samarbeidId).getOrNull()
            ?: return `fant ikke samarbeid`.left()

        val kandidater = slåSammen(
            ekteHendelser = samarbeidshistorikkRepository.hentEkteHendelser(samarbeidId = samarbeidId),
            rekonstruerteHendelser = samarbeidshistorikkRepository.hentRekonstruerteHendelser(samarbeidId = samarbeidId),
        )

        val navnPerNavIdent = hentNavnPerNavIdent(navIdenter = kandidater.mapNotNull { it.navIdent }.toSet())

        return kandidater.map { kandidat ->
            SamarbeidshistorikkRadDto(
                hendelsestype = kandidat.hendelsestype,
                tidspunkt = kandidat.tidspunkt,
                aktor = kandidat.navIdent?.let { navIdent ->
                    EierDTO(navIdent = navIdent, navn = navnPerNavIdent[navIdent] ?: "")
                },
            )
        }.right()
    }

    private suspend fun hentNavnPerNavIdent(navIdenter: Set<String>): Map<String, String> =
        if (navIdenter.isEmpty()) {
            emptyMap()
        } else {
            azureService.hentVeiledere().fold(
                ifLeft = { emptyMap() },
                ifRight = { veiledere ->
                    veiledere.filter { it.navIdent in navIdenter }
                        .map { it.tilEierDTO() }
                        .associate { it.navIdent to it.navn }
                },
            )
        }

    companion object {
        val `fant ikke samarbeid` = Feil(
            feilmelding = "Fant ikke samarbeid",
            httpStatusCode = HttpStatusCode.NotFound,
        )

        /**
         * Ekte hendelser vinner over rekonstruerte. Innenfor hver hendelsestype beholdes kun den nyeste.
         * Rader uten tidspunkt regnes som eldst, og sorteres nederst.
         */
        internal fun slåSammen(
            ekteHendelser: List<SamarbeidshistorikkKandidat>,
            rekonstruerteHendelser: List<SamarbeidshistorikkKandidat>,
        ): List<SamarbeidshistorikkKandidat> {
            val ektePerType = ekteHendelser.groupBy { it.hendelsestype }
            val rekonstruertePerType = rekonstruerteHendelser.groupBy { it.hendelsestype }

            return SamarbeidshistorikkType.entries
                .mapNotNull { type -> (ektePerType[type] ?: rekonstruertePerType[type])?.nyeste() }
                .sortedWith(compareByDescending(nullsFirst()) { it.tidspunkt })
        }

        private fun List<SamarbeidshistorikkKandidat>.nyeste(): SamarbeidshistorikkKandidat? = maxWithOrNull(compareBy(nullsFirst()) { it.tidspunkt })
    }
}
