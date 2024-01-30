package no.nav.lydia.container.ia.sak.kartlegging

import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import java.util.UUID
import kotlin.test.Test
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Kafka.Companion.spørreundersøkelseSvarGroupId
import no.nav.lydia.helper.IASakKartleggingHelper
import no.nav.lydia.helper.KafkaContainerHelper
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.sak.api.kartlegging.IASakKartleggingDto
import no.nav.lydia.integrasjoner.kartlegging.SpørreundersøkelseSvarDto

class IASakKartleggingSvarKonsumentTest {
    @Test
    fun `skal lagre svar mottatt på Kafka topic`() {
        val sak = SakHelper.nySakIKartlegges()
        val response = IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
            .tilSingelRespons<IASakKartleggingDto>()

        val kartleggingSvarDto = sendKartleggingSvarTilKafka(
            kartleggingId = response.third.get().kartleggingId,
        )

        TestContainerHelper.postgresContainer
            .hentEnkelKolonne<String>(
                "select kartlegging_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'"
            ) shouldBe kartleggingSvarDto.spørreundersøkelseId
    }

    @Test
    fun `Alle hardkodede spørsmål blir lagt til ved ny kartlegging`() {
        val sak = SakHelper.nySakIKartlegges()
        val kartlegingIdA =
            IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
                .tilSingelRespons<IASakKartleggingDto>().third.get().kartleggingId
        val kartleggingIdB =
            IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
                .tilSingelRespons<IASakKartleggingDto>().third.get().kartleggingId

        val antallSpørsmål = TestContainerHelper.postgresContainer
            .hentAlleRaderTilEnkelKolonne<String>(
                "select sporsmal_id from ia_sak_kartlegging_sporsmal",
            ).size

        TestContainerHelper.postgresContainer
            .hentAlleRaderTilEnkelKolonne<String>(
                "select sporsmal_id from ia_sak_kartlegging_sporsmal_til_kartlegging where kartlegging_id = '${kartlegingIdA}'",
            ) shouldHaveSize antallSpørsmål

        TestContainerHelper.postgresContainer
            .hentAlleRaderTilEnkelKolonne<String>(
                "select sporsmal_id from ia_sak_kartlegging_sporsmal_til_kartlegging where kartlegging_id = '${kartleggingIdB}'",
            ) shouldHaveSize antallSpørsmål

        TestContainerHelper.postgresContainer
            .hentAlleRaderTilEnkelKolonne<String>(
                "select sporsmal_id from ia_sak_kartlegging_sporsmal_til_kartlegging",
            ) shouldHaveSize antallSpørsmål * 2
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
        val response = IASakKartleggingHelper.opprettIASakKartlegging(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
            .tilSingelRespons<IASakKartleggingDto>()

        val kartleggingSvarDto = sendKartleggingSvarTilKafka(
            kartleggingId = response.third.get().kartleggingId,
        )

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

    private fun sendKartleggingSvarTilKafka(
        kartleggingId: String = UUID.randomUUID().toString(),
        spørsmålId: String = UUID.randomUUID().toString(),
        sesjonId: String = UUID.randomUUID().toString(),
        svarId: String = UUID.randomUUID().toString(),
    ): SpørreundersøkelseSvarDto {

        val spørreundersøkelseSvarDto = SpørreundersøkelseSvarDto(
            spørreundersøkelseId = kartleggingId,
            spørsmålId = spørsmålId,
            sesjonId = sesjonId,
            svarId = svarId
        )
        TestContainerHelper.kafkaContainerHelper.sendOgVentTilKonsumert(
            nøkkel = "${sesjonId}_${spørsmålId}",
            melding = Json.encodeToString(
                spørreundersøkelseSvarDto
            ),
            topic = KafkaContainerHelper.spørreundersøkelseSvarTopic,
            konsumentGruppeId = spørreundersøkelseSvarGroupId
        )
        return spørreundersøkelseSvarDto
    }
}
