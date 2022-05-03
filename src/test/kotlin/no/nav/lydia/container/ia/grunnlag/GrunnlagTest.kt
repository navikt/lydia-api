package no.nav.lydia.container.ia.grunnlag

import io.kotest.inspectors.forAll
import io.kotest.matchers.collections.shouldBeIn
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.date.shouldHaveSameDayAs
import io.kotest.matchers.shouldBe
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.ia.grunnlag.GrunnlagRepository
import no.nav.lydia.sykefraversstatistikk.SykefraversstatistikkRepository
import org.junit.Test
import java.time.LocalDateTime


class GrunnlagTest {

    val dataSource = TestContainerHelper.postgresContainer.getDataSource()
    val grunnlagRepository = GrunnlagRepository(dataSource)
    val sykefraversstatistikkRepository =
        SykefraversstatistikkRepository(dataSource)

    @Test
    fun `når man oppretter en sak, skal gjeldende sykefraværstatistikk som grunnlag i saken`() {
        val orgnummer = TestVirksomhet.TESTVIRKSOMHET_FOR_GRUNNLAG.orgnr
        val iaSakDto = SakHelper.opprettSakForVirksomhet(orgnummer = orgnummer)

        val sykefraversstatistikkVirksomhetListe =
            sykefraversstatistikkRepository.hentSykefraværForVirksomhet(orgnr = orgnummer).also {
                it shouldHaveAtLeastSize 1
            }

        grunnlagRepository.hentSykefraværstatistikkGrunnlag(orgnr = orgnummer)
            .also { sykefraversstatistikkGrunnlagListe ->
                sykefraversstatistikkGrunnlagListe shouldHaveAtLeastSize 1
            }
            .forAll { sykefraversstatistikkGrunnlag ->
                sykefraversstatistikkGrunnlag.saksnummer shouldBe iaSakDto.saksnummer
                sykefraversstatistikkGrunnlag.hendelseId shouldBe iaSakDto.endretAvHendelseId
                sykefraversstatistikkGrunnlag.orgnr shouldBe iaSakDto.orgnr
                sykefraversstatistikkGrunnlag.arstall shouldBeIn sykefraversstatistikkVirksomhetListe.map { it.arstall }
                sykefraversstatistikkGrunnlag.kvartal shouldBeIn sykefraversstatistikkVirksomhetListe.map { it.kvartal }
                sykefraversstatistikkGrunnlag.antallPersoner shouldBeIn sykefraversstatistikkVirksomhetListe.map { it.antallPersoner }
                sykefraversstatistikkGrunnlag.tapteDagsverk shouldBeIn sykefraversstatistikkVirksomhetListe.map { it.tapteDagsverk }
                sykefraversstatistikkGrunnlag.muligeDagsverk shouldBeIn sykefraversstatistikkVirksomhetListe.map { it.muligeDagsverk }
                sykefraversstatistikkGrunnlag.sykefraversprosent shouldBeIn sykefraversstatistikkVirksomhetListe.map { it.sykefraversprosent }
                sykefraversstatistikkGrunnlag.maskert shouldBeIn sykefraversstatistikkVirksomhetListe.map { it.maskert }
                sykefraversstatistikkGrunnlag.opprettet shouldHaveSameDayAs LocalDateTime.now()
            }
    }
}