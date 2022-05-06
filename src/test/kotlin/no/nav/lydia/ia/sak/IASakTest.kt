package no.nav.lydia.ia.sak

import com.github.guepardoapps.kulid.ULID
import io.kotest.inspectors.shouldForAtLeastOne
import io.kotest.matchers.collections.shouldBeEmpty
import io.kotest.matchers.collections.shouldContainAll
import io.kotest.matchers.shouldBe
import no.nav.lydia.FiaRoller
import no.nav.lydia.ia.sak.domene.*
import no.nav.lydia.ia.sak.domene.SaksHendelsestype.*
import no.nav.lydia.ia.årsak.domene.ÅrsakType
import no.nav.lydia.tilgangskontroll.Rådgiver
import java.time.LocalDateTime
import kotlin.test.Test

class IASakTest {
    companion object {
        const val orgnummer = "123456789"
        const val navIdent1 = "A123456"
        const val navIdent2 = "B123456"

        val fiaroller = FiaRoller(
            superbrukerGroupId = "123",
            saksbehandlerGroupId = "456",
            lesetilgangGroupId = "789"
        )

        val superbruker1 = Rådgiver(
            navIdent = navIdent1,
            fiaRoller = fiaroller,
            rådgiversGrupper = listOf(fiaroller.superbrukerGroupId)
        )

        val saksbehandler2 = Rådgiver(
            navIdent = navIdent2,
            fiaRoller = fiaroller,
            rådgiversGrupper = listOf(fiaroller.saksbehandlerGroupId)
        )
    }

    @Test
    fun `skal kunne merke at en virksomhet skal vurderes`() {
        val sak = nyIASak(orgnummer = orgnummer, navIdent = navIdent1)

        val vurderingsHendelse = nyHendelse(
            VIRKSOMHET_VURDERES,
            saksnummer = sak.saksnummer,
            orgnummer = sak.orgnr,
            navIdent = navIdent2
        )
        sak.behandleHendelse(vurderingsHendelse)
        sak.endretAv shouldBe vurderingsHendelse.opprettetAv
        sak.endretTidspunkt shouldBe vurderingsHendelse.opprettetTidspunkt
        sak.saksnummer shouldBe vurderingsHendelse.saksnummer
        sak.endretAvHendelseId shouldBe vurderingsHendelse.id
        sak.status shouldBe IAProsessStatus.VURDERES
    }

    @Test
    fun `skal kunne bygge sak fra en serie med hendelser`() {
        val h1 = nyFørsteHendelse(orgnummer = orgnummer, navIdent = navIdent1)
        val h2 = nyHendelse(
            VIRKSOMHET_VURDERES,
            saksnummer = h1.saksnummer,
            orgnummer = h1.orgnummer,
            navIdent = navIdent2
        )
        val h3 = nyHendelse(
            VIRKSOMHET_ER_IKKE_AKTUELL,
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

    @Test
    fun `skal få en liste over gyldige begrunnelser for når en virksomhet ikke er aktuell`() {
        val h1_ny_sak = nyFørsteHendelse(orgnummer = orgnummer, navIdent = superbruker1.navIdent)
        val h2_vurderes = nyHendelse(
            VIRKSOMHET_VURDERES,
            saksnummer = h1_ny_sak.saksnummer,
            orgnummer = h1_ny_sak.orgnummer,
            navIdent = superbruker1.navIdent
        )
        val h3_ta_eierskap = nyHendelse(
            TA_EIERSKAP_I_SAK,
            saksnummer = h1_ny_sak.saksnummer,
            orgnummer = h1_ny_sak.orgnummer,
            navIdent = saksbehandler2.navIdent
        )
        val sak = IASak.fraHendelser(listOf(h1_ny_sak, h2_vurderes, h3_ta_eierskap))
        sak.gyldigeNesteHendelser(rådgiver = saksbehandler2)
            .shouldForAtLeastOne {
                it.saksHendelsestype shouldBe VIRKSOMHET_ER_IKKE_AKTUELL
                it.gyldigeÅrsaker shouldContainAll listOf(
                    ÅrsakType.VIRKSOMHETEN_TAKKET_NEI,
                    ÅrsakType.NAV_IGANGSETTER_IKKE_TILTAK
                )
            }.shouldForAtLeastOne {
                it.saksHendelsestype shouldBe VIRKSOMHET_SKAL_KONTAKTES
                it.gyldigeÅrsaker.shouldBeEmpty()
            }
    }

    private fun nyFørsteHendelse(orgnummer: String, navIdent: String): IASakshendelse {
        val id = ULID.random()
        return IASakshendelse(
            id = id,
            opprettetTidspunkt = LocalDateTime.now(),
            saksnummer = id,
            hendelsesType = OPPRETT_SAK_FOR_VIRKSOMHET,
            orgnummer = orgnummer,
            opprettetAv = navIdent,
        )
    }

    private fun nyHendelse(type: SaksHendelsestype, saksnummer: String, orgnummer: String, navIdent: String) =
        IASakshendelse(
            id = ULID.random(),
            opprettetTidspunkt = LocalDateTime.now(),
            saksnummer = saksnummer,
            hendelsesType = type,
            orgnummer = orgnummer,
            opprettetAv = navIdent,
        )

    private fun nyIASak(orgnummer: String, navIdent: String): IASak {
        return nyFørsteHendelse(orgnummer, navIdent).let { sakshendelse ->
            IASak(
                saksnummer = sakshendelse.saksnummer,
                orgnr = orgnummer,
                type = IASakstype.NAV_STOTTER,
                opprettetTidspunkt = sakshendelse.opprettetTidspunkt,
                opprettetAv = sakshendelse.opprettetAv,
                endretAvHendelseId = sakshendelse.id,
                status = IAProsessStatus.NY,
                endretTidspunkt = null,
                endretAv = null,
                eidAv = null
            )
        }
    }
}
