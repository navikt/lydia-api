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

        // TODO: avklare --> med denne sjekk på status klarer vi ikke å utledde:
        //  antallUnikeDeltakereMedMinstEttSvar og antallUnikeDeltakereSomHarSvartPåAlt
        //   før kartlegging er AVSLUTTET ... men vi har tester som forventer det ???
        val alleSvar = if (kartlegging.status == KartleggingStatus.AVSLUTTET) {
            kartleggingRepository.hentAlleSvar(kartleggingId = kartleggingId)
        } else {
            emptyList()
        }

        val svarPerSesjonId = alleSvar.groupBy { it.sesjonId }
        val antallUnikeDeltakereMedMinstEttSvar = svarPerSesjonId.size
        val harNokDeltakere = antallUnikeDeltakereMedMinstEttSvar >= MINIMUM_ANTALL_DELTAKERE

        val spørsmålMedSvarPerTema: Map<Temanavn, List<SpørsmålMedSvar>> =
            kartlegging.temaMedSpørsmålOgSvaralternativer.map { temaMedSpørsmålOgSvaralternativer ->
                temaMedSpørsmålOgSvaralternativer.tema.navn to
                        temaMedSpørsmålOgSvaralternativer.spørsmålOgSvaralternativer.map { spørsmål ->
                    SpørsmålMedSvar(
                        spørsmålId = spørsmål.spørsmålId.toString(),
                        tekst = spørsmål.spørsmåltekst,
                        svarListe = spørsmål.svaralternativer.map { svar ->
                            Svar(
                                svarId = svar.svarId.toString(),
                                tekst = svar.svartekst,
                                // TODO: refaktorer til noe bedre:tm
                                antallSvar = (if(harNokDeltakere) alleSvar else emptyList()).filter {
                                    it.spørsmålId == spørsmål.spørsmålId.toString() &&
                                            it.svarId == svar.svarId.toString()
                                }.size
                            )
                        }
                    )
                }
            }.toMap()

        val temaerMedSpørsmålOgSvar = spørsmålMedSvarPerTema.map { TemaMedSpørsmålOgSvar(
            tema = it.key.name,
            spørsmålMedSvar = it.value
        ) }

        return KartleggingMedSvar(
            kartleggingId = kartlegging.kartleggingId.toString(),
            antallUnikeDeltakereMedMinstEttSvar = antallUnikeDeltakereMedMinstEttSvar,
            antallUnikeDeltakereSomHarSvartPåAlt = 0,
            spørsmålMedSvarPerTema = temaerMedSpørsmålOgSvar
        ).right()
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
}
