package no.nav.lydia.enhetstester

import com.github.guepardoapps.kulid.ULID
import io.kotest.matchers.shouldBe
import no.nav.lydia.ia.sak.domene.*
import java.time.LocalDateTime
import kotlin.test.Test

class IASakTest {
    companion object {
        val orgnummer = "123456789"
        val navIdent1 = "A123456"
        val navIdent2 = "B123456"
    }

    @Test
    fun `skal kunne prioritere en virksomhet`() {
        val sak = nyIASak(orgnummer = orgnummer, navIdent = navIdent1)

        val prioriteringsHendelse = nyHendelse(
            SaksHendelsestype.VIRKSOMHET_PRIORITERES,
            saksnummer = sak.saksnummer,
            orgnummer = sak.orgnr,
            navIdent = navIdent2
        )
        sak.behandleHendelse(prioriteringsHendelse)
        sak.endretAv shouldBe prioriteringsHendelse.opprettetAv
        sak.endret shouldBe prioriteringsHendelse.opprettetTidspunkt
        sak.saksnummer shouldBe prioriteringsHendelse.saksnummer
        sak.endretAvHendelseId shouldBe prioriteringsHendelse.id
        sak.status shouldBe IAProsessStatus.PRIORITERT
    }
    @Test
    fun `skal kunne bygge sak fra en serie med hendelser`() {
        val h1 = nyFørsteHendelse(orgnummer = orgnummer, navIdent = navIdent1)
        val h2 = nyHendelse(
            SaksHendelsestype.VIRKSOMHET_PRIORITERES,
            saksnummer = h1.saksnummer,
            orgnummer = h1.orgnummer,
            navIdent = navIdent2
        )
        val h3 = nyHendelse(
            SaksHendelsestype.VIRKSOMHET_TAKKER_NEI,
            saksnummer = h1.saksnummer,
            orgnummer = h1.orgnummer,
            navIdent = navIdent2
        )
        val sak = IASak.fraHendelser(listOf(h1, h2, h3))
        sak.status shouldBe IAProsessStatus.TAKKET_NEI
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
            type = SaksHendelsestype.OPPRETT_SAK_FOR_VIRKSOMHET,
            orgnummer = orgnummer,
            opprettetAv = navIdent,
        )
    }

    private fun nyHendelse(type : SaksHendelsestype, saksnummer: String, orgnummer : String, navIdent: String) =
        IASakshendelse(
            id = ULID.random(),
            opprettetTidspunkt = LocalDateTime.now(),
            saksnummer = saksnummer,
            type = type,
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
                endretAv = null
            )
        }
    }
}