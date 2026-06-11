package no.nav.lydia.tilstandsmaskin.sideeffect

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import com.github.guepardoapps.kulid.ULID
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.toJavaLocalDate
import no.nav.lydia.felles.Feil
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.samarbeidsperiode.IASak
import no.nav.lydia.samarbeidsperiode.IASakDto
import no.nav.lydia.samarbeidsperiode.IASakshendelse
import no.nav.lydia.samarbeidsperiode.IASakshendelseType
import no.nav.lydia.samarbeidsperiode.ValgtÅrsak
import no.nav.lydia.samarbeidsperiode.ÅrsakType
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.tilstandsmaskin.NyFlytService
import no.nav.lydia.tilstandsmaskin.Transaction
import no.nav.lydia.tilstandsmaskin.VirksomhetIATilstand
import no.nav.lydia.tilstandsmaskin.hendelse.GjørVirksomhetKlarTilNyVurdering
import no.nav.lydia.tilstandsmaskin.hendelse.VurderVirksomhet
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidsperiodeTransactional.Companion.hentSisteIASakDto
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidsperiodeTransactional.Companion.lagreHendelse
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidsperiodeTransactional.Companion.lagreÅrsakForHendelse
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidsperiodeTransactional.Companion.oppdaterStatusPåSak
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.TilstandVirksomhetTransactional.Companion.lagreEllerOppdaterVirksomhetTilstand
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.TilstandVirksomhetTransactional.Companion.opprettAutomatiskOppdatering
import java.time.LocalDate
import java.time.LocalDateTime

class AvsluttVurderingSideEffect(
    val orgnummer: String,
    val årsak: ValgtÅrsak,
    val navAnsatt: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    val navEnhet: NavEnhet,
) : SideEffect<IASakDto>() {
    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, IASakDto> =
        try {
            Transaction(nyFlytService.dataSource).transactional { tx ->
                with(tx) {
                    val iaSakDto = hentSisteIASakDto(orgnummer = orgnummer) ?: throw IllegalStateException("Fant ingen sak for virksomhet $orgnummer")

                    // #1 legg til en ny hendelse + årsak + oppdater sak status VURDERT
                    val iaSakshendelseVurderes = lagreHendelse(
                        hendelse = IASakshendelse(
                            id = ULID.random(),
                            opprettetTidspunkt = LocalDateTime.now(),
                            saksnummer = iaSakDto.saksnummer,
                            hendelsesType = IASakshendelseType.VURDERING_FULLFØRT_UTEN_SAMARBEID,
                            orgnummer = orgnummer,
                            opprettetAv = navAnsatt.navIdent,
                            opprettetAvRolle = navAnsatt.rolle,
                            navEnhet = navEnhet,
                            resulterendeStatus = null,
                        ),
                        sistEndretAvHendelseId = null,
                        resulterendeStatus = IASak.Status.VURDERT,
                    )
                    lagreÅrsakForHendelse(
                        hendelseId = iaSakshendelseVurderes.id,
                        valgtÅrsak = årsak,
                    )
                    val oppdatertIaSakDto = oppdaterStatusPåSak(
                        saksnummer = iaSakDto.saksnummer,
                        status = IASak.Status.VURDERT,
                        endretAv = navAnsatt.navIdent,
                        endretAvHendelseId = iaSakshendelseVurderes.id,
                    )

                    // #2 oppdater tilstand til VirksomhetVurdert
                    lagreEllerOppdaterVirksomhetTilstand(
                        orgnr = orgnummer,
                        tilstand = VirksomhetIATilstand.VirksomhetErVurdert,
                    )

                    // #3 opprett automatisk oppdatering til VirksomhetVurderes eller VirksomhetKlarTilVurdering
                    val nyTilstand = when (årsak.type) {
                        ÅrsakType.VIRKSOMHETEN_VURDERES_PÅ_ET_SENERE_TIDSPUNKT,
                        -> VirksomhetIATilstand.VirksomhetVurderes

                        else -> VirksomhetIATilstand.VirksomhetKlarTilVurdering
                    }

                    val planlagtHendelse = when (årsak.type) {
                        ÅrsakType.VIRKSOMHETEN_VURDERES_PÅ_ET_SENERE_TIDSPUNKT,
                        -> VurderVirksomhet::class.simpleName!!

                        else -> GjørVirksomhetKlarTilNyVurdering::class.simpleName!!
                    }

                    opprettAutomatiskOppdatering(
                        orgnr = iaSakDto.orgnr,
                        startTilstand = VirksomhetIATilstand.VirksomhetErVurdert,
                        planlagtHendelse = planlagtHendelse,
                        nyTilstand = nyTilstand,
                        planlagtDato = if (årsak.dato == null) {
                            LocalDate.now().plusDays(90)
                        } else {
                            årsak.dato.toJavaLocalDate()
                        },
                    )
                    oppdatertIaSakDto
                }
            }.also { nyFlytService.varsleIASakObservers(it) }.right()
        } catch (e: Exception) {
            Feil(
                feilmelding = "Feil ved avslutning av vurdering for virksomhet med orgnr: '$orgnummer' med melding: '${e.message}'",
                httpStatusCode = HttpStatusCode.InternalServerError,
            ).left()
        }
}
