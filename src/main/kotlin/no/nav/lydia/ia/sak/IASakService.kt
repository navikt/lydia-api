package no.nav.lydia.ia.sak

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.IASakDto.Companion.toDto
import no.nav.lydia.ia.sak.api.IASakError
import no.nav.lydia.ia.sak.api.SaksStatusDto
import no.nav.lydia.ia.sak.api.ÅrsakTilAtSakIkkeKanAvsluttes
import no.nav.lydia.ia.sak.api.ÅrsaksType
import no.nav.lydia.ia.sak.db.IASakLeveranseRepository
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.sak.db.PlanRepository
import no.nav.lydia.ia.sak.db.SpørreundersøkelseRepository
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakLeveranse
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.plan.PlanUndertema
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import org.slf4j.Logger
import org.slf4j.LoggerFactory

class IASakService(
    private val iaSakRepository: IASakRepository,
    private val iaSakshendelseRepository: IASakshendelseRepository,
    private val iaSakLeveranseRepository: IASakLeveranseRepository,
    private val samarbeidService: IASamarbeidService,
    private val planRepository: PlanRepository,
    private val spørreundersøkelseRepository: SpørreundersøkelseRepository,
) {
    private val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun hentAktivSak(orgnummer: String): IASakDto? =
        hentSakerForOrgnummer(orgnummer)
            .sortedByDescending { it.opprettetTidspunkt }
            .toDto()
            .firstOrNull {
                !it.status.regnesSomAvsluttet()
            }

    fun tilbakeførSaker(tørrKjør: Boolean): Int =
        iaSakRepository.hentUrørteSakerIVurderesUtenEier()
            // TODO: [OPPRYDDING] Må fikses opp i
//            .map {
//            it.maskineltSettSakTilIkkeAktuell(tørrKjør = tørrKjør)
//        }
            .size

//    private fun IASak.maskineltSettSakTilIkkeAktuell(tørrKjør: Boolean) {
//        val tilbakeføringsHendelse = this.nyTilbakeføringsHendelse()
//        val sistEndretAvHendelseId = this.endretAvHendelseId
//        val endretTidspunkt = this.endretTidspunkt
//        if (!tørrKjør) {
//            tilbakeføringsHendelse.lagre(sistEndretAvHendelseId = sistEndretAvHendelseId, resulterendeStatus = IASak.Status.IKKE_AKTUELL)
//            val oppdatertSak = tilbakeførSak(iaSak = this, hendelse = tilbakeføringsHendelse)
//            årsakService.lagreÅrsak(sakshendelse = tilbakeføringsHendelse)
//            oppdatertSak.lagreOppdatering(sistEndretAvHendelseId = sistEndretAvHendelseId)
//        }
//        log.info(
//            "${if (tørrKjør) "Skulle tilbakeføre" else "Tilbakeførte"} sak med saksnummer ${this.saksnummer}, sist oppdatert: $endretTidspunkt",
//        )
//    }

//    private fun IASak.maskineltAvsluttProsess(iaSamarbeidDto: IASamarbeidDto) {
//        val hendelse = nyMaskineltOppdaterSamarbeidHendelse(
//            iaSamarbeidDto = iaSamarbeidDto,
//            iASakshendelseType = IASakshendelseType.AVBRYT_PROSESS,
//            resulterendeStatus = this.status,
//        )
//        val sistEndretAvHendelseId = this.endretAvHendelseId
//        hendelse.lagre(sistEndretAvHendelseId = sistEndretAvHendelseId, resulterendeStatus = this.status)
//        samarbeidService.oppdaterSamarbeid(sakshendelse = hendelse, sak = this)
//        val oppdatertSak = maskineltBehandleSamarbeidsHendelse(
//            iaSak = this,
//            hendelse = hendelse,
//        )
//        oppdatertSak.lagreOppdatering(sistEndretAvHendelseId = sistEndretAvHendelseId)
//    }

    fun hentSakerForOrgnummer(orgnummer: String): List<IASak> = iaSakRepository.hentSaker(orgnummer)

    fun hentIASakDtoerForOrgnummer(orgnummer: String): List<IASakDto> = iaSakRepository.hentAlleSakerDtoForVirksomhet(orgnummer)

    fun hentHendelserForOrgnummer(orgnr: String): List<IASakshendelse> = iaSakshendelseRepository.hentHendelserForOrgnummer(orgnr = orgnr)

    fun hentIASakLeveranser(saksnummer: String): Either<Feil, List<IASakLeveranse>> =
        try {
            iaSakLeveranseRepository.hentIASakLeveranser(saksnummer = saksnummer).right()
        } catch (e: Exception) {
            log.error("Noe gikk feil ved uthenting av leveranser: ${e.message}", e)
            IASakError.`generell feil under uthenting`.left()
        }

    fun hentIASakDto(saksnummer: String): Either<Feil, IASakDto> =
        iaSakRepository.hentIASakDto(saksnummer = saksnummer)?.right() ?: IASakError.`ugyldig saksnummer`.left()

    fun hentMal(): Either<Feil, PlanMalDto> = PlanMalDto().right()

    fun hentSaksStatus(saksnummer: String): Either<Feil, SaksStatusDto> {
        val årsaker = mutableListOf<ÅrsakTilAtSakIkkeKanAvsluttes>()
        val sak = hentIASakDto(saksnummer).getOrNull()
            ?: return IASakError.`generell feil under uthenting`.left()
        val samarbeid = samarbeidService.hentSamarbeidSomIkkeErSlettet(sak.saksnummer).getOrNull()
            ?: return IASamarbeidFeil.`feil ved henting av samarbeid`.left()

        samarbeid.forEach { prosess ->
            årsaker.addAll(sjekkBehovsvurderinger(prosess))
            sjekkPlan(prosess)?.let { årsaker.add(it) }
        }

        return SaksStatusDto(
            årsaker = årsaker.toList(),
        ).right()
    }

    private fun sjekkPlan(prosess: IASamarbeid): ÅrsakTilAtSakIkkeKanAvsluttes? {
        val plan = planRepository.hentPlan(samarbeidId = prosess.id) ?: return ÅrsakTilAtSakIkkeKanAvsluttes(
            samarbeidsId = prosess.id,
            samarbeidsNavn = prosess.navn,
            type = ÅrsaksType.INGEN_FULLFØRT_SAMARBEIDSPLAN,
        )

        val ingenPlanlagteUndertemaer = plan.temaer.map { tema ->
            tema.undertemaer.all { undertema -> !undertema.inkludert }
        }.all { it }

        if (ingenPlanlagteUndertemaer) {
            return ÅrsakTilAtSakIkkeKanAvsluttes(
                samarbeidsId = prosess.id,
                samarbeidsNavn = prosess.navn,
                type = ÅrsaksType.SAMARBEIDSPLAN_IKKE_FULLFØRT,
                id = plan.id.toString(),
            )
        }

        val erPlanFullført = plan.temaer.map { tema ->
            tema.undertemaer.filter { it.inkludert }.all { undertema ->
                undertema.status == PlanUndertema.Status.FULLFØRT
            }
        }.all { it }

        return when (erPlanFullført) {
            true -> null

            false -> ÅrsakTilAtSakIkkeKanAvsluttes(
                samarbeidsId = prosess.id,
                samarbeidsNavn = prosess.navn,
                type = ÅrsaksType.SAMARBEIDSPLAN_IKKE_FULLFØRT,
                id = plan.id.toString(),
            )
        }
    }

    private fun sjekkBehovsvurderinger(samarbeid: IASamarbeid): List<ÅrsakTilAtSakIkkeKanAvsluttes> {
        val årsaker = mutableListOf<ÅrsakTilAtSakIkkeKanAvsluttes>()
        val statusForBehovsvurderinger =
            iaSakRepository.hentStatusForBehovsvurderinger(samarbeidId = samarbeid.id)
        if (statusForBehovsvurderinger.isEmpty()) {
            return emptyList()
        }

        statusForBehovsvurderinger.forEach {
            when (it.second) {
                Spørreundersøkelse.Status.AVSLUTTET,
                Spørreundersøkelse.Status.SLETTET,
                -> {}

                else -> {
                    årsaker.add(
                        ÅrsakTilAtSakIkkeKanAvsluttes(
                            samarbeidsId = samarbeid.id,
                            samarbeidsNavn = samarbeid.navn,
                            id = it.first,
                            type = ÅrsaksType.BEHOVSVURDERING_IKKE_FULLFØRT,
                        ),
                    )
                }
            }
        }
        return årsaker
    }

    fun avsluttSakForSlettetVirksomhet(orgnr: String) {
        hentAktivSak(orgnummer = orgnr)?.let { iaSak ->
            if (iaSak.status != IASak.Status.FULLFØRT && iaSak.status != IASak.Status.IKKE_AKTUELL) {
                // avslutt alle samarbeid
                samarbeidService.hentAktiveSamarbeid(iaSak).forEach { samarbeid ->
                    // avslutt eventuelle spørreundersøkelser i samarbeid
                    spørreundersøkelseRepository.hentSpørreundersøkelser(samarbeid = samarbeid, type = Spørreundersøkelse.Type.Behovsvurdering)
                        .plus(spørreundersøkelseRepository.hentSpørreundersøkelser(samarbeid = samarbeid, type = Spørreundersøkelse.Type.Evaluering))
                        .filter { it.status != Spørreundersøkelse.Status.AVSLUTTET }
                        .forEach { spørreundersøkelseRepository.slettSpørreundersøkelse(spørreundersøkelseId = it.id) }

                    // slett eventuell plan for samarbeid
                    planRepository.hentPlan(samarbeidId = samarbeid.id)
                        ?.let { planRepository.settPlanTilAvbrutt(it) }

                    // sett samarbeid til AVBRYTT
                    val oppdatertSak = iaSakRepository.hentIASak(saksnummer = iaSak.saksnummer)!!
                    // TODO: [OPPRYDDING] Må fikses opp i
//                    oppdatertSak.maskineltAvsluttProsess(iaSamarbeidDto = samarbeid.tilDto())
                }
                val oppdatertSak = iaSakRepository.hentIASak(saksnummer = iaSak.saksnummer)!!
                // TODO: [OPPRYDDING] Må fikses opp i
                // sett sak til Ikke aktuell
//                oppdatertSak.maskineltSettSakTilIkkeAktuell(tørrKjør = false)
            }
        }
    }
}
