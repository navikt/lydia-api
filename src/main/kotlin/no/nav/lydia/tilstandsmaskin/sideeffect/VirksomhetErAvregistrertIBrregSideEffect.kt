package no.nav.lydia.tilstandsmaskin.sideeffect

import arrow.core.Either
import com.github.guepardoapps.kulid.ULID
import io.ktor.http.HttpStatusCode
import no.nav.lydia.felles.Feil
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.samarbeid.tilDto
import no.nav.lydia.samarbeidsperiode.IASak
import no.nav.lydia.samarbeidsperiode.IASakshendelse
import no.nav.lydia.samarbeidsperiode.IASakshendelseType
import no.nav.lydia.tilgangskontroll.Standardbrukere
import no.nav.lydia.tilstandsmaskin.NyFlytService
import no.nav.lydia.tilstandsmaskin.Transaction
import no.nav.lydia.tilstandsmaskin.VirksomhetIATilstand
import no.nav.lydia.tilstandsmaskin.hendelse.Avregistrering
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.IASakTransactional.hentAlleUslettedeIAsaker
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.IASakTransactional.slettSlettedeSaker
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.KartleggingTransactional.Companion.slettKartlegginger
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidTransactional.Companion.avbrytSamarbeid
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidTransactional.Companion.hentAktiveSamarbeid
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidTransactional.Companion.slettAlleSamarbeidForOrg
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidsperiodeTransactional.Companion.hentSisteIASakDto
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidsperiodeTransactional.Companion.lagreHendelse
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidsperiodeTransactional.Companion.oppdaterStatusPåSak
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.SamarbeidsplanTransactional.Companion.slettPlaner
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.TilstandVirksomhetTransactional.Companion.lagreEllerOppdaterVirksomhetTilstand
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.VirksomhetTransactional
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.VirksomhetTransactional.AlleSakerErSlettetPåVirksomhet.Companion.alleSakerErSlettetEllerKast
import no.nav.lydia.tilstandsmaskin.sideeffect.transactional.VirksomhetTransactional.slettVirksomhet
import java.time.LocalDateTime

class VirksomhetErAvregistrertIBrregSideEffect(
    val orgnr: String,
    val navEnhet: NavEnhet,
    val oppdateringsid: Long,
    val avregistrering: Avregistrering,
) : SideEffect<Unit>() {
    context(nyFlytService: NyFlytService)
    override fun apply(): Either<Feil, Unit> =
        Either.catch {
            Transaction(nyFlytService.dataSource).transactional {
                val alleSaker = hentAlleUslettedeIAsaker(orgnr)

                if (alleSaker.isEmpty()) {
                    alleSakerErSlettetEllerKast(orgnr) {
                        "Kan ikke slette virksomhet '$orgnr'; finnes saker som ikke har status SLETTET."
                    }.run {
                        slettKartlegginger(orgnr)
                        slettPlaner(orgnr)
                        slettAlleSamarbeidForOrg(orgnr)
                        slettSlettedeSaker(orgnr)
                        slettVirksomhet(orgnr)
                    }
                    emptyList<Int>() to null
                } else {
                    val aktiveSamarbeid = hentAktiveSamarbeid(orgnr)
                    aktiveSamarbeid.forEach { samarbeid -> avbrytSamarbeid(samarbeid.tilDto()) }

                    val sakDto = hentSisteIASakDto(orgnummer = orgnr)?.takeUnless { it.status.regnesSomAvsluttet() }
                    sakDto?.run {
                        val hendelse = IASakshendelse(
                            id = ULID.random(),
                            opprettetTidspunkt = LocalDateTime.now(),
                            saksnummer = saksnummer,
                            hendelsesType = IASakshendelseType.AVBRYT_PROSESS,
                            orgnummer = orgnr,
                            opprettetAv = Standardbrukere.fiaSystemSuperbruker.navIdent,
                            opprettetAvRolle = Standardbrukere.fiaSystemSuperbruker.rolle,
                            navEnhet = navEnhet,
                            resulterendeStatus = IASak.Status.AVSLUTTET,
                        )

                        lagreHendelse(hendelse, null, IASak.Status.AVSLUTTET)

                        oppdaterStatusPåSak(
                            saksnummer = saksnummer,
                            status = IASak.Status.AVSLUTTET,
                            endretAv = Standardbrukere.fiaSystemSuperbruker.navIdent,
                            endretAvHendelseId = hendelse.id,
                        )
                    }

                    VirksomhetTransactional.oppdaterStatus(orgnr, avregistrering.virksomhetStatus, oppdateringsid)
                    lagreEllerOppdaterVirksomhetTilstand(orgnr, VirksomhetIATilstand.VirksomhetErAvregistrertIBrreg)

                    aktiveSamarbeid.map { it.id } to sakDto?.saksnummer
                }
            }.let { (samarbeidsIder: List<Int>, saksnummer: String?) ->
                samarbeidsIder.forEach { id ->
                    nyFlytService.iaSamarbeidRepository.hentSamarbeid(id)?.let { samarbeid ->
                        nyFlytService.iaSamarbeidObservers.forEach {
                            it.receive(samarbeid)
                        }
                    }
                }
                saksnummer?.let { sak ->
                    nyFlytService.iaSakRepository.hentIASakDto(sak)?.let {
                        nyFlytService.varsleIASakObservers(it)
                    }
                }
                return@let
            }
        }.mapLeft { Feil("Sletting av virksomhet '$orgnr' feilet: ${it.message}", HttpStatusCode.InternalServerError) }
}
