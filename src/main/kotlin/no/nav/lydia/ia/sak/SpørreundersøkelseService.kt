package no.nav.lydia.ia.sak

import arrow.core.Either
import arrow.core.flatMap
import arrow.core.getOrElse
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.toKotlinLocalDateTime
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
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseUtenInnhold
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørsmål
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
    val samarbeidService: IASamarbeidService,
    val iaSakService: IASakService,
    val planService: PlanService,
    val spørreundersøkelseObservers: List<Observer<Spørreundersøkelse>>,
    private val spørreundersøkelseOppdateringProdusent: SpørreundersøkelseOppdateringProdusent,
) {
    private val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun lagreSvar(svarliste: List<SpørreundersøkelseSvarDto>) {
        svarliste.forEach { besvarelse ->
            val spørreundersøkelse =
                spørreundersøkelseRepository.hentSpørreundersøkelse(besvarelse.spørreundersøkelseId)
                    ?: run {
                        log.error("Fant ikke kartlegging på denne iden: ${besvarelse.spørreundersøkelseId}, hopper over")
                        return@forEach
                    }
            if (spørreundersøkelse.status != Spørreundersøkelse.Status.PÅBEGYNT) {
                log.warn("Kan ikke svare på en kartlegging i status ${spørreundersøkelse.status}, hopper over")
                return@forEach
            }

            val spørsmål = spørreundersøkelse.finnSpørsmål(UUID.fromString(besvarelse.spørsmålId)) ?: run {
                log.warn("Finner ikke spørsmål '${besvarelse.spørsmålId}' svaret er knyttet til, hopper over")
                return@forEach
            }

            if (besvarelse.svarIder.size > 1 && !spørsmål.flervalg) {
                log.warn("Kan ikke lagre flere svar til et ikke flervalg spørsmål '${besvarelse.spørsmålId}', hopper over")
                return@forEach
            }

            if (!spørsmål.svaralternativerHørerTilSpørsmål(besvarelser = besvarelse)) {
                log.warn(
                    "Funnet noen ukjente svarIder ('${besvarelse.svarIder}') i svar til spørsmål '${besvarelse.spørsmålId}', hopper over",
                )
                return@forEach
            }

            spørreundersøkelseRepository.lagreSvar(besvarelse)

            val antallSvar = spørreundersøkelseRepository.hentAntallSvar(
                spørreundersøkelseId = spørreundersøkelse.id,
                spørsmålId = UUID.fromString(besvarelse.spørsmålId),
            ).tilDto()

            spørreundersøkelseOppdateringProdusent.sendPåKafka(
                SpørreundersøkelseOppdateringProdusent.AntallSvar(
                    spørreundersøkelseId = spørreundersøkelse.id.toString(),
                    antallSvar = antallSvar,
                ),
            )

            log.info("Lagret svar for kartlegging med id: '${besvarelse.spørreundersøkelseId}'")
        }
    }

    private fun Spørsmål.svaralternativerHørerTilSpørsmål(besvarelser: SpørreundersøkelseSvarDto) =
        svaralternativer.map { (svarId: UUID) -> svarId.toString() }.toList().containsAll(besvarelser.svarIder)

    fun hentSpørreundersøkelseResultat(spørreundersøkelseId: String): Either<Feil, SpørreundersøkelseResultatDto> {
        val spørreundersøkelse =
            spørreundersøkelseRepository.hentSpørreundersøkelse(spørreundersøkelseId = spørreundersøkelseId)
                ?: return IASakSpørreundersøkelseError.`ugyldig id`.left()
        if (spørreundersøkelse.status != Spørreundersøkelse.Status.AVSLUTTET) {
            return IASakSpørreundersøkelseError.`ikke avsluttet`.left()
        }

        val alleSvar =
            spørreundersøkelseRepository.hentAlleSvar(spørreundersøkelseId = spørreundersøkelse.id.toString())

        return spørreundersøkelse.tilResultat(alleSvar).tilDto().right()
    }

    fun opprettSpørreundersøkelse(
        orgnummer: String,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
        iaSak: IASak,
        prosessId: Int,
        type: Spørreundersøkelse.Type,
    ): Either<Feil, Spørreundersøkelse> =
        when (type) {
            Spørreundersøkelse.Type.Behovsvurdering -> {
                samarbeidService.hentSamarbeid(iaSak, prosessId).flatMap { samarbeid ->
                    spørreundersøkelseRepository.opprettSpørreundersøkelse(
                        orgnummer = orgnummer,
                        prosessId = samarbeid.id,
                        saksbehandler = saksbehandler,
                        spørreundersøkelseId = UUID.randomUUID(),
                        temaer = spørreundersøkelseRepository.hentAktiveTemaer(type),
                        type = type,
                    )
                }.onRight { behovsvurdering ->
                    spørreundersøkelseObservers.forEach { observer -> observer.receive(behovsvurdering) }
                }
            }

            Spørreundersøkelse.Type.Evaluering -> {
                if (iaSak.status == IASak.Status.VI_BISTÅR) {
                    planService.hentPlan(samarbeidId = prosessId).flatMap { plan ->
                        val temaerInkludertIPlan = plan.temaer.filter {
                            it.inkludert
                        }.ifEmpty {
                            return Feil(
                                feilmelding = "Kan ikke opprette en evaluering basert på en tom plan",
                                httpStatusCode = HttpStatusCode.BadRequest,
                            ).left()
                        }.map {
                            it.navn
                        }
                        val aktiveTemaer = spørreundersøkelseRepository.hentAktiveTemaer(type)
                        val temaerSomSkalEvalueres = aktiveTemaer.filter {
                            temaerInkludertIPlan.contains(it.navn)
                        }

                        val undertemaerInkludertIPlan: List<String> = plan.temaer.filter {
                            it.inkludert
                        }.flatMap { it.undertemaer }.filter { it.inkludert }.map { it.navn }

                        val temaerMedUndertemaerSomIPlan = temaerSomSkalEvalueres.map {
                            it.copy(
                                undertemaer = it.undertemaer.filter { undertemaInfo -> undertemaerInkludertIPlan.contains(undertemaInfo.navn) } +
                                    spørreundersøkelseRepository.hentObligatoriskeAktiveUndertemaer(it.id),
                            )
                        }

                        samarbeidService.hentSamarbeid(sak = iaSak, samarbeidId = prosessId).flatMap { samarbeid ->
                            spørreundersøkelseRepository.opprettSpørreundersøkelse(
                                orgnummer = orgnummer,
                                prosessId = samarbeid.id,
                                saksbehandler = saksbehandler,
                                spørreundersøkelseId = UUID.randomUUID(),
                                temaer = temaerMedUndertemaerSomIPlan,
                                type = type,
                            )
                        }.onRight { evaluering ->
                            spørreundersøkelseObservers.forEach { observer -> observer.receive(evaluering) }
                        }
                    }
                } else {
                    IASakSpørreundersøkelseError.`sak ikke i rett status`.left()
                }
            }
        }

    fun slettSpørreundersøkelse(spørreundersøkelseId: String): Either<Feil, Spørreundersøkelse> {
        val spørreundersøkelse = spørreundersøkelseRepository.hentSpørreundersøkelse(spørreundersøkelseId)
            ?: return IASakSpørreundersøkelseError.`ugyldig id`.left()

        spørreundersøkelseRepository.slettSpørreundersøkelse(spørreundersøkelseId = spørreundersøkelseId)

        val oppdatertKartlegging =
            spørreundersøkelse.copy(
                status = Spørreundersøkelse.Status.SLETTET,
                endretTidspunkt = LocalDateTime.now().toKotlinLocalDateTime(),
            )

        spørreundersøkelseObservers.forEach { it.receive(oppdatertKartlegging) }

        return oppdatertKartlegging.right()
    }

    fun hentSpørreundersøkelser(
        sak: IASak,
        prosessId: Int,
        type: Spørreundersøkelse.Type,
    ): Either<Feil, List<SpørreundersøkelseUtenInnhold>> =
        try {
            samarbeidService.hentSamarbeid(sak, prosessId).map {
                spørreundersøkelseRepository.hentSpørreundersøkelser(samarbeid = it, type = type)
            }
        } catch (e: Exception) {
            log.error("Noe gikk feil ved henting av spørreundersøkelse av type ${type.name}: ${e.message}", e)
            IASakSpørreundersøkelseError.`generell feil under uthenting`.left()
        }

    fun hentSpørreundersøkelse(spørreundersøkelseId: String): Either<Feil, Spørreundersøkelse> =
        spørreundersøkelseRepository.hentSpørreundersøkelse(spørreundersøkelseId)?.right()
            ?: IASakSpørreundersøkelseError.`ugyldig id`.left()

    fun endreSpørreundersøkelseStatus(
        spørreundersøkelseId: String,
        statusViSkalEndreTil: Spørreundersøkelse.Status,
    ): Either<Feil, Spørreundersøkelse> {
        val spørreundersøkelseUtenInnhold = spørreundersøkelseRepository.hentEnSpørreundersøkelseUtenInnhold(
            spørreundersøkelseId = spørreundersøkelseId,
        ) ?: return IASakSpørreundersøkelseError.`ugyldig id`.left()

        val oppdatertSpørreundersøkelse: Spørreundersøkelse = when (statusViSkalEndreTil) {
            Spørreundersøkelse.Status.PÅBEGYNT ->
                if (spørreundersøkelseUtenInnhold.status != Spørreundersøkelse.Status.OPPRETTET) {
                    return IASakSpørreundersøkelseError.`feil status kan ikke starte`.left()
                } else {
                    spørreundersøkelseRepository.startSpørreundersøkelse(spørreundersøkelseId = spørreundersøkelseId)
                        ?: return IASakSpørreundersøkelseError.`feil under oppdatering`.left()
                }
            Spørreundersøkelse.Status.AVSLUTTET ->
                if (spørreundersøkelseUtenInnhold.status != Spørreundersøkelse.Status.PÅBEGYNT) {
                    return IASakSpørreundersøkelseError.`ikke påbegynt`.left()
                } else {
                    spørreundersøkelseRepository.avsluttSpørreundersøkelse(spørreundersøkelseId = spørreundersøkelseId)
                        ?: return IASakSpørreundersøkelseError.`feil under oppdatering`.left()
                }
            Spørreundersøkelse.Status.OPPRETTET ->
                return IASakSpørreundersøkelseError.`ikke støttet statusendring`.left()
            Spørreundersøkelse.Status.SLETTET ->
                return IASakSpørreundersøkelseError.`ikke støttet statusendring`.left()
        }

        spørreundersøkelseObservers.forEach { it.receive(oppdatertSpørreundersøkelse) }

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

        val alleTemaErFullført = oppdatertSpørreundersøkelse.temaer.all { it.stengtForSvar }

        if (alleTemaErFullført) {
            endreSpørreundersøkelseStatus(
                spørreundersøkelseId = hendelse.spørreundersøkelseId,
                statusViSkalEndreTil = Spørreundersøkelse.Status.AVSLUTTET,
            )
            log.info("Alle temaer i spørreundersøkelse '${hendelse.spørreundersøkelseId}' er fullført, spørreundersøkelse er avsluttet")
        }

        sendResultaterForTemaPåKafka(
            spørreundersøkelseId = UUID.fromString(hendelse.spørreundersøkelseId),
            temaId = hendelse.temaId,
        )
    }

    fun oppdaterSamarbeidIdIBehovsvurdering(
        behovsvurderingId: String,
        oppdaterBehovsvurderingDto: OppdaterBehovsvurderingDto,
    ): Either<Feil, Spørreundersøkelse> {
        val behovsvurdering = spørreundersøkelseRepository.hentSpørreundersøkelse(behovsvurderingId)
            ?: return IASakSpørreundersøkelseError.`generell feil under uthenting`.left()
        if (behovsvurdering.type == Spørreundersøkelse.Type.Evaluering) {
            return IASakSpørreundersøkelseError.`ugyldig type`.left()
        }
        if (behovsvurdering.orgnummer != oppdaterBehovsvurderingDto.orgnummer) {
            return IASakSpørreundersøkelseError.`feil under oppdatering`.left()
        }
        if (behovsvurdering.saksnummer != oppdaterBehovsvurderingDto.saksnummer) {
            return IASakSpørreundersøkelseError.`feil under oppdatering`.left()
        }
        if (behovsvurdering.status != Spørreundersøkelse.Status.AVSLUTTET) {
            return IASakSpørreundersøkelseError.`ikke avsluttet, kan ikke bytte samarbeid`.left()
        }

        val oppdatertBehovsvurdering = iaSakService.hentIASak(saksnummer = behovsvurdering.saksnummer).flatMap {
            samarbeidService.hentSamarbeid(sak = it)
        }.map { prosess ->
            prosess.map { it.id }
        }.flatMap { prosesserISak ->
            if (prosesserISak.contains(oppdaterBehovsvurderingDto.prosessId)) {
                spørreundersøkelseRepository.oppdaterBehovsvurdering(behovsvurderingId, oppdaterBehovsvurderingDto)
            } else {
                IASakSpørreundersøkelseError.`feil under oppdatering`.left()
            }
        }

        oppdatertBehovsvurdering.getOrNull()?.let { oppdatertSpørreundersøkelse ->
            spørreundersøkelseObservers.forEach { it.receive(oppdatertSpørreundersøkelse) }
        }
        return oppdatertBehovsvurdering
    }

    private fun sendResultaterForTemaPåKafka(
        spørreundersøkelseId: UUID,
        temaId: Int,
    ) = spørreundersøkelseOppdateringProdusent.sendPåKafka(
        oppdatering = SpørreundersøkelseOppdateringProdusent.ResultaterForTema(
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
        val alleSvar =
            spørreundersøkelseRepository.hentAlleSvar(spørreundersøkelseId = spørreundersøkelse.id.toString())
        val spørreundersøkelseResultat = spørreundersøkelse.tilResultat(alleSvar)

        val temaResultat = spørreundersøkelseResultat.temaer.firstOrNull { it.id == temaId }
            ?: return IASakSpørreundersøkelseError.`ugyldig temaId`.left()

        return temaResultat.tilKafkaMelding().right()
    }

    private fun Spørreundersøkelse.finnSpørsmål(spørsmålId: UUID): Spørsmål? =
        temaer.flatMap { it.spørsmål }.firstOrNull {
            it.spørsmålId ==
                spørsmålId
        }
}
