package no.nav.lydia.historikk

import arrow.core.Either
import arrow.core.left
import arrow.core.raise.either
import arrow.core.raise.ensure
import arrow.core.right
import no.nav.lydia.felles.Feil
import no.nav.lydia.historikk.HistorikkUtils.tilBeskrivelse
import no.nav.lydia.historikk.model.Historikkfeil
import no.nav.lydia.historikk.model.Historikklinje
import no.nav.lydia.historikk.model.SamarbeidshistorikkKandidat
import no.nav.lydia.historikk.model.SamarbeidshistorikkRadDto
import no.nav.lydia.historikk.model.SamarbeidshistorikkType
import no.nav.lydia.historikk.model.Samarbeidsperiode
import no.nav.lydia.historikk.model.SamarbeidsperiodeHistorikkDto
import no.nav.lydia.historikk.model.Virksomhetshistorikk
import no.nav.lydia.historikk.repository.SamarbeidshistorikkRepository
import no.nav.lydia.historikk.repository.VirksomhetshistorikkRepository
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.prioritering.sykefraværsstatistikk.api.EierDTO
import no.nav.lydia.prioritering.virksomhet.VirksomhetRepository
import no.nav.lydia.samarbeid.IASamarbeidService
import no.nav.lydia.samarbeidsperiode.IASakRepository
import no.nav.lydia.samarbeidsperiode.IASakService

class HistorikkService(
    private val samarbeidshistorikkRepository: SamarbeidshistorikkRepository,
    private val virksomhetshistorikkRepository: VirksomhetshistorikkRepository,
    private val iaSakRepository: IASakRepository,
    private val iaSakService: IASakService,
    private val azureService: AzureService,
    private val samarbeidService: IASamarbeidService,
    private val virksomhetRepository: VirksomhetRepository,
) {
    fun hentHistorikkForVirksomhet(orgnr: String): Either<Feil, Virksomhetshistorikk> =
        either {
            val virksomhet = virksomhetRepository.hentVirksomhet(orgnr)
            ensure(virksomhet != null) { Historikkfeil.`fant ikke virksomhet` }
            val hendelser = virksomhetshistorikkRepository.hentVirksomhetHendelser(orgnr)
            val samarbeidsperioder = iaSakRepository.hentAlleSakerForVirksomhet(orgnr)
                .map {
                    Samarbeidsperiode(
                        saksnummer = it.saksnummer,
                        fraDato = it.opprettetTidspunkt,
                        status = it.status,
                        eier = it.eidAv,
                    )
                }
                .sortedBy { it.fraDato }
            Virksomhetshistorikk(
                hendelser = hendelser.map {
                    Historikklinje(beskrivelse = it.hendelsetype.tilBeskrivelse(), tidspunkt = it.tidspunkt, relatertHendelse = it)
                },
                samarbeidsperioder = samarbeidsperioder,
            )
        }

    suspend fun hentHistorikkForSamarbeid(
        orgnr: String,
        saksnummer: String,
        samarbeidId: Int,
    ): Either<Feil, List<SamarbeidshistorikkRadDto>> {
        val sak = iaSakService.hentIASakDto(saksnummer).getOrNull()
        if (sak == null || sak.orgnr != orgnr) {
            return Historikkfeil.`fant ikke samarbeid`.left()
        }
        samarbeidService.hentSamarbeid(saksnummer = saksnummer, samarbeidId = samarbeidId).getOrNull()
            ?: return Historikkfeil.`fant ikke samarbeid`.left()

        val kandidater = slåSammen(
            ekteHendelser = samarbeidshistorikkRepository.hentEkteHendelser(samarbeidId = samarbeidId),
            rekonstruerteHendelser = samarbeidshistorikkRepository.hentRekonstruerteHendelser(samarbeidId = samarbeidId),
        )

        val navnPerNavIdent = azureService.hentNavnPerNavIdent(navIdenter = kandidater.mapNotNull { it.navIdent }.toSet())

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

    suspend fun berikMedAktører(historikk: SamarbeidsperiodeHistorikkDto): SamarbeidsperiodeHistorikkDto {
        val navnPerNavIdent = azureService.hentNavnPerNavIdent(
            navIdenter = historikk.historikkHendelser.map { it.hendelseOpprettetAv }.toSet(),
        )
        return historikk.copy(
            historikkHendelser = historikk.historikkHendelser.map { hendelse ->
                hendelse.copy(
                    aktør = navnPerNavIdent[hendelse.hendelseOpprettetAv]?.let { navn ->
                        EierDTO(navIdent = hendelse.hendelseOpprettetAv, navn = navn)
                    },
                )
            },
        )
    }

    companion object {
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
