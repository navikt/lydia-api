package no.nav.lydia.container.sykefraversstatistikk.importering

import io.kotest.assertions.shouldFail
import io.kotest.matchers.shouldBe
import no.nav.lydia.Kafka
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.KVARTAL_2022_4
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.KVARTAL_2023_1
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.cleanUpStatistikkSiste4KvartalTable
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.cleanUpStatistikkTable
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.hentStatistikkGjeldendeKvartal
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.hentStatistikkSiste4Kvartal
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.hentStatistikkVirksomhetGraderingGjeldendeKvartal
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.hentStatistikkVirksomhetGraderingSiste4Kvartal
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.siste4KvartalShouldBeEqual
import no.nav.lydia.container.sykefraversstatistikk.importering.SykefraversstatistikkImportTestUtils.Companion.sistePubliserteKvartalShouldBeEqual
import no.nav.lydia.helper.KafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldNotContainLog
import no.nav.lydia.sykefraversstatistikk.import.GraderingSiste4Kvartal
import no.nav.lydia.sykefraversstatistikk.import.GraderingSistePubliserteKvartal
import no.nav.lydia.sykefraversstatistikk.import.Kategori.VIRKSOMHET
import no.nav.lydia.sykefraversstatistikk.import.Siste4Kvartal
import no.nav.lydia.sykefraversstatistikk.import.SistePubliserteKvartal
import kotlin.test.BeforeTest
import kotlin.test.Test


class SykefraversstatistikkVirksomhetImportTest {
    private val kafkaContainer = TestContainerHelper.kafkaContainerHelper

    private val sistePubliserteKvartal: SistePubliserteKvartal =
        SistePubliserteKvartal(
            årstall = KVARTAL_2023_1.årstall,
            kvartal = KVARTAL_2023_1.kvartal,
            tapteDagsverk = 1740.5,
            muligeDagsverk = 76139.3,
            prosent = 2.3,
            erMaskert = false,
            antallPersoner = 1789
        )
    private val siste4Kvartal: Siste4Kvartal =
        Siste4Kvartal(
            tapteDagsverk = 8020.0,
            muligeDagsverk = 300991.3,
            prosent = 2.7,
            erMaskert = false,
            kvartaler = listOf(KVARTAL_2023_1)
        )

    private val graderingSistePubliserteKvartal: GraderingSistePubliserteKvartal =
        GraderingSistePubliserteKvartal(
            årstall = KVARTAL_2023_1.årstall,
            kvartal = KVARTAL_2023_1.kvartal,
            tapteDagsverkGradert = 76139.3,
            tapteDagsverk = 1740.5,
            prosent = 2.3,
            erMaskert = false,
            antallPersoner = 1789
        )
    private val graderingSiste4Kvartal: GraderingSiste4Kvartal =
        GraderingSiste4Kvartal(
            tapteDagsverkGradert = 300991.3,
            tapteDagsverk = 8020.0,
            prosent = 2.7,
            erMaskert = false,
            kvartaler = listOf(KVARTAL_2023_1)
        )

    @BeforeTest
    fun cleanUp() {
        cleanUpStatistikkTable(VIRKSOMHET, "999999999")
        cleanUpStatistikkSiste4KvartalTable(VIRKSOMHET, "999999999")
    }

    @Test
    fun `vi lagrer IKKE statistikk når alt er NULL`() {
        val kafkaMelding = SykefraversstatistikkImportTestUtils.JsonMeldingGradering(
            kategori = "VIRKSOMHET_GRADERT",
            kode = "999999997",
            kvartal = KVARTAL_2023_1,
            sistePubliserteKvartal = graderingSistePubliserteKvartal.copy(
                tapteDagsverkGradert = null,
                tapteDagsverk = null,
                prosent = null
            ),
            siste4Kvartal = graderingSiste4Kvartal.copy(
                tapteDagsverkGradert = null,
                tapteDagsverk = null,
                prosent = null
            )
        )
        kafkaContainer.sendOgVentTilKonsumert(
            kafkaMelding.toJsonKey(),
            kafkaMelding.toJsonValue(),
            KafkaContainerHelper.statistikkVirksomhetGraderingTopic,
            Kafka.statistikkVirksomhetGraderingGroupId
        )

        lydiaApiContainer shouldNotContainLog "PSQLException: ERROR: null value in column".toRegex()
        shouldFail {
            hentStatistikkVirksomhetGraderingGjeldendeKvartal(orgnr = "999999997", kvartal = KVARTAL_2023_1)
        }
        shouldFail {
            hentStatistikkVirksomhetGraderingSiste4Kvartal(orgnr = "999999997", kvartal = KVARTAL_2023_1)
        }
    }

    @Test
    fun `vi lagrer statistikk når prosent er NULL`() {
        val kafkaMelding = SykefraversstatistikkImportTestUtils.JsonMeldingGradering(
            kategori = "VIRKSOMHET_GRADERT",
            kode = "999999998",
            kvartal = KVARTAL_2023_1,
            sistePubliserteKvartal = graderingSistePubliserteKvartal.copy(
                tapteDagsverkGradert = 0.0,
                tapteDagsverk = 0.0,
                prosent = null
            ),
            siste4Kvartal = graderingSiste4Kvartal.copy(
                tapteDagsverkGradert = 0.0,
                tapteDagsverk = 0.0,
                prosent = null
            )
        )
        kafkaContainer.sendOgVentTilKonsumert(
            kafkaMelding.toJsonKey(),
            kafkaMelding.toJsonValue(),
            KafkaContainerHelper.statistikkVirksomhetGraderingTopic,
            Kafka.statistikkVirksomhetGraderingGroupId
        )

        val graderingGjeldendeKvartal = hentStatistikkVirksomhetGraderingGjeldendeKvartal(orgnr = "999999998", kvartal = KVARTAL_2023_1)
        val graderingSiste4Kvartal = hentStatistikkVirksomhetGraderingSiste4Kvartal(orgnr = "999999998", kvartal = KVARTAL_2023_1)

        graderingGjeldendeKvartal.graderingSistePubliserteKvartal.prosent shouldBe null
        graderingSiste4Kvartal.graderingSiste4Kvartal.prosent shouldBe null
    }

    @Test
    fun `vi lagrer sykefraværsstatistikk for kategori VIRKSOMHET (både siste kvartal OG siste 4 kvartaler)`() {
        val kafkaMelding = SykefraversstatistikkImportTestUtils.JsonMelding(
            kategori = VIRKSOMHET,
            kode = "999999999",
            kvartal = KVARTAL_2023_1,
            sistePubliserteKvartal = sistePubliserteKvartal,
            siste4Kvartal = siste4Kvartal
        )

        kafkaContainer.sendOgVentTilKonsumert(
            kafkaMelding.toJsonKey(),
            kafkaMelding.toJsonValue(),
            KafkaContainerHelper.statistikkVirksomhetTopic,
            Kafka.statistikkVirksomhetGroupId
        )

        kafkaMelding sistePubliserteKvartalShouldBeEqual
                hentStatistikkGjeldendeKvartal(
                    VIRKSOMHET,
                    "999999999",
                    KVARTAL_2023_1
                ).sistePubliserteKvartal
        kafkaMelding siste4KvartalShouldBeEqual
                hentStatistikkSiste4Kvartal(VIRKSOMHET, "999999999", KVARTAL_2023_1).siste4Kvartal
    }

    @Test
    fun `vi lagrer statistikk for gradert sykemelding i siste kvartal`() {
        val kafkaMelding = SykefraversstatistikkImportTestUtils.JsonMeldingGradering(
            kategori = "VIRKSOMHET_GRADERT",
            kode = "999999999",
            kvartal = KVARTAL_2023_1,
            sistePubliserteKvartal = graderingSistePubliserteKvartal,
            siste4Kvartal = graderingSiste4Kvartal
        )
        kafkaContainer.sendOgVentTilKonsumert(
            kafkaMelding.toJsonKey(),
            kafkaMelding.toJsonValue(),
            KafkaContainerHelper.statistikkVirksomhetGraderingTopic,
            Kafka.statistikkVirksomhetGraderingGroupId
        )

        lydiaApiContainer shouldContainLog "Lagret 1 meldinger i StatistikkVirksomhetGraderingConsumer \\(topic 'arbeidsgiver.sykefravarsstatistikk-virksomhet-gradert-v1'\\)".toRegex()

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
        val kafkaMelding = SykefraversstatistikkImportTestUtils.JsonMeldingGradering(
            kategori = "VIRKSOMHET_GRADERT",
            kode = "999999999",
            kvartal = KVARTAL_2023_1,
            sistePubliserteKvartal = graderingSistePubliserteKvartal,
            siste4Kvartal = graderingSiste4Kvartal
        )
        kafkaContainer.sendOgVentTilKonsumert(
            kafkaMelding.toJsonKey(),
            kafkaMelding.toJsonValue(),
            KafkaContainerHelper.statistikkVirksomhetGraderingTopic,
            Kafka.statistikkVirksomhetGraderingGroupId
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
        val kafkaMelding = SykefraversstatistikkImportTestUtils.JsonMeldingGradering(
            kategori = "VIRKSOMHET_GRADERT",
            kode = "999999999",
            kvartal = KVARTAL_2023_1,
            sistePubliserteKvartal = graderingSistePubliserteKvartal,
            siste4Kvartal = graderingSiste4Kvartal
        )
        kafkaContainer.sendOgVentTilKonsumert(
            kafkaMelding.toJsonKey(),
            kafkaMelding.toJsonValue(),
            KafkaContainerHelper.statistikkVirksomhetGraderingTopic,
            Kafka.statistikkVirksomhetGraderingGroupId
        )
        val oppdatertStatistikkMelding = SykefraversstatistikkImportTestUtils.JsonMeldingGradering(
            kategori = "VIRKSOMHET_GRADERT",
            kode = "999999999",
            kvartal = KVARTAL_2023_1,
            sistePubliserteKvartal = graderingSistePubliserteKvartal.copy(
                tapteDagsverk = 56.0,
                tapteDagsverkGradert = 5.6,
                prosent = 10.0,
                antallPersoner = 200,
                erMaskert = false
            ),
            siste4Kvartal = graderingSiste4Kvartal.copy(
                tapteDagsverkGradert = 17.2,
                tapteDagsverk = 86.0,
                kvartaler = listOf(KVARTAL_2023_1, KVARTAL_2022_4),
                prosent = 20.0,
                erMaskert = false
            )
        )
        kafkaContainer.sendOgVentTilKonsumert(
            oppdatertStatistikkMelding.toJsonKey(),
            oppdatertStatistikkMelding.toJsonValue(),
            KafkaContainerHelper.statistikkVirksomhetGraderingTopic,
            Kafka.statistikkVirksomhetGraderingGroupId
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
        resultatSiste4Kvartal.orgnr shouldBe  "999999999"
        resultatSiste4Kvartal.publisertÅrstall shouldBe graderingSistePubliserteKvartal.årstall
        resultatSiste4Kvartal.publisertKvartal shouldBe graderingSistePubliserteKvartal.kvartal
        resultatSiste4Kvartal.graderingSiste4Kvartal.erMaskert shouldBe false
        resultatSiste4Kvartal.graderingSiste4Kvartal.prosent shouldBe 20
        resultatSiste4Kvartal.graderingSiste4Kvartal.tapteDagsverkGradert shouldBe 17.2
        resultatSiste4Kvartal.graderingSiste4Kvartal.tapteDagsverk shouldBe 86.0
        resultatSiste4Kvartal.graderingSiste4Kvartal.kvartaler shouldBe listOf(KVARTAL_2023_1, KVARTAL_2022_4)
    }
}
