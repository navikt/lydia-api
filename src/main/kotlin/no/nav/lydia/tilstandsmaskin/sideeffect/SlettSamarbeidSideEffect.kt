package no.nav.lydia.tilstandsmaskin.sideeffect

import arrow.core.Either
import com.github.guepardoapps.kulid.ULID
import no.nav.lydia.felles.Feil
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.samarbeid.IASamarbeid
import no.nav.lydia.samarbeid.IASamarbeidDto
import no.nav.lydia.samarbeid.tilDto
import no.nav.lydia.samarbeidsperiode.IASak.Status.AKTIV
import no.nav.lydia.samarbeidsperiode.IASak.Status.AVSLUTTET
import no.nav.lydia.samarbeidsperiode.IASak.Status.VURDERES
import no.nav.lydia.samarbeidsperiode.IASakshendelse
import no.nav.lydia.samarbeidsperiode.IASakshendelseType
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle
import no.nav.lydia.tilstandsmaskin.NyFlytService
import no.nav.lydia.tilstandsmaskin.Transaction
import no.nav.lydia.tilstandsmaskin.VirksomhetIATilstand
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidTransactional.Companion.hentSamarbeidSomIkkeErSlettet
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidTransactional.Companion.slettSamarbeid
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidsperiodeTransactional.Companion.lagreHendelse
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidsperiodeTransactional.Companion.oppdaterStatusPåSak
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.TilstandVirksomhetTransactional.Companion.lagreEllerOppdaterVirksomhetTilstand
import java.time.LocalDateTime

class SlettSamarbeidSideEffect(
    val orgnummer: String,
    val saksnummer: String,
    val samarbeidId: Int,
    val saksbehandler: NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
) : SideEffect<IASamarbeidDto>() {
    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, IASamarbeidDto> =
        nyFlytService.validerSlettingAvSamarbeid(
            saksnummer = saksnummer,
            samarbeidId = samarbeidId,
            saksbehandler = saksbehandler,
        ).map {
            Transaction(nyFlytService.dataSource).transactional { tx ->
                with(tx) {
                    val samarbeidDto = IASamarbeidDto(
                        id = samarbeidId,
                        saksnummer = saksnummer,
                        navn = "",
                    )

                    val slettetSamarbeid = slettSamarbeid(samarbeidDto)

                    val iASakshendelse = IASakshendelse(
                        id = ULID.random(),
                        opprettetTidspunkt = LocalDateTime.now(),
                        saksnummer = saksnummer,
                        hendelsesType = IASakshendelseType.SLETT_PROSESS,
                        orgnummer = orgnummer,
                        opprettetAv = saksbehandler.navIdent,
                        opprettetAvRolle = saksbehandler.rolle,
                        navEnhet = navEnhet,
                        resulterendeStatus = null,
                    )

                    val alleSamarbeid = hentSamarbeidSomIkkeErSlettet(saksnummer = saksnummer)
                    val ingenAndreSamarbeid = alleSamarbeid.isEmpty()
                    val alleAndreSamarbeidErAvsluttet = alleSamarbeid.isNotEmpty() && alleSamarbeid
                        .all { it.status == IASamarbeid.Status.AVBRUTT || it.status == IASamarbeid.Status.FULLFØRT }

                    val resulterendeStatus = when {
                        ingenAndreSamarbeid -> VURDERES
                        alleAndreSamarbeidErAvsluttet -> AVSLUTTET
                        else -> AKTIV
                    }

                    lagreHendelse(
                        hendelse = iASakshendelse,
                        sistEndretAvHendelseId = null,
                        resulterendeStatus = resulterendeStatus,
                    )

                    val oppdatertSak = oppdaterStatusPåSak(
                        saksnummer = saksnummer,
                        status = resulterendeStatus,
                        endretAv = saksbehandler.navIdent,
                        endretAvHendelseId = iASakshendelse.id,
                    )

                    val nyTilstand = when (oppdatertSak.status) {
                        VURDERES -> VirksomhetIATilstand.VirksomhetVurderes
                        AVSLUTTET -> VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet
                        else -> VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
                    }

                    lagreEllerOppdaterVirksomhetTilstand(
                        orgnr = oppdatertSak.orgnr,
                        tilstand = nyTilstand,
                    )

                    slettetSamarbeid
                }
            }.also { samarbeid ->
                nyFlytService.iaSamarbeidObservers.forEach { it.receive(samarbeid) }
                nyFlytService.iaSakRepository.hentIASakDto(saksnummer)!!.also {
                    nyFlytService.varsleIASakObservers(it)
                }
            }.tilDto()
        }
}
