package no.nav.lydia.integrasjoner.kartlegging

import io.kotest.matchers.shouldBe
import kotlinx.datetime.toKotlinLocalDateTime
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse.Companion.harMinstEttResultat
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørsmål
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Tema
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Undertema
import java.time.LocalDateTime
import java.util.UUID
import kotlin.test.Test

class SpørreundersøkelseResultatUnitTest {
    @Test
    fun `tom verdi er ikke gyldig`() {
        harMinstEttResultat(
            Spørreundersøkelse(
                id = UUID.randomUUID(),
                saksnummer = "12",
                samarbeidId = 1,
                orgnummer = "12",
                virksomhetsNavn = "ABC AS",
                status = Spørreundersøkelse.Status.AVSLUTTET,
                type = Spørreundersøkelse.Type.Behovsvurdering,
                opprettetAv = "TODO()",
                opprettetTidspunkt = LocalDateTime.now().toKotlinLocalDateTime(),
                endretTidspunkt = LocalDateTime.now().toKotlinLocalDateTime(),
                påbegyntTidspunkt = LocalDateTime.now().toKotlinLocalDateTime(),
                fullførtTidspunkt = LocalDateTime.now().toKotlinLocalDateTime(),
                publiseringStatus = DokumentPublisering.Status.IKKE_PUBLISERT,
                temaer = listOf(
                    Tema(
                        id = 1,
                        stengtForSvar = true,
                        navn = "Partssamarbeid",
                        status = Tema.Status.AKTIV,
                        rekkefølge = 1,
                        sistEndret = LocalDateTime.now().toKotlinLocalDateTime(),
                        undertemaer = listOf(
                            Undertema(
                                id = 1,
                                navn = "TODO()",
                                status = Undertema.Status.AKTIV,
                                rekkefølge = 1,
                                sistEndret = LocalDateTime.now().toKotlinLocalDateTime(),
                                spørsmål = listOf(
                                    Spørsmål(
                                        id = UUID.randomUUID(),
                                        tekst = "Hva er et godt samarbeid?",
                                        rekkefølge = 1,
                                        antallSvar = 3,
                                        flervalg = true,
                                        svaralternativer = emptyList(),
                                    ),
                                ),
                            ),
                        ),
                    ),
                ),
                gyldigTilTidspunkt = LocalDateTime.now().toKotlinLocalDateTime(),
            ),
        ) shouldBe true
    }
}
