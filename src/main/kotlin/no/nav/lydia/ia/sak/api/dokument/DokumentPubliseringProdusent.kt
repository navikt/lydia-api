package no.nav.lydia.ia.sak.api.dokument

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.Topic
import no.nav.lydia.ia.eksport.KafkaProdusent
import no.nav.lydia.ia.sak.api.spørreundersøkelse.tilDto
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse

class DokumentPubliseringProdusent(
    kafka: Kafka,
    topic: Topic = Topic.DOKUMENT_PUBLISERING_TOPIC,
) : KafkaProdusent<DokumentPubliseringMedInnhold>(kafka = kafka, topic = topic) {
    override fun tilKafkaMelding(input: DokumentPubliseringMedInnhold): Pair<String, String> {
        val key = "${input.samarbeidId}-${input.dokumentId}"
        val value = Json.encodeToString<DokumentPubliseringMedInnhold>(input)
        return key to value
    }

    companion object {
        fun DokumentPubliseringDto.medTilsvarendeInnhold(spørreundersøkelse: Spørreundersøkelse): DokumentPubliseringMedInnhold =
            DokumentPubliseringMedInnhold(
                dokumentId = this.dokumentId,
                referanseId = this.referanseId,
                orgnr = spørreundersøkelse.orgnummer,
                saksnummer = spørreundersøkelse.saksnummer,
                samarbeidId = spørreundersøkelse.samarbeidId,
                innhold = Json.encodeToString(spørreundersøkelse.tilDto()),
            )
    }
}

@Serializable
data class DokumentPubliseringMedInnhold(
    val dokumentId: String,
    val referanseId: String,
    val orgnr: String,
    val saksnummer: String,
    val samarbeidId: Int,
    val innhold: String,
)
