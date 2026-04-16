package no.nav.lydia.container.ny.flyt.migrering

import io.kotest.assertions.throwables.shouldThrow
import io.kotest.matchers.shouldBe
import kotlinx.datetime.toKotlinLocalDateTime
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.migrering.NyFlytMigreringService.Companion.erAvsluttetEtter
import no.nav.lydia.ia.sak.api.ny.flyt.migrering.NyFlytMigreringService.Companion.erAvsluttetFør
import no.nav.lydia.ia.sak.api.ny.flyt.migrering.NyFlytMigreringService.Companion.erSistEndretEtter
import no.nav.lydia.ia.sak.api.ny.flyt.migrering.NyFlytMigreringService.Companion.faktiskMigrer
import no.nav.lydia.ia.sak.api.ny.flyt.migrering.NyFlytMigreringService.Companion.getSamarbeidUseCase
import no.nav.lydia.ia.sak.api.ny.flyt.migrering.NyFlytMigreringService.Companion.tilFylkenummer
import no.nav.lydia.ia.sak.api.ny.flyt.migrering.NyFlytMigreringService.Companion.tilOrgnr
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
    fun `tilFylkenummer fungerer`() {
        "ALLE".tilFylkenummer() shouldBe "ALLE"
        "00".tilFylkenummer() shouldBe "00"
        "50:".tilFylkenummer() shouldBe "50"
        "50:true".tilFylkenummer() shouldBe "50"
        "50:false".tilFylkenummer() shouldBe "50"
        shouldThrow<IllegalArgumentException> { "Alle".tilFylkenummer() }
        shouldThrow<IllegalArgumentException> { "501".tilFylkenummer() }
        shouldThrow<IllegalArgumentException> { "501:true".tilFylkenummer() }
        shouldThrow<IllegalArgumentException> { "3".tilFylkenummer() }
        shouldThrow<IllegalArgumentException> { "".tilFylkenummer() }
        shouldThrow<IllegalArgumentException> { "true:03".tilFylkenummer() }
    }

    @Test
    fun `tilOrgnr fungerer`() {
        "123456789".tilOrgnr() shouldBe "123456789"
        "123456789:".tilOrgnr() shouldBe "123456789"
        "123456789:true".tilOrgnr() shouldBe "123456789"
        "123456789:false".tilOrgnr() shouldBe "123456789"
        shouldThrow<IllegalArgumentException> { "1234567890".tilOrgnr() }
        shouldThrow<IllegalArgumentException> { "1234567890:true".tilOrgnr() }
        shouldThrow<IllegalArgumentException> { "123".tilOrgnr() }
        shouldThrow<IllegalArgumentException> { "".tilOrgnr() }
        shouldThrow<IllegalArgumentException> { "true:123456789".tilOrgnr() }
    }

    @Test
    fun `faktisk migrer fungerer`() {
        "123456789:".tilOrgnr() shouldBe "123456789"
        "123456789:yolo".faktiskMigrer() shouldBe false
        "123456789:".faktiskMigrer() shouldBe false
        "123456789".faktiskMigrer() shouldBe false
        "".faktiskMigrer() shouldBe false
        "true".faktiskMigrer() shouldBe false
        "50".faktiskMigrer() shouldBe false
        "50:hei".faktiskMigrer() shouldBe false
        "50:trueee".faktiskMigrer() shouldBe false
        "Trøndelag:".faktiskMigrer() shouldBe false
        "Trøndelag:true".faktiskMigrer() shouldBe true
        "50:true".faktiskMigrer() shouldBe true
        "123456789:true".faktiskMigrer() shouldBe true
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
