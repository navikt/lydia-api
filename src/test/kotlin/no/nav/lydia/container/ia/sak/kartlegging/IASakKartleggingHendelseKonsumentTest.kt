package no.nav.lydia.container.ia.sak.kartlegging

import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettKartlegging
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.sendKartleggingSvarTilKafka
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.start
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.stengTema
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.TemaMedSpørsmålOgSvar
import no.nav.lydia.integrasjoner.kartlegging.OppdateringsType
import no.nav.lydia.integrasjoner.kartlegging.SpørreundersøkelseOppdateringNøkkel
import org.junit.After
import org.junit.Before
import java.util.*
import kotlin.test.Test

class IASakKartleggingHendelseKonsumentTest {
    val spørreundersøkelseOppdateringKonsument = TestContainerHelper.kafkaContainerHelper.nyKonsument(Topic.SPORREUNDERSOKELSE_OPPDATERING_TOPIC.konsumentGruppe)

    @Before
    fun setUp() {
        spørreundersøkelseOppdateringKonsument.subscribe(mutableListOf(Topic.SPORREUNDERSOKELSE_OPPDATERING_TOPIC.navn))
    }

    @After
    fun tearDown() {
        spørreundersøkelseOppdateringKonsument.unsubscribe()
        spørreundersøkelseOppdateringKonsument.close()
    }

    @Test
    fun `skal oppdatere tema til stengt i databasen`() {
        val sak = SakHelper.nySakIKartlegges()
        val kartleggingDto = sak.opprettKartlegging()
        kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val tema = kartleggingDto.temaMedSpørsmålOgSvaralternativer.first()
        kartleggingDto.stengTema(temaId = tema.temaId)
        TestContainerHelper.postgresContainer.hentEnkelKolonne<Boolean>(
            """
                SELECT stengt from ia_sak_kartlegging_kartlegging_til_tema
                    WHERE kartlegging_id = '${kartleggingDto.kartleggingId}'
                    AND tema_id = ${tema.temaId}
            """.trimIndent()
        ) shouldBe true
    }

    @Test
    fun `skal sende resultater for stengt tema på kafka`() {
        val sak = SakHelper.nySakIKartlegges()
        val kartleggingDto = sak.opprettKartlegging()
        kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val tema = kartleggingDto.temaMedSpørsmålOgSvaralternativer.first()
        val spørsmål = tema.spørsmålOgSvaralternativer.first()
        val svarIder = listOf(tema.spørsmålOgSvaralternativer.first().svaralternativer.first().svarId)

        (1..5).forEach { _ ->
            val sesjonId = UUID.randomUUID().toString()
            kartleggingDto.sendKartleggingSvarTilKafka(
                spørsmålId = spørsmål.id,
                sesjonId = sesjonId,
                svarIder = svarIder
            )
        }

        kartleggingDto.stengTema(temaId = tema.temaId)
        runBlocking {
            TestContainerHelper.kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = Json.encodeToString(SpørreundersøkelseOppdateringNøkkel(
                    spørreundersøkelseId = kartleggingDto.kartleggingId,
                    hendelsesType = OppdateringsType.RESULTATER_FOR_TEMA
                )),
                konsument = spørreundersøkelseOppdateringKonsument
            ) { meldinger ->
                meldinger.forEach { melding ->
                    val resultaterForTema = Json.decodeFromString<TemaMedSpørsmålOgSvar>(melding)
                    resultaterForTema.tema shouldBe tema.temanavn.name
                    resultaterForTema.spørsmålMedSvar.forExactlyOne {
                        it.spørsmålId shouldBe spørsmål.id
                        it.svarListe.forEach {
                            println("${it.svarId} har ${it.antallSvar} svar")
                        }
                        it.svarListe.filter { svar -> svar.antallSvar == 5 } shouldHaveSize 1
                    }
                }
            }
        }
    }
}
