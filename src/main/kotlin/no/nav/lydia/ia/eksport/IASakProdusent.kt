package no.nav.lydia.ia.eksport

import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Observer
import no.nav.lydia.ia.sak.api.LocalDateTimeSerializer
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASak
import java.time.LocalDateTime

class IASakProdusent(private val produsent: KafkaProdusent, private val topic: String) : Observer<IASak> {

    override fun receive(input: IASak) {
        val kafkaMelding = input.tilKafkaMelding()
        produsent.sendMelding(topic, kafkaMelding.first, kafkaMelding.second)
    }

    companion object {
        fun IASak.tilKafkaMelding(): Pair<String, String> {
            val key = this.saksnummer
            val value = IASakValue(
                saksnummer = this.saksnummer,
                orgnr = this.orgnr,
                kontaktperson = this.eidAv ?: this.endretAv ?: this.opprettetAv,
                endretAvHendelseId = this.endretAvHendelseId,
                status = this.status,
                opprettetTidspunkt = this.opprettetTidspunkt,
                endretTidspunkt = this.endretTidspunkt ?: this.opprettetTidspunkt,
            )
            return key to Json.encodeToString(value)

        }
    }

    @Serializable
    private data class IASakValue(
        val saksnummer: String,
        val orgnr: String,
        val kontaktperson: String,
        val endretAvHendelseId: String,
        val status: IAProsessStatus,
        @Serializable(with = LocalDateTimeSerializer::class)
        val opprettetTidspunkt: LocalDateTime,
        @Serializable(with = LocalDateTimeSerializer::class)
        val endretTidspunkt: LocalDateTime,
    )
}
