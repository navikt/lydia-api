package no.nav.lydia.container.sykefraversstatistikk

import arrow.core.Either
import com.github.kittinunf.fuel.gson.responseObject
import com.github.kittinunf.result.getOrElse
import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.ints.shouldBeExactly
import io.kotest.matchers.ints.shouldBeGreaterThanOrEqual
import io.kotest.matchers.nulls.shouldBeNull
import io.kotest.matchers.nulls.shouldNotBeNull
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.*
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.withLydiaToken
import no.nav.lydia.helper.TestVirksomhet.Companion.TESTVIRKSOMHET_FOR_IMPORT
import no.nav.lydia.sykefraversstatistikk.api.Periode
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto
import java.sql.ResultSet
import kotlin.test.Test
import kotlin.test.fail

class SykefraversstatistikkImportTest {
    private val lydiaApi = TestContainerHelper.lydiaApiContainer
    private val kafkaContainer = TestContainerHelper.kafkaContainerHelper
    private val postgres = TestContainerHelper.postgresContainer

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
        hentKolonneFraSykefraværsstatistikk(virksomhet, "endret").getOrNull("endret").shouldBeNull()

        val opppdatertStatistikk = lagSykefraværsstatistikkImportDto(
            orgnr = virksomhet.orgnr,
            periode = Periode.gjeldendePeriode(),
            sykefraværsProsent = 3.0,
            antallPersoner = 1337.0,
            tapteDagsverk = 16.0,
            sektor = 3
        )
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(opppdatertStatistikk)
        hentSykefraværsstatistikk(virksomhet.orgnr).forExactlyOne {
            it.sykefraversprosent shouldBe 3.0
            it.antallPersoner shouldBe 1337
            it.tapteDagsverk shouldBe 16.0
        }

        hentKolonneFraSykefraværsstatistikk(virksomhet, "endret").getOrNull("endret").shouldNotBeNull()
    }

    @Test
    fun `skal importere sykefraværsstatistikk for sektor`() {
        val orgnr = "111111111"
        val sektorKode = 3
        val periode = Periode(kvartal = 1, årstall = 1971)
        val melding = lagSykefraværsstatistikkImportDto(
            orgnr = orgnr,
            periode = periode,
            antallPersoner = 100.0,
            sektor = sektorKode
        )
        kafkaContainer.sendSykefraversstatistikkKafkaMelding(importDto = melding)
        postgres.performQuery(
            """
            select * from sykefravar_statistikk_sektor
            where sektor_kode = $sektorKode AND
            arstall = ${periode.årstall} AND
            kvartal = ${periode.kvartal}
            """.trimIndent()
        ).getString("sektor_kode") shouldBe sektorKode.toString()
    }


    private fun hentKolonneFraSykefraværsstatistikk(virksomhet: TestVirksomhet, kolonneNavn: String) =
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
        lydiaApi.performGet("$SYKEFRAVERSSTATISTIKK_PATH/${orgnr}")
            .withLydiaToken()
            .responseObject<List<SykefraversstatistikkVirksomhetDto>>().third
            .getOrElse { fail(it.message) }


    private fun ResultSet.getOrNull(columnLabel: String): Any? = Either.catch {
        this.getObject(columnLabel)
    }.orNull()
}

