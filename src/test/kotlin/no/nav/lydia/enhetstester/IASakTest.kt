package no.nav.lydia.enhetstester

import com.github.guepardoapps.kulid.ULID
import io.kotest.matchers.shouldBe
import no.nav.lydia.ia.sak.domene.*
import java.time.LocalDateTime
import kotlin.test.Test

class IASakTest {
    companion object {
        const val orgnummer = "123456789"
        const val navIdent1 = "A123456"
        const val navIdent2 = "B123456"
    }

    @Test
    fun `skal kunne merke at en virksomhet skal vurderes`() {
        val sak = nyIASak(orgnummer = orgnummer, navIdent = navIdent1)

        val vurderingsHendelse = nyHendelse(
            SaksHendelsestype.VIRKSOMHET_VURDERES,
            saksnummer = sak.saksnummer,
            orgnummer = sak.orgnr,
            navIdent = navIdent2
        )
        sak.behandleHendelse(vurderingsHendelse)
        sak.endretAv shouldBe vurderingsHendelse.opprettetAv
        sak.endret shouldBe vurderingsHendelse.opprettetTidspunkt
        sak.saksnummer shouldBe vurderingsHendelse.saksnummer
        sak.endretAvHendelseId shouldBe vurderingsHendelse.id
        sak.status shouldBe IAProsessStatus.VURDERES
    }
    @Test
    fun `skal kunne bygge sak fra en serie med hendelser`() {
        val h1 = nyFørsteHendelse(orgnummer = orgnummer, navIdent = navIdent1)
        val h2 = nyHendelse(
            SaksHendelsestype.VIRKSOMHET_VURDERES,
            saksnummer = h1.saksnummer,
            orgnummer = h1.orgnummer,
            navIdent = navIdent2
        )
        val h3 = nyHendelse(
            SaksHendelsestype.VIRKSOMHET_ER_IKKE_AKTUELL,
            saksnummer = h1.saksnummer,
            orgnummer = h1.orgnummer,
            navIdent = navIdent2
        )
        val sak = IASak.fraHendelser(listOf(h1, h2, h3))
        sak.status shouldBe IAProsessStatus.IKKE_AKTUELL
        sak.opprettetAv shouldBe h1.opprettetAv
        sak.endretAv shouldBe h3.opprettetAv
        sak.endretAvHendelseId shouldBe h3.id
    }

    private fun nyFørsteHendelse(orgnummer: String, navIdent: String) : IASakshendelse {
        val id = ULID.random()
        return IASakshendelse(
            id = id,
            opprettetTidspunkt = LocalDateTime.now(),
            saksnummer = id,
            hendelsesType = SaksHendelsestype.OPPRETT_SAK_FOR_VIRKSOMHET,
            orgnummer = orgnummer,
            opprettetAv = navIdent,
        )
    }

    private fun nyHendelse(type : SaksHendelsestype, saksnummer: String, orgnummer : String, navIdent: String) =
        IASakshendelse(
            id = ULID.random(),
            opprettetTidspunkt = LocalDateTime.now(),
            saksnummer = saksnummer,
            hendelsesType = type,
            orgnummer = orgnummer,
            opprettetAv = navIdent,
        )

    private fun nyIASak(orgnummer : String, navIdent : String) : IASak {
        return nyFørsteHendelse(orgnummer, navIdent).let { sakshendelse ->
            IASak(
                saksnummer = sakshendelse.saksnummer,
                orgnr = orgnummer,
                type = IASakstype.NAV_STOTTER,
                opprettet = sakshendelse.opprettetTidspunkt,
                opprettetAv = sakshendelse.opprettetAv,
                endretAvHendelseId = sakshendelse.id,
                status = IAProsessStatus.NY,
                endret = null,
                endretAv = null,
                eidAv = null
            )
        }
    }
}
