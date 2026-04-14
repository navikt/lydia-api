package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.sideeffect

import arrow.core.Either
import com.github.guepardoapps.kulid.ULID
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.ny.flyt.NyFlytService
import no.nav.lydia.ia.sak.api.ny.flyt.Transaction
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetIATilstand
import no.nav.lydia.ia.sak.api.ny.flyt.hentSamarbeidSomIkkeErSlettet
import no.nav.lydia.ia.sak.api.ny.flyt.lagreEllerOppdaterVirksomhetTilstand
import no.nav.lydia.ia.sak.api.ny.flyt.lagreHendelse
import no.nav.lydia.ia.sak.api.ny.flyt.oppdaterStatusPåSak
import no.nav.lydia.ia.sak.api.ny.flyt.slettSamarbeid
import no.nav.lydia.ia.sak.api.samarbeid.IASamarbeidDto
import no.nav.lydia.ia.sak.api.samarbeid.tilDto
import no.nav.lydia.ia.sak.domene.IASak.Status.AKTIV
import no.nav.lydia.ia.sak.domene.IASak.Status.AVSLUTTET
import no.nav.lydia.ia.sak.domene.IASak.Status.VURDERES
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle
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
