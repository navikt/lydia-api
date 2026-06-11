package no.nav.lydia.tilstandsmaskin.sideeffect

import arrow.core.Either
import com.github.guepardoapps.kulid.ULID
import no.nav.lydia.felles.Feil
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.samarbeid.IASamarbeidDto
import no.nav.lydia.samarbeid.tilDto
import no.nav.lydia.samarbeidsperiode.IASak
import no.nav.lydia.samarbeidsperiode.IASakshendelse
import no.nav.lydia.samarbeidsperiode.IASakshendelseType
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle
import no.nav.lydia.tilstandsmaskin.NyFlytService
import no.nav.lydia.tilstandsmaskin.Transaction
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidTransactional.Companion.hentSamarbeid
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidTransactional.Companion.oppdaterNavnPåSamarbeid
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidsperiodeTransactional.Companion.lagreHendelse
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidsperiodeTransactional.Companion.oppdaterStatusPåSak
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
        nyFlytService.validerEndringAvSamarbeid(
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
