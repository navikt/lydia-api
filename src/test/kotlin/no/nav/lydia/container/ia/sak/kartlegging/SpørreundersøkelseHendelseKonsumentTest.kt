package no.nav.lydia.container.ia.sak.kartlegging

import ia.felles.integrasjoner.kafkameldinger.SpørreundersøkelseStatus
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.IASakKartleggingHelper
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettBehovsvurdering
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.sendKartleggingSvarTilKafka
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.start
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.stengTema
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.ia.eksport.SpørreundersøkelseOppdateringProdusent
import no.nav.lydia.ia.eksport.SpørreundersøkelseOppdateringProdusent.OppdateringsType.RESULTATER_FOR_TEMA
import no.nav.lydia.ia.eksport.SpørreundersøkelseOppdateringProdusent.SpørreundersøkelseOppdateringNøkkel
import org.junit.After
import org.junit.Before
import java.util.UUID
import kotlin.test.Test

class SpørreundersøkelseHendelseKonsumentTest {
    val spørreundersøkelseOppdateringKonsument =
        TestContainerHelper.kafkaContainerHelper.nyKonsument(Topic.SPORREUNDERSOKELSE_OPPDATERING_TOPIC.konsumentGruppe)

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
        val sak = SakHelper.nySakIKartleggesMedEtSamarbeid()
        val kartleggingDto = sak.opprettBehovsvurdering()
        kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val tema = kartleggingDto.temaMedSpørsmålOgSvaralternativer.first()
        kartleggingDto.stengTema(temaId = tema.temaId)
        TestContainerHelper.postgresContainer.hentEnkelKolonne<Boolean>(
            """
            SELECT stengt from ia_sak_kartlegging_kartlegging_til_tema
                WHERE kartlegging_id = '${kartleggingDto.id}'
                AND tema_id = ${tema.temaId}
            """.trimIndent(),
        ) shouldBe true
    }

    @Test
    fun `skal oppdatere spørreundersøkelse til stengt i databasen om alle temaer har blitt stengt`() {
        val sak = SakHelper.nySakIKartleggesMedEtSamarbeid()
        val samarbeid = sak.hentAlleSamarbeid().first()
        val behovsvurdering = sak.opprettBehovsvurdering(prosessId = samarbeid.id)

        behovsvurdering.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        behovsvurdering.temaMedSpørsmålOgSvaralternativer.forEach { tema ->
            behovsvurdering.stengTema(temaId = tema.temaId)
        }

        val fullførtBehovsvurdering = IASakKartleggingHelper.hentIASakKartlegginger(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = samarbeid.id,
        ).first()

        fullførtBehovsvurdering.status shouldBe SpørreundersøkelseStatus.AVSLUTTET

        TestContainerHelper.lydiaApiContainer.shouldContainLog(
            "Alle temaer i spørreundersøkelse '${behovsvurdering.id}' er fullført, spørreundersøkelse er avsluttet".toRegex(),
        )
    }

    @Test
    fun `steng tema skal ikke avslutte spørreundersøkelse før alle temaer er stengt`() {
        val sak = SakHelper.nySakIKartleggesMedEtSamarbeid()
        val samarbeid = sak.hentAlleSamarbeid().first()
        val behovsvurdering = sak.opprettBehovsvurdering(prosessId = samarbeid.id)

        behovsvurdering.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        val førsteTema = behovsvurdering.temaMedSpørsmålOgSvaralternativer.first()
        behovsvurdering.stengTema(temaId = førsteTema.temaId)

        val behovsvurderingMedEttStengtTema = IASakKartleggingHelper.hentIASakKartlegginger(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = samarbeid.id,
        ).first()

        behovsvurderingMedEttStengtTema.status shouldBe SpørreundersøkelseStatus.PÅBEGYNT

        TestContainerHelper.lydiaApiContainer.shouldContainLog(
            "Mottok stenging av tema: ${førsteTema.temaId} i spørreundersøkelse ${behovsvurdering.id}".toRegex(),
        )
    }

    @Test
    fun `skal sende resultater for stengt tema på kafka`() {
        val sak = SakHelper.nySakIKartleggesMedEtSamarbeid()
        val kartleggingDto = sak.opprettBehovsvurdering()
        kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val tema = kartleggingDto.temaMedSpørsmålOgSvaralternativer.first()
        val førsteSpørsmål = tema.spørsmålOgSvaralternativer.first()
        val svarIder = listOf(tema.spørsmålOgSvaralternativer.first().svaralternativer.first().svarId)

        (1..5).forEach { _ ->
            val sesjonId = UUID.randomUUID().toString()
            kartleggingDto.sendKartleggingSvarTilKafka(
                spørsmålId = førsteSpørsmål.id,
                sesjonId = sesjonId,
                svarIder = svarIder,
            )
        }

        kartleggingDto.stengTema(temaId = tema.temaId)
        runBlocking {
            TestContainerHelper.kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = Json.encodeToString(
                    SpørreundersøkelseOppdateringNøkkel(
                        spørreundersøkelseId = kartleggingDto.id,
                        oppdateringsType = RESULTATER_FOR_TEMA,
                    ),
                ),
                konsument = spørreundersøkelseOppdateringKonsument,
            ) { meldinger ->
                meldinger.forEach { melding ->
                    val resultaterForTema = Json.decodeFromString<SpørreundersøkelseOppdateringProdusent.SerializableTemaResultat>(melding)
                    resultaterForTema.navn shouldBe tema.navn
                    resultaterForTema.spørsmålMedSvar.forExactlyOne { spørsmål ->
                        spørsmål.spørsmålId shouldBe førsteSpørsmål.id
                        spørsmål.svarListe.forEach { svar ->
                            println("${svar.svarId} har ${svar.antallSvar} svar")
                        }
                        spørsmål.svarListe.filter { svar -> svar.antallSvar == 5 } shouldHaveSize 1
                    }
                }
            }
        }
    }
}
