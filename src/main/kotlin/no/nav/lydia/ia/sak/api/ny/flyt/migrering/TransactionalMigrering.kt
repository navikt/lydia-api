package no.nav.lydia.ia.sak.api.ny.flyt.migrering

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import com.github.guepardoapps.kulid.ULID
import io.ktor.http.HttpStatusCode
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.NyFlytService
import no.nav.lydia.ia.sak.api.ny.flyt.Transaction
import no.nav.lydia.ia.sak.api.ny.flyt.lagreEllerOppdaterVirksomhetTilstand
import no.nav.lydia.ia.sak.api.ny.flyt.lagreHendelse
import no.nav.lydia.ia.sak.api.ny.flyt.oppdaterStatusPåSak
import no.nav.lydia.ia.sak.api.ny.flyt.opprettAutomatiskOppdatering
import no.nav.lydia.ia.sak.api.ny.flyt.tilTilstand
import no.nav.lydia.ia.sak.api.ny.flyt.tilVirksomhetIATilstand
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.GjørVirksomhetKlarTilNyVurdering
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.tilstand.VirksomhetKlarTilVurdering
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import no.nav.lydia.vedlikehold.IASakStatusOppdaterer
import java.time.LocalDate
import java.time.LocalDateTime

class TransactionalMigrering(
    val iaSakDto: IASakDto,
    val migreringsplan: Migreringsplan.Gjennomførbar,
) {
    context(nyFlytService: NyFlytService)
    fun apply(): Either<Feil, IASakDto> {
        val fiaSystemBruker = NavAnsatt.NavAnsattMedSaksbehandlerRolle.Superbruker(
            navIdent = "Fia system",
            navn = "Fia system",
            token = "",
            ansattesGrupper = emptySet(),
        )
        return try {
            Transaction(nyFlytService.dataSource).transactional { tx ->
                with(receiver = tx) {
                    val migreringshendelse = lagreHendelse(
                        hendelse = IASakshendelse(
                            id = ULID.random(),
                            opprettetTidspunkt = LocalDateTime.now(),
                            saksnummer = iaSakDto.saksnummer,
                            hendelsesType = IASakshendelseType.MIGRERING_TIL_NY_FLYT,
                            orgnummer = iaSakDto.orgnr,
                            opprettetAv = fiaSystemBruker.navn,
                            opprettetAvRolle = fiaSystemBruker.rolle,
                            navEnhet = IASakStatusOppdaterer.NAV_ENHET_FOR_MASKINELT_OPPDATERING,
                            resulterendeStatus = migreringsplan.resulterendeSakStatus,
                        ),
                        sistEndretAvHendelseId = null,
                        resulterendeStatus = migreringsplan.resulterendeSakStatus,
                    )
                    val oppdatertIaSakDto: IASakDto = `oppdaterStatusPåSak`(
                        saksnummer = iaSakDto.saksnummer,
                        status = migreringsplan.resulterendeSakStatus,
                        endretAv = "Fia system",
                        endretAvHendelseId = migreringshendelse.id,
                        oppdaterSistEndretPåSak = false,
                    )
                    val virksomhetTilstand = lagreEllerOppdaterVirksomhetTilstand(
                        orgnr = oppdatertIaSakDto.orgnr,
                        tilstand = migreringsplan.tilstand.tilVirksomhetIATilstand(),
                    )

                    if (migreringsplan.gjørVirksomhetKlarTilVurderingSenere &&
                        virksomhetTilstand != null &&
                        virksomhetTilstand.tilstand.tilTilstand().kanUtføreAutomatiskTransisjon()

                    ) {
                        opprettAutomatiskOppdatering(
                            orgnr = oppdatertIaSakDto.orgnr,
                            startTilstand = migreringsplan.tilstand.tilVirksomhetIATilstand(),
                            planlagtHendelse = `GjørVirksomhetKlarTilNyVurdering`::class.simpleName!!,
                            nyTilstand = VirksomhetKlarTilVurdering.tilVirksomhetIATilstand(),
                            planlagtDato = LocalDate.now().plusDays(90),
                        )
                    }
                    oppdatertIaSakDto
                }
            }.also { nyFlytService.varsleIASakObservers(sakDto = it) }
                .right()
        } catch (e: Exception) {
            Feil("Feil ved vurdering av virksomhet: ${e.message}", HttpStatusCode.InternalServerError).left()
        }
    }
}
