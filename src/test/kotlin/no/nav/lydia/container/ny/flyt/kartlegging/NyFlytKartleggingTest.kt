package no.nav.lydia.container.ny.flyt.kartlegging

import com.github.kittinunf.fuel.core.extensions.authentication
import io.kotest.matchers.shouldBe
import io.ktor.http.HttpStatusCode
import no.nav.lydia.abc.api.NY_FLYT_API_PATH
import no.nav.lydia.abc.kartlegging.Spørreundersøkelse
import no.nav.lydia.abc.kartlegging.SpørreundersøkelseDto
import no.nav.lydia.abc.tilstandsmaskin.VirksomhetIATilstand
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.hentVirksomhetTilstand
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.opprettSamarbeid
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.vurderVirksomhet
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.fullfør
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.opprettKartlegging
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.slett
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.start
import no.nav.lydia.helper.PlanHelper.Companion.opprettSamarbeidsplan
import no.nav.lydia.helper.SakHelper.Companion.hentSak
import no.nav.lydia.helper.SakHelper.Companion.leggTilFolger
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.statuskode
import no.nav.lydia.helper.tilSingelRespons
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class NyFlytKartleggingTest {
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
    }

    @Test
    fun `Opprett kartlegging fungerer`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()

        val behovsvurdering = samarbeid.opprettKartlegging(orgnr = sak.orgnr, Spørreundersøkelse.Type.Behovsvurdering)
        behovsvurdering.type shouldBe Spørreundersøkelse.Type.Behovsvurdering.name.uppercase()

        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)

        val evaluering = samarbeid.opprettKartlegging(orgnr = sak.orgnr, Spørreundersøkelse.Type.Evaluering)
        evaluering.type shouldBe Spørreundersøkelse.Type.Evaluering.name.uppercase()
    }

    @Test
    fun `Opprett kartlegging avviser ugyldig type`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()

        val respons = applikasjon.performPost(
            url = "$NY_FLYT_API_PATH/virksomhet/${sak.orgnr}/samarbeidsperiode/${sak.saksnummer}/samarbeid/${samarbeid.id}/kartlegging/UGYLDIG_TYPE",
        )
            .authentication().bearer(authContainerHelper.saksbehandler1.token)
            .tilSingelRespons<SpørreundersøkelseDto>()
        respons.statuskode() shouldBe HttpStatusCode.BadRequest.value
    }

    @Test
    fun `Opprettelse av behovsvurdering skal ikke endre status`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes

        val samarbeid = sak.opprettSamarbeid()
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        val behovsvurdering = samarbeid.opprettKartlegging(orgnr = sak.orgnr, type = Spørreundersøkelse.Type.Behovsvurdering)
        behovsvurdering.type shouldBe Spørreundersøkelse.Type.Behovsvurdering.name.uppercase()

        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        val spørreundersøkelse = IASakSpørreundersøkelseHelper.hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = samarbeid.id,
            type = Spørreundersøkelse.Type.Behovsvurdering,
        )
        spørreundersøkelse.first().id shouldBe behovsvurdering.id
    }

    @Test
    fun `Starting og fullføring av behovsvurdering skal ikke endre status på IASak`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes

        val samarbeid = sak.opprettSamarbeid()
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        val opprettetBehovsvurdering = samarbeid.opprettKartlegging(
            orgnr = sak.orgnr,
            type = Spørreundersøkelse.Type.Behovsvurdering,
        )
        opprettetBehovsvurdering.status shouldBe Spørreundersøkelse.Status.OPPRETTET

        val startetBehovsvurdering = opprettetBehovsvurdering.start(
            orgnummer = sak.orgnr,
            saksnummer = sak.saksnummer,
        )
        startetBehovsvurdering.status shouldBe Spørreundersøkelse.Status.PÅBEGYNT
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        val fullførtBehovsvurdering = startetBehovsvurdering.fullfør(
            orgnummer = sak.orgnr,
            saksnummer = sak.saksnummer,
        )

        fullførtBehovsvurdering.status shouldBe Spørreundersøkelse.Status.AVSLUTTET
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
    }

    @Test
    fun `Sletting av behovsvurdering skal ikke endre tilstand til virksomhet eller status på IASak`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes

        val samarbeid = sak.opprettSamarbeid()
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        val opprettetBehovsvurdering = samarbeid.opprettKartlegging(orgnr = sak.orgnr, type = Spørreundersøkelse.Type.Behovsvurdering)

        opprettetBehovsvurdering.start(
            orgnummer = sak.orgnr,
            saksnummer = sak.saksnummer,
        )
        val sakFørKartleggingErSlettet = hentSak(orgnummer = sak.orgnr)

        val slettetBehovsvurdering = opprettetBehovsvurdering.slett(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        slettetBehovsvurdering.status shouldBe Spørreundersøkelse.Status.SLETTET
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
        hentSak(orgnummer = sak.orgnr).let {
            it.saksnummer shouldBe sakFørKartleggingErSlettet.saksnummer
            it.status shouldBe sakFørKartleggingErSlettet.status
        }
    }

    @Test
    @Deprecated("Duplisert test som skal fjernes etter NY_FLYT_API_KARTLEGGING_BASE_PATH er tatt i bruk og slett-kartlegging er fjernet fra NyFlytRoutes")
    fun `(Deprecated) Sletting av behovsvurdering skal ikke endre tilstand til virksomhet eller status på IASak`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes

        val samarbeid = sak.opprettSamarbeid()
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        val opprettetBehovsvurdering = samarbeid.opprettKartlegging(orgnr = sak.orgnr, type = Spørreundersøkelse.Type.Behovsvurdering)

        opprettetBehovsvurdering.start(
            orgnummer = sak.orgnr,
            saksnummer = sak.saksnummer,
        )
        val sakFørKartleggingErSlettet = hentSak(orgnummer = sak.orgnr)

        val slettetBehovsvurdering = opprettetBehovsvurdering.slett(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        slettetBehovsvurdering.status shouldBe Spørreundersøkelse.Status.SLETTET
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
        hentSak(orgnummer = sak.orgnr).let {
            it.saksnummer shouldBe sakFørKartleggingErSlettet.saksnummer
            it.status shouldBe sakFørKartleggingErSlettet.status
        }
    }

    @Test
    fun `Starting og fullføring av evaluering skal ikke endre status på IASak`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes

        val samarbeid = sak.opprettSamarbeid()
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)

        val opprettetEvaluering = samarbeid.opprettKartlegging(
            orgnr = sak.orgnr,
            type = Spørreundersøkelse.Type.Evaluering,
        )
        opprettetEvaluering.status shouldBe Spørreundersøkelse.Status.OPPRETTET

        val startetEvaluering = opprettetEvaluering.start(
            orgnummer = sak.orgnr,
            saksnummer = sak.saksnummer,
        )
        startetEvaluering.status shouldBe Spørreundersøkelse.Status.PÅBEGYNT
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        val fullførtEvaluering = startetEvaluering.fullfør(
            orgnummer = sak.orgnr,
            saksnummer = sak.saksnummer,
        )

        fullførtEvaluering.status shouldBe Spørreundersøkelse.Status.AVSLUTTET
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
    }

    @Test
    fun `Sletting av evaluering skal ikke endre tilstand til virksomhet eller status på IASak`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes

        val samarbeid = sak.opprettSamarbeid()
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)

        val opprettetEvaluering = samarbeid.opprettKartlegging(
            orgnr = sak.orgnr,
            type = Spørreundersøkelse.Type.Evaluering,
        )
        opprettetEvaluering.status shouldBe Spørreundersøkelse.Status.OPPRETTET

        val startetEvaluering = opprettetEvaluering.start(
            orgnummer = sak.orgnr,
            saksnummer = sak.saksnummer,
        )
        startetEvaluering.status shouldBe Spørreundersøkelse.Status.PÅBEGYNT
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
        val sakFørKartleggingErSlettet = hentSak(orgnummer = sak.orgnr)

        val slettetEvaluering = startetEvaluering.slett(
            orgnummer = sak.orgnr,
            saksnummer = sak.saksnummer,
        )

        slettetEvaluering.status shouldBe Spørreundersøkelse.Status.SLETTET
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
        hentSak(orgnummer = sak.orgnr).let {
            it.saksnummer shouldBe sakFørKartleggingErSlettet.saksnummer
            it.status shouldBe sakFørKartleggingErSlettet.status
        }
    }

    @Test
    @Deprecated("Duplisert test som skal fjernes etter NY_FLYT_API_KARTLEGGING_BASE_PATH er tatt i bruk og slett-kartlegging er fjernet fra NyFlytRoutes")
    fun `(Deprecated) Sletting av evaluering skal ikke endre tilstand til virksomhet eller status på IASak`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes

        val samarbeid = sak.opprettSamarbeid()
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)

        val opprettetEvaluering = samarbeid.opprettKartlegging(
            orgnr = sak.orgnr,
            type = Spørreundersøkelse.Type.Evaluering,
        )
        opprettetEvaluering.status shouldBe Spørreundersøkelse.Status.OPPRETTET

        val startetEvaluering = opprettetEvaluering.start(
            orgnummer = sak.orgnr,
            saksnummer = sak.saksnummer,
        )
        startetEvaluering.status shouldBe Spørreundersøkelse.Status.PÅBEGYNT
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
        val sakFørKartleggingErSlettet = hentSak(orgnummer = sak.orgnr)

        val slettetEvaluering = startetEvaluering.slett(
            orgnummer = sak.orgnr,
            saksnummer = sak.saksnummer,
        )

        slettetEvaluering.status shouldBe Spørreundersøkelse.Status.SLETTET
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
        hentSak(orgnummer = sak.orgnr).let {
            it.saksnummer shouldBe sakFørKartleggingErSlettet.saksnummer
            it.status shouldBe sakFørKartleggingErSlettet.status
        }
    }
}
