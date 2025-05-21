package no.nav.lydia.container.ia.eksport

import ia.felles.integrasjoner.jobbsender.Jobb.iaSakLeveranseEksport
import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldContain
import kotlinx.coroutines.runBlocking
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.SakHelper.Companion.oppdaterIASakLeveranse
import no.nav.lydia.helper.SakHelper.Companion.opprettIASakLeveranse
import no.nav.lydia.helper.SakHelper.Companion.slettIASakLeveranse
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.TestData.Companion.AKTIV_MODUL
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.ia.eksport.IASakLeveranseProdusent.IASakLeveranseValue
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus
import no.nav.lydia.ia.sak.domene.IASakshendelseType.TA_EIERSKAP_I_SAK
import no.nav.lydia.tilgangskontroll.fia.Rolle
import org.junit.AfterClass
import org.junit.BeforeClass
import java.sql.Timestamp
import kotlin.test.Test

class IASakLeveranseEksportererTest {
    companion object {
        private val topic = Topic.IA_SAK_LEVERANSE_TOPIC
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
    fun `skal trigge kafka-eksport av IASakLeveranse`() {
        val sak = nySakIViBistår()
        val leveranse = sak.opprettIASakLeveranse(
            modulId = AKTIV_MODUL.id,
            token = authContainerHelper.saksbehandler1.token,
        )

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = leveranse.id.toString(),
                konsument = konsument,
            ) { meldinger ->
                val objektene = meldinger.map {
                    Json.decodeFromString<IASakLeveranseValue>(it)
                }
                objektene shouldHaveAtLeastSize 1
                objektene.forAtLeastOne {
                    it.id shouldBe leveranse.id
                    it.saksnummer shouldBe sak.saksnummer
                    it.opprettetAv shouldBe authContainerHelper.saksbehandler1.navIdent
                    it.sistEndretAv shouldBe authContainerHelper.saksbehandler1.navIdent
                    it.iaModulNavn shouldBe leveranse.modul.navn
                    it.frist shouldBe leveranse.frist
                    it.status shouldBe leveranse.status
                    it.fullført shouldBe leveranse.fullført
                    it.enhetsnavn shouldBe "IT-avdelingen 2B"
                    it.enhetsnummer shouldBe "2900"
                    it.opprettetTidspunkt shouldBe postgresContainerHelper.hentEnkelKolonne<Timestamp?>(
                        """
                        select opprettet_tidspunkt from iasak_leveranse where id = ${leveranse.id}
                        """.trimIndent(),
                    )?.toLocalDateTime()?.toKotlinLocalDateTime()
                }
            }
        }
    }

    @Test
    fun `skal trigge kafka-eksport av IASakLeveranse ved alle endringer`() {
        val sak = nySakIViBistår()
        val nyLeveranse = sak.opprettIASakLeveranse(
            modulId = AKTIV_MODUL.id,
            token = authContainerHelper.saksbehandler1.token,
        )
        sak.nyHendelse(hendelsestype = TA_EIERSKAP_I_SAK, token = authContainerHelper.saksbehandler2.token)

        val levertLeveranse = nyLeveranse.oppdaterIASakLeveranse(
            orgnr = sak.orgnr,
            status = IASakLeveranseStatus.LEVERT,
            token = authContainerHelper.saksbehandler2.token,
        )
        levertLeveranse.slettIASakLeveranse(orgnr = sak.orgnr, token = authContainerHelper.saksbehandler2.token)

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = nyLeveranse.id.toString(),
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveAtLeastSize 3
                meldinger.forExactlyOne {
                    it shouldContain nyLeveranse.id.toString()
                    it shouldContain sak.saksnummer
                    it shouldContain authContainerHelper.saksbehandler1.navIdent
                    it shouldContain Rolle.SAKSBEHANDLER.name
                    it shouldContain nyLeveranse.modul.navn
                    it shouldContain nyLeveranse.frist.toString()
                    it shouldContain nyLeveranse.status.toString()
                }
                meldinger.forExactlyOne {
                    it shouldContain levertLeveranse.id.toString()
                    it shouldContain sak.saksnummer
                    it shouldContain authContainerHelper.saksbehandler2.navIdent
                    it shouldContain Rolle.SAKSBEHANDLER.name
                    it shouldContain levertLeveranse.modul.navn
                    it shouldContain levertLeveranse.frist.toString()
                    it shouldContain IASakLeveranseStatus.LEVERT.toString()
                }
                meldinger.forExactlyOne {
                    it shouldContain levertLeveranse.id.toString()
                    it shouldContain sak.saksnummer
                    it shouldContain authContainerHelper.saksbehandler2.navIdent
                    it shouldContain Rolle.SAKSBEHANDLER.name
                    it shouldContain levertLeveranse.modul.navn
                    it shouldContain levertLeveranse.frist.toString()
                    it shouldContain IASakLeveranseStatus.SLETTET.toString()
                }
            }
        }
    }

    @Test
    fun `spille av leveranser burde gi samme resultat`() {
        val sak = nySakIViBistår()
        val nyLeveranse = sak.opprettIASakLeveranse(
            modulId = AKTIV_MODUL.id,
            token = authContainerHelper.saksbehandler1.token,
        )

        var melding: IASakLeveranseValue? = null

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = nyLeveranse.id.toString(),
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveSize 1
                melding = Json.decodeFromString(meldinger.first())
            }
        }

        kafkaContainerHelper.sendJobbMelding(iaSakLeveranseEksport)

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = nyLeveranse.id.toString(),
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveSize 1
                Json.decodeFromString<IASakLeveranseValue>(meldinger.first()) shouldBe melding
            }
        }
    }
}
