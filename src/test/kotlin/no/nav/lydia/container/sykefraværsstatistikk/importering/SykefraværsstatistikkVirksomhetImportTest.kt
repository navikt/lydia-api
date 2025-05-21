package no.nav.lydia.container.sykefraværsstatistikk.importering

import io.kotest.assertions.shouldFail
import io.kotest.matchers.shouldBe
import no.nav.lydia.Topic
import no.nav.lydia.container.sykefraværsstatistikk.importering.SykefraværsstatistikkImportTestUtils.Companion.KVARTAL_2022_4
import no.nav.lydia.container.sykefraværsstatistikk.importering.SykefraværsstatistikkImportTestUtils.Companion.KVARTAL_2023_1
import no.nav.lydia.container.sykefraværsstatistikk.importering.SykefraværsstatistikkImportTestUtils.Companion.cleanUpGraderingStatistikkSiste4KvartalTable
import no.nav.lydia.container.sykefraværsstatistikk.importering.SykefraværsstatistikkImportTestUtils.Companion.cleanUpGraderingStatistikkTable
import no.nav.lydia.container.sykefraværsstatistikk.importering.SykefraværsstatistikkImportTestUtils.Companion.cleanUpStatistikkSiste4KvartalTable
import no.nav.lydia.container.sykefraværsstatistikk.importering.SykefraværsstatistikkImportTestUtils.Companion.cleanUpStatistikkTable
import no.nav.lydia.container.sykefraværsstatistikk.importering.SykefraværsstatistikkImportTestUtils.Companion.hentStatistikkGjeldendeKvartal
import no.nav.lydia.container.sykefraværsstatistikk.importering.SykefraværsstatistikkImportTestUtils.Companion.hentStatistikkSiste4Kvartal
import no.nav.lydia.container.sykefraværsstatistikk.importering.SykefraværsstatistikkImportTestUtils.Companion.hentStatistikkVirksomhetGraderingGjeldendeKvartal
import no.nav.lydia.container.sykefraværsstatistikk.importering.SykefraværsstatistikkImportTestUtils.Companion.hentStatistikkVirksomhetGraderingSiste4Kvartal
import no.nav.lydia.container.sykefraværsstatistikk.importering.SykefraværsstatistikkImportTestUtils.Companion.siste4KvartalShouldBeEqual
import no.nav.lydia.container.sykefraværsstatistikk.importering.SykefraværsstatistikkImportTestUtils.Companion.sistePubliserteKvartalShouldBeEqual
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldNotContainLog
import no.nav.lydia.sykefraværsstatistikk.import.GraderingSiste4Kvartal
import no.nav.lydia.sykefraværsstatistikk.import.GraderingSistePubliserteKvartal
import no.nav.lydia.sykefraværsstatistikk.import.Kategori.VIRKSOMHET
import no.nav.lydia.sykefraværsstatistikk.import.Siste4Kvartal
import no.nav.lydia.sykefraværsstatistikk.import.SistePubliserteKvartal
import kotlin.test.BeforeTest
import kotlin.test.Test

class SykefraværsstatistikkVirksomhetImportTest {
    private val sistePubliserteKvartal: SistePubliserteKvartal =
        SistePubliserteKvartal(
            årstall = KVARTAL_2023_1.årstall,
            kvartal = KVARTAL_2023_1.kvartal,
            tapteDagsverk = 1740.5,
            muligeDagsverk = 76139.3,
            prosent = 2.3,
            erMaskert = false,
            antallPersoner = 1789,
        )
    private val siste4Kvartal: Siste4Kvartal =
        Siste4Kvartal(
            tapteDagsverk = 8020.0,
            muligeDagsverk = 300991.3,
            prosent = 2.7,
            erMaskert = false,
            kvartaler = listOf(KVARTAL_2023_1),
        )

    private val graderingSistePubliserteKvartal: GraderingSistePubliserteKvartal =
        GraderingSistePubliserteKvartal(
            årstall = KVARTAL_2023_1.årstall,
            kvartal = KVARTAL_2023_1.kvartal,
            tapteDagsverkGradert = 76139.3,
            tapteDagsverk = 1740.5,
            prosent = 2.3,
            erMaskert = false,
            antallPersoner = 1789,
        )
    private val graderingSiste4Kvartal: GraderingSiste4Kvartal =
        GraderingSiste4Kvartal(
            tapteDagsverkGradert = 300991.3,
            tapteDagsverk = 8020.0,
            prosent = 2.7,
            erMaskert = false,
            kvartaler = listOf(KVARTAL_2023_1),
        )

    @BeforeTest
    fun cleanUp() {
        cleanUpGraderingStatistikkTable(kvartal = KVARTAL_2023_1)
        cleanUpGraderingStatistikkSiste4KvartalTable(kvartal = KVARTAL_2023_1)
        cleanUpStatistikkTable(VIRKSOMHET, "999999999")
        cleanUpStatistikkSiste4KvartalTable(VIRKSOMHET, "999999999")
    }

    @Test
    fun `vi tar hensyn til maskering på gradering siste publiserte kvartal`() {
        val kafkaMelding = SykefraværsstatistikkImportTestUtils.JsonMeldingGradering(
            kategori = "VIRKSOMHET_GRADERT",
            kode = "999999997",
            kvartal = KVARTAL_2023_1,
            sistePubliserteKvartal = graderingSistePubliserteKvartal.copy(
                tapteDagsverkGradert = 10.0,
                tapteDagsverk = 100.0,
                prosent = 10.0,
                antallPersoner = 4,
                erMaskert = true,
            ),
            siste4Kvartal = graderingSiste4Kvartal,
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            kafkaMelding.toJsonKey(),
            kafkaMelding.toJsonValue(),
            Topic.STATISTIKK_VIRKSOMHET_GRADERING_TOPIC,
        )

        val gjeldendeKvartal =
            hentStatistikkVirksomhetGraderingGjeldendeKvartal(orgnr = "999999997", kvartal = KVARTAL_2023_1)

        gjeldendeKvartal.graderingSistePubliserteKvartal.erMaskert shouldBe true
        gjeldendeKvartal.graderingSistePubliserteKvartal.prosent shouldBe 0.0
        gjeldendeKvartal.graderingSistePubliserteKvartal.tapteDagsverk shouldBe 0.0
        gjeldendeKvartal.graderingSistePubliserteKvartal.tapteDagsverkGradert shouldBe 0.0
    }

    @Test
    fun `vi tar hensyn til maskering på gradering siste 4 kvartal`() {
        val kafkaMelding = SykefraværsstatistikkImportTestUtils.JsonMeldingGradering(
            kategori = "VIRKSOMHET_GRADERT",
            kode = "999999997",
            kvartal = KVARTAL_2023_1,
            siste4Kvartal = graderingSiste4Kvartal.copy(
                tapteDagsverkGradert = 10.0,
                tapteDagsverk = 100.0,
                prosent = 10.0,
                erMaskert = true,
            ),
            sistePubliserteKvartal = graderingSistePubliserteKvartal,
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            kafkaMelding.toJsonKey(),
            kafkaMelding.toJsonValue(),
            Topic.STATISTIKK_VIRKSOMHET_GRADERING_TOPIC,
        )

        val siste4Kvartaler =
            hentStatistikkVirksomhetGraderingSiste4Kvartal(orgnr = "999999997", kvartal = KVARTAL_2023_1)

        siste4Kvartaler.graderingSiste4Kvartal.erMaskert shouldBe true
        siste4Kvartaler.graderingSiste4Kvartal.prosent shouldBe 0.0
        siste4Kvartaler.graderingSiste4Kvartal.tapteDagsverk shouldBe 0.0
        siste4Kvartaler.graderingSiste4Kvartal.tapteDagsverkGradert shouldBe 0.0
        siste4Kvartaler.publisertÅrstall shouldBe KVARTAL_2023_1.årstall
        siste4Kvartaler.publisertKvartal shouldBe KVARTAL_2023_1.kvartal
    }

    @Test
    fun `vi lagrer IKKE statistikk når alt er NULL`() {
        val kafkaMelding = SykefraværsstatistikkImportTestUtils.JsonMeldingGradering(
            kategori = "VIRKSOMHET_GRADERT",
            kode = "999999997",
            kvartal = KVARTAL_2023_1,
            sistePubliserteKvartal = graderingSistePubliserteKvartal.copy(
                tapteDagsverkGradert = null,
                tapteDagsverk = null,
                prosent = null,
            ),
            siste4Kvartal = graderingSiste4Kvartal.copy(
                tapteDagsverkGradert = null,
                tapteDagsverk = null,
                prosent = null,
            ),
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            kafkaMelding.toJsonKey(),
            kafkaMelding.toJsonValue(),
            Topic.STATISTIKK_VIRKSOMHET_GRADERING_TOPIC,
        )

        applikasjon shouldNotContainLog "PSQLException: ERROR: null value in column".toRegex()
        shouldFail {
            hentStatistikkVirksomhetGraderingGjeldendeKvartal(orgnr = "999999997", kvartal = KVARTAL_2023_1)
        }
        shouldFail {
            hentStatistikkVirksomhetGraderingSiste4Kvartal(orgnr = "999999997", kvartal = KVARTAL_2023_1)
        }
    }

    @Test
    fun `vi lagrer statistikk når prosent er NULL`() {
        val kafkaMelding = SykefraværsstatistikkImportTestUtils.JsonMeldingGradering(
            kategori = "VIRKSOMHET_GRADERT",
            kode = "999999998",
            kvartal = KVARTAL_2023_1,
            sistePubliserteKvartal = graderingSistePubliserteKvartal.copy(
                tapteDagsverkGradert = 0.0,
                tapteDagsverk = 0.0,
                prosent = null,
            ),
            siste4Kvartal = graderingSiste4Kvartal.copy(
                tapteDagsverkGradert = 0.0,
                tapteDagsverk = 0.0,
                prosent = null,
            ),
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            kafkaMelding.toJsonKey(),
            kafkaMelding.toJsonValue(),
            Topic.STATISTIKK_VIRKSOMHET_GRADERING_TOPIC,
        )

        val graderingGjeldendeKvartal =
            hentStatistikkVirksomhetGraderingGjeldendeKvartal(orgnr = "999999998", kvartal = KVARTAL_2023_1)
        val graderingSiste4Kvartal =
            hentStatistikkVirksomhetGraderingSiste4Kvartal(orgnr = "999999998", kvartal = KVARTAL_2023_1)

        graderingGjeldendeKvartal.graderingSistePubliserteKvartal.prosent shouldBe null
        graderingSiste4Kvartal.graderingSiste4Kvartal.prosent shouldBe null
    }

    @Test
    fun `vi lagrer sykefraværsstatistikk for kategori VIRKSOMHET (både siste kvartal OG siste 4 kvartaler)`() {
        val kafkaMelding = SykefraværsstatistikkImportTestUtils.JsonMelding(
            kategori = VIRKSOMHET,
            kode = "999999999",
            kvartal = KVARTAL_2023_1,
            sistePubliserteKvartal = sistePubliserteKvartal,
            siste4Kvartal = siste4Kvartal,
        )

        kafkaContainerHelper.sendOgVentTilKonsumert(
            kafkaMelding.toJsonKey(),
            kafkaMelding.toJsonValue(),
            Topic.STATISTIKK_VIRKSOMHET_TOPIC,
        )

        kafkaMelding sistePubliserteKvartalShouldBeEqual
            hentStatistikkGjeldendeKvartal(
                VIRKSOMHET,
                "999999999",
                KVARTAL_2023_1,
            ).sistePubliserteKvartal
        kafkaMelding siste4KvartalShouldBeEqual
            hentStatistikkSiste4Kvartal(VIRKSOMHET, "999999999", KVARTAL_2023_1).siste4Kvartal
    }

    @Test
    fun `vi lagrer statistikk for gradert sykemelding i siste kvartal`() {
        val kafkaMelding = SykefraværsstatistikkImportTestUtils.JsonMeldingGradering(
            kategori = "VIRKSOMHET_GRADERT",
            kode = "999999999",
            kvartal = KVARTAL_2023_1,
            sistePubliserteKvartal = graderingSistePubliserteKvartal,
            siste4Kvartal = graderingSiste4Kvartal,
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            kafkaMelding.toJsonKey(),
            kafkaMelding.toJsonValue(),
            Topic.STATISTIKK_VIRKSOMHET_GRADERING_TOPIC,
        )

        applikasjon shouldContainLog
            "Lagret 1 meldinger i StatistikkVirksomhetGraderingConsumer \\(topic 'pia.sykefravarsstatistikk-virksomhet-gradert-v1'\\)"
                .toRegex()

        val resultat = hentStatistikkVirksomhetGraderingGjeldendeKvartal(orgnr = "999999999", kvartal = KVARTAL_2023_1)
        resultat.orgnr shouldBe "999999999"
        resultat.graderingSistePubliserteKvartal.prosent shouldBe graderingSistePubliserteKvartal.prosent
        resultat.graderingSistePubliserteKvartal.tapteDagsverkGradert shouldBe graderingSistePubliserteKvartal.tapteDagsverkGradert
        resultat.graderingSistePubliserteKvartal.tapteDagsverk shouldBe graderingSistePubliserteKvartal.tapteDagsverk
        resultat.graderingSistePubliserteKvartal.årstall shouldBe graderingSistePubliserteKvartal.årstall
        resultat.graderingSistePubliserteKvartal.kvartal shouldBe graderingSistePubliserteKvartal.kvartal
        resultat.graderingSistePubliserteKvartal.antallPersoner shouldBe graderingSistePubliserteKvartal.antallPersoner
        resultat.graderingSistePubliserteKvartal.erMaskert shouldBe graderingSistePubliserteKvartal.erMaskert
    }

    @Test
    fun `vi lagrer statistikk for gradert sykemelding i de siste 4 kvartaler`() {
        val kafkaMelding = SykefraværsstatistikkImportTestUtils.JsonMeldingGradering(
            kategori = "VIRKSOMHET_GRADERT",
            kode = "999999999",
            kvartal = KVARTAL_2023_1,
            sistePubliserteKvartal = graderingSistePubliserteKvartal,
            siste4Kvartal = graderingSiste4Kvartal,
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            kafkaMelding.toJsonKey(),
            kafkaMelding.toJsonValue(),
            Topic.STATISTIKK_VIRKSOMHET_GRADERING_TOPIC,
        )

        val resultat = hentStatistikkVirksomhetGraderingSiste4Kvartal(orgnr = "999999999", kvartal = KVARTAL_2023_1)
        resultat.orgnr shouldBe "999999999"
        resultat.graderingSiste4Kvartal.prosent shouldBe graderingSiste4Kvartal.prosent
        resultat.graderingSiste4Kvartal.tapteDagsverkGradert shouldBe graderingSiste4Kvartal.tapteDagsverkGradert
        resultat.graderingSiste4Kvartal.tapteDagsverk shouldBe graderingSiste4Kvartal.tapteDagsverk
        resultat.publisertÅrstall shouldBe graderingSistePubliserteKvartal.årstall
        resultat.publisertKvartal shouldBe graderingSistePubliserteKvartal.kvartal
        resultat.graderingSiste4Kvartal.kvartaler shouldBe graderingSiste4Kvartal.kvartaler
        resultat.graderingSiste4Kvartal.erMaskert shouldBe graderingSiste4Kvartal.erMaskert
    }

    @Test
    fun `vi oppdaterer statistikk for gradert sykemelding i både siste kvartal og siste 4 kvartal`() {
        val kafkaMelding = SykefraværsstatistikkImportTestUtils.JsonMeldingGradering(
            kategori = "VIRKSOMHET_GRADERT",
            kode = "999999999",
            kvartal = KVARTAL_2023_1,
            sistePubliserteKvartal = graderingSistePubliserteKvartal,
            siste4Kvartal = graderingSiste4Kvartal,
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            kafkaMelding.toJsonKey(),
            kafkaMelding.toJsonValue(),
            Topic.STATISTIKK_VIRKSOMHET_GRADERING_TOPIC,
        )
        val oppdatertStatistikkMelding = SykefraværsstatistikkImportTestUtils.JsonMeldingGradering(
            kategori = "VIRKSOMHET_GRADERT",
            kode = "999999999",
            kvartal = KVARTAL_2023_1,
            sistePubliserteKvartal = graderingSistePubliserteKvartal.copy(
                tapteDagsverk = 56.0,
                tapteDagsverkGradert = 5.6,
                prosent = 10.0,
                antallPersoner = 200,
                erMaskert = false,
            ),
            siste4Kvartal = graderingSiste4Kvartal.copy(
                tapteDagsverkGradert = 17.2,
                tapteDagsverk = 86.0,
                kvartaler = listOf(KVARTAL_2023_1, KVARTAL_2022_4),
                prosent = 20.0,
                erMaskert = false,
            ),
        )
        kafkaContainerHelper.sendOgVentTilKonsumert(
            oppdatertStatistikkMelding.toJsonKey(),
            oppdatertStatistikkMelding.toJsonValue(),
            Topic.STATISTIKK_VIRKSOMHET_GRADERING_TOPIC,
        )

        val resultatSistePubliserteKvartal = hentStatistikkVirksomhetGraderingGjeldendeKvartal(orgnr = "999999999", kvartal = KVARTAL_2023_1)
        resultatSistePubliserteKvartal.orgnr shouldBe "999999999"
        resultatSistePubliserteKvartal.graderingSistePubliserteKvartal.årstall shouldBe graderingSistePubliserteKvartal.årstall
        resultatSistePubliserteKvartal.graderingSistePubliserteKvartal.kvartal shouldBe graderingSistePubliserteKvartal.kvartal
        resultatSistePubliserteKvartal.graderingSistePubliserteKvartal.erMaskert shouldBe false
        resultatSistePubliserteKvartal.graderingSistePubliserteKvartal.prosent shouldBe 10.0
        resultatSistePubliserteKvartal.graderingSistePubliserteKvartal.tapteDagsverkGradert shouldBe 5.6
        resultatSistePubliserteKvartal.graderingSistePubliserteKvartal.tapteDagsverk shouldBe 56.0
        resultatSistePubliserteKvartal.graderingSistePubliserteKvartal.antallPersoner shouldBe 200

        val resultatSiste4Kvartal = hentStatistikkVirksomhetGraderingSiste4Kvartal(orgnr = "999999999", kvartal = KVARTAL_2023_1)
        resultatSiste4Kvartal.orgnr shouldBe "999999999"
        resultatSiste4Kvartal.publisertÅrstall shouldBe graderingSistePubliserteKvartal.årstall
        resultatSiste4Kvartal.publisertKvartal shouldBe graderingSistePubliserteKvartal.kvartal
        resultatSiste4Kvartal.graderingSiste4Kvartal.erMaskert shouldBe false
        resultatSiste4Kvartal.graderingSiste4Kvartal.prosent shouldBe 20
        resultatSiste4Kvartal.graderingSiste4Kvartal.tapteDagsverkGradert shouldBe 17.2
        resultatSiste4Kvartal.graderingSiste4Kvartal.tapteDagsverk shouldBe 86.0
        resultatSiste4Kvartal.graderingSiste4Kvartal.kvartaler shouldBe listOf(KVARTAL_2023_1, KVARTAL_2022_4)
    }
}
