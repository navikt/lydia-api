package no.nav.lydia.ia.sak.api.ny.flyt.migrering

import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.IASamarbeidService
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.NyFlytService
import no.nav.lydia.ia.sak.api.ny.flyt.Tilstand
import no.nav.lydia.ia.sak.api.ny.flyt.tilVirksomhetIATilstand
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.vedlikehold.IASakStatusOppdaterer
import org.slf4j.Logger
import org.slf4j.LoggerFactory

class NyFlytMigreringService(
    val nyFlytService: NyFlytService,
    val iaSakService: IASakService,
    val samarbeidService: IASamarbeidService,
) {
    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun migrer(orgnr: String) {
        nyFlytService.hentSisteIASakDto(orgnummer = orgnr)?.let { iaSakDto ->
            samarbeidService.hentSamarbeid(saksnummer = iaSakDto.saksnummer).apply {
                onRight { samarbeidListe ->
                    if (!migreringUseCaseErHåndtert(iaSakDto, samarbeidListe)) {
                        log.info(
                            "[Migrering] Saken '${iaSakDto.saksnummer}' på virksomhet med orgnr '${iaSakDto.orgnr}' " +
                                "er ikke håndtert som en use-case til migrering enda, og vil derfor ikke bli migrert. " +
                                "Saken har status '${iaSakDto.status.name}' og ${samarbeidListe.size} samarbeid.",
                        )
                        return
                    }
                }
                val resulterendeStatusAvMigrering = IASak.Status.AKTIV
                val resulterendeTilstandAvMigrering = Tilstand.VirksomhetHarAktiveSamarbeid

                nyFlytService.lagreHendelseOgOppdaterIaSakDto(
                    orgnummer = iaSakDto.orgnr,
                    hendelsesType = IASakshendelseType.MIGRERING_TIL_NY_FLYT,
                    saksbehandler = NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker(
                        navIdent = "Fia system",
                        navn = "Fia system",
                        token = "",
                        ansattesGrupper = emptySet(),
                    ),
                    saksnummer = iaSakDto.saksnummer,
                    navEnhet = IASakStatusOppdaterer.NAV_ENHET_FOR_MASKINELT_OPPDATERING,
                    resulterendeSakStatus = resulterendeStatusAvMigrering,
                    oppdaterSistEndretPåSak = false,
                ).apply {
                    onRight { migrertSakDto ->
                        nyFlytService.lagreEllerOppdaterVirksomhetTilstand(
                            orgnr = iaSakDto.orgnr,
                            samarbeidsperiodeId = iaSakDto.saksnummer,
                            tilstand = resulterendeTilstandAvMigrering.tilVirksomhetIATilstand(),
                        ).let { tilstand ->
                            log.info(
                                "Oppdatert sak '${migrertSakDto.saksnummer}' på virksomhet med orgnr '${migrertSakDto.orgnr}' " +
                                    "fra status '${iaSakDto.status.name}' til status'${migrertSakDto.status.name}', " +
                                    "og opprettet tilstand '${tilstand?.tilstand}'",
                            )
                        }
                    }
                    onLeft { feil ->
                        log.error(
                            "Feil ved migrering av sak '${iaSakDto.saksnummer}' på virksomhet med orgnr '${iaSakDto.orgnr}': ${feil.feilmelding}",
                        )
                    }
                }
            }
        }
    }

    private fun migreringUseCaseErHåndtert(
        iaSakDto: IASakDto,
        samarbeidListe: List<IASamarbeid>,
    ): Boolean =
        when (iaSakDto.status) {
            IASak.Status.KARTLEGGES -> samarbeidListe.any { it.status == IASamarbeid.Status.AKTIV }
            else -> false
        }
}
