package no.nav.lydia.container.ia.eksport

import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldContain
import kotlinx.coroutines.runBlocking
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.json.Json
import no.nav.lydia.helper.KafkaContainerHelper
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.SakHelper.Companion.oppdaterIASakLeveranse
import no.nav.lydia.helper.SakHelper.Companion.opprettIASakLeveranse
import no.nav.lydia.helper.SakHelper.Companion.slettIASakLeveranse
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainer
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.ia.eksport.IASakLeveranseProdusent.IASakLeveranseValue
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.integrasjoner.jobblytter.Jobb
import no.nav.lydia.tilgangskontroll.Rolle
import org.junit.After
import org.junit.Before
import java.sql.Timestamp
import kotlin.test.Test

class IASakLeveranseEksportererTest {
    private val konsument = kafkaContainerHelper.nyKonsument(consumerGroupId = this::class.java.name)

    @Before
    fun setUp() {
        konsument.subscribe(mutableListOf(KafkaContainerHelper.iaSakLeveranseTopic))
    }

    @After
    fun tearDown() {
        konsument.unsubscribe()
        konsument.close()
    }

    @Test
    fun `skal trigge kafka-eksport av IASakLeveranse`() {
        val sak = nySakIViBistår()
        val leveranse = sak.opprettIASakLeveranse(modulId = 1, token = oauth2ServerContainer.saksbehandler1.token)

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = leveranse.id.toString(),
                konsument = konsument
            ) { meldinger ->
                val objektene = meldinger.map {
                    Json.decodeFromString<IASakLeveranseValue>(it)
                }
                objektene shouldHaveAtLeastSize 1
                objektene.forAtLeastOne {
                    it.id shouldBe leveranse.id
                    it.saksnummer shouldBe sak.saksnummer
                    it.opprettetAv shouldBe oauth2ServerContainer.saksbehandler1.navIdent
                    it.sistEndretAv shouldBe oauth2ServerContainer.saksbehandler1.navIdent
                    it.modul.navn shouldBe leveranse.modul.navn
                    it.frist shouldBe leveranse.frist
                    it.status shouldBe leveranse.status
                    it.fullført shouldBe leveranse.fullført
                    it.enhetsnavn shouldBe "IT-avdelingen"
                    it.enhetsnummer shouldBe "2900"
                    it.opprettetTidspunkt shouldBe postgresContainer.hentEnkelKolonne<Timestamp?>("""
                        select opprettet_tidspunkt from iasak_leveranse where id = ${leveranse.id}
                    """.trimIndent())?.toLocalDateTime()?.toKotlinLocalDateTime()
                }
            }
        }
    }

    @Test
    fun `skal trigge kafka-eksport av IASakLeveranse ved alle endringer`() {
        val sak = nySakIViBistår()
        val nyLeveranse = sak.opprettIASakLeveranse(modulId = 1, token = oauth2ServerContainer.saksbehandler1.token)
        sak.nyHendelse(IASakshendelseType.TA_EIERSKAP_I_SAK, token = oauth2ServerContainer.saksbehandler2.token)

        val levertLeveranse = nyLeveranse.oppdaterIASakLeveranse(
            orgnr = sak.orgnr, status = IASakLeveranseStatus.LEVERT, token = oauth2ServerContainer.saksbehandler2.token)
        levertLeveranse.slettIASakLeveranse(sak.orgnr, token = oauth2ServerContainer.saksbehandler2.token)

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = nyLeveranse.id.toString(),
                konsument = konsument
            ) { meldinger ->
                meldinger shouldHaveAtLeastSize 3
                meldinger.forExactlyOne {
                    it shouldContain nyLeveranse.id.toString()
                    it shouldContain sak.saksnummer
                    it shouldContain oauth2ServerContainer.saksbehandler1.navIdent
                    it shouldContain Rolle.SAKSBEHANDLER.name
                    it shouldContain nyLeveranse.modul.navn
                    it shouldContain nyLeveranse.frist.toString()
                    it shouldContain nyLeveranse.status.toString()
                }
                meldinger.forExactlyOne {
                    it shouldContain levertLeveranse.id.toString()
                    it shouldContain sak.saksnummer
                    it shouldContain oauth2ServerContainer.saksbehandler2.navIdent
                    it shouldContain Rolle.SAKSBEHANDLER.name
                    it shouldContain levertLeveranse.modul.navn
                    it shouldContain levertLeveranse.frist.toString()
                    it shouldContain IASakLeveranseStatus.LEVERT.toString()
                }
                meldinger.forExactlyOne {
                    it shouldContain levertLeveranse.id.toString()
                    it shouldContain sak.saksnummer
                    it shouldContain oauth2ServerContainer.saksbehandler2.navIdent
                    it shouldContain Rolle.SAKSBEHANDLER.name
                    it shouldContain levertLeveranse.modul.navn
                    it shouldContain levertLeveranse.frist.toString()
                    it shouldContain IASakLeveranseStatus.SLETTET.toString()
                }
            }
        }
    }

    @Test
    fun  `spille av leveranser burde gi samme resultat`() {
        val sak = nySakIViBistår()
        val nyLeveranse = sak.opprettIASakLeveranse(modulId = 1, token = oauth2ServerContainer.saksbehandler1.token)

        var melding: IASakLeveranseValue? = null

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = nyLeveranse.id.toString(),
                konsument = konsument
            ) { meldinger ->
                meldinger shouldHaveSize 1
                melding = Json.decodeFromString(meldinger.first())
            }
        }

        kafkaContainerHelper.sendJobbMelding(Jobb.iaSakLeveranseEksport)

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = nyLeveranse.id.toString(),
                konsument = konsument
            ) { meldinger ->
                meldinger shouldHaveSize 1
                Json.decodeFromString<IASakLeveranseValue>(meldinger.first()) shouldBe melding
            }
        }
    }
}
