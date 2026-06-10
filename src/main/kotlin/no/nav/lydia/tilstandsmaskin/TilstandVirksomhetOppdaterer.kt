package no.nav.lydia.tilstandsmaskin

import no.nav.lydia.dokumentpublisering.DokumentPubliseringService
import no.nav.lydia.samarbeid.IASamarbeidService
import no.nav.lydia.samarbeidsperiode.IASakService
import no.nav.lydia.samarbeidsperiode.IASakStatusOppdaterer
import no.nav.lydia.samarbeidsplan.PlanService
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.tilstandsmaskin.hendelse.GjørVirksomhetKlarTilNyVurdering
import no.nav.lydia.tilstandsmaskin.hendelse.Hendelse
import no.nav.lydia.tilstandsmaskin.hendelse.VurderVirksomhet
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
            tilstandsmaskin(it.orgnr).prosesserHendelse(
                hendelse = hendelse,
            )
            val nyTilstand = tilstandsmaskin(it.orgnr).tilstand
            log.info("Oppdatert tilstand for virksomhet. Gammel tilstand: ${it.tilstand.tilTilstand().navn()}. Ny tilstand: ${nyTilstand.navn()}")
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
