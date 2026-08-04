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
import no.nav.lydia.samarbeidsperiode.IASakService
import no.nav.lydia.samarbeidsplan.PlanService
import no.nav.lydia.tilstandsmaskin.FiaKontekst
import no.nav.lydia.tilstandsmaskin.NyFlytService
import no.nav.lydia.tilstandsmaskin.TilstandVirksomhetOppdaterer.Companion.NAV_ENHET_FOR_MASKINELT_OPPDATERING
import no.nav.lydia.tilstandsmaskin.TilstandVirksomhetRepository
import no.nav.lydia.tilstandsmaskin.TilstandsmaskinBuilder
import no.nav.lydia.tilstandsmaskin.hendelse.Avregistrering
import no.nav.lydia.tilstandsmaskin.hendelse.VirksomhetErAvregistrertIBrreg
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

    fun finnSlettedeVirksomheterMedAktivSak() = virksomhetRepository.finnSlettedeVirksomheterMedAktivSak()

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

    fun tempBehandleSlettedeVirksomheter(): Either<Feil, String> =
        either {
            val virksomheter = virksomhetRepository.tempFinnSlettedeVirksomheterMedFeilStatus()
            virksomheter.forEach { oppdatering ->
                oppdaterStatusTilVirksomhetTilSlettetEllerFjernet(oppdatering).bind()
            }
            "Vellykket oppdatering av ${virksomheter.size} slettede/fjernede virksomheter."
        }

    private fun hentAvregistreringstype(oppdatering: BrregOppdateringConsumer.BrregVirksomhetEndringstype) =
        when (oppdatering) {
            Sletting -> Avregistrering.SLETTET
            Fjernet -> Avregistrering.FJERNET
            else -> null
        }
}
