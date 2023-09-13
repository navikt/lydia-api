package no.nav.lydia.container.sykefraversstatistikk

import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.StatistikkHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestData
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.sykefraversstatistikk.api.Periode

import kotlin.test.Test

class SykefraversstatistikkVirksomhetApiTest {

    @Test
    fun `skal kunne hente sykefraværsstatistikk fra siste tilgjengelige kvartal`() {
        val gjeldendePeriode = TestData.gjeldendePeriode
        val virksomhet = TestVirksomhet.nyVirksomhet()
        VirksomhetHelper.lastInnTestdata(
                TestData().lagData(
                        virksomhet = virksomhet,
                        perioder = listOf(
                                gjeldendePeriode,
                                gjeldendePeriode.forrigePeriode(),
                                Periode(kvartal = 4, årstall = 2019)
                        ),
                )
        )
        val sykefraværsprosentSisteTilgjengeligeKvartal = TestContainerHelper.postgresContainer.hentEnkelKolonne<Double>(
                """select sykefraversprosent from sykefravar_statistikk_virksomhet 
                where orgnr='${virksomhet.orgnr}' 
                and kvartal=${gjeldendePeriode.kvartal}
                and arstall=${gjeldendePeriode.årstall}
                """.trimMargin()
        )

        val result =
                StatistikkHelper.hentSykefraværForVirksomhetSisteTilgjengeligKvartal(orgnummer = virksomhet.orgnr)
        result.arstall shouldBe gjeldendePeriode.årstall
        result.kvartal shouldBe gjeldendePeriode.kvartal
        result.sykefraversprosent shouldBe sykefraværsprosentSisteTilgjengeligeKvartal
    }

    @Test
    fun `skal kunne hente sykefraværsstatistikk riktig når vi mangler siste periode`() {
        val gjeldendePeriode = TestData.gjeldendePeriode
        val virksomhet = TestVirksomhet.nyVirksomhet()
        VirksomhetHelper.lastInnTestdata(
                TestData().lagData(
                        virksomhet = virksomhet,
                        perioder = listOf(gjeldendePeriode.forrigePeriode()), // uten siste periode
                )
        )
        val sykefraværsprosentSisteTilgjengeligeKvartal = TestContainerHelper.postgresContainer.hentEnkelKolonne<Double>(
                """select sykefraversprosent from sykefravar_statistikk_virksomhet 
                where orgnr='${virksomhet.orgnr}' 
                and kvartal=${gjeldendePeriode.forrigePeriode().kvartal}
                and arstall=${gjeldendePeriode.forrigePeriode().årstall}
                """.trimMargin()
        )

        val result =
                StatistikkHelper.hentSykefraværForVirksomhetSisteTilgjengeligKvartal(orgnummer = virksomhet.orgnr)
        result.sykefraversprosent shouldBe sykefraværsprosentSisteTilgjengeligeKvartal
    }
}
