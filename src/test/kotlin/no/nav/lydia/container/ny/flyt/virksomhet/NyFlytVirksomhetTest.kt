package no.nav.lydia.container.ny.flyt.virksomhet

import io.kotest.matchers.shouldBe
import kotlinx.datetime.toKotlinLocalDate
import no.nav.lydia.abc.tilstandsmaskin.VirksomhetIATilstand
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.avsluttVurdering
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.årsak.domene.BegrunnelseType
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.ÅrsakType
import no.nav.lydia.tilgangskontroll.fia.Rolle
import org.junit.AfterClass
import org.junit.BeforeClass
import java.time.LocalDate
import kotlin.test.Test

class NyFlytVirksomhetTest {
    companion object {
        @BeforeClass
        @JvmStatic
        fun setUp() {
            NyFlytTestUtils.setUpKonsumenter()
        }

        @AfterClass
        @JvmStatic
        fun tearDown() {
            NyFlytTestUtils.tearDownKonsumenter()
        }
    }

    @Test
    fun `skal kunne avslutte vurdering som ikke medfører et samarbeid`() {
        val sak = NyFlytTestUtils.vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES

        val oppdatertSakDto = sak.avsluttVurdering(
            valgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_ER_FERDIG_VURDERT_OG_TAKKET_NEI,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_ER_IKKE_MOTIVERT_ELLER_HAR_IKKE_KAPASITET,
                    BegrunnelseType.VIRKSOMHETEN_FERDIG_VURDERT_TAKKET_NEI_ANNET,
                ),
                dato = LocalDate.now().plusDays(20).toKotlinLocalDate(),
            ),
        )
        oppdatertSakDto.status shouldBe IASak.Status.VURDERT

        NyFlytTestUtils.verifiserIASakObserversErVarslet(
            iASakDto = oppdatertSakDto,
            forventedeIASakStatuser = listOf(IASak.Status.VURDERES, IASak.Status.VURDERT),
            forventetIASakStatusIStatistikk = IASak.Status.VURDERT,
            rolle = Rolle.SUPERBRUKER,
            hendelseType = IASakshendelseType.VURDERING_FULLFØRT_UTEN_SAMARBEID,
            begrunnelser = listOf(
                BegrunnelseType.VIRKSOMHETEN_ER_IKKE_MOTIVERT_ELLER_HAR_IKKE_KAPASITET,
                BegrunnelseType.VIRKSOMHETEN_FERDIG_VURDERT_TAKKET_NEI_ANNET,
            ),
        )
    }

    @Test
    fun `avslutt vurdering med gyldig årsak gir tilstand VirksomhetErVurdert og nesteTilstand VirksomhetKlarTilVurdering`() {
        val sak = NyFlytTestUtils.vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES

        sak.avsluttVurdering(
            valgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_ER_FERDIG_VURDERT_MED_INTERN_VURDERING,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_HAR_FOR_LAVT_POTENSIALE,
                    BegrunnelseType.VIRKSOMHETEN_MANGLER_REPRESANTANTER_ELLER_ETABLERT_PARTSGRUPPE,
                ),
                dato = LocalDate.now().plusDays(20).toKotlinLocalDate(),
            ),
        )

        val virksomhetsTilstand = NyFlytTestUtils.hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstand.tilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        virksomhetsTilstand.nesteTilstand!!.startTilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        virksomhetsTilstand.nesteTilstand.planlagtHendelse shouldBe "GjørVirksomhetKlarTilNyVurdering"
        virksomhetsTilstand.nesteTilstand.nyTilstand shouldBe VirksomhetIATilstand.VirksomhetKlarTilVurdering
        virksomhetsTilstand.nesteTilstand.planlagtDato shouldBe LocalDate.now().plusDays(20).toKotlinLocalDate()
    }

    @Test
    fun `avslutt vurdering med årsak 'skal vurderes senere' gir tilstand VirksomhetErVurdert og nesteTilstand VirksomhetVurderes`() {
        val sak = NyFlytTestUtils.vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES

        sak.avsluttVurdering(
            valgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_VURDERES_PÅ_ET_SENERE_TIDSPUNKT,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_ØNSKER_Å_BLI_KONTAKTET_SENERE,
                ),
                dato = LocalDate.now().plusDays(20).toKotlinLocalDate(),
            ),
        )

        val virksomhetsTilstand = NyFlytTestUtils.hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstand.tilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        virksomhetsTilstand.nesteTilstand!!.startTilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        virksomhetsTilstand.nesteTilstand.planlagtHendelse shouldBe "VurderVirksomhet"
        virksomhetsTilstand.nesteTilstand.nyTilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes
        virksomhetsTilstand.nesteTilstand.planlagtDato shouldBe LocalDate.now().plusDays(20).toKotlinLocalDate()
    }
}
