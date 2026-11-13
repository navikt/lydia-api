package no.nav.lydia.prioritering.virksomhet

import arrow.core.Either
import arrow.core.raise.context.bind
import arrow.core.raise.context.either
import no.nav.lydia.dokumentpublisering.DokumentPubliseringService
import no.nav.lydia.felles.Feil
import no.nav.lydia.integrasjoner.brreg.BrregOppdateringConsumer
import no.nav.lydia.integrasjoner.brreg.BrregOppdateringConsumer.BrregVirksomhetEndringstype.Fjernet
import no.nav.lydia.integrasjoner.brreg.BrregOppdateringConsumer.BrregVirksomhetEndringstype.Sletting
import no.nav.lydia.prioritering.virksomhet.domene.Virksomhet
import no.nav.lydia.samarbeid.IASamarbeidService
import no.nav.lydia.samarbeidsperiode.BegrunnelseType
import no.nav.lydia.samarbeidsperiode.IASakService
import no.nav.lydia.samarbeidsperiode.ValgtÅrsak
import no.nav.lydia.samarbeidsperiode.ÅrsakType
import no.nav.lydia.samarbeidsplan.PlanService
import no.nav.lydia.tilgangskontroll.Standardbrukere
import no.nav.lydia.tilstandsmaskin.FiaKontekst
import no.nav.lydia.tilstandsmaskin.NyFlytService
import no.nav.lydia.tilstandsmaskin.TilstandVirksomhetOppdaterer.Companion.NAV_ENHET_FOR_MASKINELT_OPPDATERING
import no.nav.lydia.tilstandsmaskin.TilstandVirksomhetRepository
import no.nav.lydia.tilstandsmaskin.TilstandsmaskinBuilder
import no.nav.lydia.tilstandsmaskin.hendelse.Avregistrering
import no.nav.lydia.tilstandsmaskin.hendelse.AvsluttVurdering
import no.nav.lydia.tilstandsmaskin.hendelse.VirksomhetErAvregistrertIBrreg
import no.nav.lydia.tilstandsmaskin.hendelse.VurderVirksomhet
import org.slf4j.Logger
import org.slf4j.LoggerFactory

class VirksomhetService(
    val virksomhetRepository: VirksomhetRepository,
    val iaSakService: IASakService,
    val iASamarbeidService: IASamarbeidService,
    val nyFlytService: NyFlytService,
    val dokumentPubliseringService: DokumentPubliseringService,
    val planService: PlanService,
    val tilstandVirksomhetRepository: TilstandVirksomhetRepository,
) {
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)

    fun hentVirksomhet(orgnr: String): Virksomhet? = virksomhetRepository.hentVirksomhet(orgnr)

    fun finnVirksomheter(søkestreng: String): List<VirksomhetSøkeresultat> {
        if (søkestreng.isBlank() || søkestreng.length < 3) {
            return emptyList()
        }
        return virksomhetRepository.finnVirksomheter(søkestreng)
    }

    fun insertVirksomhet(virksomhetLagringDao: VirksomhetLagringDao) = virksomhetRepository.insertVirksomhet(virksomhetLagringDao)

    fun insertNæringsundergrupper(virksomhetLagringDao: VirksomhetLagringDao) = virksomhetRepository.insertNæringsundergrupper(virksomhetLagringDao)

    fun rettOppIIkkeAktuellStatus(ikkeAktuellVirksomhet: IkkeAktuellVirksomhet) {
        either {
            val hentTilstandForVirksomhet = TilstandsmaskinBuilder.medKontekst(
                fiaKontekst = FiaKontekst(
                    iaSakService = iaSakService,
                    iASamarbeidService = iASamarbeidService,
                    nyFlytService = nyFlytService,
                    dokumentPubliseringService = dokumentPubliseringService,
                    planService = planService,
                    tilstandVirksomhetRepository = tilstandVirksomhetRepository,
                    saksnummer = nyFlytService.hentSisteIASakDto(ikkeAktuellVirksomhet.orgnr)?.saksnummer,
                ),
            )

            val avsluttVurderingHendelse = AvsluttVurdering(
                orgnr = ikkeAktuellVirksomhet.orgnr,
                årsak = ValgtÅrsak(
                    type = ÅrsakType.VIRKSOMHETEN_VURDERES_PÅ_ET_SENERE_TIDSPUNKT,
                    beskrivelse = "Vurder virksomheten senere",
                    begrunnelser = listOf(BegrunnelseType.VIRKSOMHETEN_ØNSKER_Å_BLI_KONTAKTET_SENERE),
                ),
                saksbehandler = Standardbrukere.fiaSystemSuperbruker,
                navEnhet = NAV_ENHET_FOR_MASKINELT_OPPDATERING,
            )

            val avsluttTilstand = hentTilstandForVirksomhet.build(ikkeAktuellVirksomhet.orgnr)
            avsluttTilstand.prosesserHendelse(avsluttVurderingHendelse).bind()

            val vurderHendelse = VurderVirksomhet(
                orgnr = ikkeAktuellVirksomhet.orgnr,
                valgtÅrsak = ValgtÅrsak(
                    type = ÅrsakType.BAKGRUNN_FOR_VURDERING_AV_VIRKSOMHET,
                    beskrivelse = "Bakgrunn for vurdering av virksomhet",
                    begrunnelser = listOf(BegrunnelseType.AUTOMATISK_VURDERT_PÅ_NYTT),
                ),
                superbruker = Standardbrukere.fiaSystemSuperbruker,
                navEnhet = NAV_ENHET_FOR_MASKINELT_OPPDATERING,
            )
            val vurderTilstand = hentTilstandForVirksomhet.build(ikkeAktuellVirksomhet.orgnr)
            vurderTilstand.prosesserHendelse(vurderHendelse).bind()
        }.onLeft {
            logger.error("Prøver å rette opp i IKKE_AKTUELL status, men feiler med '${it.feilmelding}. Saksnummer: '${ikkeAktuellVirksomhet.saksnummer}'")
        }
    }

    fun finnVirksomheterMedIkkeAktuellStatus() = virksomhetRepository.finnVirksomheterMedIkkeAktuellStatus()

    fun oppdaterStatusTilVirksomhetTilSlettetEllerFjernet(oppdateringVirksomhet: BrregOppdateringConsumer.OppdateringVirksomhet): Either<Feil, Unit> =
        either {
            when (val avregistrering = hentAvregistreringstype(oppdateringVirksomhet.endringstype)) {
                Avregistrering.FJERNET, Avregistrering.SLETTET -> {
                    val tilstandsmaskin = TilstandsmaskinBuilder.medKontekst(
                        fiaKontekst = FiaKontekst(
                            iASamarbeidService = iASamarbeidService,
                            dokumentPubliseringService = dokumentPubliseringService,
                            planService = planService,
                            nyFlytService = nyFlytService,
                            tilstandVirksomhetRepository = tilstandVirksomhetRepository,
                            iaSakService = iaSakService,
                            saksnummer = iaSakService.hentAktivSak(oppdateringVirksomhet.orgnummer)?.saksnummer,
                        ),
                    ).build(orgnr = oppdateringVirksomhet.orgnummer)

                    val hendelse = VirksomhetErAvregistrertIBrreg(
                        orgnr = oppdateringVirksomhet.orgnummer,
                        navEnhet = NAV_ENHET_FOR_MASKINELT_OPPDATERING,
                        oppdateringsid = oppdateringVirksomhet.oppdateringsid,
                        avregistrering = avregistrering,
                    )
                    tilstandsmaskin.prosesserHendelse(hendelse).bind()
                }

                null -> {}
            }
        }

    private fun hentAvregistreringstype(oppdatering: BrregOppdateringConsumer.BrregVirksomhetEndringstype) =
        when (oppdatering) {
            Sletting -> Avregistrering.SLETTET
            Fjernet -> Avregistrering.FJERNET
            else -> null
        }
}
