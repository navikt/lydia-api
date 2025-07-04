package no.nav.lydia.ia.sak

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import no.nav.lydia.Observer
import no.nav.lydia.appstatus.ObservedPlan
import no.nav.lydia.appstatus.PlanHendelseType
import no.nav.lydia.ia.sak.IASamarbeidService.StatusendringBegrunnelser.AKTIV_BEHOVSVURDERING
import no.nav.lydia.ia.sak.IASamarbeidService.StatusendringBegrunnelser.AKTIV_EVALUERING
import no.nav.lydia.ia.sak.IASamarbeidService.StatusendringBegrunnelser.FINNES_BEHOVSVURDERING
import no.nav.lydia.ia.sak.IASamarbeidService.StatusendringBegrunnelser.FINNES_EVALUERING
import no.nav.lydia.ia.sak.IASamarbeidService.StatusendringBegrunnelser.FINNES_SALESFORCE_AKTIVITET
import no.nav.lydia.ia.sak.IASamarbeidService.StatusendringBegrunnelser.FINNES_SAMARBEIDSPLAN
import no.nav.lydia.ia.sak.IASamarbeidService.StatusendringBegrunnelser.INGEN_EVALUERING
import no.nav.lydia.ia.sak.IASamarbeidService.StatusendringBegrunnelser.INGEN_PLAN
import no.nav.lydia.ia.sak.IASamarbeidService.StatusendringBegrunnelser.SAK_I_FEIL_STATUS
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.KanGjennomføreStatusendring
import no.nav.lydia.ia.sak.api.samarbeid.IASamarbeidDto
import no.nav.lydia.ia.sak.db.IASamarbeidRepository
import no.nav.lydia.ia.sak.db.PlanRepository
import no.nav.lydia.ia.sak.db.SpørreundersøkelseRepository
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelse
import no.nav.lydia.ia.sak.domene.IASakshendelseType.AVBRYT_PROSESS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.ENDRE_PROSESS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.FULLFØR_PROSESS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.FULLFØR_PROSESS_MASKINELT_PÅ_EN_FULLFØRT_SAK
import no.nav.lydia.ia.sak.domene.IASakshendelseType.NY_PROSESS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.SLETT_PROSESS
import no.nav.lydia.ia.sak.domene.ProsessHendelse
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse

class IASamarbeidService(
    val samarbeidRepository: IASamarbeidRepository,
    val spørreundersøkelseRepository: SpørreundersøkelseRepository,
    val samarbeidObservers: List<Observer<IASamarbeid>>,
    val planRepository: PlanRepository,
    val planObservers: List<Observer<ObservedPlan>>,
) {
    fun hentSamarbeid(sak: IASak): Either<Feil, List<IASamarbeid>> =
        Either.catch {
            samarbeidRepository.hentSamarbeid(saksnummer = sak.saksnummer)
        }.mapLeft {
            IASamarbeidFeil.`feil ved henting av samarbeid`
        }

    fun hentAktiveSamarbeid(sak: IASak): List<IASamarbeid> = samarbeidRepository.hentAktiveSamarbeid(saksnummer = sak.saksnummer)

    fun hentSamarbeid(
        sak: IASak,
        samarbeidId: Int,
    ): Either<Feil, IASamarbeid> =
        samarbeidRepository.hentSamarbeid(saksnummer = sak.saksnummer, samarbeidId = samarbeidId)?.right()
            ?: IASamarbeidFeil.`ugyldig samarbeidId`.left()

    fun hentSamarbeid(
        saksnummer: String,
        samarbeidId: Int,
    ): Either<Feil, IASamarbeid> =
        samarbeidRepository.hentSamarbeid(saksnummer = saksnummer, samarbeidId = samarbeidId)?.right()
            ?: IASamarbeidFeil.`ugyldig samarbeidId`.left()

    fun oppdaterSamarbeid(
        sakshendelse: IASakshendelse,
        sak: IASak,
    ) {
        when (sakshendelse) {
            is ProsessHendelse -> {
                when (sakshendelse.hendelsesType) {
                    FULLFØR_PROSESS_MASKINELT_PÅ_EN_FULLFØRT_SAK -> fullførSamarbeidMaskineltPåEnFullførtSak(
                        sakshendelse = sakshendelse,
                    )?.let { samarbeid ->
                        samarbeidObservers.forEach { it.receive(input = samarbeid) }
                    }

                    FULLFØR_PROSESS -> fullførSamarbeid(
                        sakshendelse = sakshendelse,
                        sak = sak,
                    )?.let { samarbeid ->
                        samarbeidObservers.forEach { it.receive(input = samarbeid) }
                    }

                    AVBRYT_PROSESS -> avbrytSamarbeid(sakshendelse, sak)?.let { samarbeid ->
                        samarbeidObservers.forEach { it.receive(input = samarbeid) }
                    }

                    ENDRE_PROSESS -> oppdaterNavnPåSamarbeid(samarbeidDto = sakshendelse.samarbeidDto)
                        ?.let { samarbeid -> samarbeidObservers.forEach { it.receive(input = samarbeid) } }

                    SLETT_PROSESS -> slettSamarbeid(sakshendelse, sak)
                        ?.let { samarbeid -> samarbeidObservers.forEach { it.receive(input = samarbeid) } }

                    NY_PROSESS -> samarbeidRepository.opprettNyttSamarbeid(
                        saksnummer = sakshendelse.saksnummer,
                        navn = sakshendelse.samarbeidDto.navn,
                    ).also { samarbeid ->
                        samarbeidObservers.forEach { it.receive(input = samarbeid) }
                    }

                    else -> {}
                }
            }

            else -> {}
        }
    }

    private fun oppdaterNavnPåSamarbeid(samarbeidDto: IASamarbeidDto): IASamarbeid? {
        samarbeidRepository.oppdaterNavnPåSamarbeid(samarbeidDto = samarbeidDto)
        return samarbeidRepository.hentSamarbeid(
            saksnummer = samarbeidDto.saksnummer,
            samarbeidId = samarbeidDto.id,
        )
    }

    enum class StatusendringBegrunnelser {
        // -- fullføre
        INGEN_EVALUERING,
        INGEN_PLAN,
        AKTIV_EVALUERING,
        AKTIV_BEHOVSVURDERING,
        SAK_I_FEIL_STATUS,

        // -- slette
        FINNES_SALESFORCE_AKTIVITET,
        FINNES_BEHOVSVURDERING,
        FINNES_SAMARBEIDSPLAN,
        FINNES_EVALUERING,
    }

    fun kanFullføreSamarbeid(
        sak: IASak,
        samarbeidId: Int,
    ): KanGjennomføreStatusendring {
        val samarbeid = hentSamarbeid(sak = sak, samarbeidId = samarbeidId).getOrNull()
            ?: throw IllegalStateException("Fant ikke samarbeid")
        val behovsvurderinger = spørreundersøkelseRepository.hentSpørreundersøkelser(samarbeid = samarbeid, type = Spørreundersøkelse.Type.Behovsvurdering)
        val evalueringer = spørreundersøkelseRepository.hentSpørreundersøkelser(samarbeid = samarbeid, type = Spørreundersøkelse.Type.Evaluering)
        val blokkerende = mutableListOf<StatusendringBegrunnelser>()
        val advarsler = mutableListOf<StatusendringBegrunnelser>()

        if (sak.status != IASak.Status.VI_BISTÅR) {
            blokkerende.add(SAK_I_FEIL_STATUS)
        }

        if (behovsvurderinger.any { it.status != Spørreundersøkelse.Status.AVSLUTTET }) {
            blokkerende.add(AKTIV_BEHOVSVURDERING)
        }

        if (evalueringer.isEmpty()) {
            advarsler.add(INGEN_EVALUERING)
        }

        if (evalueringer.any { it.status != Spørreundersøkelse.Status.AVSLUTTET }) {
            blokkerende.add(AKTIV_EVALUERING)
        }

        val plan = planRepository.hentPlan(samarbeidId = samarbeid.id)
        if (plan == null) {
            blokkerende.add(INGEN_PLAN)
        }

        return KanGjennomføreStatusendring(
            kanGjennomføres = blokkerende.isEmpty(),
            advarsler = advarsler.toList(),
            blokkerende = blokkerende.toList(),
        )
    }

    fun kanSletteSamarbeid(
        sak: IASak,
        samarbeidId: Int,
    ): KanGjennomføreStatusendring {
        val samarbeid = hentSamarbeid(sak = sak, samarbeidId = samarbeidId).getOrNull()
            ?: throw IllegalStateException("Fant ikke samarbeid")
        val blokkerende = mutableListOf<StatusendringBegrunnelser>()
        val advarsler = mutableListOf<StatusendringBegrunnelser>()

        if (spørreundersøkelseRepository.hentSpørreundersøkelser(samarbeid = samarbeid, type = Spørreundersøkelse.Type.Behovsvurdering).isNotEmpty()) {
            blokkerende.add(FINNES_BEHOVSVURDERING)
        }
        if (spørreundersøkelseRepository.hentSpørreundersøkelser(samarbeid = samarbeid, type = Spørreundersøkelse.Type.Evaluering).isNotEmpty()) {
            blokkerende.add(FINNES_EVALUERING)
        }
        if (planRepository.hentPlan(samarbeidId = samarbeid.id) != null) {
            blokkerende.add(FINNES_SAMARBEIDSPLAN)
        }
        if (samarbeidRepository.hentSalesforceAktiviteter(saksnummer = sak.saksnummer, samarbeidId = samarbeid.id).isNotEmpty()) {
            blokkerende.add(FINNES_SALESFORCE_AKTIVITET)
        }

        return KanGjennomføreStatusendring(
            kanGjennomføres = blokkerende.isEmpty(),
            blokkerende = blokkerende,
            advarsler = advarsler,
        )
    }

    fun kanAvbryteSamarbeid(
        sak: IASak,
        samarbeidId: Int,
    ): KanGjennomføreStatusendring {
        val samarbeid = hentSamarbeid(sak = sak, samarbeidId = samarbeidId).getOrNull()
            ?: throw IllegalStateException("Fant ikke samarbeid")
        val blokkerende = mutableListOf<StatusendringBegrunnelser>()

        if (spørreundersøkelseRepository.hentSpørreundersøkelser(samarbeid = samarbeid, type = Spørreundersøkelse.Type.Behovsvurdering)
                .any { it.status != Spørreundersøkelse.Status.AVSLUTTET }
        ) {
            blokkerende.add(AKTIV_BEHOVSVURDERING)
        }
        if (spørreundersøkelseRepository.hentSpørreundersøkelser(samarbeid = samarbeid, type = Spørreundersøkelse.Type.Evaluering)
                .any { it.status != Spørreundersøkelse.Status.AVSLUTTET }
        ) {
            blokkerende.add(AKTIV_EVALUERING)
        }

        return KanGjennomføreStatusendring(
            kanGjennomføres = blokkerende.isEmpty(),
            blokkerende = blokkerende,
            advarsler = emptyList(),
        )
    }

    private fun fullførSamarbeid(
        sakshendelse: ProsessHendelse,
        sak: IASak,
    ): IASamarbeid? {
        val samarbeidDto = sakshendelse.samarbeidDto

        return if (kanFullføreSamarbeid(sak = sak, samarbeidId = samarbeidDto.id).kanGjennomføres) {
            planRepository.hentPlan(samarbeidId = samarbeidDto.id)?.let { plan ->
                planRepository.settPlanTilFullført(plan)
                planRepository.hentPlan(samarbeidId = samarbeidDto.id)?.let { oppdatertPlan ->
                    planObservers.forEach {
                        it.receive(
                            input = ObservedPlan(
                                plan = oppdatertPlan,
                                hendelsesType = PlanHendelseType.ENDRE_STATUS,
                            ),
                        )
                    }
                }
            }
            samarbeidRepository.fullførSamarbeid(samarbeidDto = samarbeidDto)
        } else {
            samarbeidRepository.hentSamarbeid(
                saksnummer = samarbeidDto.saksnummer,
                samarbeidId = samarbeidDto.id,
            )
        }
    }

    private fun fullførSamarbeidMaskineltPåEnFullførtSak(sakshendelse: ProsessHendelse): IASamarbeid? =
        samarbeidRepository.fullførSamarbeid(samarbeidDto = sakshendelse.samarbeidDto)

    private fun avbrytSamarbeid(
        sakshendelse: ProsessHendelse,
        sak: IASak,
    ): IASamarbeid? {
        val samarbeidDto = sakshendelse.samarbeidDto

        return if (kanAvbryteSamarbeid(sak = sak, samarbeidId = samarbeidDto.id).kanGjennomføres) {
            samarbeidRepository.avbrytSamarbeid(samarbeidDto = samarbeidDto)
        } else {
            samarbeidRepository.hentSamarbeid(
                saksnummer = samarbeidDto.saksnummer,
                samarbeidId = samarbeidDto.id,
            )
        }
    }

    private fun slettSamarbeid(
        sakshendelse: ProsessHendelse,
        sak: IASak,
    ): IASamarbeid? {
        val samarbeidDto = sakshendelse.samarbeidDto

        return if (kanSletteSamarbeid(sak = sak, samarbeidId = samarbeidDto.id).kanGjennomføres) {
            samarbeidRepository.slettSamarbeid(samarbeidDto = samarbeidDto)
        } else {
            samarbeidRepository.hentSamarbeid(
                saksnummer = samarbeidDto.saksnummer,
                samarbeidId = samarbeidDto.id,
            )
        }
    }
}

const val DEFAULT_SAMARBEID_NAVN = "Samarbeid uten navn"
const val MAKS_ANTALL_TEGN_I_SAMARBEIDSNAVN = 50

object IASamarbeidFeil {
    val `ugyldig samarbeidsnavn` =
        Feil(feilmelding = "Ugyldig samarbeidsnavn", httpStatusCode = HttpStatusCode.BadRequest)
    val `samarbeidsnavn finnes allerede` =
        Feil(feilmelding = "Samarbeidsnavn finnes allerede", httpStatusCode = HttpStatusCode.Conflict)

    // TODO: Endre feilmelding fra prosess til samarbeid
    val `feil ved henting av samarbeid` =
        Feil(feilmelding = "Feil ved henting av prosess", httpStatusCode = HttpStatusCode.InternalServerError)

    // TODO: Endre feilmelding fra prosess til samarbeid
    val `ugyldig samarbeidId` =
        Feil(feilmelding = "Ugyldig prosess", httpStatusCode = HttpStatusCode.BadRequest)
    val `kan ikke slette samarbeid som inneholder behovsvurdering eller samarbeidsplan` =
        Feil(feilmelding = "kan ikke slette samarbeid som inneholder behovsvurdering eller samarbeidsplan", httpStatusCode = HttpStatusCode.BadRequest)
    val `kan ikke fullføre samarbeid` =
        Feil(feilmelding = "kan ikke fullføre samarbeid", httpStatusCode = HttpStatusCode.BadRequest)
    val `kan ikke avbryte samarbeid` =
        Feil(feilmelding = "kan ikke avbryte samarbeid", httpStatusCode = HttpStatusCode.BadRequest)
}
