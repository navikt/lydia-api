package no.nav.lydia.container.ny.flyt

import io.kotest.matchers.shouldBe
import no.nav.lydia.ia.sak.api.ny.flyt.Hendelse.VurderVirksomhet
import no.nav.lydia.ia.sak.api.ny.flyt.Tilstand
import no.nav.lydia.ia.sak.api.ny.flyt.Tilstand.VirksomhetKlarTilVurdering
import no.nav.lydia.ia.sak.api.ny.flyt.Tilstandsmaskin
import kotlin.test.Test

class TilstandsmaskinUnitTest {

    @Test
    fun `hendelse 'vurdervirksomhet' gir tilstand VirksomhetVurderes`() {
        val tilstandsmaskin = Tilstandsmaskin(startTilstand = VirksomhetKlarTilVurdering)
        val nyTilstand = tilstandsmaskin.prosessHendelse(VurderVirksomhet(orgnr = "987654321"))

        nyTilstand shouldBe Tilstand.VirksomhetVurderes
    }
}
