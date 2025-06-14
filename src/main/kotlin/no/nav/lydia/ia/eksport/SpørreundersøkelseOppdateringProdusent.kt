package no.nav.lydia.ia.eksport

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
    // Evt bare dropp det helt når pia-survey gjør det obsolete
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
            AntallSvarKafkaDto(
                spørreundersøkelseId = spørreundersøkelseId.toString(),
                spørsmålId = spørsmålId.toString(),
                antallSvar = antallSvar,
            )
    }

    class ResultaterForTema(
        spørreundersøkelseId: String,
        resultaterForTema: TemaResultatKafkaDto,
    ) : SpørreundersøkelseOppdatering<TemaResultatKafkaDto>(
            spørreundersøkelseId = spørreundersøkelseId,
            oppdateringsType = Type.RESULTATER_FOR_TEMA,
            data = resultaterForTema,
        )

    class AntallSvar(
        spørreundersøkelseId: String,
        antallSvar: AntallSvarKafkaDto,
    ) : SpørreundersøkelseOppdatering<AntallSvarKafkaDto>(
            spørreundersøkelseId = spørreundersøkelseId,
            oppdateringsType = Type.ANTALL_SVAR,
            data = antallSvar,
        )

    @Serializable
    sealed class SpørreundersøkelseOppdatering<T>(
        val spørreundersøkelseId: String,
        val oppdateringsType: Type,
        val data: T,
    ) {
        fun tilKafkaMelding(): Pair<String, String> {
            val nøkkel =
                Json.encodeToString(SpørreundersøkelseOppdateringNøkkel(spørreundersøkelseId, oppdateringsType))

            val verdi = when (this) {
                is ResultaterForTema -> Json.encodeToString<TemaResultatKafkaDto>(data)
                is AntallSvar -> Json.encodeToString<AntallSvarKafkaDto>(data)
            }
            return nøkkel to verdi
        }

        enum class Type {
            RESULTATER_FOR_TEMA,
            ANTALL_SVAR,
        }
    }

    @Serializable
    data class TemaResultatKafkaDto(
        val id: Int,
        val navn: String,
        val spørsmålMedSvar: List<SpørsmålResultatKafkaDto>,
    )

    @Serializable
    data class SpørsmålResultatKafkaDto(
        val id: String,
        val tekst: String,
        val flervalg: Boolean,
        val svarListe: List<SvarResultatKafkaDto>,
        val kategori: String,
    )

    @Serializable
    data class SvarResultatKafkaDto(
        val id: String,
        val tekst: String,
        val antallSvar: Int,
    )

    @Serializable
    data class AntallSvarKafkaDto(
        val spørreundersøkelseId: String,
        val spørsmålId: String,
        val antallSvar: Int,
    )

    @Serializable
    data class SpørreundersøkelseOppdateringNøkkel(
        val spørreundersøkelseId: String,
        val oppdateringsType: SpørreundersøkelseOppdatering.Type,
    )
}
