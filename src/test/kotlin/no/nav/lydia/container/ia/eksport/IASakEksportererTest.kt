package no.nav.lydia.container.ia.eksport

import ia.felles.integrasjoner.jobbsender.Jobb.engangsJobb
import ia.felles.integrasjoner.jobbsender.Jobb.iaSakEksport
import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.string.shouldContain
import kotlinx.coroutines.runBlocking
import no.nav.lydia.Topic
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import org.junit.After
import org.junit.Before
import kotlin.test.Test

class IASakEksportererTest {
    private val konsument = kafkaContainerHelper.nyKonsument(consumerGroupId = this::class.java.name)

    @Before
    fun setUp() {
        konsument.subscribe(mutableListOf(Topic.IA_SAK_TOPIC.navn))
    }

    @After
    fun tearDown() {
        konsument.unsubscribe()
        konsument.close()
    }

    @Test
    fun `skal trigge kafka-eksport av IASaker`() {
        val sak = SakHelper.opprettSakForVirksomhet(orgnummer = VirksomhetHelper.nyttOrgnummer())
            .nyHendelse(
                hendelsestype = IASakshendelseType.TA_EIERSKAP_I_SAK,
                token = oauth2ServerContainer.saksbehandler1.token,
            )

        runBlocking {
            kafkaContainerHelper.sendJobbMelding(iaSakEksport)

            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveAtLeastSize 1
                meldinger.forAtLeastOne {
                    it shouldContain sak.saksnummer
                    it shouldContain oauth2ServerContainer.saksbehandler1.navIdent
                    it shouldContain IAProsessStatus.VURDERES.name
                }
            }
        }
    }

    @Test
    fun `skal trigge kafka-eksport av enkel IASak`() {
        // OBS: denne testen her kommer til å feile dersom 'engangsJobb' blir brukt til noe annet
        val sak = SakHelper.opprettSakForVirksomhet(orgnummer = VirksomhetHelper.nyttOrgnummer())
            .nyHendelse(
                hendelsestype = IASakshendelseType.TA_EIERSKAP_I_SAK,
                token = oauth2ServerContainer.saksbehandler1.token,
            )
        // Opprettelse av en ny sak trigger utsendelse til Kafka -> vi må lese denne meldingen først
        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveAtLeastSize 1
                meldinger.forAtLeastOne {
                    it shouldContain sak.saksnummer
                }
            }
        }

        // Start jobben som skal sende en melding om IA-sak på Kafka
        kafkaContainerHelper.sendJobbMelding(engangsJobb, parameter = sak.saksnummer)
        runBlocking {
            // Sjekk at denne meldingen ble sendt på Kafka
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = konsument,
            ) { meldinger ->
                meldinger shouldHaveAtLeastSize 1
                meldinger.forAtLeastOne {
                    it shouldContain sak.saksnummer
                    it shouldContain oauth2ServerContainer.saksbehandler1.navIdent
                    it shouldContain IAProsessStatus.VURDERES.name
                }
            }
        }
        lydiaApiContainer shouldContainLog "Eksport av enkel sak er ferdig".toRegex()
    }

    @Test
    fun `kafka-eksport av enkel IASak logger warn dersom saken ikke er funnet`() {
        // OBS: denne testen her kommer til å feile dersom 'engangsJobb' blir brukt til noe annet
        SakHelper.opprettSakForVirksomhet(orgnummer = VirksomhetHelper.nyttOrgnummer())
            .nyHendelse(
                hendelsestype = IASakshendelseType.TA_EIERSKAP_I_SAK,
                token = oauth2ServerContainer.saksbehandler1.token,
            )

        // Start jobben som skal sende en melding om IA-sak på Kafka
        kafkaContainerHelper.sendJobbMelding(engangsJobb, parameter = "UKJENT_SAKSNUMMER")

        lydiaApiContainer shouldContainLog "Eksport av enkel sak, med saksnummer: 'UKJENT_SAKSNUMMER' feilet. Sak ikke funnet".toRegex()
    }
}
