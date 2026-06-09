package no.nav.lydia.helper

import com.github.kittinunf.fuel.core.extensions.authentication
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.abc.dokument.DOKUMENT_PUBLISERING_BASE_ROUTE
import no.nav.lydia.abc.dokument.DokumentPubliseringDto
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.integrasjoner.kvittering.KvitteringDto
import java.time.ZoneId
import java.time.ZonedDateTime
import java.util.UUID

class DokumentPubliseringHelper {
    companion object {
        fun publiserDokument(
            dokumentReferanseId: String,
            dokumentType: DokumentPubliseringDto.Type = DokumentPubliseringDto.Type.BEHOVSVURDERING,
            token: String,
        ) = TestContainerHelper.applikasjon.performPost(url = "${DOKUMENT_PUBLISERING_BASE_ROUTE}/type/$dokumentType/ref/$dokumentReferanseId")
            .authentication().bearer(token = token)
            .tilSingelRespons<DokumentPubliseringDto>()

        fun sendKvittering(
            dokument: DokumentPubliseringDto,
            samarbeidId: Int,
            ønsketPublisertDato: LocalDateTime =
                ZonedDateTime.now().withZoneSameInstant(ZoneId.of("Europe/Oslo")).toLocalDateTime().toKotlinLocalDateTime(),
        ) {
            val dokId = UUID.randomUUID().toString()
            TestContainerHelper.kafkaContainerHelper.sendOgVentTilKonsumert(
                nøkkel = dokId,
                melding = Json.encodeToString(
                    KvitteringDto(
                        referanseId = dokument.referanseId,
                        samarbeidId = samarbeidId,
                        dokumentId = dokId,
                        journalpostId = UUID.randomUUID().toString(),
                        publisertDato = ønsketPublisertDato,
                        type = dokument.dokumentType.name,
                    ),
                ),
                topic = Topic.DOKUMENT_KVITTERING_TOPIC,
            )
        }
    }
}
