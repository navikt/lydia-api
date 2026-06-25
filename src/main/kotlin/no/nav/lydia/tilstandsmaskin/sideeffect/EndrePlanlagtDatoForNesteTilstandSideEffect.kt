package no.nav.lydia.tilstandsmaskin.sideeffect

import arrow.core.Either
import com.github.guepardoapps.kulid.ULID
import no.nav.lydia.felles.Feil
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.samarbeidsperiode.IASak
import no.nav.lydia.samarbeidsperiode.IASakDto
import no.nav.lydia.samarbeidsperiode.IASakshendelse
import no.nav.lydia.samarbeidsperiode.IASakshendelseType
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.tilstandsmaskin.NyFlytService
import no.nav.lydia.tilstandsmaskin.Transaction
import no.nav.lydia.tilstandsmaskin.VirksomhetTilstandAutomatiskOppdateringDto
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidsperiodeTransactional.Companion.lagreHendelse
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidsperiodeTransactional.Companion.oppdaterStatusPåSak
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.TilstandVirksomhetTransactional.Companion.endrePlanlagtDatoForNesteTilstand
import org.slf4j.LoggerFactory
import java.time.LocalDateTime

class EndrePlanlagtDatoForNesteTilstandSideEffect(
    val orgnummer: String,
    val saksnummer: String,
    val nyPlanlagtDato: java.time.LocalDate,
    val resulterendeSakStatus: IASak.Status,
    val saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
) : SideEffect<VirksomhetTilstandAutomatiskOppdateringDto>() {
    val logger = LoggerFactory.getLogger(this::class.java)

    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, VirksomhetTilstandAutomatiskOppdateringDto> =
        nyFlytService.validerEndringAvPlanlagtDatoForNesteTilstand(
            orgnummer = orgnummer,
            saksnummer = saksnummer,
            nyPlanlagtDato = nyPlanlagtDato,
        ).map { _ ->
            Transaction(nyFlytService.dataSource).transactional {
                val hendelse = lagreHendelse(
                    hendelse = IASakshendelse(
                        id = ULID.random(),
                        opprettetTidspunkt = LocalDateTime.now(),
                        saksnummer = saksnummer,
                        hendelsesType = IASakshendelseType.ENDRE_PLANLAGT_DATO,
                        orgnummer = orgnummer,
                        opprettetAv = saksbehandler.navIdent,
                        opprettetAvRolle = saksbehandler.rolle,
                        navEnhet = navEnhet,
                        resulterendeStatus = null,
                    ),
                    sistEndretAvHendelseId = null,
                    resulterendeStatus = resulterendeSakStatus,
                )

                val iaSakDto: IASakDto = oppdaterStatusPåSak(
                    saksnummer = saksnummer,
                    status = resulterendeSakStatus,
                    endretAv = saksbehandler.navIdent,
                    endretAvHendelseId = hendelse.id,
                )
                val virksomhetTilstandAutomatiskOppdateringDto: VirksomhetTilstandAutomatiskOppdateringDto? = endrePlanlagtDatoForNesteTilstand(
                    orgnr = orgnummer,
                    nyPlanlagtDato = nyPlanlagtDato,
                )
                Pair(iaSakDto, virksomhetTilstandAutomatiskOppdateringDto)
            }.also { result: Pair<IASakDto, VirksomhetTilstandAutomatiskOppdateringDto?> ->
                nyFlytService.varsleIASakObservers(result.first)
                logger.info("EndrePlanlagtDatoForNesteTilstand kjørt for saksnummer='$saksnummer', nyPlanlagtDato='$nyPlanlagtDato'")
            }.second ?: error("Fant ingen tilstand_automatisk_oppdatering for saksnummer '$saksnummer'")
        }
}
