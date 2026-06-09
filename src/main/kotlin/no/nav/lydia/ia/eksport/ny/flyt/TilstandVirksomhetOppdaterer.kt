package no.nav.lydia.ia.eksport.ny.flyt

import no.nav.lydia.abc.samarbeid.IASamarbeidService
import no.nav.lydia.abc.samarbeidsperiode.IASakService
import no.nav.lydia.abc.tilstandsmaskin.FiaKontekst
import no.nav.lydia.abc.tilstandsmaskin.NyFlytService
import no.nav.lydia.abc.tilstandsmaskin.TilstandVirksomhetRepository
import no.nav.lydia.abc.tilstandsmaskin.TilstandsmaskinBuilder
import no.nav.lydia.abc.tilstandsmaskin.hendelse.GjørVirksomhetKlarTilNyVurdering
import no.nav.lydia.abc.tilstandsmaskin.hendelse.Hendelse
import no.nav.lydia.abc.tilstandsmaskin.hendelse.VurderVirksomhet
import no.nav.lydia.abc.tilstandsmaskin.tilTilstand
import no.nav.lydia.ia.sak.PlanService
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringService
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

    fun oppdaterTilstandVirksomhet() {
        log.info("Oppdaterer tilstand virksomhet...")
        val virksomhetTilstander = nyFlytService.hentAlleVirksomhetTilstanderMedPlanlagtDatoFørEllerIDag()
        log.info("Fant ${virksomhetTilstander.size} virksomheter med planlagte tilstandsoppdateringer.")
        virksomhetTilstander.forEach {
            val hendelse = utledHendelseFraString(it.nesteTilstand?.planlagtHendelse, it.orgnr)
            val konsekvens = tilstandsmaskin(it.orgnr).prosesserHendelse(
                hendelse = hendelse,
            )
            log.info("Oppdatert tilstand for virksomhet. Gammel tilstand: ${it.tilstand.tilTilstand().navn()}. Ny tilstand: ${konsekvens.nyTilstand.navn()}")
            nyFlytService.slettVirksomhetTilstandAutomatiskOppdatering(it.orgnr)
            log.info("Slettet planlagt tilstandsoppdatering for virksomhet.")
        }
        log.info("Ferdig med å oppdatere alle tilstand virksomheter.")
    }

    private fun utledHendelseFraString(
        hendelse: String?,
        orgnr: String,
    ): Hendelse =
        when (hendelse) {
            "GjørVirksomhetKlarTilNyVurdering" -> GjørVirksomhetKlarTilNyVurdering(
                orgnr = orgnr,
            )

            "VurderVirksomhet" -> VurderVirksomhet(
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
