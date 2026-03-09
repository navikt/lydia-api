package no.nav.lydia.ia.sak.api.ny.flyt.migrering

import kotlinx.datetime.toJavaLocalDateTime
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.IASamarbeidService
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.Hendelse
import no.nav.lydia.ia.sak.api.ny.flyt.NyFlytService
import no.nav.lydia.ia.sak.api.ny.flyt.Tilstand
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetTilstandAutomatiskOppdateringDto
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetTilstandDto
import no.nav.lydia.ia.sak.api.ny.flyt.tilTilstand
import no.nav.lydia.ia.sak.api.ny.flyt.tilVirksomhetIATilstand
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.vedlikehold.IASakStatusOppdaterer
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.time.LocalDate
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

        fun List<IASamarbeid>.getSamarbeidUseCase(migreringsDato: LocalDateTime): SamarbeidUseCase =
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

        fun IASakDto.getSakUseCase(migreringsDato: LocalDateTime): SakUseCase =
            when {
                this.erSistEndretEtter(dato = migreringsDato, tilbakeIAntallDager = 10)
                -> SakUseCase.SIST_ENDRET_DATO_PÅ_SAK_FOR_MINDRE_ENN_10_DAGER_SIDEN

                else
                -> SakUseCase.SIST_ENDRET_DATO_PÅ_SAK_FOR_MER_ENN_10_DAGER_SIDEN
            }

        fun IASamarbeid.erAvsluttetEtter(
            dato: LocalDateTime,
            tilbakeIAntallDager: Long,
        ): Boolean =
            this.sistEndret != null &&
                (this.status == IASamarbeid.Status.FULLFØRT || this.status == IASamarbeid.Status.AVBRUTT) &&
                this.sistEndret.toJavaLocalDateTime().isAfter(dato.minusDays(tilbakeIAntallDager))

        fun IASamarbeid.erAvsluttetFør(
            dato: LocalDateTime,
            tilbakeIAntallDager: Long,
        ): Boolean =
            this.sistEndret != null &&
                (this.status == IASamarbeid.Status.FULLFØRT || this.status == IASamarbeid.Status.AVBRUTT) &&
                !this.sistEndret.toJavaLocalDateTime().isAfter(dato.minusDays(tilbakeIAntallDager))

        fun IASakDto.erSistEndretEtter(
            dato: LocalDateTime,
            tilbakeIAntallDager: Long,
        ): Boolean =
            this.endretTidspunkt != null &&
                this.endretTidspunkt.toJavaLocalDateTime().isAfter(dato.minusDays(tilbakeIAntallDager))
    }

    fun migrer(
        orgnr: String,
        tørrKjør: Boolean,
    ) {
        val migreringsDato: LocalDateTime = LocalDateTime.now().toLocalDate().atStartOfDay()
        nyFlytService.hentSisteIASakDto(orgnummer = orgnr)?.let { iaSakDto ->
            migrerSisteSak(
                iaSakDto = iaSakDto,
                orgnummer = orgnr,
                migreringsDato = migreringsDato,
                tørrKjør = tørrKjør,
            )
        }?.let {
            nyFlytService.hentAlleAndreIASakDto(orgnummer = it.orgnr, saksnummer = it.saksnummer).forEach { gammelIaSakDto ->
                logMenIkkeMigrerGammelSak(
                    iaSakDto = gammelIaSakDto,
                    tørrKjør = tørrKjør,
                )
            }
        }
    }

    fun logMenIkkeMigrerGammelSak(
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
        migreringsDato: LocalDateTime,
        tørrKjør: Boolean,
    ): IASakDto? {
        if (iaSakDto == null) {
            log.info("Fant ingen sak for virksomhet med orgnr '$orgnummer', og det er derfor ingen sak å migrere.")
            return null
        }

        val tilstandVirksomhet = nyFlytService.hentTilstandVirksomhet(orgnummer = iaSakDto.orgnr)
        if (tilstandVirksomhet != null) {
            val loggForNyTilstand = if (tilstandVirksomhet.nesteTilstand?.nyTilstand != null) {
                "neste tilstand '${tilstandVirksomhet.nesteTilstand.nyTilstand}' med planlagt hendelse '${tilstandVirksomhet.nesteTilstand.planlagtHendelse}' " +
                    "og planlagt dato '${tilstandVirksomhet.nesteTilstand.planlagtDato}'"
            } else {
                "ingen neste tilstand"
            }
            log.info(
                "[Migrering][TørrKjør=$tørrKjør] Sak '${iaSakDto.saksnummer}' med status '${iaSakDto.status}' på virksomhet med orgnr '${iaSakDto.orgnr}' " +
                    "er allerede migrert. Virksomhet har tilstand '${tilstandVirksomhet.tilstand}', og eventuelt ny tilstand til senere oppdatering: " +
                    "'$loggForNyTilstand'. Det er derfor ingen sak å migrere.",
            )
            return null
        }

        samarbeidService.hentSamarbeidSomIkkeErSlettet(saksnummer = iaSakDto.saksnummer).apply {
            onRight { samarbeidListe ->
                val samarbeidUseCase = samarbeidListe.getSamarbeidUseCase(migreringsDato = migreringsDato)
                val sakUseCase = iaSakDto.getSakUseCase(migreringsDato = migreringsDato)
                val migreringsPlan = utledMigreringsPlan(
                    iaSakDto = iaSakDto,
                    samarbeidUseCase = samarbeidUseCase,
                    sakSakUseCase = sakUseCase,
                )
                val samarbeidDetaljer =
                    samarbeidListe.joinToString(separator = "; ", prefix = "[", postfix = "]") { samarbeid ->
                        "samarbeid #${samarbeid.id}, status '${samarbeid.status?.name}', " +
                            "opprettet '${samarbeid.opprettet}', " +
                            "sist endret '${samarbeid.sistEndret}', " +
                            "fullført '${samarbeid.fullført}', " +
                            "avbrutt '${samarbeid.avbrutt}'"
                    }

                val samarbeidEllerSakBasertUsecase = when (iaSakDto.status) {
                    IASak.Status.FULLFØRT -> sakUseCase.name
                    IASak.Status.IKKE_AKTUELL -> "${sakUseCase.name} og ${samarbeidUseCase.name}"
                    else -> samarbeidUseCase.name
                }
                when (migreringsPlan) {
                    is MigreringsPlan.IkkeGjennomførbar -> {
                        log.info(
                            "[Migrering][${migreringsPlan.javaClass.simpleName}][TørrKjør=$tørrKjør] Sak '${iaSakDto.saksnummer}' " +
                                "med status '${iaSakDto.status.name}' på virksomhet med orgnr '${iaSakDto.orgnr}' " +
                                "er ikke håndtert som en use-case til migrering og vil derfor ikke bli migrert. " +
                                "Følgende use-case '$samarbeidEllerSakBasertUsecase' er ikke håndtert for status '${iaSakDto.status.name}'. " +
                                "Det finnes ${samarbeidListe.size} samarbeid på saken. Detaljer om samarbeid: '$samarbeidDetaljer'. ",
                        )
                        return null
                    }

                    is MigreringsPlan.Gjennomførbar -> {
                        val bakgrunnForMigrering = when (iaSakDto.status) {
                            IASak.Status.FULLFØRT -> {
                                "'$sakUseCase' med status på sak '${iaSakDto.status}' " +
                                    "og sist endret dato '${iaSakDto.endretTidspunkt}'"
                            }

                            else -> {
                                "'$samarbeidUseCase' og ${samarbeidListe.size} samarbeid på saken. Detaljer om samarbeid: '$samarbeidDetaljer'. "
                            }
                        }
                        log.info(
                            "[Migrering][${migreringsPlan.javaClass.simpleName}][TørrKjør=$tørrKjør] Sak '${iaSakDto.saksnummer}' " +
                                "med status '${iaSakDto.status.name}' på virksomhet med orgnr '${iaSakDto.orgnr}' er en gyldig use-case til migrering. " +
                                "Saken blir migrert til status '${migreringsPlan.resulterendeSakStatus.name}', " +
                                "virksomhet vil få tilstand '${migreringsPlan.tilstand.tilVirksomhetIATilstand()}', " +
                                "og automatisk oppdatering (VirksomhetKlarTilVurdering om 90 dager): " +
                                "'${migreringsPlan.gjørVirksomhetKlarTilVurderingSenere}'. " +
                                "Bakgrunn for migrering er: '$bakgrunnForMigrering'. ",
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
                        ).let { tilstand: VirksomhetTilstandDto? ->
                            log.info(
                                "[Migrering] Oppdatert sak '${migrertSakDto.saksnummer}' på virksomhet med orgnr '${migrertSakDto.orgnr}' " +
                                    "fra status '${iaSakDto.status.name}' til status '${migrertSakDto.status.name}', " +
                                    "og opprettet tilstand '${tilstand?.tilstand}'",
                            )
                            if (migreringsPlan.gjørVirksomhetKlarTilVurderingSenere &&
                                tilstand != null &&
                                tilstand.tilstand.tilTilstand().kanUtføreAutomatiskTransisjon()

                            ) {
                                nyFlytService.opprettAutomatiskOppdatering(
                                    orgnr = migrertSakDto.orgnr,
                                    samarbeidsperiodeId = migrertSakDto.saksnummer,
                                    startTilstand = migreringsPlan.tilstand,
                                    planlagtHendelse = Hendelse.GjørVirksomhetKlarTilNyVurdering::class.simpleName!!,
                                    nyTilstand = Tilstand.VirksomhetKlarTilVurdering,
                                    planlagtDato = LocalDate.now().plusDays(90),
                                ).let { automatiskOppdatering: VirksomhetTilstandAutomatiskOppdateringDto? ->
                                    if (automatiskOppdatering != null) {
                                        log.info(
                                            "[Migrering] Opprettet automatisk oppdatering for sak '${migrertSakDto.saksnummer}' " +
                                                "på virksomhet med orgnr '${migrertSakDto.orgnr}' " +
                                                "med start tilstand '${automatiskOppdatering.startTilstand}', " +
                                                "planlagt hendelse '${automatiskOppdatering.planlagtHendelse}', " +
                                                "ny tilstand '${automatiskOppdatering.nyTilstand}' og " +
                                                "planlagt dato '${automatiskOppdatering.planlagtDato}'",
                                        )
                                    } else {
                                        log.warn(
                                            "[Migrering] Det oppsto en feil ved opprettelse av automatisk oppdatering for sak '${migrertSakDto.saksnummer}' " +
                                                "på virksomhet med orgnr '${migrertSakDto.orgnr}'. Virksomhet har tilstand '${tilstand.tilstand}', " +
                                                "men fikk ikke opprettet automatisk oppdatering " +
                                                "til tilstand '${Tilstand.VirksomhetKlarTilVurdering::class.simpleName}'",
                                        )
                                    }
                                }
                            }
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
        sakSakUseCase: SakUseCase,
    ): MigreringsPlan =
        when (iaSakDto.status) {
            IASak.Status.VURDERES -> {
                MigreringsPlan.Gjennomførbar(
                    nåværendeSakStatus = iaSakDto.status,
                    resulterendeSakStatus = IASak.Status.VURDERES,
                    tilstand = Tilstand.VirksomhetVurderes,
                )
            }

            IASak.Status.KONTAKTES -> {
                MigreringsPlan.Gjennomførbar(
                    nåværendeSakStatus = iaSakDto.status,
                    resulterendeSakStatus = IASak.Status.VURDERES,
                    tilstand = Tilstand.VirksomhetVurderes,
                )
            }

            IASak.Status.KARTLEGGES -> {
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
                        gjørVirksomhetKlarTilVurderingSenere = true,
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
                        gjørVirksomhetKlarTilVurderingSenere = true,
                    )
                }
            }

            IASak.Status.FULLFØRT -> {
                when (sakSakUseCase) {
                    SakUseCase.SIST_ENDRET_DATO_PÅ_SAK_FOR_MER_ENN_10_DAGER_SIDEN,
                    -> {
                        MigreringsPlan.Gjennomførbar(
                            nåværendeSakStatus = iaSakDto.status,
                            resulterendeSakStatus = IASak.Status.AVSLUTTET,
                            tilstand = Tilstand.VirksomhetKlarTilVurdering,
                        )
                    }

                    SakUseCase.SIST_ENDRET_DATO_PÅ_SAK_FOR_MINDRE_ENN_10_DAGER_SIDEN,
                    -> {
                        MigreringsPlan.Gjennomførbar(
                            nåværendeSakStatus = iaSakDto.status,
                            resulterendeSakStatus = IASak.Status.AVSLUTTET,
                            tilstand = Tilstand.AlleSamarbeidIVirksomhetErAvsluttet,
                            gjørVirksomhetKlarTilVurderingSenere = true,
                        )
                    }
                }
            }

            IASak.Status.IKKE_AKTUELL -> {
                when (sakSakUseCase) {
                    SakUseCase.SIST_ENDRET_DATO_PÅ_SAK_FOR_MINDRE_ENN_10_DAGER_SIDEN,
                    -> {
                        when (samarbeidUseCase) {
                            SamarbeidUseCase.INGEN_SAMARBEID_ELLER_ALLE_SAMARBEID_ER_SLETTET,
                            -> {
                                MigreringsPlan.Gjennomførbar(
                                    nåværendeSakStatus = iaSakDto.status,
                                    resulterendeSakStatus = IASak.Status.AVSLUTTET,
                                    tilstand = Tilstand.VirksomhetErVurdert,
                                    gjørVirksomhetKlarTilVurderingSenere = true,
                                )
                            }

                            SamarbeidUseCase.INGEN_AKTIVE_SAMARBEID_MEN_MINST_ETT_AVSLUTTET_SAMARBEID_OM_TIDLIGST_10_DAGER_SIDEN,
                            SamarbeidUseCase.INGEN_AKTIVE_SAMARBEID_MEN_MINST_ETT_AVSLUTTET_SAMARBEID_FOR_MER_ENN_10_DAGER_SIDEN,
                            -> {
                                MigreringsPlan.Gjennomførbar(
                                    nåværendeSakStatus = iaSakDto.status,
                                    resulterendeSakStatus = IASak.Status.AVSLUTTET,
                                    tilstand = Tilstand.AlleSamarbeidIVirksomhetErAvsluttet,
                                    gjørVirksomhetKlarTilVurderingSenere = true,
                                )
                            }

                            else -> {
                                MigreringsPlan.IkkeGjennomførbar
                            }
                        }
                    }

                    SakUseCase.SIST_ENDRET_DATO_PÅ_SAK_FOR_MER_ENN_10_DAGER_SIDEN,
                    -> {
                        when (samarbeidUseCase) {
                            SamarbeidUseCase.INGEN_SAMARBEID_ELLER_ALLE_SAMARBEID_ER_SLETTET,
                            -> {
                                MigreringsPlan.Gjennomførbar(
                                    nåværendeSakStatus = iaSakDto.status,
                                    resulterendeSakStatus = IASak.Status.AVSLUTTET,
                                    tilstand = Tilstand.VirksomhetKlarTilVurdering,
                                )
                            }

                            SamarbeidUseCase.INGEN_AKTIVE_SAMARBEID_MEN_MINST_ETT_AVSLUTTET_SAMARBEID_OM_TIDLIGST_10_DAGER_SIDEN,
                            SamarbeidUseCase.INGEN_AKTIVE_SAMARBEID_MEN_MINST_ETT_AVSLUTTET_SAMARBEID_FOR_MER_ENN_10_DAGER_SIDEN,
                            -> {
                                MigreringsPlan.Gjennomførbar(
                                    nåværendeSakStatus = iaSakDto.status,
                                    resulterendeSakStatus = IASak.Status.AVSLUTTET,
                                    tilstand = Tilstand.VirksomhetKlarTilVurdering,
                                )
                            }

                            else -> {
                                MigreringsPlan.IkkeGjennomførbar
                            }
                        }
                    }
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
            val gjørVirksomhetKlarTilVurderingSenere: Boolean = false,
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

    enum class SakUseCase {
        SIST_ENDRET_DATO_PÅ_SAK_FOR_MER_ENN_10_DAGER_SIDEN,
        SIST_ENDRET_DATO_PÅ_SAK_FOR_MINDRE_ENN_10_DAGER_SIDEN,
    }
}
