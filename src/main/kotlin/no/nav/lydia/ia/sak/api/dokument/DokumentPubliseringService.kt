package no.nav.lydia.ia.sak.api.dokument

import arrow.core.Either
import arrow.core.getOrElse
import arrow.core.left
import arrow.core.right
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.encodeToJsonElement
import kotlinx.serialization.json.jsonObject
import no.nav.lydia.ia.sak.IASamarbeidService
import no.nav.lydia.ia.sak.SpørreundersøkelseService
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering.Status.OPPRETTET
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering.Type.BEHOVSVURDERING
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering.Type.EVALUERING
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering.Type.SAMARBEIDSPLAN
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringProdusent.Companion.medTilsvarendeInnhold
import no.nav.lydia.ia.sak.api.plan.tilDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseResultatDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.tilResultatDto
import no.nav.lydia.ia.sak.db.PlanRepository
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
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

    fun hentDokumentPublisering(
        dokumentReferanseId: UUID,
        dokumentType: DokumentPublisering.Type,
    ): Either<Feil, DokumentPubliseringDto> =
        try {
            val liste = dokumentPubliseringRepository.hentDokument(dokumentReferanseId = dokumentReferanseId, dokumentType = dokumentType)
            liste.firstOrNull()?.right() ?: Feil(
                feilmelding = "Ingen dokument funnet for referanseId: $dokumentReferanseId og type: $dokumentType",
                httpStatusCode = HttpStatusCode.NotFound,
            ).left()
        } catch (e: Exception) {
            val melding = "Feil ved henting av en dokument til publisering"
            log.warn("$melding. Feilmelding: '${e.message}'", e)
            Feil(feilmelding = melding, httpStatusCode = HttpStatusCode.InternalServerError).left()
        }

    fun publiserDokument(
        dokumentType: DokumentPublisering.Type,
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
        val listeAvTidligerePubliseringer = dokumentPubliseringRepository.hentDokument(dokumentReferanseId = dokumentReferanseId, dokumentType = SAMARBEIDSPLAN)
        val driverÅPubliserer = listeAvTidligerePubliseringer.any { it.status == OPPRETTET }
        if (driverÅPubliserer) {
            return Feil(feilmelding = "", httpStatusCode = HttpStatusCode.InternalServerError).left()
        }

        val plan = planRepository.hentPlan(dokumentReferanseId) ?: return Feil("", HttpStatusCode.NotFound).left()
        val metadata = dokumentPubliseringRepository.hentDokumentPubliseringMetadata(plan.samarbeidId) ?: return Feil("", HttpStatusCode.NotFound).left()

        return dokumentPubliseringRepository.opprettDokument(
            samarbeidId = plan.samarbeidId,
            referanseId = dokumentReferanseId,
            SAMARBEIDSPLAN,
            opprettetAv,
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
        dokumentType: DokumentPublisering.Type,
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

        if (spørreundersøkelse.type != Spørreundersøkelse.Type.Behovsvurdering) {
            return Feil(
                feilmelding = "Spørreundersøkelse med id: $dokumentReferanseId er ikke av type ${dokumentType.name}",
                httpStatusCode = HttpStatusCode.BadRequest,
            ).left()
        }

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
            samarbeidId = samarbeid.id,
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
