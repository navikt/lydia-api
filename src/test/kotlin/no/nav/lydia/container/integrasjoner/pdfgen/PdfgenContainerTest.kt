package no.nav.lydia.container.integrasjoner.pdfgen

import java.io.ByteArrayInputStream
import java.time.ZonedDateTime
import kotlin.test.BeforeTest
import kotlin.test.Test
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.integrasjoner.pdfgen.VirksomhetDto
import no.nav.lydia.integrasjoner.pdfgen.IASamarbeidDto
import no.nav.lydia.integrasjoner.pdfgen.SakDto
import org.verapdf.gf.foundry.VeraGreenfieldFoundryProvider
import org.verapdf.pdfa.Foundries
import org.verapdf.pdfa.flavours.PDFAFlavour

class PdfgenContainerTest {
    private val piaPdfgenContainer = TestContainerHelper.piaPdfgenContainer

    @BeforeTest
    internal fun setup() {
        VeraGreenfieldFoundryProvider.initialise()
    }

	@Test
	fun `valider at genererte pdfer er i pdf-a format`() {
		val pdf = piaPdfgenContainer.hentBistandPdf(
			IASamarbeidDto(
				dato = ZonedDateTime.now().toString(),
				sak = SakDto(
					saksnummer = "tulll",
					eier = "Donald Duck"
				),
				virksomhet = VirksomhetDto(
					orgnummer = "987654321",
					navn = "Andeby Catering"
				)
			)
		)

        val pdfaFlavour = PDFAFlavour.PDFA_2_U
        val validator = Foundries.defaultInstance().createValidator(pdfaFlavour, false)
        Foundries.defaultInstance().createParser(ByteArrayInputStream(pdf)).use {
            assert(validator.validate(it).isCompliant)
        }
    }
}
