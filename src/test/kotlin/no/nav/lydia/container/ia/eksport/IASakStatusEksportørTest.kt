package no.nav.lydia.container.ia.eksport

import ia.felles.integrasjoner.jobbsender.Jobb.iaSakStatusExport
import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldContain
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.avbrytSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.fullførSak
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.nyIkkeAktuellHendelse
import no.nav.lydia.helper.SakHelper.Companion.opprettSakForVirksomhet
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestData.Companion.BOLIGBYGGELAG
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.lastInnNyVirksomhet
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.ia.eksport.IASakStatusProdusent
import no.nav.lydia.ia.sak.domene.IASakStatus.FULLFØRT
import no.nav.lydia.ia.sak.domene.IASakStatus.KONTAKTES
import no.nav.lydia.ia.sak.domene.IASakshendelseType.SLETT_SAK
import no.nav.lydia.ia.sak.domene.IASakshendelseType.TA_EIERSKAP_I_SAK
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class IASakStatusEksportørTest {
    companion object {
        private val topic = Topic.IA_SAK_STATUS_TOPIC
        private val konsument = kafkaContainerHelper.nyKonsument(topic = topic)

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
    fun `skal trigge kafka-eksport av IASakStatus`() {
        val virksomhet =
            TestVirksomhet.nyVirksomhet(næringer = listOf(BOLIGBYGGELAG))
        lastInnNyVirksomhet(virksomhet)

        val sak = opprettSakForVirksomhet(orgnummer = virksomhet.orgnr, token = authContainerHelper.superbruker1.token)
            .nyHendelse(
                hendelsestype = TA_EIERSKAP_I_SAK,
                token = authContainerHelper.saksbehandler1.token,
            )
            .nyHendelse(
                hendelsestype = VIRKSOMHET_SKAL_KONTAKTES,
                token = authContainerHelper.saksbehandler1.token,
            )

        kafkaContainerHelper.sendJobbMelding(iaSakStatusExport)

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.orgnr,
                konsument = konsument,
            ) { meldinger ->
                val objektene = meldinger.map {
                    Json.decodeFromString<IASakStatusProdusent.IASakStatus>(it)
                }
                objektene shouldHaveSize 5
                objektene.forAtLeastOne {
                    it.orgnr shouldBe sak.orgnr
                    it.saksnummer shouldBe sak.saksnummer
                    it.status shouldBe KONTAKTES
                }
                objektene.filter { it.status == KONTAKTES } shouldHaveSize 2
            }
        }
    }

    @Test
    fun `sletting av feilåpnet sak produserer en slett melding på topic og spiller ut aktiv sak sin status`() {
        runBlocking {
            val eldsteSak = SakHelper.nySakIViBistår()
                .let { sak ->
                    sak.avbrytSamarbeid(sak.hentAlleSamarbeid().first())
                }.nyIkkeAktuellHendelse()
            val gammelSak = SakHelper.nySakIViBistår(orgnummer = eldsteSak.orgnr).fullførSak()

            // -- Slett en sak, for å teste om siste melding er den gjeldene aktive statusen
            opprettSakForVirksomhet(orgnummer = eldsteSak.orgnr)
                .nyHendelse(
                    hendelsestype = SLETT_SAK,
                    token = authContainerHelper.superbruker1.token,
                )

            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(eldsteSak.orgnr, konsument) { meldinger ->
                meldinger shouldHaveSize 22
                // -- Siste meldingen skal være den gamle fullførte saken
                meldinger[21] shouldContain gammelSak.saksnummer
                meldinger[21] shouldContain gammelSak.orgnr
                meldinger[21] shouldContain FULLFØRT.name
            }
        }
    }
}
