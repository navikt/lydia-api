package no.nav.lydia.integrasjoner.kartlegging

import arrow.core.getOrElse
import ia.felles.integrasjoner.jobbsender.Jobb
import kotlinx.datetime.toJavaLocalDateTime
import no.nav.lydia.dokumentpublisering.DokumentPubliseringService
import no.nav.lydia.kartlegging.Spørreundersøkelse
import no.nav.lydia.samarbeid.IASamarbeidService
import no.nav.lydia.samarbeidsperiode.IASakService
import no.nav.lydia.samarbeidsplan.PlanService
import no.nav.lydia.tilgangskontroll.Standardbrukere
import no.nav.lydia.tilstandsmaskin.FiaKontekst
import no.nav.lydia.tilstandsmaskin.NyFlytService
import no.nav.lydia.tilstandsmaskin.TilstandVirksomhetOppdaterer.Companion.NAV_ENHET_FOR_MASKINELT_OPPDATERING
import no.nav.lydia.tilstandsmaskin.TilstandVirksomhetRepository
import no.nav.lydia.tilstandsmaskin.TilstandsmaskinBuilder
import no.nav.lydia.tilstandsmaskin.hendelse.FullførKartleggingForSamarbeid
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.time.LocalDateTime
import java.util.UUID

class MaskineltFullførKartleggingEtter24t(
    private val nyFlytService: NyFlytService,
    private val iaSakService: IASakService,
    private val iASamarbeidService: IASamarbeidService,
    private val dokumentPubliseringService: DokumentPubliseringService,
    private val planService: PlanService,
    private val tilstandVirksomhetRepository: TilstandVirksomhetRepository,
) {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)

    fun fullfør(parameter: String?) {
        val kartleggingId = try {
            parameter?.let { UUID.fromString(it) }?.takeIf { it.toString().equals(parameter, ignoreCase = true) }
        } catch (_: IllegalArgumentException) {
            null
        }
        if (kartleggingId == null) {
            logger.warn("Jobben '${Jobb.fullforKartleggingEtter24t.name}' krever kartleggingId som en gyldig UUID. Stopper.")
            return
        }

        val kartlegging = nyFlytService
            .validerFullføringAvKartlegging(kartleggingId).getOrElse {
                logger.warn("Kan ikke fullføre kartleggingen med id '$kartleggingId': '${it.feilmelding}'. Stopper.")
                return
            }

        if (!harPassertFristen(kartlegging, LocalDateTime.now())) {
            logger.warn("Kartleggingen med id '$kartleggingId' har ikke passert fristen og skal kunne fullføres av brukeren. Stopper.")
            return
        }

        val tilstandsmaskin = tilstandsmaskin(kartlegging.orgnummer)
        if (tilstandsmaskin.saksnummer != kartlegging.saksnummer) {
            logger.warn("Kartleggingen med id {} tilhører ikke gjeldende sak. Stopper.", kartleggingId)
            return
        }

        tilstandsmaskin.prosesserHendelse(
            FullførKartleggingForSamarbeid(
                orgnr = kartlegging.orgnummer,
                spørreundersøkelseId = kartleggingId,
                saksbehandler = Standardbrukere.fiaSystemSuperbruker,
                navEnhet = NAV_ENHET_FOR_MASKINELT_OPPDATERING,
            ),
        ).fold(
            ifLeft = {
                logger.warn("Kan ikke fullføre kartleggingen med id id '$kartleggingId': '${it.feilmelding}'. Stopper.")
            },
            ifRight = {
                logger.info("Fullførte kartleggingen med id '$kartleggingId' etter fristen (maskinelt fullført)")
            },
        )
    }

    private fun tilstandsmaskin(orgnr: String) =
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

    companion object {
        internal fun harPassertFristen(
            kartlegging: Spørreundersøkelse,
            tidspunkt: LocalDateTime,
        ): Boolean = tidspunkt.isAfter(kartlegging.gyldigTilTidspunkt.toJavaLocalDateTime())
    }
}
