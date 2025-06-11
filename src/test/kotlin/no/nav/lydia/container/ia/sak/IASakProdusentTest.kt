package no.nav.lydia.container.ia.sak

import io.kotest.inspectors.forAll
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.string.shouldContain
import kotlinx.coroutines.runBlocking
import no.nav.lydia.Topic
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.toJson
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.VirksomhetHelper.Companion.nyttOrgnummer
import no.nav.lydia.ia.sak.domene.IASakStatus
import no.nav.lydia.ia.sak.domene.IASakshendelseType.SLETT_SAK
import no.nav.lydia.ia.sak.domene.IASakshendelseType.TA_EIERSKAP_I_SAK
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_ER_IKKE_AKTUELL
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES
import no.nav.lydia.ia.årsak.domene.BegrunnelseType
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.ÅrsakType
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class IASakProdusentTest {
    companion object {
        private val topic = Topic.IA_SAK_TOPIC
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
    fun `sletting av feilåpnet sak produserer en slett melding på topic`() {
        runBlocking {
            val sak = SakHelper.opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
                .nyHendelse(hendelsestype = SLETT_SAK, token = authContainerHelper.superbruker1.token)
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(key = sak.saksnummer, konsument = konsument) { meldinger ->
                meldinger.forAll { hendelse ->
                    hendelse shouldContain sak.saksnummer
                    hendelse shouldContain sak.orgnr
                }
                meldinger shouldHaveSize 3
                meldinger[0] shouldContain IASakStatus.NY.name
                meldinger[1] shouldContain IASakStatus.VURDERES.name
                meldinger[2] shouldContain IASakStatus.SLETTET.name
            }
        }
    }

    @Test
    fun `en ny hendelse på en IA-sak skal produsere en melding på kafka med oppdaterte verdier for saken`() {
        runBlocking {
            val orgnr = nyttOrgnummer()
            val sak = SakHelper.opprettSakForVirksomhet(orgnummer = orgnr)
                .nyHendelse(hendelsestype = TA_EIERSKAP_I_SAK)
                .nyHendelse(hendelsestype = VIRKSOMHET_SKAL_KONTAKTES)
                .nyHendelse(
                    hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL,
                    payload = ValgtÅrsak(
                        type = ÅrsakType.VIRKSOMHETEN_TAKKET_NEI,
                        begrunnelser = listOf(
                            BegrunnelseType.VIRKSOMHETEN_ØNSKER_IKKE_SAMARBEID,
                        ),
                    ).toJson(),
                )

            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(key = sak.saksnummer, konsument) { meldinger ->
                meldinger.forAll { hendelse ->
                    hendelse shouldContain sak.saksnummer
                    hendelse shouldContain sak.orgnr
                }
                meldinger shouldHaveSize 5
                meldinger[0] shouldContain IASakStatus.NY.name
                meldinger[1] shouldContain IASakStatus.VURDERES.name
                meldinger[1] shouldContain """"eierAvSak":null"""
                meldinger[2] shouldContain IASakStatus.VURDERES.name
                meldinger[2] shouldContain """"eierAvSak":"X12345""""
                meldinger[3] shouldContain IASakStatus.KONTAKTES.name
                meldinger[4] shouldContain IASakStatus.IKKE_AKTUELL.name
            }
        }
    }
}
