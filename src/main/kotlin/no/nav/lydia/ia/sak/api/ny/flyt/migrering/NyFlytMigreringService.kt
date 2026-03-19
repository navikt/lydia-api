package no.nav.lydia.ia.sak.api.ny.flyt.migrering

import kotlinx.datetime.toJavaLocalDateTime
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.IASamarbeidService
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.NyFlytService
import no.nav.lydia.ia.sak.api.ny.flyt.tilVirksomhetIATilstand
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.sykefraværsstatistikk.api.geografi.GeografiService
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.time.LocalDateTime
import java.util.concurrent.atomic.AtomicInteger

class NyFlytMigreringService(
    val nyFlytService: NyFlytService,
    val iaSakService: IASakService,
    val samarbeidService: IASamarbeidService,
    val geografiService: GeografiService,
) {
    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun migrerAlle(
        fylkenummer: String = "ALLE",
        faktiskMigrer: Boolean,
    ): Triple<Int, Int, Int> {
        val startTidspunkt = LocalDateTime.now()
        val antallMigrerbareSakerFunnet = AtomicInteger(0) //
        val antallGamleSakerFunnet = AtomicInteger(0)
        val antallForsøktMigrerteSaker = AtomicInteger(0)
        val antallProsessert = AtomicInteger(0)

        val fylkerOgKommuner = if (fylkenummer == "ALLE") {
            geografiService.hentFylkerOgKommuner()
        } else {
            geografiService.hentFylkerOgKommuner().filter { it.fylke.nummer == fylkenummer }
        }

        fylkerOgKommuner.flatMap { fylke ->
            val antallMigrerbareSakerIFylke = AtomicInteger(0)
            val antallGamleSakerIFylke = AtomicInteger(0)
            val antallForsøktMigrerteSakerIFylke = AtomicInteger(0)
            val antallProsesserteSakerIFylke = AtomicInteger(0)
            log.info("[Migrering] Starter migrering av saker for fylke '${fylke.fylke.navn}'. faktiskMigrer: $faktiskMigrer")

            fylke.kommuner.flatMap { kommune ->
                val antallMigrerbareSakerIKommune = AtomicInteger(0)
                val antallProsesserteSakerIKommune = AtomicInteger(0)
                val antallGamleSakerIKommune = AtomicInteger(0)
                val antallForsøktMigrerteSakerIKommune = AtomicInteger(0)

                val alleMigrerbareSakerIKommunne = nyFlytService.hentAlleSisteIASakDtoForKommune(kommune.nummer)
                antallMigrerbareSakerIKommune.addAndGet(alleMigrerbareSakerIKommunne.size)
                log.debug(
                    "[Migrering] funnet ${alleMigrerbareSakerIKommunne.size} siste saker for kommune '${kommune.nummer}' " +
                        "i fylke '${fylke.fylke.navn}'. faktiskMigrer: $faktiskMigrer",
                )

                alleMigrerbareSakerIKommunne.map { iaSakDto ->
                    antallProsesserteSakerIKommune.incrementAndGet()
                    if (faktiskMigrer) antallForsøktMigrerteSakerIKommune.incrementAndGet()

                    migrerSisteSak(
                        iaSakDto = iaSakDto,
                        orgnummer = iaSakDto.orgnr,
                        migreringsDato = LocalDateTime.now().toLocalDate().atStartOfDay(),
                        faktiskMigrer = faktiskMigrer,
                    )?.also {
                        val gamleSakerIVirksomhet = nyFlytService.hentAlleAndreIASakDto(orgnummer = it.orgnr, saksnummer = it.saksnummer)
                        antallGamleSakerIKommune.addAndGet(gamleSakerIVirksomhet.size)

                        gamleSakerIVirksomhet.forEach { gammelIaSakDto ->
                            logMenIkkeMigrerGammelSak(
                                iaSakDto = gammelIaSakDto,
                                faktiskMigrer = faktiskMigrer,
                            )
                        }
                    }
                }.also {
                    antallMigrerbareSakerIFylke.addAndGet(antallMigrerbareSakerIKommune.get())
                    antallForsøktMigrerteSakerIFylke.addAndGet(antallForsøktMigrerteSakerIKommune.get())
                    antallGamleSakerIFylke.addAndGet(antallGamleSakerIKommune.get())
                    antallProsesserteSakerIFylke.addAndGet(antallProsesserteSakerIKommune.get())
                }
            }.also {
                antallProsessert.addAndGet(antallProsesserteSakerIFylke.get())
                antallMigrerbareSakerFunnet.addAndGet(antallMigrerbareSakerIFylke.get())
                antallGamleSakerFunnet.addAndGet(antallGamleSakerIFylke.get())
                if (faktiskMigrer) antallForsøktMigrerteSaker.addAndGet(antallForsøktMigrerteSakerIFylke.get())
                log.info(
                    "[Migrering] Ferdig med migrering av saker for fylke '${fylke.fylke.navn}'. faktiskMigrer: $faktiskMigrer. " +
                        "Antall migrerbare saker i fylke: ${antallProsesserteSakerIFylke.get()}, " +
                        "Antall prosesserte saker i fylke: ${antallProsesserteSakerIFylke.get()}, " +
                        "antall forsøkt migrerte saker i fylke: ${antallForsøktMigrerteSakerIFylke.get()}, " +
                        "antall gamle saker (som ikke migreres) i fylke: ${antallGamleSakerIFylke.get()}. " +
                        "Prosesseringstid: ${java.time.Duration.between(startTidspunkt, LocalDateTime.now()).toSeconds()} sekunder.",
                )
            }
        }

        log.info(
            "[Migrering] Ferdig med migrering av saker for angitt parameter '$fylkenummer'. faktiskMigrer: $faktiskMigrer. " +
                "Antall prosesserte saker: ${antallProsessert.get()}, " +
                "antall forsøkt migrerte saker: ${antallForsøktMigrerteSaker.get()}, " +
                "antall gamle saker (som ikke migreres): ${antallGamleSakerFunnet.get()}. " +
                "Prosesseringstid: ${java.time.Duration.between(startTidspunkt, LocalDateTime.now()).toSeconds()} sekunder.",
        )
        return Triple(antallProsessert.toInt(), antallForsøktMigrerteSaker.toInt(), antallGamleSakerFunnet.toInt())
    }

    fun migrer(
        orgnr: String,
        faktiskMigrer: Boolean,
    ) {
        val migreringsDato: LocalDateTime = LocalDateTime.now().toLocalDate().atStartOfDay()
        nyFlytService.hentSisteIASakDto(orgnummer = orgnr)?.let { iaSakDto ->
            migrerSisteSak(
                iaSakDto = iaSakDto,
                orgnummer = orgnr,
                migreringsDato = migreringsDato,
                faktiskMigrer = faktiskMigrer,
            )
        }?.let {
            nyFlytService.hentAlleAndreIASakDto(orgnummer = it.orgnr, saksnummer = it.saksnummer).forEach { gammelIaSakDto ->
                logMenIkkeMigrerGammelSak(
                    iaSakDto = gammelIaSakDto,
                    faktiskMigrer = faktiskMigrer,
                )
            }
        }
    }

    private fun logMenIkkeMigrerGammelSak(
        iaSakDto: IASakDto,
        faktiskMigrer: Boolean,
    ) {
        log.info(
            "[Migrering][faktiskMigrer=$faktiskMigrer] Funnet eldre sak '${iaSakDto.saksnummer}' med status '${iaSakDto.status}' på virksomhet med orgnr '${iaSakDto.orgnr}' ",
        )
    }

    private fun migrerSisteSak(
        iaSakDto: IASakDto?,
        orgnummer: String,
        migreringsDato: LocalDateTime,
        faktiskMigrer: Boolean,
    ): IASakDto? {
        if (iaSakDto == null) {
            log.info("Fant ingen sak for virksomhet med orgnr '$orgnummer', og det er derfor ingen sak å migrere.")
            return null
        }

        val tilstandVirksomhet = nyFlytService.hentTilstandVirksomhet(orgnummer = iaSakDto.orgnr)
        if (tilstandVirksomhet != null) {
            val loggForNyTilstand = if (tilstandVirksomhet.nesteTilstand?.nyTilstand != null) {
                "neste tilstand '${tilstandVirksomhet.nesteTilstand.nyTilstand}' " +
                    "med planlagt hendelse '${tilstandVirksomhet.nesteTilstand.planlagtHendelse}' " +
                    "og planlagt dato '${tilstandVirksomhet.nesteTilstand.planlagtDato}'"
            } else {
                "ingen neste tilstand"
            }
            log.info(
                "[Migrering][faktiskMigrer=$faktiskMigrer] Sak '${iaSakDto.saksnummer}' med status '${iaSakDto.status}' " +
                    "på virksomhet med orgnr '${iaSakDto.orgnr}' er allerede migrert. Virksomhet har tilstand '${tilstandVirksomhet.tilstand}', " +
                    "og eventuelt ny tilstand til senere oppdatering: '$loggForNyTilstand'. Det er derfor ingen sak å migrere.",
            )
            return iaSakDto
        }

        samarbeidService.hentSamarbeidSomIkkeErSlettet(saksnummer = iaSakDto.saksnummer).apply {
            onRight { samarbeidListe ->
                val samarbeidUseCase = samarbeidListe.getSamarbeidUseCase(migreringsDato = migreringsDato)
                val sakUseCase = iaSakDto.getSakUseCase(migreringsDato = migreringsDato)
                val migreringsplan = Migreringsplan.utledMigreringsplan(
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
                when (migreringsplan) {
                    is Migreringsplan.IkkeGjennomførbar -> {
                        log.info(
                            "[Migrering][${migreringsplan.javaClass.simpleName}][faktiskMigrer=$faktiskMigrer] Sak '${iaSakDto.saksnummer}' " +
                                "med status '${iaSakDto.status.name}' på virksomhet med orgnr '${iaSakDto.orgnr}' " +
                                "er ikke håndtert som en use-case til migrering og vil derfor ikke bli migrert. " +
                                "Følgende use-case '$samarbeidEllerSakBasertUsecase' er ikke håndtert for status '${iaSakDto.status.name}'. " +
                                "Det finnes ${samarbeidListe.size} samarbeid på saken. Detaljer om samarbeid: '$samarbeidDetaljer'. ",
                        )
                        return iaSakDto
                    }

                    is Migreringsplan.Gjennomførbar -> {
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
                            "[Migrering][${migreringsplan.javaClass.simpleName}][faktiskMigrer=$faktiskMigrer] Sak '${iaSakDto.saksnummer}' " +
                                "med status '${iaSakDto.status.name}' på virksomhet med orgnr '${iaSakDto.orgnr}' er en gyldig use-case til migrering. " +
                                "Saken blir migrert til status '${migreringsplan.resulterendeSakStatus.name}', " +
                                "virksomhet vil få tilstand '${migreringsplan.tilstand.tilVirksomhetIATilstand()}', " +
                                "og automatisk oppdatering (VirksomhetKlarTilVurdering om 90 dager): " +
                                "'${migreringsplan.gjørVirksomhetKlarTilVurderingSenere}'. " +
                                "Bakgrunn for migrering er: '$bakgrunnForMigrering'. ",
                        )
                    }
                }

                if (!faktiskMigrer) return iaSakDto

                val transactionalMigrering = TransactionalMigrering(
                    iaSakDto = iaSakDto,
                    migreringsplan = migreringsplan,
                )

                with(receiver = nyFlytService) {
                    transactionalMigrering.apply().apply {
                        onLeft { feil ->
                            log.warn(
                                "[Migrering] Feil ved migrering av sak '${iaSakDto.saksnummer}' på virksomhet med orgnr '${iaSakDto.orgnr}': ${feil.feilmelding}",
                            )
                        }
                        onRight { oppdatertIASakDto: IASakDto ->
                            log.info(
                                "[Migrering] Oppdatert sak '${oppdatertIASakDto.saksnummer}' på virksomhet med orgnr '${oppdatertIASakDto.orgnr}' " +
                                    "fra status '${oppdatertIASakDto.status.name}' til status '${oppdatertIASakDto.status.name}', " +
                                    "og opprettet tilstand '${migreringsplan.tilstand.tilVirksomhetIATilstand()}'",
                            )
                        }
                    }
                }
            }
        }
        return iaSakDto
    }

    companion object {
        // Eksempel på orgnr som skal migreres: "123456789", "123456789:false" eller "123456789:true".
        // Siste del av strengen indikerer om migrering blir gjennomført eller ikke. Default verdi er "false"
        fun String.tilOrgnr() = this.split(":").get(0)

        fun String.tilFylkenummer() = this.split(":").get(0)

        fun String.faktiskMigrer() = this.contains(":") && this.split(":").get(1) == "true"

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
}
