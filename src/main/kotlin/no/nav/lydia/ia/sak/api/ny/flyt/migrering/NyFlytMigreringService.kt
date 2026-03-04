package no.nav.lydia.ia.sak.api.ny.flyt.migrering

import kotlinx.datetime.toJavaLocalDateTime
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
import java.time.LocalDateTime

class NyFlytMigreringService(
    val nyFlytService: NyFlytService,
    val iaSakService: IASakService,
    val samarbeidService: IASamarbeidService,
) {
    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    companion object {
        // Eksempel på orgnr som skal migreres: "123456789", "123456789:false" eller "123456789:true".
        // Siste del av strengen indikerer om migrering blir gjennomført eller ikke. Default verdi er "false"
        fun String.tilOrgnr() = this.split(":").get(0)

        fun String.tørrKjør() = this.length <= 9 || !this.contains(":") || this.split(":").get(1) == "false"
    }

    fun migrer(
        orgnr: String,
        tørrKjør: Boolean,
    ) {
        nyFlytService.hentSisteIASakDto(orgnummer = orgnr)?.let { iaSakDto ->
            migrerSisteSak(
                iaSakDto = iaSakDto,
                orgnummer = orgnr,
                tørrKjør = tørrKjør,
            )
        }?.let {
            nyFlytService.hentAlleAndreIASakDto(orgnummer = it.orgnr, saksnummer = it.saksnummer).forEach { gammelIaSakDto ->
                migrerGammelSak(
                    iaSakDto = gammelIaSakDto,
                    tørrKjør = tørrKjør,
                )
            }
        }
    }

    fun migrerGammelSak(
        iaSakDto: IASakDto,
        tørrKjør: Boolean,
    ) {
        log.info(
            "[Migrering][TørrKjør=$tørrKjør] Funnet eldre sak '${iaSakDto.saksnummer}' med status '${iaSakDto.status}' på virksomhet med orgnr '${iaSakDto.orgnr}' ",
        )
    }

    fun migrerSisteSak(
        iaSakDto: IASakDto?,
        orgnummer: String,
        tørrKjør: Boolean,
    ): IASakDto? {
        if (iaSakDto == null) {
            log.info("Fant ingen sak for virksomhet med orgnr '$orgnummer', og det er derfor ingen sak å migrere.")
            return null
        }

        samarbeidService.hentSamarbeidSomIkkeErSlettet(saksnummer = iaSakDto.saksnummer).apply {
            onRight { samarbeidListe ->
                val samarbeidUseCase = samarbeidListe.getSamarbeidUseCase()
                val migreringsPlan = utledMigreringsPlan(
                    iaSakDto = iaSakDto,
                    samarbeidUseCase = samarbeidUseCase,
                )
                val samarbeidDetaljer =
                    samarbeidListe.joinToString(separator = "; ", prefix = "[", postfix = "]") { samarbeid ->
                        "samarbeid #${samarbeid.id}, status '${samarbeid.status?.name}', sist endret '${samarbeid.sistEndret}', avbrutt '${samarbeid.avbrutt}'"
                    }

                when (migreringsPlan) {
                    is MigreringsPlan.IkkeGjennomførbar -> {
                        log.info(
                            "[Migrering][TørrKjør=$tørrKjør] Saken '${iaSakDto.saksnummer}' på virksomhet med orgnr '${iaSakDto.orgnr}' " +
                                "er ikke håndtert som en use-case til migrering enda (use-case: '${samarbeidUseCase.name}'), og vil derfor ikke bli migrert. " +
                                "Saken har status '${iaSakDto.status.name}' og ${samarbeidListe.size} samarbeid. Detaljer om samarbeid: '$samarbeidDetaljer'. ",
                        )
                        return null
                    }

                    is MigreringsPlan.Gjennomførbar -> {
                        log.info(
                            "[Migrering][TørrKjør=$tørrKjør] Saken '${iaSakDto.saksnummer}' på virksomhet med orgnr '${iaSakDto.orgnr}' " +
                                "er håndtert som en use-case til migrering (use-case: '${samarbeidUseCase.name}'), og vil derfor bli migrert. " +
                                "Saken har status '${iaSakDto.status.name}' og ${samarbeidListe.size} samarbeid. Detaljer om samarbeid: '$samarbeidDetaljer'. " +
                                "Saken blir migrert til status '${migreringsPlan.resulterendeSakStatus.name}'" +
                                " og virksomhet vil få tilstand '${migreringsPlan.tilstand.tilVirksomhetIATilstand()}'",
                        )
                    }
                }
                val resulterendeStatusAvMigrering = migreringsPlan.resulterendeSakStatus
                val resulterendeTilstandAvMigrering = migreringsPlan.tilstand

                if (tørrKjør) return null

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
                                "[Migrering] Oppdatert sak '${migrertSakDto.saksnummer}' på virksomhet med orgnr '${migrertSakDto.orgnr}' " +
                                    "fra status '${iaSakDto.status.name}' til status'${migrertSakDto.status.name}', " +
                                    "og opprettet tilstand '${tilstand?.tilstand}'",
                            )
                        }
                    }
                    onLeft { feil ->
                        log.warn(
                            "[Migrering] Feil ved migrering av sak '${iaSakDto.saksnummer}' på virksomhet med orgnr '${iaSakDto.orgnr}': ${feil.feilmelding}",
                        )
                    }
                }
            }
        }
        return iaSakDto
    }

    private fun utledMigreringsPlan(
        iaSakDto: IASakDto,
        samarbeidUseCase: SamarbeidUseCase,
    ): MigreringsPlan =
        when (iaSakDto.status) {
            IASak.Status.KARTLEGGES -> {
                // Rad 6 til 9
                when (samarbeidUseCase) {
                    SamarbeidUseCase.INGEN_SAMARBEID_ELLER_ALLE_SAMARBEID_ER_SLETTET -> MigreringsPlan.Gjennomførbar(
                        nåværendeSakStatus = iaSakDto.status,
                        resulterendeSakStatus = IASak.Status.VURDERES,
                        tilstand = Tilstand.VirksomhetVurderes,
                    )

                    SamarbeidUseCase.MINST_ETT_AKTIVT_SAMARBEID -> MigreringsPlan.Gjennomførbar(
                        nåværendeSakStatus = iaSakDto.status,
                        resulterendeSakStatus = IASak.Status.AKTIV,
                        tilstand = Tilstand.VirksomhetHarAktiveSamarbeid,
                    )

                    SamarbeidUseCase.INGEN_AKTIVE_SAMARBEID_MEN_MINST_ETT_AVSLUTTET_SAMARBEID_FOR_MER_ENN_10_DAGER_SIDEN,
                    SamarbeidUseCase.INGEN_AKTIVE_SAMARBEID_MEN_MINST_ETT_AVSLUTTET_SAMARBEID_OM_TIDLIGST_10_DAGER_SIDEN,
                    -> MigreringsPlan.Gjennomførbar(
                        nåværendeSakStatus = iaSakDto.status,
                        resulterendeSakStatus = IASak.Status.AVSLUTTET,
                        tilstand = Tilstand.AlleSamarbeidIVirksomhetErAvsluttet,
                    )
                }
            }

            IASak.Status.VI_BISTÅR -> {
                when (samarbeidUseCase) {
                    SamarbeidUseCase.INGEN_SAMARBEID_ELLER_ALLE_SAMARBEID_ER_SLETTET -> MigreringsPlan.Gjennomførbar(
                        nåværendeSakStatus = iaSakDto.status,
                        resulterendeSakStatus = IASak.Status.VURDERES,
                        tilstand = Tilstand.VirksomhetVurderes,
                    )

                    SamarbeidUseCase.MINST_ETT_AKTIVT_SAMARBEID -> MigreringsPlan.Gjennomførbar(
                        nåværendeSakStatus = iaSakDto.status,
                        resulterendeSakStatus = IASak.Status.AKTIV,
                        tilstand = Tilstand.VirksomhetHarAktiveSamarbeid,
                    )

                    SamarbeidUseCase.INGEN_AKTIVE_SAMARBEID_MEN_MINST_ETT_AVSLUTTET_SAMARBEID_FOR_MER_ENN_10_DAGER_SIDEN,
                    -> MigreringsPlan.Gjennomførbar(
                        nåværendeSakStatus = iaSakDto.status,
                        resulterendeSakStatus = IASak.Status.AVSLUTTET,
                        tilstand = Tilstand.VirksomhetKlarTilVurdering,
                    )

                    SamarbeidUseCase.INGEN_AKTIVE_SAMARBEID_MEN_MINST_ETT_AVSLUTTET_SAMARBEID_OM_TIDLIGST_10_DAGER_SIDEN,
                    -> MigreringsPlan.Gjennomførbar(
                        nåværendeSakStatus = iaSakDto.status,
                        resulterendeSakStatus = IASak.Status.AVSLUTTET,
                        tilstand = Tilstand.AlleSamarbeidIVirksomhetErAvsluttet,
                    )
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
        INGEN_SAMARBEID_ELLER_ALLE_SAMARBEID_ER_SLETTET,
        MINST_ETT_AKTIVT_SAMARBEID,
        INGEN_AKTIVE_SAMARBEID_MEN_MINST_ETT_AVSLUTTET_SAMARBEID_OM_TIDLIGST_10_DAGER_SIDEN,
        INGEN_AKTIVE_SAMARBEID_MEN_MINST_ETT_AVSLUTTET_SAMARBEID_FOR_MER_ENN_10_DAGER_SIDEN,
    }

    /*
     Status samarbeid:
         - AKTIV,
         - FULLFØRT,
         - SLETTET,  --> samarbeid som er slettet hentes aldri ut
         - AVBRUTT,
     */
    fun List<IASamarbeid>.getSamarbeidUseCase(migreringsDato: LocalDateTime = LocalDateTime.now().toLocalDate().atStartOfDay()): SamarbeidUseCase =
        when {
            this.isEmpty() -> SamarbeidUseCase.INGEN_SAMARBEID_ELLER_ALLE_SAMARBEID_ER_SLETTET

            this.any { it.status == IASamarbeid.Status.AKTIV } -> SamarbeidUseCase.MINST_ETT_AKTIVT_SAMARBEID

            this.none {
                it.status == IASamarbeid.Status.AKTIV
            } && this.any {
                it.erAvsluttetEtter(dato = migreringsDato, tilbakeIAntallDager = 10)
            } -> SamarbeidUseCase.INGEN_AKTIVE_SAMARBEID_MEN_MINST_ETT_AVSLUTTET_SAMARBEID_OM_TIDLIGST_10_DAGER_SIDEN

            this.none {
                it.status == IASamarbeid.Status.AKTIV
            } && this.any {
                it.erAvsluttetFør(dato = migreringsDato, tilbakeIAntallDager = 10)
            } -> SamarbeidUseCase.INGEN_AKTIVE_SAMARBEID_MEN_MINST_ETT_AVSLUTTET_SAMARBEID_FOR_MER_ENN_10_DAGER_SIDEN

            else -> throw IllegalStateException("Ukjent samarbeid use-case for samarbeidListe: $this")
        }

    private fun IASamarbeid.erAvsluttetEtter(
        dato: LocalDateTime,
        tilbakeIAntallDager: Long,
    ): Boolean =
        this.sistEndret != null &&
            (this.status == IASamarbeid.Status.FULLFØRT || this.status == IASamarbeid.Status.AVBRUTT) &&
            this.sistEndret.toJavaLocalDateTime().isAfter(dato.minusDays(tilbakeIAntallDager))

    private fun IASamarbeid.erAvsluttetFør(
        dato: LocalDateTime,
        tilbakeIAntallDager: Long,
    ): Boolean =
        this.avbrutt != null &&
            (this.status == IASamarbeid.Status.FULLFØRT || this.status == IASamarbeid.Status.AVBRUTT) &&
            !this.avbrutt.toJavaLocalDateTime().isAfter(dato.minusDays(tilbakeIAntallDager))
}
