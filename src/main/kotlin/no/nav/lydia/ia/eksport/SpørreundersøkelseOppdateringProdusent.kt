package no.nav.lydia.ia.eksport

import ia.felles.integrasjoner.kafkameldinger.oppdatering.SpørsmålResultatMelding
import ia.felles.integrasjoner.kafkameldinger.oppdatering.SvarResultatMelding
import ia.felles.integrasjoner.kafkameldinger.oppdatering.TemaResultatMelding
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.Topic
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseAntallSvar
import org.apache.kafka.clients.producer.KafkaProducer
import org.apache.kafka.clients.producer.ProducerRecord

class SpørreundersøkelseOppdateringProdusent(
    kafka: Kafka,
    private val topic: Topic = Topic.SPORREUNDERSOKELSE_OPPDATERING_TOPIC,
) {
    private val produsent: KafkaProducer<String, String> = KafkaProducer(kafka.producerProperties(clientId = topic.konsumentGruppe))

    init {
        Runtime.getRuntime().addShutdownHook(
            Thread {
                produsent.close()
            },
        )
    }

    // TODO: Se på å implementere KafkaProdusent<T> for å unngå duplisering av kode
    fun <T> sendPåKafka(oppdatering: SpørreundersøkelseOppdatering<T>) {
        val (nøkkel, verdi) = oppdatering.tilKafkaMelding()
        produsent.send(
            ProducerRecord(
                topic.navn,
                nøkkel,
                verdi,
            ),
        )
    }

    companion object {
        fun SpørreundersøkelseAntallSvar.tilDto() =
            SpørreundersøkelseAntallSvarDto(
                spørreundersøkelseId = spørreundersøkelseId.toString(),
                spørsmålId = spørsmålId.toString(),
                antallSvar = antallSvar,
            )
    }

    class ResultaterForTema(
        spørreundersøkelseId: String,
        resultaterForTema: SerializableTemaResultat,
    ) : SpørreundersøkelseOppdatering<SerializableTemaResultat>(
            spørreundersøkelseId = spørreundersøkelseId,
            oppdateringsType = OppdateringsType.RESULTATER_FOR_TEMA,
            data = resultaterForTema,
        )

    class AntallSvar(
        spørreundersøkelseId: String,
        antallSvar: SpørreundersøkelseAntallSvarDto,
    ) : SpørreundersøkelseOppdatering<SpørreundersøkelseAntallSvarDto>(
            spørreundersøkelseId = spørreundersøkelseId,
            oppdateringsType = OppdateringsType.ANTALL_SVAR,
            data = antallSvar,
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
                is ResultaterForTema -> Json.encodeToString<SerializableTemaResultat>(data)
                is AntallSvar -> Json.encodeToString<SpørreundersøkelseAntallSvarDto>(data)
            }
            return nøkkel to verdi
        }
    }

    @Serializable
    data class SerializableTemaResultat(
        override val id: Int,
        override val navn: String,
        override val spørsmålMedSvar: List<SerializableSpørsmålResultat>,
    ) : TemaResultatMelding

    @Serializable
    data class SerializableSpørsmålResultat(
        override val id: String,
        override val tekst: String,
        override val flervalg: Boolean,
        override val svarListe: List<SerializableSvarResultat>,
        val kategori: String,
    ) : SpørsmålResultatMelding

    @Serializable
    data class SerializableSvarResultat(
        override val id: String,
        override val tekst: String,
        override val antallSvar: Int,
    ) : SvarResultatMelding

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
        ANTALL_SVAR,
    }
}
