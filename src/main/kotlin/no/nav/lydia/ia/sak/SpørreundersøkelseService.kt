package no.nav.lydia.ia.sak

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.getOrElse
import arrow.core.left
import arrow.core.right
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus.AVSLUTTET
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus.OPPRETTET
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus.PÅBEGYNT
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus.SLETTET
import no.nav.lydia.Observer
import no.nav.lydia.ia.eksport.SpørreundersøkelseOppdateringProdusent
import no.nav.lydia.ia.eksport.SpørreundersøkelseOppdateringProdusent.Companion.tilDto
import no.nav.lydia.ia.eksport.SpørreundersøkelseOppdateringProdusent.SerializableTemaResultat
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.spørreundersøkelse.IASakSpørreundersøkelseError
import no.nav.lydia.ia.sak.api.spørreundersøkelse.OppdaterBehovsvurderingDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseResultatDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseSvarDto
import no.nav.lydia.ia.sak.db.SpørreundersøkelseRepository
import no.nav.lydia.ia.sak.domene.IAProsessStatus.VI_BISTÅR
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseUtenInnhold
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørsmål
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Svaralternativ
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.tilDto
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.tilKafkaMelding
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.tilResultat
import no.nav.lydia.integrasjoner.kartlegging.StengTema
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.time.LocalDateTime
import java.util.UUID

const val MINIMUM_ANTALL_DELTAKERE = 3

class SpørreundersøkelseService(
    val spørreundersøkelseRepository: SpørreundersøkelseRepository,
    val iaProsessService: IAProsessService,
    val iaSakService: IASakService,
    val planService: PlanService,
    val spørreundersøkelseObservers: List<Observer<Spørreundersøkelse>>,
    private val spørreundersøkelseOppdateringProdusent: SpørreundersøkelseOppdateringProdusent,
) {
    private val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun lagreSvar(svarliste: List<SpørreundersøkelseSvarDto>) {
        svarliste.forEach { svar ->
            val spørreundersøkelse = spørreundersøkelseRepository.hentSpørreundersøkelse(svar.spørreundersøkelseId)

            if (spørreundersøkelse == null) {
                log.error("Fant ikke kartlegging på denne iden: ${svar.spørreundersøkelseId}, hopper over")
                return@forEach
            }
            if (spørreundersøkelse.status != PÅBEGYNT) {
                log.warn("Kan ikke svare på en kartlegging i status ${spørreundersøkelse.status}, hopper over")
                return@forEach
            }

            val spørsmål = spørreundersøkelse.finnSpørsmål(UUID.fromString(svar.spørsmålId))
            if (spørsmål == null) {
                log.warn("Finner ikke spørsmål '${svar.spørsmålId}' svaret er knyttet til, hopper over")
                return@forEach
            }
            if (svar.svarIder.size > 1 && !spørsmål.flervalg) {
                log.warn("Kan ikke lagre flere svar til et ikke flervalg spørsmål '${svar.spørsmålId}', hopper over")
                return@forEach
            }
            if (!spørsmål.svaralternativer
                    .map<Svaralternativ, String> { it.svarId.toString() }
                    .toList()
                    .containsAll(svar.svarIder)
            ) {
                log.warn("Funnet noen ukjente svarIder ('${svar.svarIder}') i svar til spørsmål '${svar.spørsmålId}', hopper over")
                return@forEach
            }

            spørreundersøkelseRepository.lagreSvar(svar)
            val antallSvarPåSpørsmål = spørreundersøkelseRepository.hentAntallSvar(
                spørreundersøkelseId = spørreundersøkelse.id,
                spørsmålId = UUID.fromString(svar.spørsmålId),
            )
            spørreundersøkelseOppdateringProdusent.sendPåKafka(
                SpørreundersøkelseOppdateringProdusent.AntallSvar(
                    spørreundersøkelseId = spørreundersøkelse.id.toString(),
                    antallSvar = antallSvarPåSpørsmål.tilDto(),
                ),
            )

            log.info("Lagret svar for kartlegging med id: '${svar.spørreundersøkelseId}'")
        }
    }

    fun hentSpørreundersøkelseResultat(spørreundersøkelseId: String): Either<Feil, SpørreundersøkelseResultatDto> {
        val spørreundersøkelse = spørreundersøkelseRepository.hentSpørreundersøkelse(spørreundersøkelseId = spørreundersøkelseId)
            ?: return IASakSpørreundersøkelseError.`ugyldig id`.left()
        if (spørreundersøkelse.status != AVSLUTTET) {
            return IASakSpørreundersøkelseError.`ikke avsluttet`.left()
        }

        val alleSvar = spørreundersøkelseRepository.hentAlleSvar(spørreundersøkelseId = spørreundersøkelse.id.toString())

        return spørreundersøkelse.tilResultat(alleSvar).tilDto().right()
    }

    fun opprettSpørreundersøkelse(
        orgnummer: String,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
        iaSak: IASak,
        prosessId: Int,
        type: String,
    ): Either<Feil, Spørreundersøkelse> =
        when (type) {
            "Behovsvurdering" -> {
                iaProsessService.hentIAProsess(iaSak, prosessId).flatMap { samarbeid ->
                    spørreundersøkelseRepository.opprettSpørreundersøkelse(
                        orgnummer = orgnummer,
                        prosessId = samarbeid.id,
                        saksbehandler = saksbehandler,
                        spørreundersøkelseId = UUID.randomUUID(),
                        vertId = UUID.randomUUID(),
                        temaer = spørreundersøkelseRepository.hentAktiveTemaer(type),
                        type = type,
                    )
                }.onRight { behovsvurdering ->
                    spørreundersøkelseObservers.forEach { it.receive(behovsvurdering) }
                }
            }
            "Evaluering" -> {
                if (iaSak.status == VI_BISTÅR) {
                    planService.hentPlan(
                        iaSak = iaSak,
                        prosessId = prosessId,
                    ).flatMap { plan ->
                        iaProsessService.hentIAProsess(sak = iaSak, prosessId = prosessId).flatMap { samarbeid ->
                            spørreundersøkelseRepository.opprettSpørreundersøkelse(
                                orgnummer = orgnummer,
                                prosessId = samarbeid.id,
                                saksbehandler = saksbehandler,
                                spørreundersøkelseId = UUID.randomUUID(),
                                vertId = UUID.randomUUID(),
                                temaer = spørreundersøkelseRepository.hentAktiveTemaer(type),
                                type = type,
                            )
                        }.onRight { behovsvurdering ->
                            spørreundersøkelseObservers.forEach { it.receive(behovsvurdering) }
                        }
                    }
                } else {
                    IASakSpørreundersøkelseError.`sak ikke i rett status`.left()
                }
            } else -> {
                IASakSpørreundersøkelseError.`ugyldig type`.left()
            }
        }

    fun slettSpørreundersøkelse(spørreundersøkelseId: String): Either<Feil, Spørreundersøkelse> {
        val spørreundersøkelse = spørreundersøkelseRepository.hentSpørreundersøkelse(spørreundersøkelseId)
            ?: return IASakSpørreundersøkelseError.`ugyldig id`.left()

        spørreundersøkelseRepository.slettSpørreundersøkelse(spørreundersøkelseId = spørreundersøkelseId)

        val oppdatertKartlegging =
            spørreundersøkelse.copy(status = SLETTET, endretTidspunkt = LocalDateTime.now())

        spørreundersøkelseObservers.forEach { it.receive(oppdatertKartlegging) }

        return oppdatertKartlegging.right()
    }

    fun hentSpørreundersøkelser(
        sak: IASak,
        prosessId: Int,
        type: String,
    ): Either<Feil, List<SpørreundersøkelseUtenInnhold>> =
        try {
            iaProsessService.hentIAProsess(sak, prosessId).map {
                spørreundersøkelseRepository.hentSpørreundersøkelser(prosess = it, type = type)
            }
        } catch (e: Exception) {
            log.error("Noe gikk feil ved henting av spørreundersøkelse av type $type: ${e.message}", e)
            IASakSpørreundersøkelseError.`generell feil under uthenting`.left()
        }

    fun endreSpørreundersøkelseStatus(
        spørreundersøkelseId: String,
        statusViSkalEndreTil: SpørreundersøkelseStatus,
    ): Either<Feil, Spørreundersøkelse> {
        val spørreundersøkelseUtenInnhold = spørreundersøkelseRepository.hentEnSpørreundersøkelseUtenInnhold(
            spørreundersøkelseId = spørreundersøkelseId,
        ) ?: return IASakSpørreundersøkelseError.`ugyldig id`.left()

        when (statusViSkalEndreTil) {
            PÅBEGYNT -> if (spørreundersøkelseUtenInnhold.status != OPPRETTET) {
                return IASakSpørreundersøkelseError.`feil status kan ikke starte`.left()
            }
            AVSLUTTET -> if (spørreundersøkelseUtenInnhold.status != PÅBEGYNT) {
                return IASakSpørreundersøkelseError.`ikke påbegynt`.left()
            }
            OPPRETTET -> return IASakSpørreundersøkelseError.`ikke støttet statusendring`.left()
            SLETTET -> return IASakSpørreundersøkelseError.`ikke støttet statusendring`.left()
        }

        val oppdatertSpørreundersøkelse = spørreundersøkelseRepository.endreSpørreundersøkelseStatus(
            spørreundersøkelseId = spørreundersøkelseId,
            status = statusViSkalEndreTil,
        ) ?: return IASakSpørreundersøkelseError.`feil under oppdatering`.left()

        spørreundersøkelseObservers.forEach {
            it.receive(oppdatertSpørreundersøkelse)
        }

        return oppdatertSpørreundersøkelse.right()
    }

    fun stengTema(hendelse: StengTema) {
        log.info("Mottok stenging av tema: ${hendelse.temaId} i spørreundersøkelse ${hendelse.spørreundersøkelseId}")

        val spørreundersøkelse =
            spørreundersøkelseRepository.hentSpørreundersøkelse(spørreundersøkelseId = hendelse.spørreundersøkelseId)

        if (spørreundersøkelse == null) {
            log.warn("Kunne ikke hente behovsvurdering med id ${hendelse.spørreundersøkelseId}")
            return
        }

        spørreundersøkelseRepository.stengTema(
            spørreundersøkelseId = hendelse.spørreundersøkelseId,
            temaId = hendelse.temaId,
        )

        val oppdatertSpørreundersøkelse =
            spørreundersøkelseRepository.hentSpørreundersøkelse(spørreundersøkelseId = hendelse.spørreundersøkelseId)

        if (oppdatertSpørreundersøkelse == null) {
            log.warn("Kunne ikke hente oppdatert behovsvurdering med id ${hendelse.spørreundersøkelseId}")
            return
        }

        val alleTemaErFullført = oppdatertSpørreundersøkelse.tema.all { it.stengtForSvar }

        if (alleTemaErFullført) {
            endreSpørreundersøkelseStatus(
                spørreundersøkelseId = hendelse.spørreundersøkelseId,
                statusViSkalEndreTil = AVSLUTTET,
            )
            log.info("Alle temaer i spørreundersøkelse '${hendelse.spørreundersøkelseId}' er fullført, spørreundersøkelse er avsluttet")
        }

        sendResultaterForTemaPåKafka(
            spørreundersøkelseId = UUID.fromString(hendelse.spørreundersøkelseId),
            temaId = hendelse.temaId,
        )
    }

    fun oppdaterBehovsvurdering(
        behovsvurderingId: String,
        oppdaterBehovsvurderingDto: OppdaterBehovsvurderingDto,
    ): Either<Feil, Spørreundersøkelse> {
        val behovsvurdering = spørreundersøkelseRepository.hentSpørreundersøkelse(behovsvurderingId)
            ?: return IASakSpørreundersøkelseError.`generell feil under uthenting`.left()
        if (behovsvurdering.orgnummer != oppdaterBehovsvurderingDto.orgnummer) {
            return IASakSpørreundersøkelseError.`feil under oppdatering`.left()
        }
        if (behovsvurdering.saksnummer != oppdaterBehovsvurderingDto.saksnummer) {
            return IASakSpørreundersøkelseError.`feil under oppdatering`.left()
        }

        return iaSakService.hentIASak(behovsvurdering.saksnummer).flatMap {
            iaProsessService.hentIAProsesser(it)
        }.map { prosess ->
            prosess.map { it.id }
        }.flatMap { prosesserISak ->
            if (prosesserISak.contains(oppdaterBehovsvurderingDto.prosessId)) {
                spørreundersøkelseRepository.oppdaterBehovsvurdering(behovsvurderingId, oppdaterBehovsvurderingDto)
            } else {
                IASakSpørreundersøkelseError.`feil under oppdatering`.left()
            }
        }
    }

    private fun sendResultaterForTemaPåKafka(
        spørreundersøkelseId: UUID,
        temaId: Int,
    ) = spørreundersøkelseOppdateringProdusent.sendPåKafka(
        SpørreundersøkelseOppdateringProdusent.ResultaterForTema(
            spørreundersøkelseId = spørreundersøkelseId.toString(),
            resultaterForTema = hentSvarForTema(
                spørreundersøkelseId = spørreundersøkelseId,
                temaId = temaId,
            ).getOrElse {
                log.error("Kunne ikke hente resultat for tema")
                return
            },
        ),
    )

    private fun hentSvarForTema(
        spørreundersøkelseId: UUID,
        temaId: Int,
    ): Either<Feil, SerializableTemaResultat> {
        val spørreundersøkelse =
            spørreundersøkelseRepository.hentSpørreundersøkelse(spørreundersøkelseId = spørreundersøkelseId.toString())
                ?: return IASakSpørreundersøkelseError.`ugyldig id`.left()
        val alleSvar = spørreundersøkelseRepository.hentAlleSvar(spørreundersøkelseId = spørreundersøkelse.id.toString())
        val spørreundersøkelseResultat = spørreundersøkelse.tilResultat(alleSvar)

        val temaResultat = spørreundersøkelseResultat.tema.firstOrNull { it.id == temaId }
            ?: return IASakSpørreundersøkelseError.`ugyldig temaId`.left()

        return temaResultat.tilKafkaMelding().right()
    }

    private fun Spørreundersøkelse.finnSpørsmål(spørsmålId: UUID): Spørsmål? =
        tema.flatMap { it.spørsmål }.firstOrNull { it.spørsmålId == spørsmålId }
}
