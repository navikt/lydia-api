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
                    val migreringsPlan = utledMigreringsPlan(iaSakDto = iaSakDto, samarbeidListe = samarbeidListe)

                    when (migreringsPlan) {
                        is MigreringsPlan.IkkeGjennomførbar -> {
                            val samarbeidDetaljer = samarbeidListe.joinToString { "samarbeid #${it.id}, status '${it.status?.name}'" }
                            log.info(
                                "[Migrering] Saken '${iaSakDto.saksnummer}' på virksomhet med orgnr '${iaSakDto.orgnr}' " +
                                    "er ikke håndtert som en use-case til migrering enda, og vil derfor ikke bli migrert. " +
                                    "Saken har status '${iaSakDto.status.name}' og ${samarbeidListe.size} samarbeid. Detaljer om samarbeid: '$samarbeidDetaljer'. ",
                            )
                            return
                        }

                        is MigreringsPlan.Gjennomførbar -> {
                            log.info(
                                "[Migrering] Saken '${iaSakDto.saksnummer}' på virksomhet med orgnr '${iaSakDto.orgnr}' " +
                                    "er håndtert som en use-case til migrering, og vil derfor bli migrert. " +
                                    "Saken har status '${iaSakDto.status.name}' og ${samarbeidListe.size} samarbeid.",
                            )
                        }
                    }

                    log.info(
                        "[Migrering] Saken '${iaSakDto.saksnummer}' på virksomhet med orgnr '${iaSakDto.orgnr}' " +
                            "er håndtert som en use-case til migrering, og vil derfor bli migrert. " +
                            "Saken har status '${iaSakDto.status.name}' og ${samarbeidListe.size} samarbeid.",
                    )
                    val resulterendeStatusAvMigrering = migreringsPlan.resulterendeSakStatus
                    val resulterendeTilstandAvMigrering = migreringsPlan.tilstand

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
    }

    private fun utledMigreringsPlan(
        iaSakDto: IASakDto,
        samarbeidListe: List<IASamarbeid>,
    ): MigreringsPlan =
        when (iaSakDto.status) {
            IASak.Status.KARTLEGGES -> {
                // Rad 6 til 9
                when (samarbeidListe.getSamarbeidUseCase()) {
                    SamarbeidUseCase.INGEN_SAMARBEID -> MigreringsPlan.Gjennomførbar(
                        nåværendeSakStatus = iaSakDto.status,
                        resulterendeSakStatus = IASak.Status.VURDERES,
                        tilstand = Tilstand.VirksomhetVurderes,
                    )

                    SamarbeidUseCase.MINST_ETT_AKTIVT_SAMARBEID -> MigreringsPlan.Gjennomførbar(
                        nåværendeSakStatus = iaSakDto.status,
                        resulterendeSakStatus = IASak.Status.AKTIV,
                        tilstand = Tilstand.VirksomhetHarAktiveSamarbeid,
                    )

                    SamarbeidUseCase.ALLE_SAMARBEID_ER_SLETTET -> MigreringsPlan.Gjennomførbar(
                        nåværendeSakStatus = iaSakDto.status,
                        resulterendeSakStatus = IASak.Status.VURDERES,
                        tilstand = Tilstand.VirksomhetVurderes,
                    )

                    SamarbeidUseCase.INGEN_AKTIVE_SAMARBEID_MEN_MINST_ET_AVBRYTT_SAMARBEID -> MigreringsPlan.Gjennomførbar(
                        nåværendeSakStatus = iaSakDto.status,
                        resulterendeSakStatus = IASak.Status.AVSLUTTET,
                        tilstand = Tilstand.AlleSamarbeidIVirksomhetErAvsluttet,
                    )

                    SamarbeidUseCase.ALLE_SAMARBEID_ER_AVSLUTTET,
                    -> MigreringsPlan.IkkeGjennomførbar
                }
            }

            else -> {
                MigreringsPlan.IkkeGjennomførbar
            }
        }

    sealed class MigreringsPlan {
        abstract fun kanGjennomføres(): Boolean

        data class Gjennomførbar(
            val nåværendeSakStatus: IASak.Status,
            val resulterendeSakStatus: IASak.Status,
            val tilstand: Tilstand,
            val tilAutomatiskOppdatering: Tilstand? = null,
        ) : MigreringsPlan() {
            override fun kanGjennomføres(): Boolean = true
        }

        object IkkeGjennomførbar : MigreringsPlan() {
            override fun kanGjennomføres(): Boolean = false
        }
    }

    enum class SamarbeidUseCase {
        INGEN_SAMARBEID,
        MINST_ETT_AKTIVT_SAMARBEID,
        ALLE_SAMARBEID_ER_SLETTET,
        ALLE_SAMARBEID_ER_AVSLUTTET,
        INGEN_AKTIVE_SAMARBEID_MEN_MINST_ET_AVBRYTT_SAMARBEID,
    }

    /*
     Status samarbeid:
         - AKTIV,
         - FULLFØRT,
         - SLETTET,
         - AVBRUTT,
     */
    fun List<IASamarbeid>.getSamarbeidUseCase(): SamarbeidUseCase =
        when {
            this.isEmpty() -> SamarbeidUseCase.INGEN_SAMARBEID

            this.any { it.status == IASamarbeid.Status.AKTIV } -> SamarbeidUseCase.MINST_ETT_AKTIVT_SAMARBEID

            this.all { it.status == IASamarbeid.Status.SLETTET } -> SamarbeidUseCase.ALLE_SAMARBEID_ER_SLETTET

            this.all { it.status == IASamarbeid.Status.FULLFØRT } -> SamarbeidUseCase.ALLE_SAMARBEID_ER_AVSLUTTET

            this.none {
                it.status == IASamarbeid.Status.AKTIV
            } && this.any { it.status == IASamarbeid.Status.AVBRUTT } -> SamarbeidUseCase.INGEN_AKTIVE_SAMARBEID_MEN_MINST_ET_AVBRYTT_SAMARBEID

            else -> throw IllegalStateException("Ukjent samarbeid use-case for samarbeidListe: $this")
        }
}
