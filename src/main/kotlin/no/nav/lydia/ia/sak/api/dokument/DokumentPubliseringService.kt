package no.nav.lydia.ia.sak.api.dokument

import arrow.core.Either
import arrow.core.getOrElse
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toJavaLocalDateTime
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.encodeToJsonElement
import kotlinx.serialization.json.jsonObject
import no.nav.lydia.ia.sak.IASamarbeidService
import no.nav.lydia.ia.sak.SpørreundersøkelseService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringDto.Type.BEHOVSVURDERING
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringDto.Type.EVALUERING
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringDto.Type.SAMARBEIDSPLAN
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringProdusent.Companion.medTilsvarendeInnhold
import no.nav.lydia.ia.sak.api.plan.erEtter
import no.nav.lydia.ia.sak.api.plan.tilDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseResultatDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.tilResultatDto
import no.nav.lydia.ia.sak.db.PlanRepository
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.integrasjoner.kvittering.KvitteringDto
import no.nav.lydia.tilgangskontroll.fia.NavAnsatt
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.util.UUID

class DokumentPubliseringService(
    val dokumentPubliseringRepository: DokumentPubliseringRepository,
    val spørreundersøkelseService: SpørreundersøkelseService,
    val samarbeidService: IASamarbeidService,
    val dokumentPubliseringProdusent: DokumentPubliseringProdusent,
    val planRepository: PlanRepository,
) {
    val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun hentPubliseringStatus(
        referanseId: UUID,
        type: DokumentPubliseringDto.Type,
    ): PubliseringStatus {
        val dokumentTilPublisering: DokumentPubliseringDto? =
            dokumentPubliseringRepository.hentDokumentTilPublisering(dokumentReferanseId = referanseId, dokumentType = type)
        val kvitterteDokumenter: List<KvittertDokument> = dokumentPubliseringRepository.hentKvitterteDokumenter(referanseId = referanseId, type = type)
        val sistMottattKvittering: KvittertDokument? = kvitterteDokumenter.maxByOrNull { it.kvittertTidspunkt }

        return if (erEnPubliseringIGang(dokumentTilPublisering, sistMottattKvittering)) {
            PubliseringStatus(
                referanseId = referanseId,
                type = type,
                status = DokumentPubliseringDto.Status.OPPRETTET,
                publiseringTidspunkt = null,
            )
        } else {
            PubliseringStatus(
                referanseId = referanseId,
                type = type,
                status = sistMottattKvittering?.status ?: DokumentPubliseringDto.Status.IKKE_PUBLISERT,
                publiseringTidspunkt = sistMottattKvittering?.kvittertTidspunkt,
            )
        }
    }

    private fun erEnPubliseringIGang(
        dokumentTilPublisering: DokumentPubliseringDto?,
        sistMottattKvittering: KvittertDokument?,
    ): Boolean {
        if (dokumentTilPublisering == null) return false
        if (sistMottattKvittering == null) return true

        val sistKvitteringTid = sistMottattKvittering.kvittertTidspunkt
        return dokumentTilPublisering.opprettetTidspunkt.toJavaLocalDateTime()
            .isAfter(sistKvitteringTid.toJavaLocalDateTime())
    }

    fun hentDokumentPublisering(
        dokumentReferanseId: UUID,
        dokumentType: DokumentPubliseringDto.Type,
    ): Either<Feil, DokumentPubliseringDto> =
        try {
            dokumentPubliseringRepository.hentDokumentTilPublisering(dokumentReferanseId = dokumentReferanseId, dokumentType = dokumentType)?.right()
                ?: Feil(
                    feilmelding = "Ingen dokument funnet for referanseId: $dokumentReferanseId og type: $dokumentType",
                    httpStatusCode = HttpStatusCode.NotFound,
                ).left()
        } catch (e: Exception) {
            val melding = "Feil ved henting av en dokument til publisering"
            log.warn("$melding. Feilmelding: '${e.message}'", e)
            Feil(feilmelding = melding, httpStatusCode = HttpStatusCode.InternalServerError).left()
        }

    fun publiserDokument(
        dokumentType: DokumentPubliseringDto.Type,
        dokumentReferanseId: UUID,
        opprettetAv: NavAnsatt,
        navEnhet: NavEnhet,
    ) = when (dokumentType) {
        EVALUERING,
        BEHOVSVURDERING,
        -> publiserSpørreundersøkelse(dokumentReferanseId, dokumentType, opprettetAv, navEnhet)
        SAMARBEIDSPLAN -> publiserSamarbeidsplan(dokumentReferanseId, opprettetAv, navEnhet)
    }

    private fun publiserSamarbeidsplan(
        dokumentReferanseId: UUID,
        opprettetAv: NavAnsatt,
        navEnhet: NavEnhet,
    ): Either<Feil, DokumentPubliseringDto> {
        val driverÅPubliserer = dokumentPubliseringRepository.hentDokumentTilPublisering(
            dokumentReferanseId = dokumentReferanseId,
            dokumentType = SAMARBEIDSPLAN,
        ) != null
        if (driverÅPubliserer) {
            return Feil(feilmelding = "", httpStatusCode = HttpStatusCode.InternalServerError).left()
        }

        val plan = planRepository.hentPlan(dokumentReferanseId) ?: return Feil("", HttpStatusCode.NotFound).left()
        val metadata = dokumentPubliseringRepository.hentDokumentPubliseringMetadata(plan.samarbeidId) ?: return Feil("", HttpStatusCode.NotFound).left()

        val harInnhold = plan.temaer.any { tema -> tema.inkludert && tema.undertemaer.any { it.inkludert } }
        if (!harInnhold) {
            return Feil("Planen med id '$dokumentReferanseId' har ingen innhold", HttpStatusCode.BadRequest).left()
        }

        val sistMottattKvittering = dokumentPubliseringRepository.hentKvitterteDokumenter(
            referanseId = dokumentReferanseId,
            type = SAMARBEIDSPLAN,
        ).maxByOrNull { it.kvittertTidspunkt }

        if (sistMottattKvittering != null) {
            if (!plan.sistEndret.erEtter(sistMottattKvittering.kvittertTidspunkt)) {
                return Feil(
                    feilmelding = "Planen med id '$dokumentReferanseId' har ingen endringer siden sist publisert",
                    httpStatusCode = HttpStatusCode.BadRequest,
                ).left()
            }
        }

        return dokumentPubliseringRepository.opprettDokument(
            referanseId = dokumentReferanseId,
            dokumentType = SAMARBEIDSPLAN,
            opprettetAv = opprettetAv,
        ).onRight { dokumentPubliseringDto ->
            dokumentPubliseringProdusent.sendPåKafka(
                input = dokumentPubliseringDto.medTilsvarendeInnhold(
                    orgnr = metadata.orgnummer,
                    virksomhetsNavn = metadata.virksomhetsNavn,
                    saksnummer = metadata.saksnummer,
                    samarbeidId = metadata.samarbeidId,
                    samarbeidsnavn = metadata.samarbeidsnavn,
                    navEnhet = navEnhet,
                    innhold = plan.tilDto(),
                ),
            )
        }
    }

    private fun publiserSpørreundersøkelse(
        dokumentReferanseId: UUID,
        dokumentType: DokumentPubliseringDto.Type,
        opprettetAv: NavAnsatt,
        navEnhet: NavEnhet,
    ): Either<Feil, DokumentPubliseringDto> {
        if (hentDokumentPublisering(
                dokumentReferanseId = dokumentReferanseId,
                dokumentType = dokumentType,
            ).isRight()
        ) {
            return Feil(
                feilmelding = "Dokument med referanseId: $dokumentReferanseId og type: $dokumentType finnes allerede",
                httpStatusCode = HttpStatusCode.Conflict,
            ).left()
        }

        val spørreundersøkelse = spørreundersøkelseService.hentFullførtSpørreundersøkelse(spørreundersøkelseId = dokumentReferanseId)
            .getOrElse { return it.left() }

        if (!spørreundersøkelse.harMinstEttResultat()) {
            return Feil(
                feilmelding = "Spørreundersøkelse med id: '$dokumentReferanseId' har ingen resultat, og dermed ikke kan lagres som dokument.",
                httpStatusCode = HttpStatusCode.BadRequest,
            ).left()
        }

        val samarbeid: IASamarbeid = samarbeidService.hentSamarbeid(
            saksnummer = spørreundersøkelse.saksnummer,
            samarbeidId = spørreundersøkelse.samarbeidId,
        ).getOrElse {
            return Feil(
                feilmelding = "Samarbeid med id: '${spørreundersøkelse.samarbeidId}' ble ikke funnet",
                httpStatusCode = HttpStatusCode.NotFound,
            ).left()
        }

        return dokumentPubliseringRepository.opprettDokument(
            referanseId = dokumentReferanseId,
            dokumentType = dokumentType,
            opprettetAv = opprettetAv,
        ).onRight { dokumentPubliseringDto ->

            val innhold =
                Json.encodeToJsonElement(
                    spørreundersøkelse.tilResultatDto().tilSpørreundersøkelseInnholdDto(
                        fullførtTidspunkt = spørreundersøkelse.fullførtTidspunkt ?: spørreundersøkelse.endretTidspunkt ?: spørreundersøkelse.opprettetTidspunkt,
                    ),
                ).jsonObject

            dokumentPubliseringProdusent.sendPåKafka(
                input = dokumentPubliseringDto.medTilsvarendeInnhold(
                    orgnr = spørreundersøkelse.orgnummer,
                    virksomhetsNavn = spørreundersøkelse.virksomhetsNavn,
                    saksnummer = samarbeid.saksnummer,
                    samarbeidId = samarbeid.id,
                    samarbeidsnavn = samarbeid.navn,
                    navEnhet = navEnhet,
                    innhold = innhold,
                ),
            )
        }
    }

    private fun SpørreundersøkelseResultatDto.tilSpørreundersøkelseInnholdDto(fullførtTidspunkt: LocalDateTime): SpørreundersøkelseInnholdIDokumentDto =
        SpørreundersøkelseInnholdIDokumentDto(
            id = id,
            fullførtTidspunkt = fullførtTidspunkt,
            spørsmålMedSvarPerTema = spørsmålMedSvarPerTema,
        )

    fun lagreKvittering(kvittering: KvitteringDto) = dokumentPubliseringRepository.lagreKvittering(kvittering)
}
