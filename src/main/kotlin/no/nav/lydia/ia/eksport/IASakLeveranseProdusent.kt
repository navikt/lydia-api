package no.nav.lydia.ia.eksport

import arrow.core.getOrElse
import kotlinx.datetime.LocalDate
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.Observer
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.domene.IASakLeveranse
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.tilgangskontroll.fia.Rolle

class IASakLeveranseProdusent(
    kafka: Kafka,
    topic: Topic = Topic.IA_SAK_LEVERANSE_TOPIC,
    private val azureService: AzureService,
) : KafkaProdusent<IASakLeveranse>(kafka, topic),
    Observer<IASakLeveranse> {
    override fun receive(input: IASakLeveranse) = sendPåKafka(input = input)

    override fun tilKafkaMelding(input: IASakLeveranse): Pair<String, String> {
        val navEnhet = azureService.hentNavenhetFraNavIdent(input.sistEndretAv)

        val nøkkel = input.id.toString()
        val verdi = IASakLeveranseValue(
            id = input.id,
            saksnummer = input.saksnummer,
            iaTjenesteId = input.modul.iaTjeneste.id,
            iaTjenesteNavn = input.modul.iaTjeneste.navn,
            iaModulId = input.modul.id,
            iaModulNavn = input.modul.navn,
            frist = input.frist.toKotlinLocalDate(),
            status = input.status,
            opprettetAv = input.opprettetAv,
            sistEndret = input.sistEndret.toKotlinLocalDateTime(),
            sistEndretAv = input.sistEndretAv,
            sistEndretAvRolle = input.sistEndretAvRolle,
            fullført = input.fullført?.toKotlinLocalDateTime(),
            enhetsnummer = navEnhet.map { it.enhetsnummer }.getOrElse { "Ukjent" },
            enhetsnavn = navEnhet.map { it.enhetsnavn }.getOrElse { "Ukjent" },
            opprettetTidspunkt = input.opprettetTidspunkt?.toKotlinLocalDateTime(),
        )
        return nøkkel to Json.encodeToString(verdi)
    }

    @Serializable
    data class IASakLeveranseValue(
        val id: Int,
        val saksnummer: String,
        val iaTjenesteId: Int,
        val iaTjenesteNavn: String,
        val iaModulId: Int,
        val iaModulNavn: String,
        val frist: LocalDate,
        val status: IASakLeveranseStatus,
        val opprettetAv: String,
        val sistEndret: LocalDateTime,
        val sistEndretAv: String,
        val sistEndretAvRolle: Rolle?,
        val fullført: LocalDateTime?,
        val enhetsnummer: String,
        val enhetsnavn: String,
        val opprettetTidspunkt: LocalDateTime?,
    )
}
