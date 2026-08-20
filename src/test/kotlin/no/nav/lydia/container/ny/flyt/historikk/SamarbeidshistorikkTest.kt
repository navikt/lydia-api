package no.nav.lydia.container.ny.flyt.historikk

import io.kotest.matchers.collections.shouldContainExactly
import io.kotest.matchers.nulls.shouldNotBeNull
import io.kotest.matchers.shouldBe
import io.ktor.http.HttpStatusCode
import no.nav.lydia.api.v1.NY_FLYT_API_PATH
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.avsluttSamarbeid
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.opprettSamarbeid
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.slettSamarbeidsplan
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.vurderVirksomhet
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.fullfør
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.opprettKartlegging
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.start
import no.nav.lydia.helper.PlanHelper.Companion.opprettSamarbeidsplan
import no.nav.lydia.helper.SakHelper.Companion.leggTilFolger
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.TestResponseTriple
import no.nav.lydia.helper.statuskode
import no.nav.lydia.helper.tilListeRespons
import no.nav.lydia.kartlegging.Spørreundersøkelse
import no.nav.lydia.samarbeid.IASamarbeid
import no.nav.lydia.samarbeidsperiode.SamarbeidshistorikkRadDto
import no.nav.lydia.samarbeidsperiode.SamarbeidshistorikkType
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test
import kotlin.test.fail

class SamarbeidshistorikkTest {
    companion object {
        @BeforeClass
        @JvmStatic
        fun setUp() {
            NyFlytTestUtils.setUpKonsumenter()
        }

        @AfterClass
        @JvmStatic
        fun tearDown() {
            NyFlytTestUtils.tearDownKonsumenter()
        }

        private fun hentHistorikkRespons(
            orgnr: String,
            saksnummer: String,
            samarbeidId: Int,
            token: String = authContainerHelper.saksbehandler1.token,
        ): TestResponseTriple<List<SamarbeidshistorikkRadDto>> =
            applikasjon.performGet(
                "$NY_FLYT_API_PATH/virksomhet/$orgnr/samarbeidsperiode/$saksnummer/samarbeid/$samarbeidId/historikk",
            )
                .authentication().bearer(token)
                .tilListeRespons<SamarbeidshistorikkRadDto>()

        private fun hentHistorikk(
            orgnr: String,
            saksnummer: String,
            samarbeidId: Int,
            token: String = authContainerHelper.saksbehandler1.token,
        ): List<SamarbeidshistorikkRadDto> =
            hentHistorikkRespons(
                orgnr = orgnr,
                saksnummer = saksnummer,
                samarbeidId = samarbeidId,
                token = token,
            ).third.fold(
                success = { it },
                failure = { fail(it.message) },
            )

        // -- Simulerer historiske data: hendelser som ble skapt før knytningstabellene fantes
        private fun fjernAlleKoblingerTilHendelser(samarbeidId: Int) {
            postgresContainerHelper.performUpdate(
                """
                DELETE FROM hendelser_til_kartlegging htk
                USING ia_sak_kartlegging k
                WHERE htk.kartlegging_id = k.kartlegging_id
                  AND k.ia_prosess = $samarbeidId
                """.trimIndent(),
            )
            postgresContainerHelper.performUpdate(
                """
                DELETE FROM hendelser_til_samarbeidsplan htp
                USING ia_sak_plan p
                WHERE htp.samarbeidsplan_id = p.plan_id
                  AND p.ia_prosess = $samarbeidId
                """.trimIndent(),
            )
            postgresContainerHelper.performUpdate(
                "DELETE FROM hendelser_til_samarbeid WHERE samarbeid_id = $samarbeidId",
            )
        }
    }

    @Test
    fun `historikken inneholder ekte hendelser med aktør for et nyopprettet samarbeid`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()

        val historikk = hentHistorikk(orgnr = sak.orgnr, saksnummer = sak.saksnummer, samarbeidId = samarbeid.id)

        historikk.map { it.hendelsestype } shouldContainExactly listOf(SamarbeidshistorikkType.SAMARBEID_OPPRETTET)
        historikk.first().tidspunkt.shouldNotBeNull()
        historikk.first().aktor.shouldNotBeNull().navIdent shouldBe authContainerHelper.saksbehandler1.navIdent
    }

    @Test
    fun `historikken rekonstrueres fra samarbeidet når hendelsen ikke er koblet`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        fjernAlleKoblingerTilHendelser(samarbeidId = samarbeid.id)

        val historikk = hentHistorikk(orgnr = sak.orgnr, saksnummer = sak.saksnummer, samarbeidId = samarbeid.id)

        historikk.map { it.hendelsestype } shouldContainExactly listOf(SamarbeidshistorikkType.SAMARBEID_OPPRETTET)
        historikk.first().tidspunkt.shouldNotBeNull()
        historikk.first().aktor shouldBe null
    }

    @Test
    fun `historikken skiller mellom fullført behovsvurdering og evaluering`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()

        samarbeid.opprettKartlegging(orgnr = sak.orgnr, type = Spørreundersøkelse.Type.Behovsvurdering)
            .start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
            .fullfør(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)
        samarbeid.opprettKartlegging(orgnr = sak.orgnr, type = Spørreundersøkelse.Type.Evaluering)
            .start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
            .fullfør(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        val hendelsestyper = hentHistorikk(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            samarbeidId = samarbeid.id,
        ).map { it.hendelsestype }

        hendelsestyper shouldContainExactly listOf(
            SamarbeidshistorikkType.EVALUERING_FULLFØRT,
            SamarbeidshistorikkType.SAMARBEIDSPLAN_OPPRETTET,
            SamarbeidshistorikkType.BEHOVSVURDERING_FULLFØRT,
            SamarbeidshistorikkType.SAMARBEID_OPPRETTET,
        )
    }

    @Test
    fun `fullførte kartlegginger rekonstrueres når hendelsene ikke er koblet`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()

        samarbeid.opprettKartlegging(orgnr = sak.orgnr, type = Spørreundersøkelse.Type.Behovsvurdering)
            .start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
            .fullfør(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        fjernAlleKoblingerTilHendelser(samarbeidId = samarbeid.id)

        val historikk = hentHistorikk(orgnr = sak.orgnr, saksnummer = sak.saksnummer, samarbeidId = samarbeid.id)

        val behovsvurdering = historikk.single { it.hendelsestype == SamarbeidshistorikkType.BEHOVSVURDERING_FULLFØRT }
        behovsvurdering.tidspunkt.shouldNotBeNull()
        behovsvurdering.aktor shouldBe null
    }

    @Test
    fun `slettet samarbeidsplan rekonstrueres med slettetidspunkt`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        val plan = samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)
        samarbeid.slettSamarbeidsplan(orgnr = sak.orgnr, planId = plan.id)
        fjernAlleKoblingerTilHendelser(samarbeidId = samarbeid.id)

        val historikk = hentHistorikk(orgnr = sak.orgnr, saksnummer = sak.saksnummer, samarbeidId = samarbeid.id)

        historikk.single { it.hendelsestype == SamarbeidshistorikkType.SAMARBEIDSPLAN_SLETTET }
            .tidspunkt.shouldNotBeNull()
        // -- Vi har ikke noe opprettet-tidspunkt for planer, men vi vet hvem som opprettet den
        val planOpprettet = historikk.single { it.hendelsestype == SamarbeidshistorikkType.SAMARBEIDSPLAN_OPPRETTET }
        planOpprettet.tidspunkt shouldBe null
        planOpprettet.aktor.shouldNotBeNull().navIdent shouldBe authContainerHelper.saksbehandler1.navIdent
    }

    @Test
    fun `rader uten tidspunkt sorteres nederst`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)
        fjernAlleKoblingerTilHendelser(samarbeidId = samarbeid.id)

        val historikk = hentHistorikk(orgnr = sak.orgnr, saksnummer = sak.saksnummer, samarbeidId = samarbeid.id)

        historikk.last().hendelsestype shouldBe SamarbeidshistorikkType.SAMARBEIDSPLAN_OPPRETTET
        historikk.last().tidspunkt shouldBe null
    }

    @Test
    fun `avsluttet samarbeid gir hendelse om fullført samarbeid`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)
        samarbeid.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT)

        val hendelsestyper = hentHistorikk(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            samarbeidId = samarbeid.id,
        ).map { it.hendelsestype }

        hendelsestyper shouldContainExactly listOf(
            SamarbeidshistorikkType.SAMARBEID_FULLFØRT,
            SamarbeidshistorikkType.SAMARBEIDSPLAN_OPPRETTET,
            SamarbeidshistorikkType.SAMARBEID_OPPRETTET,
        )
    }

    @Test
    fun `kun den nyeste hendelsen per hendelsestype returneres`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        val førstePlan = samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)
        samarbeid.slettSamarbeidsplan(orgnr = sak.orgnr, planId = førstePlan.id)
        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)

        val historikk = hentHistorikk(orgnr = sak.orgnr, saksnummer = sak.saksnummer, samarbeidId = samarbeid.id)

        historikk.count { it.hendelsestype == SamarbeidshistorikkType.SAMARBEIDSPLAN_OPPRETTET } shouldBe 1
        historikk.count { it.hendelsestype == SamarbeidshistorikkType.SAMARBEIDSPLAN_SLETTET } shouldBe 1
    }

    @Test
    fun `samarbeid som ikke tilhører saksnummeret gir 404`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()

        val annenSak = vurderVirksomhet()

        hentHistorikkRespons(
            orgnr = annenSak.orgnr,
            saksnummer = annenSak.saksnummer,
            samarbeidId = samarbeid.id,
        ).statuskode() shouldBe HttpStatusCode.NotFound.value
    }

    @Test
    fun `bruker uten tilgang får ikke hente historikk`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()

        hentHistorikkRespons(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            samarbeidId = samarbeid.id,
            token = authContainerHelper.brukerUtenTilgangsrolle.token,
        ).statuskode() shouldBe HttpStatusCode.Forbidden.value
    }
}
