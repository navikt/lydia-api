package no.nav.lydia.container.ia.eksport

import ia.felles.integrasjoner.jobbsender.Jobb
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.abc.samarbeid.DEFAULT_SAMARBEID_NAVN
import no.nav.lydia.abc.samarbeid.SamarbeidBigqueryProdusent
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.aktivSamarbeidsperiode
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.endreSamarbeidsNavn
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.opprettSamarbeid
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.slettSamarbeid
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.vurderVirksomhet
import no.nav.lydia.helper.SakHelper.Companion.leggTilFolger
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldNotContainLog
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentAlleSamarbeid
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class SamarbeidBigqueryEksportererTest {
    companion object {
        private val topic = Topic.SAMARBEID_BIGQUERY_TOPIC
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
    fun `oppretting av samarbeid skal trigge kafka-eksport av samarbeid`() {
        val sak = aktivSamarbeidsperiode(samarbeidsnavn = DEFAULT_SAMARBEID_NAVN)
        val førsteSamarbeid = sak.hentAlleSamarbeid().first()

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveSize 1
                val samarbeidValues = meldinger.map {
                    Json.decodeFromString<SamarbeidBigqueryProdusent.SamarbeidValue>(it)
                }
                samarbeidValues shouldHaveSize 1
                val sisteSamarbeid = samarbeidValues.last()
                sisteSamarbeid.id shouldBe førsteSamarbeid.id
                sisteSamarbeid.saksnummer shouldBe førsteSamarbeid.saksnummer
                sisteSamarbeid.status shouldBe "AKTIV"
                sisteSamarbeid.navn shouldBe DEFAULT_SAMARBEID_NAVN
            }
        }
    }

    @Test
    fun `jobb starter re-eksport av alle samarbeid til bigquery`() {
        val sakMedAktivtSamarbeid = aktivSamarbeidsperiode(samarbeidsnavn = "ATIVT SAMARBEID")
        val aktivtSamarbeid = sakMedAktivtSamarbeid.hentAlleSamarbeid().first()

        val sakMedSamarbeidSomSkalSlettes = aktivSamarbeidsperiode(samarbeidsnavn = "SLETTET SAMARBEID")
        val samarbeidSomSkalSlettes = sakMedSamarbeidSomSkalSlettes.hentAlleSamarbeid().first()

        samarbeidSomSkalSlettes.slettSamarbeid(orgnr = sakMedSamarbeidSomSkalSlettes.orgnr)

        val sakMedNavngittSamarbeid = vurderVirksomhet().leggTilFolger(TestContainerHelper.authContainerHelper.saksbehandler1.token)
        val samarbeidUtenNavn = sakMedNavngittSamarbeid.opprettSamarbeid(samarbeidsnavn = "SAMARBEID UTEN NAVN")
        val samarbeidMedNyttNavn = samarbeidUtenNavn.endreSamarbeidsNavn(orgnr = sakMedNavngittSamarbeid.orgnr, nyttNavn = "NAVNGITT SAMARBEID")

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                keys = listOf(
                    sakMedAktivtSamarbeid.saksnummer,
                    sakMedSamarbeidSomSkalSlettes.saksnummer,
                    sakMedNavngittSamarbeid.saksnummer,
                ),
                konsument = konsument,
            ) { meldinger ->
                val sendteSamarbeid = meldinger.map {
                    Json.decodeFromString<SamarbeidBigqueryProdusent.SamarbeidValue>(it)
                }

                // Om denne testen feiler sporadisk bare sjekk at logg ikke inneholder "Klarte ikke å kjøre eksport av samarbeid"
                // og at fullført melding logges

                sendteSamarbeid.forExactlyOne {
                    it.id shouldBe aktivtSamarbeid.id
                    it.saksnummer shouldBe aktivtSamarbeid.saksnummer
                    it.navn shouldBe aktivtSamarbeid.navn
                    it.status shouldBe "AKTIV"
                }

                sendteSamarbeid.forExactlyOne {
                    it.id shouldBe samarbeidSomSkalSlettes.id
                    it.saksnummer shouldBe samarbeidSomSkalSlettes.saksnummer
                    it.navn shouldBe samarbeidSomSkalSlettes.navn
                    it.status shouldBe "SLETTET"
                }

                sendteSamarbeid.forExactlyOne {
                    it.id shouldBe samarbeidMedNyttNavn.id
                    it.saksnummer shouldBe samarbeidMedNyttNavn.saksnummer
                    it.navn shouldBe samarbeidMedNyttNavn.navn
                    it.status shouldBe "AKTIV"
                }
            }

            kafkaContainerHelper.sendJobbMelding(Jobb.iaSakSamarbeidBigQueryEksport)

            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                keys = listOf(
                    sakMedAktivtSamarbeid.saksnummer,
                    sakMedSamarbeidSomSkalSlettes.saksnummer,
                    sakMedNavngittSamarbeid.saksnummer,
                ),
                konsument = konsument,
            ) { meldinger ->
                val sendteSamarbeid = meldinger.map {
                    Json.decodeFromString<SamarbeidBigqueryProdusent.SamarbeidValue>(it)
                }

                sendteSamarbeid.forExactlyOne {
                    it.id shouldBe aktivtSamarbeid.id
                    it.saksnummer shouldBe aktivtSamarbeid.saksnummer
                    it.navn shouldBe aktivtSamarbeid.navn
                    it.status shouldBe "AKTIV"
                }

                sendteSamarbeid.forExactlyOne {
                    it.id shouldBe samarbeidSomSkalSlettes.id
                    it.saksnummer shouldBe samarbeidSomSkalSlettes.saksnummer
                    it.navn shouldBe samarbeidSomSkalSlettes.navn
                    it.status shouldBe "SLETTET"
                }

                sendteSamarbeid.forExactlyOne {
                    it.id shouldBe samarbeidMedNyttNavn.id
                    it.saksnummer shouldBe samarbeidMedNyttNavn.saksnummer
                    it.navn shouldBe samarbeidMedNyttNavn.navn
                    it.status shouldBe "AKTIV"
                }
            }
        }

        applikasjon.shouldNotContainLog("Klarte ikke å kjøre eksport av samarbeid".toRegex())
        applikasjon.shouldContainLog("Jobb 'iaSakSamarbeidBigQueryEksport' ferdig".toRegex())
    }
}
