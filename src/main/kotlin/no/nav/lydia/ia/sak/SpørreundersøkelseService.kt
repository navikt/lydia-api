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
import no.nav.lydia.ia.eksport.SpørreundersøkelseOppdateringProdusent.TemaResultatKafkaDto
import no.nav.lydia.ia.eksport.tilTemaResultatKafkaDto
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringDto
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringRepository
import no.nav.lydia.ia.sak.api.extensions.tilUUID
import no.nav.lydia.ia.sak.api.spørreundersøkelse.IASakSpørreundersøkelseError
import no.nav.lydia.ia.sak.api.spørreundersøkelse.OppdaterBehovsvurderingDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseSvarDto
import no.nav.lydia.ia.sak.db.SpørreundersøkelseRepository
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse.Type.*
import no.nav.lydia.integrasjoner.kartlegging.StengTema
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.time.LocalDateTime
import java.util.UUID

class SpørreundersøkelseService(
    val spørreundersøkelseRepository: SpørreundersøkelseRepository,
    val samarbeidService: IASamarbeidService,
    val iaSakService: IASakService,
    val planService: PlanService,
    val spørreundersøkelseObservers: List<Observer<Spørreundersøkelse>>,
    val dokumentPubliseringRepository: DokumentPubliseringRepository,
    private val spørreundersøkelseOppdateringProdusent: SpørreundersøkelseOppdateringProdusent,
) {
    private val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun lagreSvar(svarliste: List<SpørreundersøkelseSvarDto>) {
        svarliste.forEach { besvarelse ->
            val spørreundersøkelse = hentSpørreundersøkelse(besvarelse.spørreundersøkelseId.tilUUID(hvaErJeg = "spørreundersøkelseId")).getOrElse {
                log.error("Fant ikke kartlegging på denne iden: ${besvarelse.spørreundersøkelseId}, hopper over")
                return@forEach
            }

            if (spørreundersøkelse.status != Spørreundersøkelse.Status.PÅBEGYNT) {
                log.warn("Kan ikke svare på en kartlegging i status ${spørreundersøkelse.status}, hopper over")
                return@forEach
            }

            val spørsmål = spørreundersøkelse.finnSpørsmål(besvarelse.spørsmålId.tilUUID(hvaErJeg = "spørsmålId")) ?: run {
                log.warn("Finner ikke spørsmål '${besvarelse.spørsmålId}' svaret er knyttet til, hopper over")
                return@forEach
            }

            if (besvarelse.svarIder.size > 1 && !spørsmål.flervalg) {
                log.warn("Kan ikke lagre flere svar til et ikke flervalg spørsmål '${besvarelse.spørsmålId}', hopper over")
                return@forEach
            }

            if (!spørsmål.svaralternativerHørerTilSpørsmål(besvarelse.svarIder.map { it.tilUUID(hvaErJeg = "svarId") })) {
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

    fun hentFullførtSpørreundersøkelse(spørreundersøkelseId: UUID): Either<Feil, Spørreundersøkelse> {
        val spørreundersøkelse = hentSpørreundersøkelse(spørreundersøkelseId = spørreundersøkelseId).getOrElse { return it.left() }
        if (spørreundersøkelse.status != Spørreundersøkelse.Status.AVSLUTTET) {
            return IASakSpørreundersøkelseError.`ikke avsluttet`.left()
        }
        return spørreundersøkelse.right()
    }

    fun opprettSpørreundersøkelse(
        orgnummer: String,
        iaSak: IASak,
        prosessId: Int,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
        type: Spørreundersøkelse.Type,
    ): Either<Feil, Spørreundersøkelse> =
        samarbeidService.hentSamarbeid(iaSak, prosessId).flatMap { samarbeid ->
            opprettSpørreundersøkelse(
                orgnummer = orgnummer,
                saksnummer = iaSak.saksnummer,
                samarbeidId = samarbeid.id,
                type = type,
                saksbehandler = saksbehandler,
            )
        }

    fun opprettSpørreundersøkelse(
        orgnummer: String,
        saksnummer: String,
        samarbeidId: Int,
        type: Spørreundersøkelse.Type,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
    ): Either<Feil, Spørreundersøkelse> =
        when (type) {
            Behovsvurdering -> {
                samarbeidService.hentSamarbeid(saksnummer, samarbeidId).flatMap { samarbeid ->
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

            Evaluering -> {
                if (iaSakService.hentStatusForSaksnummer(saksnummer) == IASak.Status.VI_BISTÅR) {
                    planService.hentPlan(samarbeidId = samarbeidId).flatMap { plan ->
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

                        samarbeidService.hentSamarbeid(saksnummer = saksnummer, samarbeidId = samarbeidId).flatMap { samarbeid ->
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

    fun slettSpørreundersøkelse(spørreundersøkelseId: UUID): Either<Feil, Spørreundersøkelse> {
        val spørreundersøkelse = hentSpørreundersøkelse(spørreundersøkelseId).getOrElse { return it.left() }

        if (spørreundersøkelse.status == Spørreundersøkelse.Status.SLETTET) {
            return IASakSpørreundersøkelseError.`allerede slettet`.left()
        }

        if (erPublisertEllerUnderPublisering(spørreundersøkelse)) {
            return IASakSpørreundersøkelseError.`publisert, kan ikke slettes`.left()
        }

        if (spørreundersøkelse.status == Spørreundersøkelse.Status.AVSLUTTET && spørreundersøkelse.harMinstEttResultat()) {
            return IASakSpørreundersøkelseError.`kan ikke slettes`.left()
        }

        spørreundersøkelseRepository.slettSpørreundersøkelse(spørreundersøkelseId = spørreundersøkelseId)

        val oppdatertSpørreundersøkelse = spørreundersøkelse.copy(
            status = Spørreundersøkelse.Status.SLETTET,
            endretTidspunkt = LocalDateTime.now().toKotlinLocalDateTime(),
        )

        spørreundersøkelseObservers.forEach { it.receive(oppdatertSpørreundersøkelse) }

        return oppdatertSpørreundersøkelse.right()
    }

    fun hentSpørreundersøkelser(
        sak: IASak,
        prosessId: Int,
    ): Either<Feil, List<Spørreundersøkelse>> =
        try {
            samarbeidService.hentSamarbeid(sak, prosessId).map {
                spørreundersøkelseRepository.hentSpørreundersøkelser(samarbeid = it, type = Behovsvurdering) +
                    spørreundersøkelseRepository.hentSpørreundersøkelser(it, Evaluering)
            }
        } catch (e: Exception) {
            log.error("Noe gikk feil ved henting av spørreundersøkelser for samarbeid $prosessId: ${e.message}", e)
            IASakSpørreundersøkelseError.`generell feil under uthenting`.left()
        }

    fun hentSpørreundersøkelser(
        saksnummer: String,
        prosessId: Int,
        type: Spørreundersøkelse.Type,
    ): Either<Feil, List<Spørreundersøkelse>> =
        try {
            samarbeidService.hentSamarbeid(saksnummer, prosessId).map {
                spørreundersøkelseRepository.hentSpørreundersøkelser(samarbeid = it, type = type)
            }
        } catch (e: Exception) {
            log.error("Noe gikk feil ved henting av spørreundersøkelse av type ${type.name}: ${e.message}", e)
            IASakSpørreundersøkelseError.`generell feil under uthenting`.left()
        }

    fun hentSpørreundersøkelse(spørreundersøkelseId: UUID): Either<Feil, Spørreundersøkelse> =
        spørreundersøkelseRepository.hentSpørreundersøkelse(spørreundersøkelseId)?.right()
            ?: IASakSpørreundersøkelseError.`ugyldig id`.left()

    fun endreSpørreundersøkelseStatus(
        spørreundersøkelseId: UUID,
        statusViSkalEndreTil: Spørreundersøkelse.Status,
    ): Either<Feil, Spørreundersøkelse> {
        val spørreundersøkelse = hentSpørreundersøkelse(spørreundersøkelseId = spørreundersøkelseId).getOrElse { return it.left() }

        val oppdatertSpørreundersøkelse: Spørreundersøkelse = when (statusViSkalEndreTil) {
            Spørreundersøkelse.Status.PÅBEGYNT -> {
                if (spørreundersøkelse.status != Spørreundersøkelse.Status.OPPRETTET) {
                    return IASakSpørreundersøkelseError.`feil status kan ikke starte`.left()
                } else {
                    spørreundersøkelseRepository.startSpørreundersøkelse(spørreundersøkelseId = spørreundersøkelseId)
                        ?: return IASakSpørreundersøkelseError.`feil under oppdatering`.left()
                }
            }

            Spørreundersøkelse.Status.AVSLUTTET -> {
                if (spørreundersøkelse.status != Spørreundersøkelse.Status.PÅBEGYNT) {
                    return IASakSpørreundersøkelseError.`ikke påbegynt`.left()
                } else {
                    spørreundersøkelseRepository.avsluttSpørreundersøkelse(spørreundersøkelseId = spørreundersøkelseId)
                        ?: return IASakSpørreundersøkelseError.`feil under oppdatering`.left()
                }
            }

            Spørreundersøkelse.Status.OPPRETTET -> {
                return IASakSpørreundersøkelseError.`ikke støttet statusendring`.left()
            }

            Spørreundersøkelse.Status.SLETTET -> {
                return IASakSpørreundersøkelseError.`ikke støttet statusendring`.left()
            }
        }

        spørreundersøkelseObservers.forEach { it.receive(oppdatertSpørreundersøkelse) }

        return oppdatertSpørreundersøkelse.right()
    }

    fun stengTema(hendelse: StengTema) {
        val spørreundersøkelseId = hendelse.spørreundersøkelseId.tilUUID(hvaErJeg = "spørreundersøkelseId")
        log.info("Mottok stenging av tema: ${hendelse.temaId} i spørreundersøkelse $spørreundersøkelseId")

        val spørreundersøkelse = hentSpørreundersøkelse(spørreundersøkelseId = spørreundersøkelseId).getOrElse { feil ->
            log.warn(
                "Kunne ikke stenge tema med id: '${hendelse.temaId}' i spørreundersøkelse med id '$spørreundersøkelseId', Feil: '${feil.feilmelding}'",
            )
            return
        }

        spørreundersøkelseRepository.stengTema(
            spørreundersøkelseId = spørreundersøkelse.id,
            temaId = hendelse.temaId,
        )

        val oppdatertSpørreundersøkelse = hentSpørreundersøkelse(spørreundersøkelseId = spørreundersøkelseId).getOrElse { feil ->
            log.warn(
                "Kunne ikke hente ut spørreundersøkels etter stenging av tema med id: '${hendelse.temaId}' i spørreundersøkelse med id '$spørreundersøkelseId', Feil: '${feil.feilmelding}'",
            )
            return
        }

        if (oppdatertSpørreundersøkelse.alleTemaErFullført()) {
            endreSpørreundersøkelseStatus(
                spørreundersøkelseId = oppdatertSpørreundersøkelse.id,
                statusViSkalEndreTil = Spørreundersøkelse.Status.AVSLUTTET,
            )
            log.info("Alle temaer i spørreundersøkelse '${hendelse.spørreundersøkelseId}' er fullført, spørreundersøkelse er avsluttet")
        }

        sendResultaterForTemaPåKafka(
            spørreundersøkelseId = spørreundersøkelseId,
            temaId = hendelse.temaId,
        )
    }

    fun oppdaterSamarbeidIdISpørreundersøkelse(
        spørreundersøkelseId: UUID,
        oppdaterSpørreundersøkelseDto: OppdaterBehovsvurderingDto,
    ): Either<Feil, Spørreundersøkelse> {
        val behovsvurdering = hentSpørreundersøkelse(spørreundersøkelseId = spørreundersøkelseId).getOrElse { return it.left() }
        if (behovsvurdering.type == Evaluering) {
            return IASakSpørreundersøkelseError.`ugyldig type`.left()
        }
        if (behovsvurdering.orgnummer != oppdaterSpørreundersøkelseDto.orgnummer) {
            return IASakSpørreundersøkelseError.`feil under oppdatering`.left()
        }
        if (behovsvurdering.saksnummer != oppdaterSpørreundersøkelseDto.saksnummer) {
            return IASakSpørreundersøkelseError.`feil under oppdatering`.left()
        }
        if (behovsvurdering.status != Spørreundersøkelse.Status.AVSLUTTET) {
            return IASakSpørreundersøkelseError.`ikke avsluttet, kan ikke bytte samarbeid`.left()
        }
        if (erPublisertEllerUnderPublisering(spørreundersøkelse = behovsvurdering)) {
            return IASakSpørreundersøkelseError.`publisert, kan ikke bytte samarbeid`.left()
        }

        val oppdatertBehovsvurdering = iaSakService.hentIASak(saksnummer = behovsvurdering.saksnummer).flatMap {
            samarbeidService.hentSamarbeid(saksnummer = it.saksnummer)
        }.map { prosess ->
            prosess.map { it.id }
        }.flatMap { prosesserISak ->
            if (prosesserISak.contains(oppdaterSpørreundersøkelseDto.prosessId)) {
                spørreundersøkelseRepository.oppdaterBehovsvurdering(spørreundersøkelseId, oppdaterSpørreundersøkelseDto)
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
    ): Either<Feil, TemaResultatKafkaDto> {
        val spørreundersøkelse = hentSpørreundersøkelse(spørreundersøkelseId = spørreundersøkelseId).getOrElse { return it.left() }

        val temaResultat = spørreundersøkelse.temaer.firstOrNull { it.id == temaId }
            ?: return IASakSpørreundersøkelseError.`ugyldig temaId`.left()

        return temaResultat.tilTemaResultatKafkaDto().right()
    }

    private fun erPublisertEllerUnderPublisering(spørreundersøkelse: Spørreundersøkelse): Boolean {
        val type = DokumentPubliseringDto.Type.valueOf(spørreundersøkelse.type.name.uppercase())
        val dokumentErUnderPublisering = dokumentPubliseringRepository.hentDokumentTilPublisering(
            dokumentReferanseId = spørreundersøkelse.id,
            dokumentType = type,
        ) != null
        val finnesPubliserteDokumenter = dokumentPubliseringRepository.hentKvitterteDokumenter(
            referanseId = spørreundersøkelse.id,
            type = type,
        ).any { it.status == DokumentPubliseringDto.Status.PUBLISERT }
        return finnesPubliserteDokumenter || dokumentErUnderPublisering
    }
}
