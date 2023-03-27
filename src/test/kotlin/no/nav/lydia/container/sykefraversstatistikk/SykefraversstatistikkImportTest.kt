package no.nav.lydia.container.sykefraversstatistikk

import io.kotest.matchers.ints.shouldBeGreaterThanOrEqual
import io.kotest.matchers.nulls.shouldBeNull
import io.kotest.matchers.nulls.shouldNotBeNull
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.KafkaContainerHelper.Companion.statistikkTopic
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefraværForVirksomhetSiste4Kvartaler
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefraværForVirksomhetSisteTilgjengeligKvartal
import no.nav.lydia.helper.SykefraværsstatistikkPerKategoriTestData.testVirksomhetForrigeKvartal
import no.nav.lydia.helper.SykefraværsstatistikkPerKategoriTestData.testVirksomhetGjeldeneKvartal
import no.nav.lydia.helper.SykefraværsstatistikkTestData
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldNotContainLog
import no.nav.lydia.helper.TestData
import no.nav.lydia.helper.TestData.Companion.AVVIRKNING
import no.nav.lydia.helper.TestData.Companion.DYRKING_AV_KORN
import no.nav.lydia.helper.TestData.Companion.DYRKING_AV_RIS
import no.nav.lydia.helper.TestData.Companion.LANDKODE_NO
import no.nav.lydia.helper.TestData.Companion.NÆRING_JORDBRUK
import no.nav.lydia.helper.TestData.Companion.NÆRING_SKOGBRUK
import no.nav.lydia.helper.TestData.Companion.SEKTOR_PRIVAT_NÆRINGSVIRKSOMHET
import no.nav.lydia.helper.TestData.Companion.SEKTOR_STATLIG_FORVALTNING
import no.nav.lydia.helper.TestData.Companion.SKOGSKJØTSEL
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.TestVirksomhet.Companion.TESTVIRKSOMHET_FOR_IMPORT
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.helper.lagSykefraversstatistikkPerKategoriImportDto
import no.nav.lydia.helper.lagSykefraværsstatistikkImportDto
import no.nav.lydia.helper.sektorStatistikk
import no.nav.lydia.sykefraversstatistikk.api.Periode
import no.nav.lydia.sykefraversstatistikk.import.Kategori
import org.apache.kafka.clients.producer.ProducerRecord
import kotlin.test.Test

class SykefraversstatistikkImportTest {
    private val kafkaContainer = TestContainerHelper.kafkaContainerHelper
    private val postgres = TestContainerHelper.postgresContainer
    private val lydiaApiContainer = TestContainerHelper.lydiaApiContainer

    @Test
    fun `kan importere statistikk for flere kvartal`() {
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(
            importDto = SykefraværsstatistikkTestData.testVirksomhetForrigeKvartal.sykefraværsstatistikkImportDto
        )
        kafkaContainer.sendSykefraversstatistikkPerKategoriKafkaMelding(
            importDto = testVirksomhetForrigeKvartal.sykefraversstatistikkPerKategoriImportDto
        )

        val sykefraværSiste4Kvartal = hentSykefraværForVirksomhetSiste4Kvartaler(TESTVIRKSOMHET_FOR_IMPORT.orgnr)
        sykefraværSiste4Kvartal.orgnr shouldBe TESTVIRKSOMHET_FOR_IMPORT.orgnr
        sykefraværSiste4Kvartal.sykefraversprosent shouldBe testVirksomhetForrigeKvartal.sykefraversstatistikkPerKategoriImportDto.siste4Kvartal.prosent

        kafkaContainer.sendSykefraversstatistikkKafkaMelding(
            importDto = SykefraværsstatistikkTestData.testVirksomhetGjeldeneKvartal.sykefraværsstatistikkImportDto
        )
        kafkaContainer.sendSykefraversstatistikkPerKategoriKafkaMelding(
            importDto = testVirksomhetGjeldeneKvartal.sykefraversstatistikkPerKategoriImportDto
        )

        val sykefraværSiste4KvartelEtterNyImport =
            hentSykefraværForVirksomhetSiste4Kvartaler(TESTVIRKSOMHET_FOR_IMPORT.orgnr)
        sykefraværSiste4KvartelEtterNyImport.orgnr shouldBe TESTVIRKSOMHET_FOR_IMPORT.orgnr
        sykefraværSiste4KvartelEtterNyImport.sykefraversprosent shouldBe testVirksomhetGjeldeneKvartal.sykefraversstatistikkPerKategoriImportDto.siste4Kvartal.prosent
    }

    @Test
    fun `importerte data skal kunne hentes ut og være like`() {
        val sykefraværsstatistikk =
            SykefraværsstatistikkTestData.testVirksomhetForrigeKvartal.sykefraværsstatistikkImportDto
        val sykefraværsstatistikkPerKategori = testVirksomhetForrigeKvartal.sykefraversstatistikkPerKategoriImportDto
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(sykefraværsstatistikk)
        kafkaContainer.sendSykefraversstatistikkPerKategoriKafkaMelding(sykefraværsstatistikkPerKategori)

        val sykefraværSiste4Kvartal = hentSykefraværForVirksomhetSiste4Kvartaler(TESTVIRKSOMHET_FOR_IMPORT.orgnr)
        sykefraværSiste4Kvartal.orgnr shouldBe sykefraværsstatistikk.virksomhetSykefravær.orgnr
        sykefraværSiste4Kvartal.sykefraversprosent shouldBe sykefraværsstatistikkPerKategori.siste4Kvartal.prosent
        sykefraværSiste4Kvartal.muligeDagsverk shouldBe sykefraværsstatistikkPerKategori.siste4Kvartal.muligeDagsverk
        sykefraværSiste4Kvartal.tapteDagsverk shouldBe sykefraværsstatistikkPerKategori.siste4Kvartal.tapteDagsverk

        val sykefraværSisteKvartal =
            hentSykefraværForVirksomhetSisteTilgjengeligKvartal(TESTVIRKSOMHET_FOR_IMPORT.orgnr)
        sykefraværSisteKvartal.antallPersoner shouldBe sykefraværsstatistikk.virksomhetSykefravær.antallPersoner.toInt()
    }

    @Test
    fun `import av data er idempotent`() {
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(SykefraværsstatistikkTestData.testVirksomhetForrigeKvartal.sykefraværsstatistikkImportDto)
        kafkaContainer.sendSykefraversstatistikkPerKategoriKafkaMelding(testVirksomhetForrigeKvartal.sykefraversstatistikkPerKategoriImportDto)
        val førsteLagredeStatistikkSiste4Kvartal =
            hentSykefraværForVirksomhetSiste4Kvartaler(TESTVIRKSOMHET_FOR_IMPORT.orgnr)
        val førsteLagredeStatistikkSisteKvartal =
            hentSykefraværForVirksomhetSisteTilgjengeligKvartal(TESTVIRKSOMHET_FOR_IMPORT.orgnr)
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(SykefraværsstatistikkTestData.testVirksomhetForrigeKvartal.sykefraværsstatistikkImportDto)
        kafkaContainer.sendSykefraversstatistikkPerKategoriKafkaMelding(testVirksomhetForrigeKvartal.sykefraversstatistikkPerKategoriImportDto)
        val andreLagredeStatistikkSiste4Kvartal =
            hentSykefraværForVirksomhetSiste4Kvartaler(TESTVIRKSOMHET_FOR_IMPORT.orgnr)
        val andreLagredeStatistikkSisteKvartal =
            hentSykefraværForVirksomhetSisteTilgjengeligKvartal(TESTVIRKSOMHET_FOR_IMPORT.orgnr)
        andreLagredeStatistikkSiste4Kvartal.orgnr shouldBe førsteLagredeStatistikkSiste4Kvartal.orgnr
        andreLagredeStatistikkSiste4Kvartal.sykefraversprosent shouldBe førsteLagredeStatistikkSiste4Kvartal.sykefraversprosent
        andreLagredeStatistikkSiste4Kvartal.muligeDagsverk shouldBe førsteLagredeStatistikkSiste4Kvartal.muligeDagsverk
        andreLagredeStatistikkSiste4Kvartal.tapteDagsverk shouldBe førsteLagredeStatistikkSiste4Kvartal.tapteDagsverk
        andreLagredeStatistikkSisteKvartal.antallPersoner shouldBe førsteLagredeStatistikkSisteKvartal.antallPersoner
    }

    @Test
    fun `vi lagrer metadata ved import`() {
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(SykefraværsstatistikkTestData.testVirksomhetForrigeKvartal.sykefraværsstatistikkImportDto)

        val antallMetadata =
            postgres.hentEnkelKolonne<Int>("SELECT count(*) FROM virksomhet_statistikk_metadata WHERE orgnr = '${TESTVIRKSOMHET_FOR_IMPORT.orgnr}'")

        antallMetadata shouldBeGreaterThanOrEqual 1
    }

    @Test
    fun `sykefraværsstatistikk skal oppdateres om det kommer nye versjoner av samme nøkler`() {
        val virksomhet = TestVirksomhet.nyVirksomhet()
        val originalStatistikk = TestData().lagData(
            virksomhet = virksomhet,
            perioder = listOf(Periode.gjeldendePeriode()),
            antallPersoner = 100.0,
            tapteDagsverk = 20.0,
            sykefraværsProsent = 2.0
        )
        VirksomhetHelper.lastInnTestdata(originalStatistikk)
        val førsteImport = hentSykefraværForVirksomhetSiste4Kvartaler(virksomhet.orgnr)
        førsteImport.sykefraversprosent shouldBe 2.0
        førsteImport.tapteDagsverk shouldBe 20.0
        hentSykefraværForVirksomhetSisteTilgjengeligKvartal(virksomhet.orgnr).antallPersoner shouldBe 100.0
        hentKolonneFraSykefraværsstatistikkVirksomhet(virksomhet, "endret").shouldBeNull()

        val opppdatertStatistikk = lagSykefraværsstatistikkImportDto(
            orgnr = virksomhet.orgnr,
            periode = Periode.gjeldendePeriode(),
            sykefraværsProsent = 3.0,
            antallPersoner = 1337.0,
            tapteDagsverk = 16.0,
            sektor = "3"
        )
        val opppdatertStatistikk4SisteKvartal = lagSykefraversstatistikkPerKategoriImportDto(
            kategori = Kategori.VIRKSOMHET,
            kode = virksomhet.orgnr,
            periode = Periode.gjeldendePeriode(),
            sykefraværsProsent = 3.0,
            antallPersoner = 1337,
            tapteDagsverk = 16.0,
        )
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(opppdatertStatistikk)
        kafkaContainer.sendSykefraversstatistikkPerKategoriKafkaMelding(opppdatertStatistikk4SisteKvartal)
        val andreImport = hentSykefraværForVirksomhetSiste4Kvartaler(virksomhet.orgnr)
        andreImport.sykefraversprosent shouldBe 3.0
        andreImport.tapteDagsverk shouldBe 16.0
        hentSykefraværForVirksomhetSisteTilgjengeligKvartal(virksomhet.orgnr).antallPersoner shouldBe 1337

        hentKolonneFraSykefraværsstatistikkVirksomhet(virksomhet, "endret").shouldNotBeNull()
    }

    @Test
    fun `skal kunne importere aggregert sykefraværsstatistikk for sektor, næring og land`() {
        val virksomhet = TestVirksomhet.nyVirksomhet()
        val periode1971 = Periode(kvartal = 1, årstall = 1971)
        val melding = lagSykefraværsstatistikkImportDto(
            orgnr = virksomhet.orgnr,
            periode = periode1971,
            antallPersoner = 100.0,
            sektor = SEKTOR_PRIVAT_NÆRINGSVIRKSOMHET,
            næring = NÆRING_JORDBRUK,
            næringsundergrupper = listOf(DYRKING_AV_RIS.kode),
            landKode = LANDKODE_NO
        )

        kafkaContainer.sendSykefraversstatistikkKafkaMelding(importDto = melding)

        hentStatistikk(tabell = "sykefravar_statistikk_sektor",
            kolonne = "sektor_kode",
            kode = SEKTOR_PRIVAT_NÆRINGSVIRKSOMHET,
            periode = periode1971) shouldBe SEKTOR_PRIVAT_NÆRINGSVIRKSOMHET
        hentStatistikk(tabell = "sykefravar_statistikk_naring",
            kolonne = "naring",
            kode = NÆRING_JORDBRUK,
            periode = periode1971) shouldBe NÆRING_JORDBRUK
        hentStatistikk(tabell = "sykefravar_statistikk_naringsundergruppe",
            kolonne = "naringsundergruppe",
            kode = DYRKING_AV_RIS.kode,
            periode = periode1971) shouldBe DYRKING_AV_RIS.kode
        hentStatistikk(tabell = "sykefravar_statistikk_land",
            kolonne = "land",
            kode = LANDKODE_NO,
            periode = periode1971) shouldBe LANDKODE_NO
    }

    @Test
    fun `skal kunne importere aggregert sykefraværsstatistikk for virksomheter med flere næringsundergrupper`() {
        val virksomhet = TestVirksomhet.nyVirksomhet()
        val periode1972 = Periode(kvartal = 1, årstall = 1972)
        val melding = lagSykefraværsstatistikkImportDto(
            orgnr = virksomhet.orgnr,
            periode = periode1972,
            antallPersoner = 100.0,
            sektor = SEKTOR_PRIVAT_NÆRINGSVIRKSOMHET,
            næring = NÆRING_SKOGBRUK,
            næringsundergrupper = listOf(AVVIRKNING.kode, SKOGSKJØTSEL.kode),
            landKode = LANDKODE_NO
        )

        kafkaContainer.sendSykefraversstatistikkKafkaMelding(importDto = melding)

        hentStatistikk(tabell = "sykefravar_statistikk_sektor",
            kolonne = "sektor_kode",
            kode = SEKTOR_PRIVAT_NÆRINGSVIRKSOMHET,
            periode = periode1972) shouldBe SEKTOR_PRIVAT_NÆRINGSVIRKSOMHET
        hentStatistikk(tabell = "sykefravar_statistikk_naring",
            kolonne = "naring",
            kode = NÆRING_SKOGBRUK,
            periode = periode1972) shouldBe NÆRING_SKOGBRUK
        hentStatistikk(tabell = "sykefravar_statistikk_naringsundergruppe",
            kolonne = "naringsundergruppe",
            kode = AVVIRKNING.kode,
            periode = periode1972) shouldBe AVVIRKNING.kode
        hentStatistikk(tabell = "sykefravar_statistikk_naringsundergruppe",
            kolonne = "naringsundergruppe",
            kode = SKOGSKJØTSEL.kode,
            periode = periode1972) shouldBe SKOGSKJØTSEL.kode
        hentStatistikk(tabell = "sykefravar_statistikk_land",
            kolonne = "land",
            kode = LANDKODE_NO,
            periode = periode1972) shouldBe LANDKODE_NO
    }

    @Test
    fun `sjekk at importmodel er riktig`() {
        val periode = Periode(kvartal = 1, årstall = 2019)
        kafkaContainer.sendKafkameldingSomString()
        hentStatistikk(tabell = "sykefravar_statistikk_sektor",
            kolonne = "sektor_kode",
            kode = SEKTOR_STATLIG_FORVALTNING,
            periode = periode) shouldBe SEKTOR_STATLIG_FORVALTNING
        hentStatistikk(tabell = "sykefravar_statistikk_naring",
            kolonne = "naring",
            kode = NÆRING_JORDBRUK,
            periode = periode) shouldBe NÆRING_JORDBRUK
        hentStatistikk(tabell = "sykefravar_statistikk_naringsundergruppe",
            kolonne = "naringsundergruppe",
            kode = DYRKING_AV_KORN.kode,
            periode = periode) shouldBe DYRKING_AV_KORN.kode
        hentStatistikk(tabell = "sykefravar_statistikk_land",
            kolonne = "land",
            kode = LANDKODE_NO,
            periode = periode) shouldBe LANDKODE_NO
    }

    @Test
    fun `håndterer feil formatert meldinger`() {
        kafkaContainer.sendProducerRecordKafkaMelding(
            ProducerRecord(
                statistikkTopic,
                """
                    {
                        "kategori": "SEKTOR",
                        "kode": "0",
                        "kvartal": 4,
                        "årstall": 2022
                    }
                """.trimIndent(),
                sektorStatistikk
            ))

        lydiaApiContainer shouldNotContainLog "NullPointerException.*tilBehandletStatistikk".toRegex()
        lydiaApiContainer shouldContainLog "Feil formatert Kafka melding i topic $statistikkTopic".toRegex()
    }


    private fun hentStatistikk(
        tabell: String,
        kolonne: String,
        kode: String,
        periode: Periode,
    ) = postgres.hentEnkelKolonne<Any?>("""
            select $kolonne
            from $tabell
            where $kolonne = '$kode' and
            arstall = ${periode.årstall} and
            kvartal = ${periode.kvartal}
        """.trimIndent())


    private fun hentKolonneFraSykefraværsstatistikkVirksomhet(virksomhet: TestVirksomhet, kolonneNavn: String) =
        postgres.hentEnkelKolonne<Any?>(
            """
                select $kolonneNavn from sykefravar_statistikk_virksomhet 
                where 
                orgnr = '${virksomhet.orgnr}' and
                arstall = ${Periode.gjeldendePeriode().årstall} and
                kvartal = ${Periode.gjeldendePeriode().kvartal}
            """.trimIndent()
        )
}
