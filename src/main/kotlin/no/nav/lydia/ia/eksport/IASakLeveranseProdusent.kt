package no.nav.lydia.ia.eksport

import arrow.core.getOrElse
import kotlinx.datetime.LocalDate
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Observer
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.domene.IASakLeveranse
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.tilgangskontroll.Rolle

class IASakLeveranseProdusent(
    private val produsent: KafkaProdusent,
    private val azureService: AzureService,
) : Observer<IASakLeveranse> {

    override fun receive(input: IASakLeveranse) {
        val kafkaMelding = input.tilKafkaMelding()
        produsent.sendMelding(Topic.IA_SAK_LEVERANSE_TOPIC.navn, kafkaMelding.first, kafkaMelding.second)
    }

    private fun IASakLeveranse.tilKafkaMelding(
    ): Pair<String, String> {
        val key = this.id.toString()
        val navEnhet = azureService.hentNavenhetFraNavIdent(sistEndretAv)
        val enhetsnummer = navEnhet.map { it.enhetsnummer }.getOrElse { "Ukjent" }
        val enhetsnavn = navEnhet.map { it.enhetsnavn }.getOrElse { "Ukjent" }
        val value = IASakLeveranseValue(
            id = this.id,
            saksnummer = this.saksnummer,
            iaTjenesteId = this.modul.iaTjeneste.id,
            iaTjenesteNavn = this.modul.iaTjeneste.navn,
            iaModulId = this.modul.id,
            iaModulNavn = this.modul.navn,
            frist = this.frist.toKotlinLocalDate(),
            status = this.status,
            opprettetAv = this.opprettetAv,
            sistEndret = this.sistEndret.toKotlinLocalDateTime(),
            sistEndretAv = this.sistEndretAv,
            sistEndretAvRolle = this.sistEndretAvRolle,
            fullført = this.fullført?.toKotlinLocalDateTime(),
            enhetsnummer = enhetsnummer,
            enhetsnavn = enhetsnavn,
            opprettetTidspunkt = this.opprettetTidspunkt?.toKotlinLocalDateTime()
        )
        return key to Json.encodeToString(value)

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
        val opprettetTidspunkt: LocalDateTime?
    )
}
