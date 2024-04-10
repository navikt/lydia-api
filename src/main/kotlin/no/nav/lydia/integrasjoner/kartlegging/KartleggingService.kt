package no.nav.lydia.integrasjoner.kartlegging

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import java.time.LocalDateTime
import java.util.UUID
import no.nav.lydia.ia.eksport.SpørreundersøkelseAntallSvarProdusent
import no.nav.lydia.ia.eksport.SpørreundersøkelseProdusent
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.kartlegging.IASakKartleggingError
import no.nav.lydia.ia.sak.domene.IASakKartlegging
import no.nav.lydia.ia.sak.domene.IASakKartleggingOversikt
import no.nav.lydia.ia.sak.domene.KartleggingStatus
import no.nav.lydia.ia.sak.domene.SpørsmålOgSvaralternativer
import no.nav.lydia.ia.sak.domene.Svaralternativ
import no.nav.lydia.ia.sak.domene.TemaMedSpørsmålOgSvar
import no.nav.lydia.ia.sak.domene.Temanavn
import no.nav.lydia.tilgangskontroll.NavAnsatt
import org.slf4j.Logger
import org.slf4j.LoggerFactory

const val MINIMUM_ANTALL_DELTAKERE = 3

class KartleggingService(
    val kartleggingRepository: KartleggingRepository,
    private val spørreundersøkelseProdusent: SpørreundersøkelseProdusent,
    private val spørreundersøkelseAntallSvarProdusent: SpørreundersøkelseAntallSvarProdusent,
) {
    private val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun lagreSvar(karleggingSvarDtoListe: List<SpørreundersøkelseSvarDto>) {
        karleggingSvarDtoListe.forEach { svar ->
            val kartlegging = kartleggingRepository.hentKartleggingEtterId(svar.spørreundersøkelseId)

            if (kartlegging == null) {
                log.error("Fant ikke kartlegging på denne iden: ${svar.spørreundersøkelseId}, hopper over")
                return@forEach
            }
            if (kartlegging.status != KartleggingStatus.PÅBEGYNT) {
                log.warn("Kan ikke svare på en kartlegging i status ${kartlegging.status}, hopper over")
                return@forEach
            }

            val spørsmål = kartlegging.finnSpørsmål(UUID.fromString(svar.spørsmålId))
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

            kartleggingRepository.lagreSvar(svar)
            val antallSvarPåSpørsmål = kartleggingRepository.hentAntallSvar(
                kartleggingId = kartlegging.kartleggingId,
                spørsmålId = UUID.fromString(svar.spørsmålId)
            )
            spørreundersøkelseAntallSvarProdusent.sendPåKafka(antallSvarPåSpørsmål)

            log.info("Lagret svar for kartlegging med id: '${svar.spørreundersøkelseId}'")
        }
    }

    fun hentKartleggingMedSvar(kartleggingId: String): Either<Feil, KartleggingMedSvar> {
        val kartlegging = kartleggingRepository.hentKartleggingEtterId(kartleggingId = kartleggingId)
            ?: return IASakKartleggingError.`ugyldig kartleggingId`.left()

        if (kartlegging.status != KartleggingStatus.AVSLUTTET)
            return IASakKartleggingError.`kartlegging er ikke avsluttet`.left()

        val (alleSvar, antallUnikeDeltakereMedMinstEttSvar, antallUnikeDeltakereSomHarSvartPåAlt) = beregnAlleSvar(
            kartleggingId,
            kartlegging
        )

        val spørsmålMedSvarPerTema: List<TemaMedSpørsmålOgSvar> =
            kartlegging.temaMedSpørsmålOgSvaralternativer.map { temaMedSpørsmålOgSvaralternativer ->
                TemaMedSpørsmålOgSvar (
                    tema = temaMedSpørsmålOgSvaralternativer.tema.navn.name,
                    beskrivelse = temaMedSpørsmålOgSvaralternativer.tema.beskrivelse,
                    spørsmålMedSvar = temaMedSpørsmålOgSvaralternativer.spørsmålOgSvaralternativer.map { spørsmål ->
                        SpørsmålMedSvar(
                            spørsmålId = spørsmål.spørsmålId.toString(),
                            tekst = spørsmål.spørsmåltekst,
                            flervalg = spørsmål.flervalg,
                            svarListe = spørsmål.svaralternativer.map { svar ->
                                Svar(
                                    svarId = svar.svarId.toString(),
                                    tekst = svar.svartekst,
                                    antallSvar = filtrerVekkSvarMedForFåBesvarelser(alleSvar).filter {
                                        it.spørsmålId == spørsmål.spørsmålId.toString() &&
                                                it.svarIder.contains( svar.svarId.toString() )
                                    }.size
                                )
                            }
                        )
                    }
                )
            }

        return KartleggingMedSvar(
            kartleggingId = kartlegging.kartleggingId.toString(),
            antallUnikeDeltakereMedMinstEttSvar = antallUnikeDeltakereMedMinstEttSvar,
            antallUnikeDeltakereSomHarSvartPåAlt = antallUnikeDeltakereSomHarSvartPåAlt,
            spørsmålMedSvarPerTema = spørsmålMedSvarPerTema
        ).right()
    }

    fun filtrerVekkSvarMedForFåBesvarelser(alleSvar: List<SpørreundersøkelseSvarDto>): List<SpørreundersøkelseSvarDto> {
        val spørsmålMedNokSvar = alleSvar.groupBy { it.spørsmålId }
            .filter { it.value.size >= MINIMUM_ANTALL_DELTAKERE }
            .map { it.key }
        return alleSvar.filter { it.spørsmålId in spørsmålMedNokSvar }
    }

    fun hentKartleggingOversiktMedAntallSvar(kartleggingId: String): Either<Feil, KartleggingOversiktMedAntallSvar> {
        val kartlegging = kartleggingRepository.hentKartleggingEtterId(kartleggingId = kartleggingId)
            ?: return IASakKartleggingError.`ugyldig kartleggingId`.left()

        val (alleSvar, antallUnikeDeltakereMedMinstEttSvar, antallUnikeDeltakereSomHarSvartPåAlt) = beregnAlleSvar(
            kartleggingId,
            kartlegging
        )

        return KartleggingOversiktMedAntallSvar(
            kartleggingId = kartlegging.kartleggingId,
            antallUnikeDeltakereMedMinstEttSvar = antallUnikeDeltakereMedMinstEttSvar,
            antallUnikeDeltakereSomHarSvartPåAlt = antallUnikeDeltakereSomHarSvartPåAlt,
            spørsmålMedAntallSvarPerTema = kartlegging.temaMedSpørsmålOgSvaralternativer.map { temaMedSpørsmålOgSvaralternativer ->
                val alleSpørsmålIderITema =
                    kartlegging.temaMedSpørsmålOgSvaralternativer
                        .filter { it.tema.id == temaMedSpørsmålOgSvaralternativer.tema.id }
                        .first().spørsmålOgSvaralternativer
                        .map { it.spørsmålId.toString() }
                val alleSvarITema : List<SpørreundersøkelseSvarDto> = alleSvar.filter { it.spørsmålId in alleSpørsmålIderITema }
                val antallUnikeDeltakereMedMinstEttSvarITema = alleSvarITema.groupBy { it.sesjonId }.size
                val antallUnikeDeltakereSomHarSvartPåAltITema = alleSvarITema.groupBy { it.sesjonId }.filter { it.value.size == alleSpørsmålIderITema.size }.size

                TemaMedAntallSvar(
                    tema = temaMedSpørsmålOgSvaralternativer.tema,
                    antallSpørsmål = temaMedSpørsmålOgSvaralternativer.spørsmålOgSvaralternativer.size,
                    antallUnikeDeltakereMedMinstEttSvar = antallUnikeDeltakereMedMinstEttSvarITema,
                    antallUnikeDeltakereSomHarSvartPåAlt = antallUnikeDeltakereSomHarSvartPåAltITema,
                    status = temaMedSpørsmålOgSvaralternativer.tema.status
                )
            }
        ).right()
    }

    private fun beregnAlleSvar(
        kartleggingId: String,
        kartlegging: IASakKartlegging
    ): Triple<List<SpørreundersøkelseSvarDto>, Int, Int> {
        val alleSvar: List<SpørreundersøkelseSvarDto> = kartleggingRepository.hentAlleSvar(kartleggingId = kartleggingId)
        val svarPerSesjonId: Map<String, List<SpørreundersøkelseSvarDto>> = alleSvar.filter { it.svarIder.isNotEmpty() }.groupBy { it.sesjonId }
        val antallUnikeDeltakereMedMinstEttSvar = svarPerSesjonId.size
        val antallSpørsmål = kartlegging.temaMedSpørsmålOgSvaralternativer.sumOf { spørsmålForTema ->
            spørsmålForTema.spørsmålOgSvaralternativer.size
        }
        val antallUnikeDeltakereSomHarSvartPåAlt = svarPerSesjonId.filter {
            it.value.size == antallSpørsmål
        }.size
        return Triple(alleSvar, antallUnikeDeltakereMedMinstEttSvar, antallUnikeDeltakereSomHarSvartPåAlt)
    }

    fun opprettKartlegging(
        orgnummer: String,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
        saksnummer: String,
        temaNavn: List<Temanavn>,
    ) = kartleggingRepository.opprettKartlegging(
            orgnummer = orgnummer,
            saksnummer = saksnummer,
            saksbehandler = saksbehandler,
            kartlegging = UUID.randomUUID(),
            vertId = UUID.randomUUID(),
            temaer = temaNavn.map {
                kartleggingRepository.hentTema(it)
            },
        ).onRight { spørreundersøkelseProdusent.sendPåKafka(it) }

    fun slettKartlegging(kartleggingId: String): Either<Feil, IASakKartlegging> {
        val kartlegging = kartleggingRepository.hentKartleggingEtterId(kartleggingId)
            ?: return IASakKartleggingError.`ugyldig kartleggingId`.left()

        kartleggingRepository.slettKartlegging(kartleggingId = kartleggingId,)

        val oppdatertKartlegging = kartlegging.copy(status = KartleggingStatus.SLETTET, endretTidspunkt = LocalDateTime.now())
        spørreundersøkelseProdusent.sendPåKafka(oppdatertKartlegging)

        return oppdatertKartlegging.right()
    }

    fun hentKartlegginger(
        saksnummer: String,
    ): Either<Feil, List<IASakKartleggingOversikt>> {
        return try {
            val kartlegginger = kartleggingRepository.hentKartlegginger(saksnummer = saksnummer)
            kartlegginger.right()
        } catch (e: Exception) {
            log.error("Noe gikk feil ved henting av kartlegging: ${e.message}", e)
            IASakKartleggingError.`generell feil under uthenting`.left()
        }
    }

    fun endreKartleggingStatus(kartleggingId: String, status: KartleggingStatus): Either<Feil, IASakKartlegging> {
        kartleggingRepository.hentKartleggingEtterId(kartleggingId)
            ?: return IASakKartleggingError.`ugyldig kartleggingId`.left()
        val oppdatertKartlegging = kartleggingRepository.endreKartleggingStatus(
            kartleggingId = kartleggingId,
            status = status
        )
            ?: return IASakKartleggingError.`feil under oppdatering`.left()

        spørreundersøkelseProdusent.sendPåKafka(oppdatertKartlegging)

        return oppdatertKartlegging.right()
    }


    private fun IASakKartlegging.finnSpørsmål(spørsmålId: UUID): SpørsmålOgSvaralternativer? {
        return temaMedSpørsmålOgSvaralternativer
            .flatMap { it.spørsmålOgSvaralternativer }
            .firstOrNull { it.spørsmålId == spørsmålId }
    }
}
