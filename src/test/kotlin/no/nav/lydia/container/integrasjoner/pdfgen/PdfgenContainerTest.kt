package no.nav.lydia.container.integrasjoner.pdfgen

import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.integrasjoner.pdfgen.ArbeidsgiverDto
import no.nav.lydia.integrasjoner.pdfgen.BistandDto
import no.nav.lydia.integrasjoner.pdfgen.SakDto
import org.verapdf.gf.foundry.VeraGreenfieldFoundryProvider
import org.verapdf.pdfa.Foundries
import org.verapdf.pdfa.flavours.PDFAFlavour
import java.io.ByteArrayInputStream
import java.time.ZonedDateTime
import kotlin.test.BeforeTest
import kotlin.test.Ignore
import kotlin.test.Test

class PdfgenContainerTest {
    private val piaPdfgenContainer = TestContainerHelper.piaPdfgenContainer

    @BeforeTest
    internal fun setup() {
        VeraGreenfieldFoundryProvider.initialise()
    }

    @Ignore
    @Test
    fun `valider at genererte pdfer er i pdf-a format`() {
        val pdf = piaPdfgenContainer.hentBistandPdf(
            BistandDto(
                dato = ZonedDateTime.now().toString(),
                sak = SakDto(
                    saksnummer = "tulll",
                    eier = "Donald Duck"
                ),
                arbeidsgiver = ArbeidsgiverDto(
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
