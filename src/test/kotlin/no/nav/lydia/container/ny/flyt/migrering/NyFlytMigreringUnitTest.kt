package no.nav.lydia.container.ny.flyt.migrering

import io.kotest.matchers.shouldBe
import kotlinx.datetime.toKotlinLocalDateTime
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.migrering.NyFlytMigreringService.Companion.erAvsluttetEtter
import no.nav.lydia.ia.sak.api.ny.flyt.migrering.NyFlytMigreringService.Companion.erAvsluttetFør
import no.nav.lydia.ia.sak.api.ny.flyt.migrering.NyFlytMigreringService.Companion.erSistEndretEtter
import no.nav.lydia.ia.sak.api.ny.flyt.migrering.NyFlytMigreringService.Companion.getSamarbeidUseCase
import no.nav.lydia.ia.sak.api.ny.flyt.migrering.SamarbeidUseCase
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import java.time.LocalDateTime
import java.util.UUID
import kotlin.test.Test

class NyFlytMigreringUnitTest {
    companion object {
        val iDag = LocalDateTime.now().toLocalDate().atStartOfDay()

        fun fullførtSak(antallDagerSiden: Int) =
            IASakDto(
                saksnummer = "123",
                status = IASak.Status.FULLFØRT,
                orgnr = "123456789",
                eidAv = "test",
                lukket = false,
                opprettetAv = "test",
                opprettetTidspunkt = iDag.minusDays(antallDagerSiden.toLong()).toKotlinLocalDateTime(),
                endretAv = "test",
                endretTidspunkt = iDag.minusDays(antallDagerSiden.toLong()).toKotlinLocalDateTime(),
                endretAvHendelseId = "091283471209384701",
                gyldigeNesteHendelser = emptyList(),
            )

        fun fullførtSamarbeid(antallDagerSiden: Int) = avsluttetSamarbeid(status = IASamarbeid.Status.FULLFØRT, antallDagerSiden = antallDagerSiden)

        fun avbruttSamarbeid(antallDagerSiden: Int) = avsluttetSamarbeid(status = IASamarbeid.Status.AVBRUTT, antallDagerSiden = antallDagerSiden)

        fun avsluttetSamarbeid(
            status: IASamarbeid.Status,
            antallDagerSiden: Int,
        ) = IASamarbeid(
            id = 1,
            saksnummer = "123",
            status = status,
            offentligId = UUID.randomUUID(),
            navn = "Fullført samarbeid",
            opprettet = iDag.minusDays(antallDagerSiden.toLong()).toKotlinLocalDateTime(),
            avbrutt = null,
            fullført = iDag.minusDays(antallDagerSiden.toLong()).toKotlinLocalDateTime(),
            sistEndret = iDag.minusDays(antallDagerSiden.toLong()).toKotlinLocalDateTime(),
        )
    }

    @Test
    fun `tester erSistendretEtter`() {
        fullførtSak(antallDagerSiden = 90).erSistEndretEtter(iDag, tilbakeIAntallDager = 10) shouldBe false
        fullførtSak(antallDagerSiden = 10).erSistEndretEtter(iDag, tilbakeIAntallDager = 10) shouldBe false
        fullførtSak(antallDagerSiden = 5).erSistEndretEtter(iDag, tilbakeIAntallDager = 10) shouldBe true
    }

    @Test
    fun `tester utleding av samarbeids use-cases - tidligst avsluttet samarbeid trumfer`() {
        fullførtSamarbeid(antallDagerSiden = 90).erAvsluttetEtter(dato = iDag, tilbakeIAntallDager = 10) shouldBe false
        fullførtSamarbeid(antallDagerSiden = 10).erAvsluttetEtter(dato = iDag, tilbakeIAntallDager = 10) shouldBe false
        fullførtSamarbeid(antallDagerSiden = 5).erAvsluttetEtter(dato = iDag, tilbakeIAntallDager = 10) shouldBe true

        listOf(fullførtSamarbeid(antallDagerSiden = 90), fullførtSamarbeid(antallDagerSiden = 10), fullførtSamarbeid(antallDagerSiden = 5))
            .getSamarbeidUseCase(migreringsDato = iDag) shouldBe
            SamarbeidUseCase.INGEN_AKTIVE_SAMARBEID_MEN_MINST_ETT_AVSLUTTET_SAMARBEID_OM_TIDLIGST_10_DAGER_SIDEN
    }

    @Test
    fun `tester utleding av samarbeids use-cases - avsluttet samarbeid er enten avbrutt eller fullført samarbeid`() {
        fullførtSamarbeid(antallDagerSiden = 90).erAvsluttetFør(dato = iDag, tilbakeIAntallDager = 10) shouldBe true
        avbruttSamarbeid(antallDagerSiden = 12).erAvsluttetFør(dato = iDag, tilbakeIAntallDager = 10) shouldBe true

        listOf(fullførtSamarbeid(antallDagerSiden = 10), avbruttSamarbeid(antallDagerSiden = 12)).getSamarbeidUseCase(migreringsDato = iDag) shouldBe
            SamarbeidUseCase.INGEN_AKTIVE_SAMARBEID_MEN_MINST_ETT_AVSLUTTET_SAMARBEID_FOR_MER_ENN_10_DAGER_SIDEN
    }
}
