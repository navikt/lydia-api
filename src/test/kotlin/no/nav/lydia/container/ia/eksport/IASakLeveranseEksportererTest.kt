package no.nav.lydia.container.ia.eksport

import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.string.shouldContain
import kotlinx.coroutines.runBlocking
import no.nav.lydia.helper.KafkaContainerHelper
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.opprettIASakLeveranse
import no.nav.lydia.helper.SakHelper.Companion.slettIASakLeveranse
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.VirksomhetHelper.Companion.nyttOrgnummer
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import org.junit.After
import org.junit.Before
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
        val sak = SakHelper.opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(hendelsestype = IASakshendelseType.TA_EIERSKAP_I_SAK, token = oauth2ServerContainer.saksbehandler1.token)
            .nyHendelse(hendelsestype = IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(hendelsestype = IASakshendelseType.VIRKSOMHET_KARTLEGGES)
            .nyHendelse(hendelsestype = IASakshendelseType.VIRKSOMHET_SKAL_BISTÅS)
        val leveranse = sak.opprettIASakLeveranse(modulId = 1, token = oauth2ServerContainer.saksbehandler1.token)

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = leveranse.id.toString(),
                konsument = konsument
            ) { meldinger ->
                meldinger shouldHaveAtLeastSize 1
                meldinger.forAtLeastOne {
                    it shouldContain leveranse.id.toString()
                    it shouldContain sak.saksnummer
                    it shouldContain oauth2ServerContainer.saksbehandler1.navIdent
                    it shouldContain leveranse.modul.navn
                    it shouldContain leveranse.frist.toString()
                    it shouldContain leveranse.status.toString()
                    it shouldContain leveranse.fullført.toString()
                }
            }
        }
    }

    @Test
    fun `skal trigge kafka-eksport av IASakLeveranse ved sletting`() {
        val sak = SakHelper.opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(hendelsestype = IASakshendelseType.TA_EIERSKAP_I_SAK, token = oauth2ServerContainer.saksbehandler1.token)
            .nyHendelse(hendelsestype = IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(hendelsestype = IASakshendelseType.VIRKSOMHET_KARTLEGGES)
            .nyHendelse(hendelsestype = IASakshendelseType.VIRKSOMHET_SKAL_BISTÅS)
        val leveranse = sak.opprettIASakLeveranse(modulId = 1, token = oauth2ServerContainer.saksbehandler1.token)
        leveranse.slettIASakLeveranse(sak.orgnr, token = oauth2ServerContainer.saksbehandler1.token)

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = leveranse.id.toString(),
                konsument = konsument
            ) { meldinger ->
                meldinger shouldHaveAtLeastSize 2
                meldinger.forExactlyOne {
                    it shouldContain leveranse.id.toString()
                    it shouldContain sak.saksnummer
                    it shouldContain oauth2ServerContainer.saksbehandler1.navIdent
                    it shouldContain leveranse.modul.navn
                    it shouldContain leveranse.frist.toString()
                    it shouldContain leveranse.status.toString()
                    it shouldContain leveranse.fullført.toString()
                }
                meldinger.forExactlyOne {
                    it shouldContain leveranse.id.toString()
                    it shouldContain sak.saksnummer
                    it shouldContain oauth2ServerContainer.saksbehandler1.navIdent
                    it shouldContain leveranse.modul.navn
                    it shouldContain leveranse.frist.toString()
                    it shouldContain IASakLeveranseStatus.SLETTET.toString()
                    it shouldContain leveranse.fullført.toString()
                }
            }
        }
    }
}
