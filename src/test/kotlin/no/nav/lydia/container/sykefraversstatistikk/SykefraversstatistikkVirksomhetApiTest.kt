package no.nav.lydia.container.sykefraversstatistikk

import com.github.kittinunf.fuel.core.extensions.authentication
import ia.felles.definisjoner.bransjer.Bransjer.TRANSPORT
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.StatistikkHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestData
import no.nav.lydia.helper.TestData.Companion.NÆRING_JORDBRUK
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.sykefraversstatistikk.api.Periode
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.lydia.sykefraversstatistikk.domene.BransjeSykefraværsstatistikk
import no.nav.lydia.sykefraversstatistikk.domene.NæringSykefraværsstatistikk
import kotlin.test.Test
import kotlin.test.fail

class SykefraversstatistikkVirksomhetApiTest {

    @Test
    fun `skal hente sykefraværsstatistikk for næring`(){
        SykefraversstatistikkApiTest.settSykefraværsprosentNæring(NÆRING_JORDBRUK, 4.5)

        val result = TestContainerHelper.lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/naring/${NÆRING_JORDBRUK}")
                .authentication().bearer(TestContainerHelper.oauth2ServerContainer.saksbehandler1.token)
                .tilSingelRespons<NæringSykefraværsstatistikk>()

        result.second.statusCode shouldBe 200
        val næringstatistikk: NæringSykefraværsstatistikk = result.third
                .fold(success = { response -> response }, failure = { fail(it.message) })
        næringstatistikk.næring shouldBe NÆRING_JORDBRUK
        næringstatistikk.siste4Kvartal.prosent shouldBe 4.5
        næringstatistikk.siste4Kvartal.kvartaler.size shouldBe 1
        næringstatistikk.siste4Kvartal.erMaskert shouldBe false
        næringstatistikk.sisteGjeldendeKvartal.erMaskert shouldBe false
        næringstatistikk.sisteGjeldendeKvartal.prosent shouldBe 2.0
    }

    @Test
    fun `skal hente sykefraværsstatistikk for bransje`(){
        SykefraversstatistikkApiTest.settSykefraværsprosentBransje(TRANSPORT, 9.9, 8.7)

        val url = "$SYKEFRAVERSSTATISTIKK_PATH/bransje/${TRANSPORT.name}"
        val result = TestContainerHelper.lydiaApiContainer.performGet(url)
                .authentication().bearer(TestContainerHelper.oauth2ServerContainer.saksbehandler1.token)
                .tilSingelRespons<BransjeSykefraværsstatistikk>()

        result.second.statusCode shouldBe 200
        val bransjestatistikk: BransjeSykefraværsstatistikk = result.third
                .fold(success = { response -> response }, failure = { fail(it.message) })
        bransjestatistikk.bransje shouldBe TRANSPORT.name
        bransjestatistikk.siste4Kvartal.prosent shouldBe 9.9
        bransjestatistikk.siste4Kvartal.kvartaler.size shouldBe 1
        bransjestatistikk.siste4Kvartal.erMaskert shouldBe false
        bransjestatistikk.sisteGjeldendeKvartal.prosent shouldBe 8.7
        bransjestatistikk.sisteGjeldendeKvartal.erMaskert shouldBe false
    }

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
    fun `skal kunne hente statistikk for gradert sykemelding fra siste gjeldende kvartal`() {
        val gjeldendePeriode = TestData.gjeldendePeriode
        val virksomhet = TestVirksomhet.nyVirksomhet()
        VirksomhetHelper.lastInnTestdata(
                TestData().lagData(
                        virksomhet = virksomhet,
                        tapteDagsverk = 1000.0,
                        graderingsprosent = 25.9,
                        perioder = listOf(
                                gjeldendePeriode,
                                gjeldendePeriode.forrigePeriode(),
                                Periode(kvartal = 4, årstall = 2019)
                        ),
                )
        )
        val result =
                StatistikkHelper.hentSykefraværForVirksomhetSisteTilgjengeligKvartal(orgnummer = virksomhet.orgnr)
        result.arstall shouldBe gjeldendePeriode.årstall
        result.kvartal shouldBe gjeldendePeriode.kvartal
        result.graderingsprosent shouldBe 25.9
        result.tapteDagsverkGradert shouldBe 259.0
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
