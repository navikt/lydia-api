package no.nav.lydia.ia.sak.api.ny.flyt

import arrow.core.Either
import com.github.guepardoapps.kulid.ULID
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VURDERING_FULLFØRT_UTEN_SAMARBEID
import no.nav.lydia.ia.årsak.db.ÅrsakRepository
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import java.time.LocalDateTime

class NyFlytService(
    val iaSakRepository: IASakRepository,
    val iaSakshendelseRepository: IASakshendelseRepository,
    val årsakRepository: ÅrsakRepository,
) {
    fun fullførVurderingAvVirksomhetUtenSamarbeid(
        orgnummer: String,
        årsak: ValgtÅrsak,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
        navEnhet: NavEnhet,
    ): Either<Feil, Any?> {
        val iaSak = hentAktivIASakDto(orgnummer = orgnummer)!!

        val hendelse = IASakshendelse(
            id = ULID.random(),
            opprettetTidspunkt = LocalDateTime.now(),
            saksnummer = iaSak.saksnummer,
            hendelsesType = VURDERING_FULLFØRT_UTEN_SAMARBEID,
            orgnummer = orgnummer,
            opprettetAv = saksbehandler.navIdent,
            opprettetAvRolle = saksbehandler.rolle,
            navEnhet = navEnhet,
            resulterendeStatus = null,
        )
        iaSakshendelseRepository.lagreHendelse(
            hendelse = hendelse,
            sistEndretAvHendelseId = null,
            resulterendeStatus = IASak.Status.VURDERT,
        )

        årsakRepository.lagreÅrsakForHendelse(
            hendelseId = hendelse.id,
            valgtÅrsak = årsak,
        )
        val oppdatertSak = iaSakRepository.oppdaterStatusPåSak(
            saksnummer = iaSak.saksnummer,
            status = IASak.Status.VURDERT,
            endretAvHendelseId = hendelse.id,
            endretAv = saksbehandler.navIdent,
        )

        return oppdatertSak
    }

    fun hentAktivIASakDto(orgnummer: String): IASakDto? =
        iaSakRepository.hentAlleSakerForVirksomhet(orgnummer = orgnummer)
            .sortedByDescending { it.opprettetTidspunkt }
            .firstOrNull { !it.lukket }
}
