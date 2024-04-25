package no.nav.lydia.ia.eksport

import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.api.spørreundersøkelse.TemaResultatDto
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseAntallSvar


class SpørreundersøkelseOppdateringProdusent(
    private val produsent: KafkaProdusent,
) {
    fun <T> sendPåKafka(oppdatering: SpørreundersøkelseOppdatering<T>) {
        val (nøkkel, verdi) = oppdatering.tilKafkaMelding()
        produsent.sendMelding(
            topic = Topic.SPORREUNDERSOKELSE_OPPDATERING_TOPIC.navn,
            nøkkel = nøkkel,
            verdi = verdi,
        )
    }

    companion object {
        fun SpørreundersøkelseAntallSvar.tilKafkaMelding() =
            SpørreundersøkelseAntallSvarDto(
                spørreundersøkelseId = spørreundersøkelseId.toString(),
                spørsmålId = spørsmålId.toString(),
                antallSvar = antallSvar
            )
    }

    class ResultaterForTema(
        spørreundersøkelseId: String,
        resultaterForTema: TemaResultatDto,
    ) : SpørreundersøkelseOppdatering<TemaResultatDto>(
        spørreundersøkelseId = spørreundersøkelseId,
        oppdateringsType = OppdateringsType.RESULTATER_FOR_TEMA,
        data = resultaterForTema
    )

    class AntallSvar(
        spørreundersøkelseId: String,
        antallSvar: SpørreundersøkelseAntallSvar,
    ) : SpørreundersøkelseOppdatering<SpørreundersøkelseAntallSvar>(
        spørreundersøkelseId = spørreundersøkelseId,
        oppdateringsType = OppdateringsType.ANTALL_SVAR,
        data = antallSvar
    )


    @Serializable
    sealed class SpørreundersøkelseOppdatering<T>(
        val spørreundersøkelseId: String,
        val oppdateringsType: OppdateringsType,
        val data: T,
    ) {
        fun tilKafkaMelding(): Pair<String, String> {
            val nøkkel =
                Json.encodeToString(SpørreundersøkelseOppdateringNøkkel(spørreundersøkelseId, oppdateringsType))

            val verdi = when (this) {
                is ResultaterForTema -> Json.encodeToString(data)
                is AntallSvar -> Json.encodeToString(data.tilKafkaMelding())
            }
            return nøkkel to verdi
        }
    }

    @Serializable
    data class SpørreundersøkelseAntallSvarDto(
        val spørreundersøkelseId: String,
        val spørsmålId: String,
        val antallSvar: Int,
    )

    @Serializable
    data class SpørreundersøkelseOppdateringNøkkel(
        val spørreundersøkelseId: String,
        val oppdateringsType: OppdateringsType,
    )

    enum class OppdateringsType {
        RESULTATER_FOR_TEMA,
        ANTALL_SVAR
    }
}
