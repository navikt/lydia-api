package no.nav.lydia.container.sykefraversstatistikk

import arrow.core.Either
import io.kotest.inspectors.forAll
import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.booleans.shouldBeFalse
import io.kotest.matchers.ints.shouldBeExactly
import io.kotest.matchers.ints.shouldBeGreaterThanOrEqual
import io.kotest.matchers.nulls.shouldBeNull
import io.kotest.matchers.nulls.shouldNotBeNull
import io.kotest.matchers.shouldBe
import no.nav.lydia.Kafka
import no.nav.lydia.helper.KafkaContainerHelper.Companion.statistikkLandTopic
import no.nav.lydia.helper.KafkaContainerHelper.Companion.statistikkVirksomhetTopic
import no.nav.lydia.helper.StatistikkHelper
import no.nav.lydia.helper.SykefraværsstatistikkTestData
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
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
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.lagSykefraværsstatistikkImportDto
import no.nav.lydia.sykefraversstatistikk.api.Periode
import java.sql.ResultSet
import kotlin.test.Test

class SykefraversstatistikkImportTest {
    private val kafkaContainer = TestContainerHelper.kafkaContainerHelper
    private val postgres = TestContainerHelper.postgresContainer

    @Test
    fun `kan konsumere meldinger på nye sykefraværstatistikk topics`() {
        kafkaContainer.sendOgVentTilKonsumert(
            "nøkkel-land",
            "melding-land",
            statistikkLandTopic,
            Kafka.statistikkNyConsumerGroupId)
        kafkaContainer.sendOgVentTilKonsumert(
            "nøkkel-virksomhet",
            "melding-virksomhet",
            statistikkVirksomhetTopic,
            Kafka.statistikkNyConsumerGroupId)
        lydiaApiContainer shouldContainLog """Topic: $statistikkLandTopic - Melding \d mottatt""".toRegex()
        lydiaApiContainer shouldContainLog """Topic: $statistikkVirksomhetTopic - Melding \d mottatt""".toRegex()
    }

    @Test
    fun `kan importere statistikk for flere kvartal`() {
        val gjeldendePeriode = Periode.gjeldendePeriode()
        val forrigePeriode = Periode.forrigePeriode()
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(importDto = SykefraværsstatistikkTestData.testVirksomhetForrigeKvartal.sykefraværsstatistikkImportDto)

        hentSykefraværsstatistikk(TESTVIRKSOMHET_FOR_IMPORT.orgnr)
            .forExactlyOne {
                it.kvartal shouldBeExactly forrigePeriode.kvartal
                it.arstall shouldBeExactly forrigePeriode.årstall
                it.orgnr shouldBe TESTVIRKSOMHET_FOR_IMPORT.orgnr
            }

        kafkaContainer.sendSykefraversstatistikkKafkaMelding(importDto = SykefraværsstatistikkTestData.testVirksomhetGjeldeneKvartal.sykefraværsstatistikkImportDto)

        val osloAndreOgTredjeKvart = hentSykefraværsstatistikk(TESTVIRKSOMHET_FOR_IMPORT.orgnr)
        osloAndreOgTredjeKvart.forExactlyOne {
            it.kvartal shouldBe forrigePeriode.kvartal
            it.arstall shouldBe forrigePeriode.årstall
            it.orgnr shouldBe TESTVIRKSOMHET_FOR_IMPORT.orgnr
        }
        osloAndreOgTredjeKvart.forExactlyOne {
            it.kvartal shouldBe gjeldendePeriode.kvartal
            it.arstall shouldBe gjeldendePeriode.årstall
            it.orgnr shouldBe TESTVIRKSOMHET_FOR_IMPORT.orgnr
        }
    }

    @Test
    fun `importerte data skal kunne hentes ut og være like`() {
        val sykefraværsstatistikk = SykefraværsstatistikkTestData.testVirksomhetForrigeKvartal.sykefraværsstatistikkImportDto
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(sykefraværsstatistikk)

        val dtos = hentSykefraværsstatistikk(TESTVIRKSOMHET_FOR_IMPORT.orgnr)
        dtos.size shouldBeGreaterThanOrEqual 1
        dtos.forAtLeastOne { dto ->
            dto.orgnr shouldBe sykefraværsstatistikk.virksomhetSykefravær.orgnr
            dto.arstall shouldBe sykefraværsstatistikk.virksomhetSykefravær.årstall
            dto.kvartal shouldBe sykefraværsstatistikk.virksomhetSykefravær.kvartal
            dto.sykefraversprosent shouldBe sykefraværsstatistikk.virksomhetSykefravær.prosent
            dto.antallPersoner shouldBe sykefraværsstatistikk.virksomhetSykefravær.antallPersoner.toInt()
            dto.muligeDagsverk shouldBe sykefraværsstatistikk.virksomhetSykefravær.muligeDagsverk
            dto.tapteDagsverk shouldBe sykefraværsstatistikk.virksomhetSykefravær.tapteDagsverk
        }
    }

    @Test
    fun `import av data er idempotent`() {
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(SykefraværsstatistikkTestData.testVirksomhetForrigeKvartal.sykefraværsstatistikkImportDto)
        val førsteLagredeStatistikk = hentSykefraværsstatistikk(TESTVIRKSOMHET_FOR_IMPORT.orgnr)
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(SykefraværsstatistikkTestData.testVirksomhetForrigeKvartal.sykefraværsstatistikkImportDto)
        val andreLagredeStatistikk = hentSykefraværsstatistikk(TESTVIRKSOMHET_FOR_IMPORT.orgnr)
        andreLagredeStatistikk.forExactlyOne { dto ->
            dto.orgnr shouldBe førsteLagredeStatistikk[0].orgnr
            dto.arstall shouldBe førsteLagredeStatistikk[0].arstall
            dto.kvartal shouldBe førsteLagredeStatistikk[0].kvartal
            dto.sykefraversprosent shouldBe førsteLagredeStatistikk[0].sykefraversprosent
            dto.antallPersoner shouldBe førsteLagredeStatistikk[0].antallPersoner
            dto.muligeDagsverk shouldBe førsteLagredeStatistikk[0].muligeDagsverk
            dto.tapteDagsverk shouldBe førsteLagredeStatistikk[0].tapteDagsverk
        }
    }

    @Test
    fun `vi lagrer metadata ved import`() {
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(SykefraværsstatistikkTestData.testVirksomhetForrigeKvartal.sykefraværsstatistikkImportDto)

        val rs =
            postgres.performQuery("SELECT * FROM virksomhet_statistikk_metadata WHERE orgnr = '${TESTVIRKSOMHET_FOR_IMPORT.orgnr}'")

        rs.row shouldBe 1
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
        hentSykefraværsstatistikk(virksomhet.orgnr).forExactlyOne {
            it.sykefraversprosent shouldBe 2.0
            it.antallPersoner shouldBe 100
            it.tapteDagsverk shouldBe 20.0
        }
        hentKolonneFraSykefraværsstatistikkVirksomhet(virksomhet, "endret").getOrNull("endret").shouldBeNull()

        val opppdatertStatistikk = lagSykefraværsstatistikkImportDto(
            orgnr = virksomhet.orgnr,
            periode = Periode.gjeldendePeriode(),
            sykefraværsProsent = 3.0,
            antallPersoner = 1337.0,
            tapteDagsverk = 16.0,
            sektor = "3"
        )
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(opppdatertStatistikk)
        hentSykefraværsstatistikk(virksomhet.orgnr).forExactlyOne {
            it.sykefraversprosent shouldBe 3.0
            it.antallPersoner shouldBe 1337
            it.tapteDagsverk shouldBe 16.0
        }

        hentKolonneFraSykefraværsstatistikkVirksomhet(virksomhet, "endret").getOrNull("endret").shouldNotBeNull()
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

        hentStatistikk(tabell = "sykefravar_statistikk_sektor", kolonne = "sektor_kode", kode = SEKTOR_PRIVAT_NÆRINGSVIRKSOMHET, periode = periode1971) shouldBe SEKTOR_PRIVAT_NÆRINGSVIRKSOMHET
        hentStatistikk(tabell = "sykefravar_statistikk_naring", kolonne = "naring", kode = NÆRING_JORDBRUK, periode = periode1971) shouldBe NÆRING_JORDBRUK
        hentStatistikk(tabell = "sykefravar_statistikk_naringsundergruppe", kolonne = "naringsundergruppe", kode = DYRKING_AV_RIS.kode, periode = periode1971) shouldBe DYRKING_AV_RIS.kode
        hentStatistikk(tabell = "sykefravar_statistikk_land", kolonne = "land", kode = LANDKODE_NO, periode = periode1971) shouldBe LANDKODE_NO
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

        hentStatistikk(tabell = "sykefravar_statistikk_sektor", kolonne = "sektor_kode", kode = SEKTOR_PRIVAT_NÆRINGSVIRKSOMHET, periode = periode1972) shouldBe SEKTOR_PRIVAT_NÆRINGSVIRKSOMHET
        hentStatistikk(tabell = "sykefravar_statistikk_naring", kolonne = "naring", kode = NÆRING_SKOGBRUK, periode = periode1972) shouldBe NÆRING_SKOGBRUK
        hentStatistikk(tabell = "sykefravar_statistikk_naringsundergruppe", kolonne = "naringsundergruppe", kode = AVVIRKNING.kode, periode = periode1972) shouldBe AVVIRKNING.kode
        hentStatistikk(tabell = "sykefravar_statistikk_naringsundergruppe", kolonne = "naringsundergruppe", kode = SKOGSKJØTSEL.kode, periode = periode1972) shouldBe SKOGSKJØTSEL.kode
        hentStatistikk(tabell = "sykefravar_statistikk_land", kolonne = "land", kode = LANDKODE_NO, periode = periode1972) shouldBe LANDKODE_NO
    }

    @Test
    fun `sjekk at importmodel er riktig`() {
        val periode = Periode(kvartal = 1, årstall = 2019)
        kafkaContainer.sendKafkameldingSomString()
        hentStatistikk(tabell = "sykefravar_statistikk_sektor", kolonne = "sektor_kode", kode = SEKTOR_STATLIG_FORVALTNING, periode = periode) shouldBe SEKTOR_STATLIG_FORVALTNING
        hentStatistikk(tabell = "sykefravar_statistikk_naring", kolonne = "naring", kode = NÆRING_JORDBRUK, periode = periode) shouldBe NÆRING_JORDBRUK
        hentStatistikk(tabell = "sykefravar_statistikk_naringsundergruppe", kolonne = "naringsundergruppe", kode = DYRKING_AV_KORN.kode, periode = periode) shouldBe DYRKING_AV_KORN.kode
        hentStatistikk(tabell = "sykefravar_statistikk_land", kolonne = "land", kode = LANDKODE_NO, periode = periode) shouldBe LANDKODE_NO
    }

    @Test
    fun `vi stoler ikke på at sykefraværsstatistikken er maskert`() {
        val importDto = SykefraværsstatistikkTestData.testVirksomhetSomFeilaktigIkkeErMaskert.sykefraværsstatistikkImportDto
        listOf(
            importDto.virksomhetSykefravær,
            importDto.næringSykefravær,
            importDto.sektorSykefravær,
            importDto.landSykefravær,
            *importDto.næring5SifferSykefravær.toTypedArray()
        ).forAll {
            it.maskert.shouldBeFalse()
        }
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(importDto)
        hentSykefraværsstatistikk(importDto.virksomhetSykefravær.orgnr).forExactlyOne {
            it.kvartal shouldBe importDto.virksomhetSykefravær.kvartal
            it.arstall shouldBe importDto.virksomhetSykefravær.årstall
            it.sykefraversprosent shouldBe 0.0
            it.muligeDagsverk shouldBe 0.0
            it.antallPersoner shouldBe 4.0
            it.tapteDagsverk shouldBe 0.0
        }
    }

    private fun hentStatistikk(
        tabell: String,
        kolonne: String,
        kode: String,
        periode: Periode
    ) = postgres.performQuery("""
            select $kolonne
            from $tabell
            where $kolonne = '$kode' and
            arstall = ${periode.årstall} and
            kvartal = ${periode.kvartal}
        """.trimIndent()).getOrNull(kolonne)


    private fun hentKolonneFraSykefraværsstatistikkVirksomhet(virksomhet: TestVirksomhet, kolonneNavn: String) =
        postgres.performQuery(
            """
                select $kolonneNavn from sykefravar_statistikk_virksomhet 
                where 
                orgnr = '${virksomhet.orgnr}' and
                arstall = ${Periode.gjeldendePeriode().årstall} and
                kvartal = ${Periode.gjeldendePeriode().kvartal}
            """.trimIndent()
        )

    private fun hentSykefraværsstatistikk(orgnr: String) =
        StatistikkHelper.hentSykefraværForVirksomhet(orgnummer = orgnr)


    private fun ResultSet.getOrNull(columnLabel: String): Any? = Either.catch {
        this.getObject(columnLabel)
    }.orNull()
}
