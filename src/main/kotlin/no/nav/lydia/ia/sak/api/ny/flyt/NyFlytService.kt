package no.nav.lydia.ia.sak.api.ny.flyt

import arrow.core.Either
import com.github.guepardoapps.kulid.ULID
import kotlinx.datetime.toKotlinLocalDateTime
import no.nav.lydia.Observer
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.sak.domene.IASak.Status
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VURDERING_FULLFØRT_UTEN_SAMARBEID
import no.nav.lydia.ia.årsak.db.ÅrsakRepository
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker
import java.time.LocalDateTime

class NyFlytService(
    val iaSakRepository: IASakRepository,
    val iaSakshendelseRepository: IASakshendelseRepository,
    val årsakRepository: ÅrsakRepository,
    val iaSakObservers: List<Observer<IASakDto>>,
) {
    private fun varsleIASakObservers(sakDto: IASakDto) {
        iaSakObservers.forEach { observer -> observer.receive(input = sakDto) }
    }

    private fun IASakDto.nyHendelseBasertPåSak(
        hendelsestype: IASakshendelseType,
        superbruker: Superbruker,
        navEnhet: NavEnhet,
    ) = IASakshendelse(
        id = ULID.random(),
        opprettetTidspunkt = LocalDateTime.now(),
        saksnummer = this.saksnummer,
        hendelsesType = hendelsestype,
        orgnummer = this.orgnr,
        opprettetAv = superbruker.navIdent,
        opprettetAvRolle = superbruker.rolle,
        navEnhet = navEnhet,
        resulterendeStatus = null,
    )

    private fun fraFørsteHendelse(hendelse: IASakshendelse): IASakDto =
        IASakDto(
            saksnummer = hendelse.saksnummer,
            orgnr = hendelse.orgnummer,
            opprettetTidspunkt = hendelse.opprettetTidspunkt.toKotlinLocalDateTime(),
            opprettetAv = hendelse.opprettetAv,
            eidAv = null,
            endretTidspunkt = null,
            endretAv = null,
            endretAvHendelseId = hendelse.id,
            status = Status.NY,
            gyldigeNesteHendelser = emptyList(),
            lukket = false,
        )

    fun opprettSakOgMerkSomVurdert(
        orgnummer: String,
        superbruker: Superbruker,
        navEnhet: NavEnhet,
    ): Either<Feil, IASakDto> {
        if (!iaSakRepository.hentSaker(orgnummer).all { it.status.regnesSomAvsluttet() }) {
            return Either.Left(IASakError.`det finnes flere saker på dette orgnummeret som ikke regnes som avsluttet`)
        }

        // Steg #1 lagre i DB en ny hendelse OPPRETT_SAK_FOR_VIRKSOMHET, og en ny SakDto med status NY
        val iaSakHendelseOpprettSak = IASakshendelse.nyFørsteHendelse(
            orgnummer = orgnummer,
            superbruker = superbruker,
            navEnhet = navEnhet,
        )
        iaSakshendelseRepository.lagreHendelse(
            hendelse = iaSakHendelseOpprettSak,
            sistEndretAvHendelseId = null,
            resulterendeStatus = Status.NY,
        )
        val iaSakDto: IASakDto = iaSakRepository.opprettSak(
            iaSakDto = fraFørsteHendelse(iaSakHendelseOpprettSak),
        ).also(::varsleIASakObservers)

        // Steg #2 lagre i DB en ny hendelse VIRKSOMHET_VURDERES, og oppdater SakDto med status VURDERES
        val iaSakshendelseVurderes = iaSakshendelseRepository.lagreHendelse(
            hendelse = iaSakDto.nyHendelseBasertPåSak(
                hendelsestype = IASakshendelseType.VIRKSOMHET_VURDERES,
                superbruker = superbruker,
                navEnhet = navEnhet,
            ),
            sistEndretAvHendelseId = null,
            resulterendeStatus = Status.VURDERES,
        )
        val oppdatertIaSakDto = iaSakRepository.oppdaterStatusPåSak(
            saksnummer = iaSakDto.saksnummer,
            status = Status.VURDERES,
            endretAv = superbruker.navIdent,
            endretAvHendelseId = iaSakshendelseVurderes.id,
        ).onRight(::varsleIASakObservers)

        return oppdatertIaSakDto
    }

    fun fullførVurderingAvVirksomhetUtenSamarbeid(
        orgnummer: String,
        årsak: ValgtÅrsak,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
        navEnhet: NavEnhet,
        // observers: List<Noe>
    ): Either<Feil, Any?> {
        val iaSak = hentAktivIASakDto(orgnummer = orgnummer)!!

        val iASakshendelse = IASakshendelse(
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
            hendelse = iASakshendelse,
            sistEndretAvHendelseId = null,
            resulterendeStatus = Status.VURDERT,
        )

        årsakRepository.lagreÅrsakForHendelse(
            hendelseId = iASakshendelse.id,
            valgtÅrsak = årsak,
        )
        val oppdatertSak = iaSakRepository.oppdaterStatusPåSak(
            saksnummer = iaSak.saksnummer,
            status = Status.VURDERT,
            endretAvHendelseId = iASakshendelse.id,
            endretAv = saksbehandler.navIdent,
        )

        return oppdatertSak
    }

    fun hentAktivIASakDto(orgnummer: String): IASakDto? =
        iaSakRepository.hentAlleSakerForVirksomhet(orgnummer = orgnummer)
            .sortedByDescending { it.opprettetTidspunkt }
            .firstOrNull { !it.lukket }

    fun slettSak(sakDto: IASakDto): Either<Feil, IASakDto> =
        try {
            iaSakRepository.slettSak(saksnummer = sakDto.saksnummer, sistEndretAvHendelseId = null)
            Either.Right(sakDto)
        } catch (_: Exception) {
            Either.Left(IASakError.`fikk ikke slettet sak`)
        }
}
