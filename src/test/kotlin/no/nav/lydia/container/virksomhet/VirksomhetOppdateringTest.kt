package no.nav.lydia.container.virksomhet

import io.kotest.matchers.shouldBe
import kotlinx.datetime.Clock
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.integrasjoner.brreg.BrregVirksomhetDto
import no.nav.lydia.integrasjoner.brreg.NæringsundergruppeBrreg
import no.nav.lydia.sykefraversstatistikk.import.BrregOppdateringConsumer
import kotlin.test.Test

class VirksomhetOppdateringTest {
    private val kafkaContainer = TestContainerHelper.kafkaContainerHelper
    private val token = TestContainerHelper.oauth2ServerContainer.superbruker1.token

    @Test
    fun `kan oppdatere endrede virksomheter`() {
        val tilfeldigeVirksomheter: MutableList<TestVirksomhet> = mutableListOf()
        repeat(times = 5) {
            tilfeldigeVirksomheter.add(VirksomhetHelper.lastInnNyVirksomhet())
        }

        tilfeldigeVirksomheter.forEachIndexed { index, testVirksomhet ->
            val oppdateringVirksomhet = BrregOppdateringConsumer.OppdateringVirksomhet(
                orgnummer = testVirksomhet.orgnr,
                oppdateringsId = index.toLong(),
                brregVirksomhetEndringstype = BrregOppdateringConsumer.BrregVirksomhetEndringstype.Endring,
                metadata = BrregVirksomhetDto(
                    organisasjonsnummer = testVirksomhet.orgnr,
                    navn = testVirksomhet.navn.reversed(),
                    beliggenhetsadresse = testVirksomhet.beliggenhet,
                    naeringskode1 = NæringsundergruppeBrreg(
                        beskrivelse = testVirksomhet.næringsundergruppe1.navn,
                        kode = testVirksomhet.næringsundergruppe1.kode
                    )
                ),
                endringstidspunkt = Clock.System.now()
            )
            kafkaContainer.brregOppdatering.sendBrregOppdateringKafkaMelding(oppdateringVirksomhet = oppdateringVirksomhet)

        }

        tilfeldigeVirksomheter.forEach{ testVirksomhet ->
            val virksomhetDto =
                VirksomhetHelper.hentVirksomhetsinformasjon(orgnummer = testVirksomhet.orgnr, token)
            virksomhetDto.navn shouldBe testVirksomhet.navn.reversed()
        }

    }
}
