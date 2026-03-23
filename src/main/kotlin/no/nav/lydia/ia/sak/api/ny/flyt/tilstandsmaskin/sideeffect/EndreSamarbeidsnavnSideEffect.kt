package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.sideeffect

import arrow.core.Either
import com.github.guepardoapps.kulid.ULID
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.ny.flyt.NyFlytService
import no.nav.lydia.ia.sak.api.ny.flyt.Transaction
import no.nav.lydia.ia.sak.api.ny.flyt.hentSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.lagreHendelse
import no.nav.lydia.ia.sak.api.ny.flyt.oppdaterNavnPåSamarbeid
import no.nav.lydia.ia.sak.api.ny.flyt.oppdaterStatusPåSak
import no.nav.lydia.ia.sak.api.samarbeid.IASamarbeidDto
import no.nav.lydia.ia.sak.api.samarbeid.tilDto
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle
import java.time.LocalDateTime

class EndreSamarbeidsnavnSideEffect(
    val orgnummer: String,
    val saksnummer: String,
    val samarbeidId: Int,
    val nyttNavn: String,
    val saksbehandler: NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
) : SideEffect<IASamarbeidDto>() {
    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, IASamarbeidDto> =
        nyFlytService.validerSamarbeidsnavn(
            navn = nyttNavn,
            saksnummer = saksnummer,
            saksbehandler = saksbehandler,
        ).map {
            Transaction(nyFlytService.dataSource).transactional { tx ->
                with(tx) {
                    val samarbeidDto = IASamarbeidDto(
                        id = samarbeidId,
                        saksnummer = saksnummer,
                        navn = nyttNavn,
                    )

                    oppdaterNavnPåSamarbeid(samarbeidDto)

                    val iASakshendelse = IASakshendelse(
                        id = ULID.random(),
                        opprettetTidspunkt = LocalDateTime.now(),
                        saksnummer = saksnummer,
                        hendelsesType = IASakshendelseType.ENDRE_PROSESS,
                        orgnummer = orgnummer,
                        opprettetAv = saksbehandler.navIdent,
                        opprettetAvRolle = saksbehandler.rolle,
                        navEnhet = navEnhet,
                        resulterendeStatus = null,
                    )
                    lagreHendelse(
                        hendelse = iASakshendelse,
                        sistEndretAvHendelseId = null,
                        resulterendeStatus = IASak.Status.AKTIV,
                    )
                    oppdaterStatusPåSak(
                        saksnummer = saksnummer,
                        status = IASak.Status.AKTIV,
                        endretAv = saksbehandler.navIdent,
                        endretAvHendelseId = iASakshendelse.id,
                    )
                    hentSamarbeid(samarbeidId = samarbeidId)!!
                }
            }.also { samarbeid ->
                nyFlytService.iaSamarbeidObservers.forEach { it.receive(samarbeid) }
                nyFlytService.iaSakRepository.hentIASakDto(saksnummer)!!.also {
                    nyFlytService.varsleIASakObservers(it)
                }
            }.tilDto()
        }
}
