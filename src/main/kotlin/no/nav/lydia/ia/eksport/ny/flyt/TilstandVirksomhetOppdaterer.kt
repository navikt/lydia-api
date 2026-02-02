package no.nav.lydia.ia.eksport.ny.flyt

import kotlinx.datetime.LocalDate
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.IASamarbeidService
import no.nav.lydia.ia.sak.PlanService
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringService
import no.nav.lydia.ia.sak.api.ny.flyt.FiaKontekst
import no.nav.lydia.ia.sak.api.ny.flyt.Hendelse
import no.nav.lydia.ia.sak.api.ny.flyt.NyFlytService
import no.nav.lydia.ia.sak.api.ny.flyt.TilstandVirksomhetRepository
import no.nav.lydia.ia.sak.api.ny.flyt.TilstandsmaskinBuilder
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.vedlikehold.IASakStatusOppdaterer
import org.slf4j.Logger
import org.slf4j.LoggerFactory

class TilstandVirksomhetOppdaterer(
    val nyFlytService: NyFlytService,
    val iaSakService: IASakService,
    val iASamarbeidService: IASamarbeidService,
    val dokumentPubliseringService: DokumentPubliseringService,
    val planService: PlanService,
    val tilstandVirksomhetRepository: TilstandVirksomhetRepository,
) {
    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun oppdaterTilstandVirksomhet(planlagtDato: LocalDate) {
        log.info("Oppdaterer tilstand virksomhet...")
        val alleVirksomhetTilstander = nyFlytService.hentAlleVirksomhetTilstanderFiltrertPåPlanlagtDato(planlagtDato = planlagtDato)
        log.info("Fant ${alleVirksomhetTilstander.size} virksomheter med planlagte tilstandsoppdateringer.")
        alleVirksomhetTilstander.forEach {
            val hendelse = utledHendelseFraString(it.nesteTilstand?.planlagtHendelse, it.orgnr)
            val konsekvens = tilstandsmaskin(it.orgnr).prosesserHendelse(
                hendelse = hendelse,
            )
            log.info("Oppdatert tilstand for virksomhet ${it.orgnr}, ny tilstand: ${konsekvens.nyTilstand}")
            nyFlytService.slettVirksomhetTilstandAutomatiskOppdatering(it.orgnr)
            log.info("Slettet planlagt tilstandsoppdatering for virksomhet ${it.orgnr}.")
        }
        log.info("Ferdig med å oppdatere alle tilstand virksomheter.")
    }

    private fun utledHendelseFraString(
        hendelse: String?,
        orgnr: String,
    ): Hendelse =
        when (hendelse) {
            "GjørVirksomhetKlarTilNyVurdering" -> Hendelse.GjørVirksomhetKlarTilNyVurdering(
                orgnr = orgnr,
            )

            "VurderVirksomhet" -> Hendelse.VurderVirksomhet(
                orgnr = orgnr,
                superbruker = NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker(
                    navIdent = "Fia system",
                    navn = "Fia system",
                    token = "",
                    ansattesGrupper = emptySet(),
                ),
                navEnhet = IASakStatusOppdaterer.NAV_ENHET_FOR_MASKINELT_OPPDATERING,
            )

            else -> throw IllegalArgumentException("Ukjent hendelse: $hendelse")
        }

    fun tilstandsmaskin(orgnr: String) =
        TilstandsmaskinBuilder.medKontekst(
            fiaKontekst = FiaKontekst(
                iaSakService = iaSakService,
                iASamarbeidService = iASamarbeidService,
                nyFlytService = nyFlytService,
                dokumentPubliseringService = dokumentPubliseringService,
                planService = planService,
                tilstandVirksomhetRepository = tilstandVirksomhetRepository,
                saksnummer = nyFlytService.hentSisteIASakDto(orgnr)?.saksnummer,
            ),
        ).build(orgnr)
}
