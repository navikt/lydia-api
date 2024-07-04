package no.nav.lydia.ia.eksport

import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Observer
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASak

class IASakProdusent(private val produsent: KafkaProdusent) : Observer<IASak> {

    override fun receive(input: IASak) {
        val kafkaMelding = input.tilKafkaMelding()
        produsent.sendMelding(Topic.IA_SAK_TOPIC.navn, kafkaMelding.first, kafkaMelding.second)
    }

    companion object {
        fun IASak.tilKafkaMelding(): Pair<String, String> {
            val key = this.saksnummer
            val value = IASakValue(
                saksnummer = this.saksnummer,
                orgnr = this.orgnr,
                eierAvSak = this.eidAv,
                endretAvHendelseId = this.endretAvHendelseId,
                status = this.status,
                opprettetTidspunkt = this.opprettetTidspunkt.toKotlinLocalDateTime(),
                endretTidspunkt = this.endretTidspunkt?.toKotlinLocalDateTime()
                    ?: this.opprettetTidspunkt.toKotlinLocalDateTime(),
            )
            return key to Json.encodeToString(value)

        }
    }

    @Serializable
    private data class IASakValue(
        val saksnummer: String,
        val orgnr: String,
        val eierAvSak: String?,
        val endretAvHendelseId: String,
        val status: IAProsessStatus,
        val opprettetTidspunkt: LocalDateTime,
        val endretTidspunkt: LocalDateTime,
    )
}
