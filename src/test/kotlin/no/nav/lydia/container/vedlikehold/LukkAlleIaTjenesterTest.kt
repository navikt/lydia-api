package no.nav.lydia.container.vedlikehold

import ia.felles.integrasjoner.jobbsender.Jobb
import io.kotest.matchers.shouldBe
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.SakHelper.Companion.hentIASakLeveranser
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.SakHelper.Companion.opprettIASakLeveranse
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.ia.eksport.IASakLeveranseProdusent
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus.LEVERT
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus.UNDER_ARBEID
import no.nav.lydia.vedlikehold.IASakStatusOppdaterer.Companion.NAV_ENHET_FOR_MASKINELT_OPPDATERING
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class LukkAlleIaTjenesterTest {
    companion object {
        private val topic = Topic.IA_SAK_LEVERANSE_TOPIC
        private val konsument = kafkaContainerHelper.nyKonsument(consumerGroupId = topic.konsumentGruppe)

        @BeforeClass
        @JvmStatic
        fun setUp() = konsument.subscribe(mutableListOf(topic.navn))

        @AfterClass
        @JvmStatic
        fun tearDown() {
            konsument.unsubscribe()
            konsument.close()
        }
    }

    @Test
    fun `skal kunne lukke alle åpne ia-tjenester`() {
        val sak = nySakIViBistår()
        val leveranse = sak.opprettIASakLeveranse(modulId = 18)
        hentIASakLeveranser(orgnr = sak.orgnr, saksnummer = sak.saksnummer).forExactlyOne { leveransePerTjeneste ->
            leveransePerTjeneste.leveranser.forExactlyOne { leveranse ->
                leveranse.status shouldBe UNDER_ARBEID
            }
        }

        runBlocking {
            // -- har hijacket denne meldingen
            kafkaContainerHelper.sendJobbMelding(Jobb.kalkulerResulterendeStatusForHendelser)

            hentIASakLeveranser(orgnr = sak.orgnr, saksnummer = sak.saksnummer).forExactlyOne { leveransePerTjeneste ->
                leveransePerTjeneste.leveranser.forExactlyOne { leveranse ->
                    leveranse.status shouldBe LEVERT
                }
            }

            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(leveranse.id.toString(), konsument) { melding ->
                melding.forExactlyOne {
                    val kafkaMelding = Json.decodeFromString<IASakLeveranseProdusent.IASakLeveranseValue>(it)
                    kafkaMelding.id shouldBe leveranse.id
                    kafkaMelding.status shouldBe LEVERT
                    kafkaMelding.sistEndretAv shouldBe "Fia system"
                    kafkaMelding.enhetsnummer shouldBe NAV_ENHET_FOR_MASKINELT_OPPDATERING.enhetsnummer
                }
            }

            postgresContainerHelper.hentEnkelKolonne<String>(
                """
                select status from iasak_leveranse where id = ${leveranse.id}
                """.trimIndent(),
            ) shouldBe "LEVERT"
        }
    }
}
