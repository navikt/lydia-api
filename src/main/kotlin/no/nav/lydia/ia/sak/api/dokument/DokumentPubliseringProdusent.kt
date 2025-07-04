package no.nav.lydia.ia.sak.api.dokument

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.Topic
import no.nav.lydia.ia.eksport.KafkaProdusent
import no.nav.lydia.ia.sak.api.spørreundersøkelse.tilDto
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.integrasjoner.pdfgen.SakDto
import no.nav.lydia.integrasjoner.pdfgen.SamarbeidDto
import no.nav.lydia.integrasjoner.pdfgen.VirksomhetDto

class DokumentPubliseringProdusent(
    kafka: Kafka,
    topic: Topic = Topic.DOKUMENT_PUBLISERING_TOPIC,
) : KafkaProdusent<DokumentPubliseringMedInnhold>(kafka = kafka, topic = topic) {
    override fun tilKafkaMelding(input: DokumentPubliseringMedInnhold): Pair<String, String> {
        val key = getKafkaMeldingKey(samarbeidId = input.samarbeid.id, referanseId = input.referanseId, type = input.type)
        val value = Json.encodeToString<DokumentPubliseringMedInnhold>(input)
        return key to value
    }

    companion object {
        fun getKafkaMeldingKey(
            samarbeidId: Int,
            referanseId: String,
            type: String,
        ): String = "$samarbeidId-$referanseId-$type"

        fun DokumentPubliseringDto.medTilsvarendeInnhold(
            spørreundersøkelse: Spørreundersøkelse,
            samarbeid: IASamarbeid,
            navEnhet: NavEnhet,
        ): DokumentPubliseringMedInnhold =
            DokumentPubliseringMedInnhold(
                sak = SakDto(
                    saksnummer = spørreundersøkelse.saksnummer,
                    navenhet = navEnhet.enhetsnavn,
                ),
                referanseId = this.referanseId,
                type = this.dokumentType.name,
                opprettetAv = this.opprettetAv,
                virksomhet = VirksomhetDto(
                    orgnummer = spørreundersøkelse.orgnummer,
                    navn = spørreundersøkelse.virksomhetsNavn,
                ),
                samarbeid = SamarbeidDto(
                    id = samarbeid.id,
                    navn = samarbeid.navn,
                ),
                innhold = Json.encodeToString(spørreundersøkelse.tilDto()),
            )
    }
}

@Serializable
data class DokumentPubliseringMedInnhold(
    val sak: SakDto,
    val virksomhet: VirksomhetDto,
    val samarbeid: SamarbeidDto,
    val referanseId: String,
    val type: String,
    val opprettetAv: String,
    val innhold: String,
)
