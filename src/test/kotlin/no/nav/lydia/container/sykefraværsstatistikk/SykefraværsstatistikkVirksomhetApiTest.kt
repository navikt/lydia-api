package no.nav.lydia.container.sykefraværsstatistikk

import com.github.kittinunf.fuel.core.extensions.authentication
import ia.felles.definisjoner.bransjer.Bransje.TRANSPORT
import io.kotest.matchers.shouldBe
import no.nav.lydia.Topic
import no.nav.lydia.helper.StatistikkHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.TestData
import no.nav.lydia.helper.TestData.Companion.NÆRING_JORDBRUK
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.helper.lagSykefraværsstatistikkPerKategoriImportDto
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.sykefraværsstatistikk.api.Periode
import no.nav.lydia.sykefraværsstatistikk.api.SYKEFRAVÆRSSTATISTIKK_PATH
import no.nav.lydia.sykefraværsstatistikk.domene.BransjeSykefraværsstatistikk
import no.nav.lydia.sykefraværsstatistikk.domene.NæringSykefraværsstatistikk
import no.nav.lydia.sykefraværsstatistikk.import.GraderingSiste4Kvartal
import no.nav.lydia.sykefraværsstatistikk.import.GraderingSistePubliserteKvartal
import no.nav.lydia.sykefraværsstatistikk.import.GradertSykemeldingImportDto
import no.nav.lydia.sykefraværsstatistikk.import.Kategori
import no.nav.lydia.sykefraværsstatistikk.import.SykefraværsstatistikkMetadataVirksomhetImportDto
import no.nav.lydia.virksomhet.domene.Sektor
import kotlin.test.Test
import kotlin.test.fail

class SykefraværsstatistikkVirksomhetApiTest {
    @Test
    fun `skal hente sykefraværsstatistikk for næring`() {
        SykefraværsstatistikkApiTest.settSykefraværsprosentNæring(NÆRING_JORDBRUK, 4.5)

        val result =
            applikasjon.performGet("$SYKEFRAVÆRSSTATISTIKK_PATH/naring/${NÆRING_JORDBRUK}")
                .authentication().bearer(authContainerHelper.saksbehandler1.token)
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
    fun `skal hente sykefraværsstatistikk for bransje`() {
        SykefraværsstatistikkApiTest.settSykefraværsprosentBransje(TRANSPORT, 9.9, 8.7)

        val url = "$SYKEFRAVÆRSSTATISTIKK_PATH/bransje/${TRANSPORT.name}"
        val result = applikasjon.performGet(url)
            .authentication().bearer(authContainerHelper.saksbehandler1.token)
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
                    Periode(kvartal = 4, årstall = 2019),
                ),
            ),
        )
        val sykefraværsprosentSisteTilgjengeligeKvartal =
            postgresContainerHelper.hentEnkelKolonne<Double>(
                """select sykefravarsprosent from sykefravar_statistikk_virksomhet 
                where orgnr='${virksomhet.orgnr}' 
                and kvartal=${gjeldendePeriode.kvartal}
                and arstall=${gjeldendePeriode.årstall}
                """.trimMargin(),
            )

        val result =
            StatistikkHelper.hentSykefraværForVirksomhetSisteTilgjengeligKvartal(orgnummer = virksomhet.orgnr)
        result.arstall shouldBe gjeldendePeriode.årstall
        result.kvartal shouldBe gjeldendePeriode.kvartal
        result.sykefraværsprosent shouldBe sykefraværsprosentSisteTilgjengeligeKvartal
    }

    @Test
    fun `skal kunne hente statistikk selv om virksomheten mangler statistikk for gradering`() {
        val gjeldendePeriode = TestData.gjeldendePeriode
        val virksomhet = TestVirksomhet.nyVirksomhet()
        val statistikk = lagSykefraværsstatistikkPerKategoriImportDto(
            kategori = Kategori.VIRKSOMHET,
            kode = virksomhet.orgnr,
            periode = TestData.gjeldendePeriode,
            sykefraværsProsent = 5.3,
            antallPersoner = 100,
            tapteDagsverk = 35.0,
        )
        kafkaContainerHelper.sendSykefraværsstatistikkPerKategoriIBulkOgVentTilKonsumert(
            importDtoer = listOf(statistikk),
            topic = Topic.STATISTIKK_VIRKSOMHET_TOPIC,
        )

        kafkaContainerHelper.sendStatistikkMetadataVirksomhetIBulkOgVentTilKonsumert(
            listOf(
                SykefraværsstatistikkMetadataVirksomhetImportDto(
                    orgnr = virksomhet.orgnr,
                    årstall = TestData.gjeldendePeriode.årstall,
                    kvartal = TestData.gjeldendePeriode.kvartal,
                    sektor = Sektor.PRIVAT.name,
                    bransje = virksomhet.næringsundergruppe1.tilBransje()?.name,
                    naring = virksomhet.næringsundergruppe1.tilTosifret(),
                ),
            ),
        )

        val resultStatistikkSisteKvartal =
            StatistikkHelper.hentSykefraværForVirksomhetSisteTilgjengeligKvartal(orgnummer = virksomhet.orgnr)
        resultStatistikkSisteKvartal.arstall shouldBe gjeldendePeriode.årstall
        resultStatistikkSisteKvartal.kvartal shouldBe gjeldendePeriode.kvartal
        resultStatistikkSisteKvartal.sykefraværsprosent shouldBe 5.3
        resultStatistikkSisteKvartal.graderingsprosent shouldBe null
        resultStatistikkSisteKvartal.tapteDagsverkGradert shouldBe null

        val resultStatistikkSiste4Kvartal =
            StatistikkHelper.hentSykefraværForVirksomhetSiste4Kvartaler(orgnummer = virksomhet.orgnr)
        resultStatistikkSiste4Kvartal.sykefraværsprosent shouldBe 5.3
        resultStatistikkSiste4Kvartal.graderingsprosent shouldBe null
        resultStatistikkSiste4Kvartal.tapteDagsverkGradert shouldBe null
    }

    @Test
    fun `skal kunne hente statistikk for gradert sykemelding fra siste tilgjengelige kvartal`() {
        val gjeldendePeriode = TestData.gjeldendePeriode
        val virksomhet = TestVirksomhet.nyVirksomhet()
        val graderingsprosentGjeldendePeriode = 25.9
        VirksomhetHelper.lastInnTestdata(
            TestData().lagData(
                virksomhet = virksomhet,
                tapteDagsverk = 1000.0,
                graderingsprosent = graderingsprosentGjeldendePeriode,
                perioder = listOf(
                    gjeldendePeriode,
                ),
            ),
        )
        // Legg til testdata i forrige periode så vi kan verifisere at disse ikke blir hentet
        val statistikk = GradertSykemeldingImportDto(
            kategori = "VIRKSOMHET_GRADERT",
            kode = virksomhet.orgnr,
            sistePubliserteKvartal = GraderingSistePubliserteKvartal(
                årstall = gjeldendePeriode.forrigePeriode().årstall,
                kvartal = gjeldendePeriode.forrigePeriode().kvartal,
                prosent = 32.5,
                tapteDagsverkGradert = 1000.0,
                tapteDagsverk = 10000.0,
                antallPersoner = 150,
                erMaskert = false,
            ),
            siste4Kvartal = GraderingSiste4Kvartal(
                prosent = 25.3,
                tapteDagsverkGradert = 900.0,
                tapteDagsverk = 7000.0,
                erMaskert = false,
                kvartaler = listOf(
                    TestData.gjeldendePeriode.tilKvartal(),
                    TestData.gjeldendePeriode.forrigePeriode().tilKvartal(),
                ),
            ),
        )
        kafkaContainerHelper.sendStatistikkVirksomhetGraderingOgVentTilKonsumert(
            importDtoer = listOf(statistikk),
            topic = Topic.STATISTIKK_VIRKSOMHET_GRADERING_TOPIC,
        )

        val result =
            StatistikkHelper.hentSykefraværForVirksomhetSisteTilgjengeligKvartal(orgnummer = virksomhet.orgnr)
        result.arstall shouldBe gjeldendePeriode.årstall
        result.kvartal shouldBe gjeldendePeriode.kvartal
        result.graderingsprosent shouldBe graderingsprosentGjeldendePeriode
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
            ),
        )
        val sykefraværsprosentSisteTilgjengeligeKvartal =
            postgresContainerHelper.hentEnkelKolonne<Double>(
                """select sykefravarsprosent from sykefravar_statistikk_virksomhet 
                where orgnr='${virksomhet.orgnr}' 
                and kvartal=${gjeldendePeriode.forrigePeriode().kvartal}
                and arstall=${gjeldendePeriode.forrigePeriode().årstall}
                """.trimMargin(),
            )

        val result =
            StatistikkHelper.hentSykefraværForVirksomhetSisteTilgjengeligKvartal(orgnummer = virksomhet.orgnr)
        result.sykefraværsprosent shouldBe sykefraværsprosentSisteTilgjengeligeKvartal
    }

    @Test
    fun `skal kunne hente sykefraværsstatistikk riktig når vi har nyere perioder enn gjeldene`() {
        val gjeldendePeriode = TestData.gjeldendePeriode
        val virksomhet = TestVirksomhet.nyVirksomhet()
        VirksomhetHelper.lastInnTestdata(
            TestData().lagData(
                virksomhet = virksomhet,
                perioder = listOf(gjeldendePeriode, gjeldendePeriode.nestePeriode()), // med ekstra periode
            ),
        )
        val sykefraværsprosentSisteTilgjengeligeKvartal =
            postgresContainerHelper.hentEnkelKolonne<Double>(
                """select sykefravarsprosent from sykefravar_statistikk_virksomhet 
                where orgnr='${virksomhet.orgnr}' 
                and kvartal=${gjeldendePeriode.kvartal}
                and arstall=${gjeldendePeriode.årstall}
                """.trimMargin(),
            )

        val result =
            StatistikkHelper.hentSykefraværForVirksomhetSisteTilgjengeligKvartal(orgnummer = virksomhet.orgnr)
        result.sykefraværsprosent shouldBe sykefraværsprosentSisteTilgjengeligeKvartal
    }
}
