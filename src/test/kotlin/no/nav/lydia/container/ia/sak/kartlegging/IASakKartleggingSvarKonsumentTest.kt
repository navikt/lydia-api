package no.nav.lydia.container.ia.sak.kartlegging

import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettKartlegging
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.sendKartleggingSvarTilKafka
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import java.util.UUID
import kotlin.test.Test

class IASakKartleggingSvarKonsumentTest {
    @Test
    fun `skal lagre svar mottatt på Kafka topic`() {
        val sak = SakHelper.nySakIKartlegges()
        val kartlegging = sak.opprettKartlegging()
        val kartleggingSvarDto = kartlegging.sendKartleggingSvarTilKafka()

        TestContainerHelper.postgresContainer
            .hentEnkelKolonne<String>(
                "select kartlegging_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'"
            ) shouldBe kartleggingSvarDto.spørreundersøkelseId
    }

    @Test
    fun `Skal ikke kunne svare på kartlegging som ikke eksisterer`() {
        val kartleggingSvarDto = sendKartleggingSvarTilKafka()

        TestContainerHelper.postgresContainer
            .hentAlleRaderTilEnkelKolonne<String>(
                "select kartlegging_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'"
            ) shouldHaveSize 0
        TestContainerHelper.lydiaApiContainer.shouldContainLog("Fant ikke kartlegging på denne iden".toRegex())
    }

    @Test
    fun `skal oppdatere ved nytt svar mottatt på Kafka topic`() {
        val sak = SakHelper.nySakIKartlegges()
        val kartleggingSvarDto =  sak.opprettKartlegging().sendKartleggingSvarTilKafka()

        TestContainerHelper.postgresContainer
            .hentEnkelKolonne<String>(
                "select svar_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'"
            ) shouldBe kartleggingSvarDto.svarId

        TestContainerHelper.postgresContainer
            .hentEnkelKolonne<String>(
                "select endret from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'"
            ) shouldBe null

        val nySvarId = UUID.randomUUID().toString()

        sendKartleggingSvarTilKafka(
            kartleggingId = kartleggingSvarDto.spørreundersøkelseId,
            spørsmålId = kartleggingSvarDto.spørsmålId,
            sesjonId = kartleggingSvarDto.sesjonId,
            svarId = nySvarId
        )

        TestContainerHelper.postgresContainer
            .hentEnkelKolonne<String>(
                "select svar_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'"
            ) shouldBe nySvarId
        TestContainerHelper.postgresContainer
            .hentEnkelKolonne<String>(
                "select endret from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'"
            ) shouldNotBe null
    }
}
