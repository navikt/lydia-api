package no.nav.lydia.ia.eksport

import kotlinx.datetime.LocalDate
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Observer
import no.nav.lydia.ia.sak.domene.IASakLeveranse
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus
import no.nav.lydia.ia.sak.domene.Modul
import no.nav.lydia.tilgangskontroll.Rådgiver.Rolle

class IASakLeveranseProdusent(
    private val produsent: KafkaProdusent,
    private val topic: String,
) : Observer<IASakLeveranse> {

    override fun receive(input: IASakLeveranse) {
        val kafkaMelding = input.tilKafkaMelding()
        produsent.sendMelding(topic, kafkaMelding.first, kafkaMelding.second)
    }

    companion object {
        fun IASakLeveranse.tilKafkaMelding(
        ): Pair<String, String> {
            val key = this.id.toString()
            val value = IASakLeveranseValue(
                id = this.id,
                saksnummer = this.saksnummer,
                modul = this.modul,
                frist = this.frist.toKotlinLocalDate(),
                status = this.status,
                opprettetAv = this.opprettetAv,
                sistEndret = this.sistEndret.toKotlinLocalDateTime(),
                sistEndretAv = this.sistEndretAv,
                sistEndretAvRolle = this.sistEndretAvRolle,
                fullført = this.fullført?.toKotlinLocalDateTime(),
            )
            return key to Json.encodeToString(value)

        }
    }

    @Serializable
    data class IASakLeveranseValue(
        val id: Int,
        val saksnummer: String,
        val modul: Modul,
        val frist: LocalDate,
        val status: IASakLeveranseStatus,
        val opprettetAv: String,
        val sistEndret: LocalDateTime,
        val sistEndretAv: String,
        val sistEndretAvRolle: Rolle?,
        val fullført: LocalDateTime?
    )
}
