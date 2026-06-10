package no.nav.lydia.abc.tilstandsmaskin.sideeffect

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.toKotlinLocalDateTime
import no.nav.lydia.abc.felles.Feil
import no.nav.lydia.abc.samarbeidsperiode.IASak.Status.NY
import no.nav.lydia.abc.samarbeidsperiode.IASak.Status.VURDERES
import no.nav.lydia.abc.samarbeidsperiode.IASakDto
import no.nav.lydia.abc.samarbeidsperiode.IASakshendelse
import no.nav.lydia.abc.samarbeidsperiode.IASakshendelseType
import no.nav.lydia.abc.samarbeidsperiode.ValgtÅrsak
import no.nav.lydia.abc.tilstandsmaskin.NyFlytService
import no.nav.lydia.abc.tilstandsmaskin.Transaction
import no.nav.lydia.abc.tilstandsmaskin.VirksomhetIATilstand
import no.nav.lydia.abc.tilstandsmaskin.lagreEllerOppdaterVirksomhetTilstand
import no.nav.lydia.abc.tilstandsmaskin.lagreHendelse
import no.nav.lydia.abc.tilstandsmaskin.lagreÅrsakForHendelse
import no.nav.lydia.abc.tilstandsmaskin.nyHendelseBasertPåSak
import no.nav.lydia.abc.tilstandsmaskin.oppdaterStatusPåSak
import no.nav.lydia.abc.tilstandsmaskin.opprettSak
import no.nav.lydia.abc.tilstandsmaskin.slettVirksomhetTilstandAutomatiskOppdatering
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt

class VurderVirksomhetSideEffect(
    val orgnummer: String,
    val superbruker: NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker,
    val navEnhet: NavEnhet,
    val valgtÅrsak: ValgtÅrsak? = null,
) : SideEffect<IASakDto>() {
    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, IASakDto> =
        try {
            Transaction(nyFlytService.dataSource).transactional { tx ->
                with(tx) {
                    // Steg #1 lagre i DB en ny hendelse OPPRETT_SAK_FOR_VIRKSOMHET, og en ny SakDto med status NY
                    val iaSakHendelseOpprettSak = IASakshendelse.nyFørsteHendelse(
                        orgnummer = orgnummer,
                        superbruker = superbruker,
                        navEnhet = navEnhet,
                    )
                    lagreHendelse(
                        hendelse = iaSakHendelseOpprettSak,
                        sistEndretAvHendelseId = null,
                        resulterendeStatus = NY,
                    )
                    val iaSakDto: IASakDto = opprettSak(
                        iaSakDto = iaSakHendelseOpprettSak.tilIASakDto(),
                    )

                    // Steg #2 lagre i DB en ny hendelse VIRKSOMHET_VURDERES, og oppdatere SakDto til status VURDERES
                    val iaSakshendelseVurderes = lagreHendelse(
                        hendelse = iaSakDto.nyHendelseBasertPåSak(
                            hendelsestype = IASakshendelseType.VIRKSOMHET_VURDERES,
                            superbruker = superbruker,
                            navEnhet = navEnhet,
                        ),
                        sistEndretAvHendelseId = null,
                        resulterendeStatus = VURDERES,
                    )
                    valgtÅrsak?.let {
                        lagreÅrsakForHendelse(
                            hendelseId = iaSakshendelseVurderes.id,
                            valgtÅrsak = it,
                        )
                    }
                    val oppdatertIaSakDto = oppdaterStatusPåSak(
                        saksnummer = iaSakDto.saksnummer,
                        status = VURDERES,
                        endretAv = superbruker.navIdent,
                        endretAvHendelseId = iaSakshendelseVurderes.id,
                    )
                    lagreEllerOppdaterVirksomhetTilstand(
                        orgnr = orgnummer,
                        tilstand = VirksomhetIATilstand.VirksomhetVurderes,
                    )

                    slettVirksomhetTilstandAutomatiskOppdatering(
                        orgnr = orgnummer,
                    )

                    oppdatertIaSakDto
                }
            }.also { nyFlytService.varsleIASakObservers(it) }
                .right()
        } catch (e: Exception) {
            Feil("Feil ved vurdering av virksomhet: ${e.message}", HttpStatusCode.InternalServerError).left()
        }
}

private fun IASakshendelse.tilIASakDto(): IASakDto =
    IASakDto(
        saksnummer = this.saksnummer,
        orgnr = this.orgnummer,
        opprettetTidspunkt = this.opprettetTidspunkt.toKotlinLocalDateTime(),
        opprettetAv = this.opprettetAv,
        eidAv = null,
        endretTidspunkt = null,
        endretAv = null,
        endretAvHendelseId = this.id,
        status = NY,
        gyldigeNesteHendelser = emptyList(),
    )
