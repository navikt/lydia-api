package no.nav.lydia.ia.sak.api.dokument

import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka
import no.nav.lydia.Topic
import no.nav.lydia.ia.eksport.KafkaProdusent
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseResultatDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.TemaResultatDto
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.integrasjoner.azure.NavEnhet
import no.nav.lydia.integrasjoner.pdfgen.DokumentPubliseringSakDto
import no.nav.lydia.integrasjoner.pdfgen.SamarbeidDto
import no.nav.lydia.integrasjoner.pdfgen.VirksomhetDto

class DokumentPubliseringProdusent(
    kafka: Kafka,
    topic: Topic = Topic.DOKUMENT_PUBLISERING_TOPIC,
) : KafkaProdusent<DokumentPubliseringMedInnhold>(kafka = kafka, topic = topic) {
    override fun tilKafkaMelding(input: DokumentPubliseringMedInnhold): Pair<String, String> {
        val key = getKafkaMeldingKey(
            samarbeidId = input.samarbeid.id,
            referanseId = input.referanseId,
            type = input.type,
        )
        val value = Json.encodeToString<DokumentPubliseringMedInnhold>(input)
        return key to value
    }

    companion object {
        fun getKafkaMeldingKey(
            samarbeidId: Int,
            referanseId: String,
            type: DokumentPublisering.Type,
        ): String = "$samarbeidId-$referanseId-${type.name}"

        fun DokumentPubliseringDto.medTilsvarendeInnhold(
            orgnr: String,
            virksomhetsNavn: String,
            samarbeid: IASamarbeid,
            navEnhet: NavEnhet,
            spørreundersøkelseResultat: SpørreundersøkelseResultatDto,
            fullførtTidspunkt: LocalDateTime,
            spørreundersøkelseOpprettetAv: String,
        ): DokumentPubliseringMedInnhold =
            DokumentPubliseringMedInnhold(
                sak = DokumentPubliseringSakDto(
                    saksnummer = samarbeid.saksnummer,
                    navenhet = navEnhet,
                ),
                referanseId = referanseId,
                type = dokumentType,
                dokumentOpprettetAv = opprettetAv,
                virksomhet = VirksomhetDto(
                    orgnummer = orgnr,
                    navn = virksomhetsNavn,
                ),
                samarbeid = SamarbeidDto(
                    id = samarbeid.id,
                    navn = samarbeid.navn,
                ),
                innhold = spørreundersøkelseResultat.tilSpørreundersøkelseInnholdDto(
                    spørreundersøkelseOpprettetAv = spørreundersøkelseOpprettetAv,
                    fullførtTidspunkt = fullførtTidspunkt,
                ),
            )

        fun SpørreundersøkelseResultatDto.tilSpørreundersøkelseInnholdDto(
            fullførtTidspunkt: LocalDateTime,
            spørreundersøkelseOpprettetAv: String,
        ): SpørreundersøkelseInnholdIDokumentDto =
            SpørreundersøkelseInnholdIDokumentDto(
                id = id,
                spørreundersøkelseOpprettetAv = spørreundersøkelseOpprettetAv,
                fullførtTidspunkt = fullførtTidspunkt,
                spørsmålMedSvarPerTema = spørsmålMedSvarPerTema,
            )
    }
}

@Serializable
data class DokumentPubliseringMedInnhold(
    val sak: DokumentPubliseringSakDto,
    val virksomhet: VirksomhetDto,
    val samarbeid: SamarbeidDto,
    val referanseId: String,
    val type: DokumentPublisering.Type,
    val dokumentOpprettetAv: String,
    val innhold: SpørreundersøkelseInnholdIDokumentDto,
)

@Serializable
data class SpørreundersøkelseInnholdIDokumentDto(
    val id: String,
    val spørreundersøkelseOpprettetAv: String,
    val fullførtTidspunkt: LocalDateTime,
    val spørsmålMedSvarPerTema: List<TemaResultatDto>,
)
