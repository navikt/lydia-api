package no.nav.lydia.ia.sak

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import no.nav.lydia.arbeidsgiver.DokumentMetadata
import no.nav.lydia.arbeidsgiver.SamarbeidMedDokumenterDto
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
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.KanGjennomføreStatusendring
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASamarbeidRepository
import no.nav.lydia.ia.sak.db.PlanRepository
import no.nav.lydia.ia.sak.db.SpørreundersøkelseRepository
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import org.slf4j.LoggerFactory

class IASamarbeidService(
    private val iaSakRepository: IASakRepository,
    private val samarbeidRepository: IASamarbeidRepository,
    private val spørreundersøkelseRepository: SpørreundersøkelseRepository,
    private val planRepository: PlanRepository,
) {
    private val log = LoggerFactory.getLogger(this::class.java)

    fun hentSamarbeidMedPubliserteDokumenter(orgnr: String) =
        Either.catch {
            samarbeidRepository.hentSamarbeidForOrgnr(orgnr)
                .map { samarbeid ->
                    SamarbeidMedDokumenterDto(
                        offentligId = samarbeid.offentligId.toString(),
                        navn = samarbeid.navn,
                        status = samarbeid.status,
                        sistEndret = samarbeid.sistEndret,
                        dokumenter = hentPubliserteDokumenter(samarbeidId = samarbeid.id),
                    )
                }.filter { it.dokumenter.isNotEmpty() }
        }.mapLeft {
            log.warn("Feil ved uthenting av samarbeid", it)
            IASamarbeidFeil.`feil ved henting av samarbeid`
        }

    private fun hentPubliserteDokumenter(samarbeidId: Int): List<DokumentMetadata> {
        val publiserteBehovsvurderinger = samarbeidRepository.hentSpørreundersøkelseDokumenterForSamarbeid(samarbeidId = samarbeidId).toMutableList()
        val publisertSamarbeidsplan = samarbeidRepository.hentSamarbeidsplanDokumentForSamarbeid(samarbeidId = samarbeidId)
        publisertSamarbeidsplan?.let { publiserteBehovsvurderinger.add(it) }

        return publiserteBehovsvurderinger.toList()
    }

    fun hentSamarbeid(samarbeidId: Int) = samarbeidRepository.hentSamarbeid(samarbeidId = samarbeidId)

    fun hentSamarbeidSomIkkeErSlettet(saksnummer: String): Either<Feil, List<IASamarbeid>> =
        Either.catch {
            samarbeidRepository.hentSamarbeidSomIkkeErSlettet(saksnummer = saksnummer)
        }.mapLeft {
            IASamarbeidFeil.`feil ved henting av samarbeid`
        }

    fun hentAktiveSamarbeid(sak: IASakDto): List<IASamarbeid> = samarbeidRepository.hentAktiveSamarbeid(saksnummer = sak.saksnummer)

    fun hentAlleSamarbeidSomIkkeErSlettet(saksnummer: String): List<IASamarbeid> = samarbeidRepository.hentSamarbeidSomIkkeErSlettet(saksnummer = saksnummer)

    fun hentAktiveSamarbeid(saksnummer: String): List<IASamarbeid> = samarbeidRepository.hentAktiveSamarbeid(saksnummer = saksnummer)

    fun hentSamarbeid(
        saksnummer: String,
        samarbeidId: Int,
    ): Either<Feil, IASamarbeid> =
        samarbeidRepository.hentSamarbeid(saksnummer = saksnummer, samarbeidId = samarbeidId)?.right()
            ?: IASamarbeidFeil.`ugyldig samarbeidId`.left()

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
        saksnummer: String,
        samarbeidId: Int,
    ): KanGjennomføreStatusendring {
        val samarbeid = hentSamarbeid(saksnummer = saksnummer, samarbeidId = samarbeidId).getOrNull()
            ?: throw IllegalStateException("Fant ikke samarbeid")
        val behovsvurderinger = spørreundersøkelseRepository.hentSpørreundersøkelser(samarbeid = samarbeid, type = Spørreundersøkelse.Type.Behovsvurdering)
        val evalueringer = spørreundersøkelseRepository.hentSpørreundersøkelser(samarbeid = samarbeid, type = Spørreundersøkelse.Type.Evaluering)
        val blokkerende = mutableListOf<StatusendringBegrunnelser>()
        val advarsler = mutableListOf<StatusendringBegrunnelser>()

        val statusPåSak = iaSakRepository.hentStatusForSaksnummer(saksnummer)

        if (statusPåSak != IASak.Status.AKTIV) {
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
        saksnummer: String,
        samarbeidId: Int,
    ): KanGjennomføreStatusendring {
        val samarbeid = hentSamarbeid(saksnummer = saksnummer, samarbeidId = samarbeidId).getOrNull()
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
        if (samarbeidRepository.hentSalesforceAktiviteter(saksnummer = saksnummer, samarbeidId = samarbeid.id).isNotEmpty()) {
            blokkerende.add(FINNES_SALESFORCE_AKTIVITET)
        }

        return KanGjennomføreStatusendring(
            kanGjennomføres = blokkerende.isEmpty(),
            blokkerende = blokkerende,
            advarsler = advarsler,
        )
    }

    fun kanAvbryteSamarbeid(
        saksnummer: String,
        samarbeidId: Int,
    ): KanGjennomføreStatusendring {
        val samarbeid = hentSamarbeid(saksnummer = saksnummer, samarbeidId = samarbeidId).getOrNull()
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
        Feil(feilmelding = "Feil ved henting av samarbeid", httpStatusCode = HttpStatusCode.InternalServerError)

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
