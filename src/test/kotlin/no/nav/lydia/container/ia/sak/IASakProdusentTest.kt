package no.nav.lydia.container.ia.sak

import io.kotest.inspectors.forAll
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.string.shouldContain
import kotlinx.coroutines.isActive
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.time.withTimeout
import no.nav.lydia.helper.KafkaContainerHelper.Companion.iaSakTopic
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.toJson
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.SaksHendelsestype
import no.nav.lydia.ia.årsak.domene.BegrunnelseType
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.ÅrsakType
import org.junit.After
import org.junit.Before
import java.time.Duration
import kotlin.test.Test

class IASakProdusentTest {
    private val konsument = TestContainerHelper.kafkaContainerHelper.nyKonsument()

    @Before
    fun setUp() {
        konsument.subscribe(mutableListOf(iaSakTopic))
    }

    @After
    fun tearDown() {
        konsument.unsubscribe()
        konsument.close()
    }

    @Test
    fun `en ny hendelse på en IA-sak skal produsere en melding på kafka med oppdaterte verdier for saken`() {
        runBlocking {
            val orgnr = VirksomhetHelper.nyttOrgnummer()
            val sak = SakHelper.opprettSakForVirksomhet(orgnummer = orgnr)
                .nyHendelse(SaksHendelsestype.TA_EIERSKAP_I_SAK)
                .nyHendelse(SaksHendelsestype.VIRKSOMHET_SKAL_KONTAKTES)
                .nyHendelse(
                    hendelsestype = SaksHendelsestype.VIRKSOMHET_ER_IKKE_AKTUELL,
                    payload = ValgtÅrsak(
                        type = ÅrsakType.VIRKSOMHETEN_TAKKET_NEI,
                        begrunnelser = listOf(BegrunnelseType.GJENNOMFØRER_TILTAK_MED_BHT, BegrunnelseType.HAR_IKKE_KAPASITET)
                    ).toJson()
                )

            withTimeout(Duration.ofSeconds(10)) {
                launch {
                    while (this.isActive) {
                        val records = konsument.poll(Duration.ofMillis(100))
                        val meldinger = records.map { it.value() }.filter { it.contains(sak.saksnummer) }
                        if (meldinger.isNotEmpty()) {
                            meldinger.forAll { hendelse ->
                                hendelse shouldContain sak.saksnummer
                                hendelse shouldContain sak.orgnr
                            }
                            meldinger shouldHaveSize 5
                            meldinger[0] shouldContain IAProsessStatus.NY.name
                            meldinger[1] shouldContain IAProsessStatus.VURDERES.name
                            meldinger[1] shouldContain """"eierAvSak":null"""
                            meldinger[2] shouldContain IAProsessStatus.VURDERES.name
                            meldinger[2] shouldContain """"eierAvSak":"X12345""""
                            meldinger[3] shouldContain IAProsessStatus.KONTAKTES.name
                            meldinger[4] shouldContain IAProsessStatus.IKKE_AKTUELL.name
                            break
                        }
                    }
                }
            }
        }


    }
}
