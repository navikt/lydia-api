package no.nav.lydia.ia.sak

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import no.nav.lydia.appstatus.Metrics
import java.time.LocalDateTime
import java.util.*
import no.nav.lydia.ia.eksport.SpørreundersøkelseOppdateringProdusent
import no.nav.lydia.ia.eksport.SpørreundersøkelseProdusent
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.spørreundersøkelse.IASakKartleggingError
import no.nav.lydia.ia.sak.db.SpørreundersøkelseRepository
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseUtenInnhold
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.KartleggingStatus
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørsmål
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørsmålResultatDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SvarResultatDto
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Svaralternativ
import no.nav.lydia.ia.sak.api.spørreundersøkelse.TemaResultatDto
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Tema
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Temanavn
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseResultatDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseSvarDto
import no.nav.lydia.integrasjoner.kartlegging.StengTema
import no.nav.lydia.tilgangskontroll.NavAnsatt
import org.slf4j.Logger
import org.slf4j.LoggerFactory

const val MINIMUM_ANTALL_DELTAKERE = 3

class SpørreundersøkelseService(
    val spørreundersøkelseRepository: SpørreundersøkelseRepository,
    private val spørreundersøkelseProdusent: SpørreundersøkelseProdusent,
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
            if (spørreundersøkelse.status != KartleggingStatus.PÅBEGYNT) {
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
                spørsmålId = UUID.fromString(svar.spørsmålId)
            )
            spørreundersøkelseOppdateringProdusent.sendPåKafka(
                SpørreundersøkelseOppdateringProdusent.AntallSvar(
                    spørreundersøkelseId = spørreundersøkelse.id.toString(),
                    antallSvar = antallSvarPåSpørsmål
                )
            )

            log.info("Lagret svar for kartlegging med id: '${svar.spørreundersøkelseId}'")
        }
    }

    fun hentSpørreundersøkelseResultat(spørreundersøkelseId: String): Either<Feil, SpørreundersøkelseResultatDto> {
        val spørreundersøkelse =
            spørreundersøkelseRepository.hentSpørreundersøkelse(spørreundersøkelseId = spørreundersøkelseId)
                ?: return IASakKartleggingError.`ugyldig kartleggingId`.left()

        if (spørreundersøkelse.status != KartleggingStatus.AVSLUTTET)
            return IASakKartleggingError.`kartlegging er ikke avsluttet`.left()

        val (alleSvar, antallUnikeDeltakereMedMinstEttSvar, antallUnikeDeltakereSomHarSvartPåAlt) = spørreundersøkelse.beregnAlleSvar()

        val spørsmålMedSvarPerTema: List<TemaResultatDto> =
            spørreundersøkelse.tema.map { svarTilTema(alleSvar, it) }

        return SpørreundersøkelseResultatDto(
            kartleggingId = spørreundersøkelse.id.toString(),
            antallUnikeDeltakereMedMinstEttSvar = antallUnikeDeltakereMedMinstEttSvar,
            antallUnikeDeltakereSomHarSvartPåAlt = antallUnikeDeltakereSomHarSvartPåAlt,
            spørsmålMedSvarPerTema = spørsmålMedSvarPerTema
        ).right()
    }

    private fun svarTilTema(
        alleSvar: List<SpørreundersøkelseSvarDto>,
        tema: Tema,
    ) =
        TemaResultatDto(
            temaId = tema.tema.id,
            tema = tema.tema.navn.name,
            beskrivelse = tema.tema.beskrivelse,
            spørsmålMedSvar = tema.spørsmål.map { spørsmål ->
                SpørsmålResultatDto(
                    spørsmålId = spørsmål.spørsmålId.toString(),
                    tekst = spørsmål.spørsmåltekst,
                    flervalg = spørsmål.flervalg,
                    svarListe = spørsmål.svaralternativer.map { svar ->
                        SvarResultatDto(
                            svarId = svar.svarId.toString(),
                            tekst = svar.svartekst,
                            antallSvar = filtrerVekkSvarMedForFåBesvarelser(alleSvar).filter {
                                it.spørsmålId == spørsmål.spørsmålId.toString() &&
                                        it.svarIder.contains(svar.svarId.toString())
                            }.size
                        )
                    }
                )
            }
        )

    private fun filtrerVekkSvarMedForFåBesvarelser(alleSvar: List<SpørreundersøkelseSvarDto>): List<SpørreundersøkelseSvarDto> {
        val spørsmålMedNokSvar = alleSvar.groupBy { it.spørsmålId }
            .filter { it.value.size >= MINIMUM_ANTALL_DELTAKERE }
            .map { it.key }
        return alleSvar.filter { it.spørsmålId in spørsmålMedNokSvar }
    }

    private fun Spørreundersøkelse.beregnAlleSvar(): Triple<List<SpørreundersøkelseSvarDto>, Int, Int> {
        val alleSvar: List<SpørreundersøkelseSvarDto> =
            spørreundersøkelseRepository.hentAlleSvar(spørreundersøkelseId = this.id.toString())
        val svarPerSesjonId: Map<String, List<SpørreundersøkelseSvarDto>> =
            alleSvar.filter { it.svarIder.isNotEmpty() }.groupBy { it.sesjonId }
        val antallUnikeDeltakereMedMinstEttSvar = svarPerSesjonId.size
        val antallSpørsmål = this.tema.sumOf { spørsmålForTema ->
            spørsmålForTema.spørsmål.size
        }
        val antallUnikeDeltakereSomHarSvartPåAlt = svarPerSesjonId.filter {
            it.value.size == antallSpørsmål
        }.size
        return Triple(alleSvar, antallUnikeDeltakereMedMinstEttSvar, antallUnikeDeltakereSomHarSvartPåAlt)
    }

    fun opprettSpørreundersøkelse(
        orgnummer: String,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
        saksnummer: String,
        temaNavn: List<Temanavn>,
    ) = spørreundersøkelseRepository.opprettSpørreundersøkelse(
        orgnummer = orgnummer,
        saksnummer = saksnummer,
        saksbehandler = saksbehandler,
        spørreundersøkelseId = UUID.randomUUID(),
        vertId = UUID.randomUUID(),
        temaer = temaNavn.map {
            spørreundersøkelseRepository.hentTema(it)
        },
    ).onRight {
        spørreundersøkelseProdusent.sendPåKafka(it)
        Metrics.loggBehovsvurdering(it.status)
    }

    fun slettKartlegging(kartleggingId: String): Either<Feil, Spørreundersøkelse> {
        val kartlegging = spørreundersøkelseRepository.hentSpørreundersøkelse(kartleggingId)
            ?: return IASakKartleggingError.`ugyldig kartleggingId`.left()

        spørreundersøkelseRepository.slettSpørreundersøkelse(spørreundersøkelseId = kartleggingId)

        val oppdatertKartlegging =
            kartlegging.copy(status = KartleggingStatus.SLETTET, endretTidspunkt = LocalDateTime.now())
        spørreundersøkelseProdusent.sendPåKafka(oppdatertKartlegging)
        Metrics.loggBehovsvurdering(oppdatertKartlegging.status)

        return oppdatertKartlegging.right()
    }

    fun hentKartlegginger(
        saksnummer: String,
    ): Either<Feil, List<SpørreundersøkelseUtenInnhold>> {
        return try {
            val kartlegginger = spørreundersøkelseRepository.hentSpørreundersøkelser(saksnummer = saksnummer)
            //TODO: legg til deltakereSomHarFullført
            kartlegginger.right()
        } catch (e: Exception) {
            log.error("Noe gikk feil ved henting av kartlegging: ${e.message}", e)
            IASakKartleggingError.`generell feil under uthenting`.left()
        }
    }

    fun endreKartleggingStatus(
        spørreundersøkelseId: String,
        status: KartleggingStatus,
    ): Either<Feil, Spørreundersøkelse> {
        spørreundersøkelseRepository.hentSpørreundersøkelse(spørreundersøkelseId)
            ?: return IASakKartleggingError.`ugyldig kartleggingId`.left()
        val oppdatertKartlegging = spørreundersøkelseRepository.endreKartleggingStatus(
            spørreundersøkelseId = spørreundersøkelseId,
            status = status
        )
            ?: return IASakKartleggingError.`feil under oppdatering`.left()

        spørreundersøkelseProdusent.sendPåKafka(oppdatertKartlegging)
        Metrics.loggBehovsvurdering(oppdatertKartlegging.status)

        return oppdatertKartlegging.right()
    }

    fun stengTema(hendelse: StengTema) {
        log.info("Mottok stenging av tema: ${hendelse.temaId} i spørreundersøkelse ${hendelse.spørreundersøkelseId}")
        spørreundersøkelseRepository.stengTema(
            spørreundersøkelseId = hendelse.spørreundersøkelseId,
            temaId = hendelse.temaId
        )
        sendResultaterForTemaPåKafka(
            spørreundersøkelseId = UUID.fromString(hendelse.spørreundersøkelseId),
            temaId = hendelse.temaId
        )
    }

    private fun sendResultaterForTemaPåKafka(
        spørreundersøkelseId: UUID,
        temaId: Int,
    ) = spørreundersøkelseOppdateringProdusent.sendPåKafka(
        SpørreundersøkelseOppdateringProdusent.ResultaterForTema(
            spørreundersøkelseId = spørreundersøkelseId.toString(),
            resultaterForTema = hentSvarForTema(
                spørreundersøkelseId = spørreundersøkelseId,
                temaId = temaId
            )
        )
    )

    private fun hentSvarForTema(
        spørreundersøkelseId: UUID,
        temaId: Int,
    ): TemaResultatDto {
        val temaMedSpørsmålOgSvaralternativer = spørreundersøkelseRepository.hentTema(
            spørreundersøkelseId = spørreundersøkelseId
        ).first {
            it.tema.id == temaId
        }
        val svarITema = spørreundersøkelseRepository.hentSvarForTema(
            spørreundersøkelseId = spørreundersøkelseId,
            temaId = temaId
        )

        return svarTilTema(
            alleSvar = svarITema,
            tema = temaMedSpørsmålOgSvaralternativer
        )
    }

    private fun Spørreundersøkelse.finnSpørsmål(spørsmålId: UUID): Spørsmål? {
        return tema
            .flatMap { it.spørsmål }
            .firstOrNull { it.spørsmålId == spørsmålId }
    }
}
