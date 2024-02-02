package no.nav.lydia.integrasjoner.kartlegging

import arrow.core.Either
import arrow.core.left
import arrow.core.right
import no.nav.lydia.ia.eksport.SpørreundersøkelseProdusent
import no.nav.lydia.ia.sak.api.Feil
import no.nav.lydia.ia.sak.api.kartlegging.IASakKartleggingError
import no.nav.lydia.ia.sak.domene.IASakKartlegging
import no.nav.lydia.tilgangskontroll.NavAnsatt
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.util.UUID

class KartleggingService(
    val kartleggingRepository: KartleggingRepository,
    private val spørreundersøkelseProdusent: SpørreundersøkelseProdusent,
) {
    private val log: Logger = LoggerFactory.getLogger(this.javaClass)

    fun lagreSvar(karleggingSvarDtoListe: List<SpørreundersøkelseSvarDto>) {
        karleggingSvarDtoListe.forEach {
            val kartlegging = kartleggingRepository.hentKartleggingEtterId(it.spørreundersøkelseId)

            if (kartlegging == null) {
                log.error("Fant ikke kartlegging på denne iden: ${it.spørreundersøkelseId}, hopper over")
                return@forEach
            }

            kartleggingRepository.lagreSvar(it)
            log.info("Lagret svar for kartlegging med id: '${it.spørreundersøkelseId}'")
        }
    }

    fun hentKartleggingMedSvar(kartleggingId: String): Either<Feil, KartleggingMedSvar> {
        val kartlegging = kartleggingRepository.hentKartleggingEtterId(kartleggingId = kartleggingId)
            ?: return IASakKartleggingError.`ugyldig kartleggingId`.left()
        val alleSvar = kartleggingRepository.hentAlleSvar(kartleggingId = kartleggingId)

        return KartleggingMedSvar(kartlegging, alleSvar).right()
    }

    fun opprettKartlegging(
        orgnummer: String,
        saksbehandler: NavAnsatt.NavAnsattMedSaksbehandlerRolle,
        saksnummer: String,
        spørsmål: List<UUID>,
    ): Either<Feil, IASakKartlegging> =
        kartleggingRepository.opprettKartlegging(
            orgnummer = orgnummer,
            saksnummer = saksnummer,
            saksbehandler = saksbehandler,
            kartleggingId = UUID.randomUUID(),
            spørsmålIDer = spørsmål,
        ).onRight { spørreundersøkelseProdusent.sendPåKafka(it) }

    fun hentKartlegginger(
        saksnummer: String,
    ): Either<Feil, List<IASakKartlegging>> {
        return try {
            val kartlegginger = kartleggingRepository.hentKartlegginger(saksnummer = saksnummer)
            kartlegginger.right()
        } catch (e: Exception) {
            log.error("Noe gikk feil ved henting av kartlegging: ${e.message}", e)
            IASakKartleggingError.`generell feil under uthenting`.left()
        }
    }

    fun hentAlleSpørsmål() = kartleggingRepository.hentAlleSpørsmålIDer()

    fun avsluttKartlegging(kartleggingId: String): Either<Feil, IASakKartlegging> {
        kartleggingRepository.hentKartleggingEtterId(kartleggingId)
            ?: return IASakKartleggingError.`ugyldig kartleggingId`.left()
        val avsluttetKartlegging = kartleggingRepository.avsluttKartlegging(kartleggingId = kartleggingId)
            ?: return IASakKartleggingError.`feil under oppdatering`.left()

        spørreundersøkelseProdusent.sendPåKafka(avsluttetKartlegging)

        return avsluttetKartlegging.right()
    }
}
