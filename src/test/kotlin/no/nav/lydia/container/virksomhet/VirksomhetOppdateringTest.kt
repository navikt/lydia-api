package no.nav.lydia.container.virksomhet

import io.kotest.matchers.comparables.shouldBeGreaterThan
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import kotlinx.datetime.Clock
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.integrasjoner.brreg.BrregVirksomhetDto
import no.nav.lydia.integrasjoner.brreg.NæringsundergruppeBrreg
import no.nav.lydia.sykefraversstatistikk.import.BrregOppdateringConsumer
import no.nav.lydia.virksomhet.domene.VirksomhetStatus
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
                oppdateringsId = testVirksomhet.orgnr.toLong() + 1L,
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
            virksomhetDto.status shouldBe VirksomhetStatus.AKTIV
            virksomhetDto.oppdatertAvBrregOppdateringsId shouldBe testVirksomhet.orgnr.toLong() + 1L
            virksomhetDto.opprettetTidspunkt shouldNotBe null
            virksomhetDto.sistEndretTidspunkt shouldNotBe null
            virksomhetDto.sistEndretTidspunkt!! shouldBeGreaterThan virksomhetDto.opprettetTidspunkt
        }

    }
}
