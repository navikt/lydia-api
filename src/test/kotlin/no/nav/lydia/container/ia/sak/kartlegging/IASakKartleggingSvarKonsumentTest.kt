package no.nav.lydia.container.ia.sak.kartlegging

import io.kotest.matchers.shouldNotBe
import java.util.UUID
import kotlin.test.Test
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka.Companion.iaSakKartleggingSvarGroupId
import no.nav.lydia.helper.IASakKartleggingHelper
import no.nav.lydia.helper.KafkaContainerHelper
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.sak.api.kartlegging.IASakKartleggingDto
import no.nav.lydia.integrasjoner.kartlegging.KartleggingSvarDto

class IASakKartleggingSvarKonsumentTest {

    @Test
    fun `skal lagre svar mottatt på Kafka topic`() {
        val sak = SakHelper.nySakIKartlegges()
        val resp = IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
            .tilSingelRespons<IASakKartleggingDto>()

        val kartleggingId = resp.third.get().id
        val spørsmålId = UUID.randomUUID()
        val sesjonId = UUID.randomUUID()
        val svarId = UUID.randomUUID()

        TestContainerHelper.kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = "${sesjonId}_${spørsmålId}",
            melding = Json.encodeToString(
                KartleggingSvarDto(
                    spørreundersøkelseId = kartleggingId,
                    sesjonId = sesjonId.toString(),
                    spørsmålId = spørsmålId.toString(),
                    svarId = svarId.toString()
                )
            ),
            topic = KafkaContainerHelper.iaSakKartleggingSvarTopic,
            konsumentGruppeId = iaSakKartleggingSvarGroupId
        )

        TestContainerHelper.postgresContainer
            .hentEnkelKolonne<String>(
                "select id from ia_sak_kartlegging_svar where kartlegging_id = '$kartleggingId'"
            ) shouldNotBe null
    }
}