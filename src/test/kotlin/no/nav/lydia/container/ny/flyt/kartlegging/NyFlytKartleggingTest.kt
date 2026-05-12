package no.nav.lydia.container.ny.flyt.kartlegging

import com.github.kittinunf.fuel.core.extensions.authentication
import io.kotest.matchers.shouldBe
import io.ktor.http.HttpStatusCode
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.fullførKartlegging
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.hentVirksomhetTilstand
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.opprettKartlegging
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.opprettKartleggingMedRåType
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.opprettSamarbeid
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.opprettSamarbeidsplan
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.slettKartlegging
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.slettKartleggingDeprecatedPathINyFlyt
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.startKartlegging
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.vurderVirksomhet
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.start
import no.nav.lydia.helper.SakHelper.Companion.hentSak
import no.nav.lydia.helper.SakHelper.Companion.hentSakNyFlyt
import no.nav.lydia.helper.SakHelper.Companion.leggTilFolger
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.statuskode
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.sak.api.ny.flyt.NY_FLYT_API_PATH
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetIATilstand
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseDto
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
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
    fun `Opprett kartlegging aksepterer SCREAMING_CASE type`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()

        val behovsvurdering = samarbeid.opprettKartleggingMedRåType(orgnr = sak.orgnr, råType = "BEHOVSVURDERING")
        behovsvurdering.type shouldBe Spørreundersøkelse.Type.Behovsvurdering.name.uppercase()

        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)

        val evaluering = samarbeid.opprettKartleggingMedRåType(orgnr = sak.orgnr, råType = "EVALUERING")
        evaluering.type shouldBe Spørreundersøkelse.Type.Evaluering.name.uppercase()
    }

    @Test
    fun `Opprett kartlegging aksepterer lowercase type`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()

        val behovsvurdering = samarbeid.opprettKartleggingMedRåType(orgnr = sak.orgnr, råType = "behovsvurdering")
        behovsvurdering.type shouldBe Spørreundersøkelse.Type.Behovsvurdering.name.uppercase()

        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)

        val evaluering = samarbeid.opprettKartleggingMedRåType(orgnr = sak.orgnr, råType = "evaluering")
        evaluering.type shouldBe Spørreundersøkelse.Type.Evaluering.name.uppercase()
    }

    @Test
    fun `Opprett kartlegging aksepterer Pascalcase type`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()

        val behovsvurdering = samarbeid.opprettKartleggingMedRåType(orgnr = sak.orgnr, råType = "Behovsvurdering")
        behovsvurdering.type shouldBe Spørreundersøkelse.Type.Behovsvurdering.name.uppercase()

        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)

        val evaluering = samarbeid.opprettKartleggingMedRåType(orgnr = sak.orgnr, råType = "Evaluering")
        evaluering.type shouldBe Spørreundersøkelse.Type.Evaluering.name.uppercase()
    }

    @Test
    fun `Opprett kartlegging aksepterer type med tilfeldig sammensetning av stor og liten bokstav`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()

        val behovsvurdering = samarbeid.opprettKartleggingMedRåType(orgnr = sak.orgnr, råType = "BeHoVsVuRDERINg")
        behovsvurdering.type shouldBe Spørreundersøkelse.Type.Behovsvurdering.name.uppercase()

        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)

        val evaluering = samarbeid.opprettKartleggingMedRåType(orgnr = sak.orgnr, råType = "EVALuering")
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

        val startetBehovsvurdering = opprettetBehovsvurdering.startKartlegging(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
        )
        startetBehovsvurdering.status shouldBe Spørreundersøkelse.Status.PÅBEGYNT
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        val fullførtBehovsvurdering = samarbeid.fullførKartlegging(
            orgnr = sak.orgnr,
            kartleggingId = opprettetBehovsvurdering.id,
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

        val slettetBehovsvurdering = samarbeid.slettKartlegging(orgnr = sak.orgnr, kartleggingId = opprettetBehovsvurdering.id)

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

        samarbeid.startKartlegging(
            orgnr = sak.orgnr,
            kartleggingId = opprettetBehovsvurdering.id,
        )
        val sakFørKartleggingErSlettet = hentSakNyFlyt(orgnummer = sak.orgnr)

        val slettetBehovsvurdering = samarbeid.slettKartleggingDeprecatedPathINyFlyt(orgnr = sak.orgnr, kartleggingId = opprettetBehovsvurdering.id)

        slettetBehovsvurdering.status shouldBe Spørreundersøkelse.Status.SLETTET
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
        hentSakNyFlyt(orgnummer = sak.orgnr).let {
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

        val startetEvaluering = samarbeid.startKartlegging(
            orgnr = sak.orgnr,
            kartleggingId = opprettetEvaluering.id,
        )
        startetEvaluering.status shouldBe Spørreundersøkelse.Status.PÅBEGYNT
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        val fullførtEvaluering = samarbeid.fullførKartlegging(
            orgnr = sak.orgnr,
            kartleggingId = opprettetEvaluering.id,
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

        val startetEvaluering = samarbeid.startKartlegging(
            orgnr = sak.orgnr,
            kartleggingId = opprettetEvaluering.id,
        )
        startetEvaluering.status shouldBe Spørreundersøkelse.Status.PÅBEGYNT
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
        val sakFørKartleggingErSlettet = hentSakNyFlyt(orgnummer = sak.orgnr)

        val slettetEvaluering = samarbeid.slettKartlegging(
            orgnr = sak.orgnr,
            kartleggingId = opprettetEvaluering.id,
        )

        slettetEvaluering.status shouldBe Spørreundersøkelse.Status.SLETTET
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
        hentSakNyFlyt(orgnummer = sak.orgnr).let {
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

        val startetEvaluering = samarbeid.startKartlegging(
            orgnr = sak.orgnr,
            kartleggingId = opprettetEvaluering.id,
        )
        startetEvaluering.status shouldBe Spørreundersøkelse.Status.PÅBEGYNT
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
        val sakFørKartleggingErSlettet = hentSakNyFlyt(orgnummer = sak.orgnr)

        val slettetEvaluering = samarbeid.slettKartleggingDeprecatedPathINyFlyt(
            orgnr = sak.orgnr,
            kartleggingId = opprettetEvaluering.id,
        )

        slettetEvaluering.status shouldBe Spørreundersøkelse.Status.SLETTET
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
        hentSakNyFlyt(orgnummer = sak.orgnr).let {
            it.saksnummer shouldBe sakFørKartleggingErSlettet.saksnummer
            it.status shouldBe sakFørKartleggingErSlettet.status
        }
    }
}
