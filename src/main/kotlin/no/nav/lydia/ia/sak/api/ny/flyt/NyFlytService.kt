package no.nav.lydia.ia.sak.api.ny.flyt

import arrow.core.Either
import com.github.guepardoapps.kulid.ULID
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakDto.Companion.erLukket
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VURDERING_FULLFØRT_UTEN_SAMARBEID
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import java.time.LocalDateTime

class NyFlytService(
    val iaSakRepository: IASakRepository,
    val iaSakshendelseRepository: IASakshendelseRepository,
) {
    fun fullførVurderingAvVirksomhetUtenSamarbeid(
        orgnummer: String,
        årsak: String = "Legg til en årsak senere",
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
        navEnhet: NavEnhet,
    ): Either<Feil, Any?> {
        val iaSak = hentAktivSak(orgnummer = orgnummer)!!

        // lage hendelsen
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
        // lagre hendelsen

        iaSakshendelseRepository.lagreHendelse(
            hendelse = hendelse,
            sistEndretAvHendelseId = null,
            resulterendeStatus = IASak.Status.VURDERT,
        )

        // oppdater status
        // lagre årsak
        // ..
        TODO("Ikke implementert ennå")
    }

    private fun hentAktivSak(orgnummer: String): IASak? =
        iaSakRepository.hentSaker(orgnummer = orgnummer)
            .sortedByDescending { it.opprettetTidspunkt }
            .firstOrNull { !it.erLukket() }
}
