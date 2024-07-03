package no.nav.lydia.container.ia.sak.prosess

import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.hentIAProsesser
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettKartlegging
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.ia.sak.api.prosess.IAProsessDto
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import kotlin.test.Test

class IASakProsessTest {

	@Test
	fun `skal kunne endre navn på en prosess`() {
		val sak = nySakIKartlegges()
		sak.opprettKartlegging() // dette burde opprette en prosess

		val prosessId = TestContainerHelper.postgresContainer.hentEnkelKolonne<Int>("""
			SELECT id FROM ia_prosess WHERE saksnummer = '${sak.saksnummer}'
		""".trimIndent())

		val nyttNavn = "Nytt navn"
		sak.nyHendelse(
			hendelsestype = IASakshendelseType.ENDRE_PROSESS,
			payload = Json.encodeToString(IAProsessDto(
				id = prosessId,
				saksnummer = sak.saksnummer,
				navn = nyttNavn,
				status = "AKTIV"
			))
		)

		val prosesser = sak.hentIAProsesser()
		prosesser shouldHaveSize 1
		prosesser.first().navn shouldBe nyttNavn
	}

	@Test
	fun `skal kunne hente ut alle aktive prosesser i en sak`() {
		val sak = nySakIKartlegges()
		sak.opprettKartlegging() // dette burde opprette en prosess

		val prosesser = sak.hentIAProsesser()
		prosesser shouldHaveSize 1
		prosesser.first().saksnummer shouldBe sak.saksnummer
	}
}