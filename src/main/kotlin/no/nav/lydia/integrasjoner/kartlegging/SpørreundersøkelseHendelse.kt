package no.nav.lydia.integrasjoner.kartlegging

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseSvarDto
import org.apache.kafka.clients.consumer.ConsumerRecord

class StengTema(
    spørreundersøkelseId: String,
    temaId: Int,
) : SpørreundersøkelseHendelse<Int>(
        spørreundersøkelseId = spørreundersøkelseId,
        hendelsesType = HendelsType.STENG_TEMA,
        data = temaId,
    ) {
    val temaId
        get() = data
}

class SvarPåSpørsmål(
    spørreundersøkelseId: String,
    svarPåSpørsmål: SpørreundersøkelseSvarDto,
) : SpørreundersøkelseHendelse<SpørreundersøkelseSvarDto>(
        spørreundersøkelseId = spørreundersøkelseId,
        hendelsesType = HendelsType.SVAR_PÅ_SPØRSMÅL,
        data = svarPåSpørsmål,
    )

@Serializable
sealed class SpørreundersøkelseHendelse<T>(
    val spørreundersøkelseId: String,
    val hendelsesType: HendelsType,
    val data: T,
) {
    companion object {
        fun meldingTilHendelse(record: ConsumerRecord<String, String>) =
            Json.decodeFromString<SpørreundersøkelseHendeleseNøkkel>(record.key()).let { nøkkel ->
                when (nøkkel.hendelsesType) {
                    HendelsType.STENG_TEMA -> StengTema(
                        spørreundersøkelseId = nøkkel.spørreundersøkelseId,
                        temaId = Json.decodeFromString(record.value()),
                    )

                    HendelsType.SVAR_PÅ_SPØRSMÅL -> SvarPåSpørsmål(
                        spørreundersøkelseId = nøkkel.spørreundersøkelseId,
                        svarPåSpørsmål = Json.decodeFromString(record.value()),
                    )
                }
            }
    }
}

@Serializable
data class SpørreundersøkelseHendeleseNøkkel(
    val spørreundersøkelseId: String,
    val hendelsesType: HendelsType,
)

enum class HendelsType {
    STENG_TEMA,
    SVAR_PÅ_SPØRSMÅL,
}
