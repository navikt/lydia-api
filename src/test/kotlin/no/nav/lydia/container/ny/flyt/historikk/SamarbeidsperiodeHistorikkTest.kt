package no.nav.lydia.container.ny.flyt.historikk

import io.kotest.inspectors.forAtLeastOne
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.ktor.http.HttpStatusCode
import no.nav.lydia.api.v1.NY_FLYT_API_PATH
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.hentVirksomhetTilstand
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.opprettSamarbeid
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.vurderVirksomhet
import no.nav.lydia.helper.SakHelper.Companion.leggTilFolger
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestResponseTriple
import no.nav.lydia.helper.statuskode
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.historikk.model.SamarbeidsperiodeHistorikkDto
import no.nav.lydia.samarbeidsperiode.BegrunnelseType
import no.nav.lydia.samarbeidsperiode.IASak
import no.nav.lydia.samarbeidsperiode.ValgtÅrsak
import no.nav.lydia.samarbeidsperiode.ÅrsakType
import no.nav.lydia.tilstandsmaskin.VirksomhetIATilstand
import kotlin.test.Test
import kotlin.test.fail

class SamarbeidsperiodeHistorikkTest {
    @Test
    fun `endepunkt for samarbeidsperiodehistorikk returner OK`() {
        val sak = vurderVirksomhet()
        val følgerEllerEier = authContainerHelper.saksbehandler1
        sak.leggTilFolger(følgerEllerEier.token)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes

        hentSamarbeidsperiodeHistorikkRespons(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            token = følgerEllerEier.token,
        ).statuskode() shouldBe HttpStatusCode.OK.value
    }

    @Test
    fun `filtrer vekk alle hendelser som ikke fører til endring i resulterende status`() {
        val sak = vurderVirksomhet()
        val følgerEllerEier = authContainerHelper.saksbehandler1
        sak.leggTilFolger(følgerEllerEier.token)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes

        sak.opprettSamarbeid(samarbeidsnavn = "s1")
        sak.opprettSamarbeid(samarbeidsnavn = "s2")
        sak.opprettSamarbeid(samarbeidsnavn = "s3")

        val samarbeidsperiodeHistorikkDto = hentSamarbeidsperiodeHistorikk(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            token = følgerEllerEier.token,
        )
        samarbeidsperiodeHistorikkDto.historikkHendelser shouldHaveSize 2
        samarbeidsperiodeHistorikkDto.historikkHendelser.map { it.resulterendeStatus } shouldBe
            listOf(IASak.Status.VURDERES, IASak.Status.AKTIV)
    }

    // superbruker1 (S54321) er den eneste testbrukeren som også finnes i Azure-stubben
    @Test
    fun `hendelser skal berikes med navnet til den som utførte dem`() {
        val superbruker = authContainerHelper.superbruker1
        val sak = vurderVirksomhet(token = superbruker.token)

        val historikk = hentSamarbeidsperiodeHistorikk(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            token = superbruker.token,
        )

        historikk.historikkHendelser.forAtLeastOne { hendelse ->
            hendelse.hendelseOpprettetAv shouldBe "S54321"
            hendelse.aktør?.navn shouldBe "Bjørg Scheie Scheie"
        }
    }

    @Test
    fun `får tilbake samme årsaksbeskrivelse som man putter inn`() {
        val sak = vurderVirksomhet(
            valgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.BAKGRUNN_FOR_VURDERING_AV_VIRKSOMHET,
                beskrivelse = "bAkGrUnN FoR VuRdErInG Av vIrKsOmHeT",
                begrunnelser = listOf(BegrunnelseType.NAV_VURDERER_VIRKSOMHETEN),
            ),
        )

        val historikk = hentSamarbeidsperiodeHistorikk(orgnr = sak.orgnr, saksnummer = sak.saksnummer)
        historikk.historikkHendelser[0].årsak?.beskrivelse shouldBe "bAkGrUnN FoR VuRdErInG Av vIrKsOmHeT"
    }

    private fun hentSamarbeidsperiodeHistorikkRespons(
        orgnr: String,
        saksnummer: String,
        token: String = authContainerHelper.saksbehandler1.token,
    ): TestResponseTriple<SamarbeidsperiodeHistorikkDto> =
        applikasjon.performGet(
            "$NY_FLYT_API_PATH/virksomhet/$orgnr/samarbeidsperiode/$saksnummer/historikk",
        )
            .authentication().bearer(token)
            .tilSingelRespons<SamarbeidsperiodeHistorikkDto>()

    private fun hentSamarbeidsperiodeHistorikk(
        orgnr: String,
        saksnummer: String,
        token: String = authContainerHelper.saksbehandler1.token,
    ): SamarbeidsperiodeHistorikkDto =
        hentSamarbeidsperiodeHistorikkRespons(
            orgnr = orgnr,
            saksnummer = saksnummer,
            token = token,
        ).third.fold(
            success = { it },
            failure = { fail(it.message) },
        )
}
