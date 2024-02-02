package no.nav.lydia.ia.eksport

import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Observer
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASak

class IASakStatusProdusent(
    private val produsent: KafkaProdusent,
    private val iaSakRepository: IASakRepository,
) : Observer<IASak> {

    override fun receive(input: IASak) {
        val kafkaMelding = input.tilKafkaMelding()
        produsent.sendMelding(Topic.IA_SAK_STATUS_TOPIC.navn, kafkaMelding.first, kafkaMelding.second)
        if (input.status == IAProsessStatus.SLETTET) {
            iaSakRepository.hentSaker(input.orgnr)
                .lastOrNull { it.status != IAProsessStatus.SLETTET }
                ?.let { aktivSak ->
                    val aktivKafkaMelding = aktivSak.tilKafkaMelding()
                    produsent.sendMelding(Topic.IA_SAK_STATUS_TOPIC.navn, aktivKafkaMelding.first, aktivKafkaMelding.second)
                }
        }
    }

    companion object {
        fun IASak.tilKafkaMelding(
        ): Pair<String, String> {
            val key = this.orgnr
            val value = IASakStatus(
                orgnr = this.orgnr,
                saksnummer = this.saksnummer,
                status = this.status,
                sistOppdatert = this.endretTidspunkt?.toKotlinLocalDateTime()
                    ?: this.opprettetTidspunkt.toKotlinLocalDateTime(),
            )
            return key to Json.encodeToString(value)
        }
    }

    @Serializable
    data class IASakStatus(
        val orgnr: String,
        val saksnummer: String,
        val status: IAProsessStatus,
        val sistOppdatert: LocalDateTime,
    )
}
