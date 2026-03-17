package no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.sideeffect

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.toKotlinLocalDateTime
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.NyFlytService
import no.nav.lydia.ia.sak.api.ny.flyt.Transaction
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetIATilstand
import no.nav.lydia.ia.sak.api.ny.flyt.lagreEllerOppdaterVirksomhetTilstand
import no.nav.lydia.ia.sak.api.ny.flyt.lagreHendelse
import no.nav.lydia.ia.sak.api.ny.flyt.nyHendelseBasertPåSak
import no.nav.lydia.ia.sak.api.ny.flyt.oppdaterStatusPåSak
import no.nav.lydia.ia.sak.api.ny.flyt.opprettSak
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASak.Status.NY
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt

class VirksomhetVurderesSideEffect(
    val orgnummer: String,
    val superbruker: NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker,
    val navEnhet: NavEnhet,
) : SideEffect<IASakDto>() {
    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, IASakDto> =
        try {
            Transaction(nyFlytService.dataSource).transactional { tx ->
                with(tx) {
                    // Steg #1 lagre i DB en ny hendelse OPPRETT_SAK_FOR_VIRKSOMHET, og en ny SakDto med status NY
                    val iaSakHendelseOpprettSak = IASakshendelse.Companion.nyFørsteHendelse(
                        orgnummer = orgnummer,
                        superbruker = superbruker,
                        navEnhet = navEnhet,
                    )
                    lagreHendelse(
                        hendelse = iaSakHendelseOpprettSak,
                        sistEndretAvHendelseId = null,
                        resulterendeStatus = IASak.Status.NY,
                    )
                    val iaSakDto: IASakDto = opprettSak(
                        iaSakDto = iaSakHendelseOpprettSak.tilIASakDto(),
                    )

                    // Steg #2 lagre i DB en ny hendelse VIRKSOMHET_VURDERES, og oppdatere SakDto til status VURDERES
                    val iaSakshendelseVurderes = lagreHendelse(
                        hendelse = iaSakDto.`nyHendelseBasertPåSak`(
                            hendelsestype = IASakshendelseType.VIRKSOMHET_VURDERES,
                            superbruker = superbruker,
                            navEnhet = navEnhet,
                        ),
                        sistEndretAvHendelseId = null,
                        resulterendeStatus = IASak.Status.VURDERES,
                    )
                    val oppdatertIaSakDto = `oppdaterStatusPåSak`(
                        saksnummer = iaSakDto.saksnummer,
                        status = IASak.Status.VURDERES,
                        endretAv = superbruker.navIdent,
                        endretAvHendelseId = iaSakshendelseVurderes.id,
                    )
                    lagreEllerOppdaterVirksomhetTilstand(
                        orgnr = orgnummer,
                        tilstand = VirksomhetIATilstand.VirksomhetVurderes,
                    )
                    oppdatertIaSakDto
                }
            }.also { nyFlytService.varsleIASakObservers(it) }
                .right()
        } catch (e: Exception) {
            Feil("Feil ved vurdering av virksomhet: ${e.message}", HttpStatusCode.Companion.InternalServerError).left()
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
        lukket = false,
    )
