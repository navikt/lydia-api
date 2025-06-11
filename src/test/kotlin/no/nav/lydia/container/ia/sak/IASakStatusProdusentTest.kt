package no.nav.lydia.container.ia.sak

import io.kotest.inspectors.forAll
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.string.shouldContain
import kotlinx.coroutines.runBlocking
import no.nav.lydia.Topic
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.toJson
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.VirksomhetHelper.Companion.nyttOrgnummer
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.årsak.domene.BegrunnelseType
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.ÅrsakType
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class IASakStatusProdusentTest {
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
    fun `en ny hendelse på en IA-sak skal produsere en melding på kafka med oppdaterte verdier for saken`() {
        runBlocking {
            val orgnr = nyttOrgnummer()
            val sak = SakHelper.opprettSakForVirksomhet(orgnummer = orgnr)
                .nyHendelse(IASakshendelseType.TA_EIERSKAP_I_SAK)
                .nyHendelse(IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES)
                .nyHendelse(
                    hendelsestype = IASakshendelseType.VIRKSOMHET_ER_IKKE_AKTUELL,
                    payload = ValgtÅrsak(
                        type = ÅrsakType.VIRKSOMHETEN_TAKKET_NEI,
                        begrunnelser = listOf(
                            BegrunnelseType.VIRKSOMHETEN_ØNSKER_IKKE_SAMARBEID,
                        ),
                    ).toJson(),
                )

            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(key = sak.orgnr, konsument) { meldinger ->
                meldinger.forAll { hendelse ->
                    hendelse shouldContain sak.saksnummer
                    hendelse shouldContain sak.orgnr
                }
                meldinger shouldHaveSize 5
                meldinger[4] shouldContain IASak.Status.IKKE_AKTUELL.name
            }
        }
    }
}
