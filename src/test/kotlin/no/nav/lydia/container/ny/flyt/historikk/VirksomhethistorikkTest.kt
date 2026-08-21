package no.nav.lydia.container.ny.flyt.historikk

import io.kotest.inspectors.shouldForAll
import io.kotest.matchers.should
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.ktor.http.HttpStatusCode
import no.nav.lydia.api.v1.NY_FLYT_API_PATH
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.avsluttVurdering
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.hentVirksomhetTilstand
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.opprettSamarbeid
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.vurderVirksomhet
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.opprettKartlegging
import no.nav.lydia.helper.SakHelper.Companion.bliEier
import no.nav.lydia.helper.SakHelper.Companion.leggTilFolger
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.TestResponseTriple
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.lastInnNyVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.sendSlettingForVirksomhet
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.historikk.HistorikkVersjon
import no.nav.lydia.historikk.HistorikkVirksomhet
import no.nav.lydia.historikk.HistorikkVirksomhetDto
import no.nav.lydia.kartlegging.Spørreundersøkelse
import no.nav.lydia.samarbeid.IASamarbeidDto
import no.nav.lydia.samarbeidsperiode.BegrunnelseType
import no.nav.lydia.samarbeidsperiode.IASak
import no.nav.lydia.samarbeidsperiode.IASakDto
import no.nav.lydia.samarbeidsperiode.IASakshendelseType
import no.nav.lydia.samarbeidsperiode.ÅrsakType
import no.nav.lydia.tilstandsmaskin.VirksomhetIATilstand
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test
import kotlin.test.fail

class VirksomhethistorikkTest {
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

        private fun hentHistorikkForVirksomhetRespons(
            orgnr: String,
            token: String = authContainerHelper.saksbehandler1.token,
        ): TestResponseTriple<HistorikkVirksomhetDto> =
            applikasjon.performGet(
                "$NY_FLYT_API_PATH/virksomhet/$orgnr/historikk",
            )
                .authentication().bearer(token)
                .tilSingelRespons<HistorikkVirksomhetDto>()

        private fun hentHistorikkForVirksomhet(
            orgnr: String,
            token: String = authContainerHelper.saksbehandler1.token,
        ): HistorikkVirksomhetDto =
            hentHistorikkForVirksomhetRespons(
                orgnr = orgnr,
                token = token,
            ).third.fold(
                success = { it },
                failure = { fail(it.message) },
            )

        private fun TestVirksomhet.hentHistorikk(token: String = authContainerHelper.saksbehandler1.token) = hentHistorikkForVirksomhet(orgnr, token)

        private fun TestVirksomhet.hentHistorikkRespons(token: String = authContainerHelper.saksbehandler1.token) =
            hentHistorikkForVirksomhetRespons(orgnr, token)

        private fun settOppSlettetVirksomhetMedAktivitet(): TestVirksomhet {
            val virksomhet = lastInnNyVirksomhet()
            val iASakDto: IASakDto = vurderVirksomhet(virksomhet = virksomhet)
            iASakDto.leggTilFolger(authContainerHelper.saksbehandler1.token)
            val iASamarbeidDto: IASamarbeidDto = iASakDto.opprettSamarbeid(
                token = authContainerHelper.saksbehandler1.token,
            )
            hentVirksomhetTilstand(
                orgnr = iASakDto.orgnr,
                token = authContainerHelper.saksbehandler1.token,
            ).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

            val behovsvurdering = iASamarbeidDto.opprettKartlegging(
                orgnr = iASakDto.orgnr,
                type = Spørreundersøkelse.Type.Behovsvurdering,
                token = authContainerHelper.saksbehandler1.token,
            )
            behovsvurdering.type shouldBe Spørreundersøkelse.Type.Behovsvurdering.name.uppercase()
            hentVirksomhetTilstand(
                orgnr = iASakDto.orgnr,
                token = authContainerHelper.saksbehandler1.token,
            ).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

            sendSlettingForVirksomhet(virksomhet)
            return virksomhet
        }
    }

    @Test
    fun `kan hente historikk for en virksomhet uten sak og hendelser`() {
        val virksomhet = lastInnNyVirksomhet()
        val respons = virksomhet.hentHistorikk()

        respons shouldBe HistorikkVirksomhetDto(
            historikkVirksomhet = HistorikkVirksomhet(
                hendelser = emptyList(),
                samarbeidsperioder = emptyList(),
            ),
        )
    }

    @Test
    fun `henting av historikk feiler hvis orgnr ikke finnes`() {
        val orgnr = "detteErEtFakeOrgnr123"
        val respons = hentHistorikkForVirksomhetRespons(orgnr = orgnr)

        respons.second.statusCode shouldBe HttpStatusCode.BadRequest.value
        respons.second.body().asString("text/plain") shouldBe "Ugyldig orgnummer"
    }

    @Test
    fun `kan hente historikk for en virksomhet som har hatt samarbeidsperiode og blitt slettet`() {
        val virksomhet = settOppSlettetVirksomhetMedAktivitet()

        val historikk = virksomhet.hentHistorikk()

        historikk.historikkVirksomhet.hendelser.run {
            size shouldBe 1
            this.shouldForAll { linje ->
                linje.beskrivelse shouldBe "Virksomheten er avregistrert i Brønnøysundregistrene"
                linje.tidspunkt shouldNotBe null
                linje.relatertHendelse shouldNotBe null
                linje.relatertHendelse!!.run {
                    hendelsetype shouldBe IASakshendelseType.VIRKSOMHET_AVREGISTRERT
                    hendelseOpprettetAv shouldBe "Fia system"
                    resulterendeStatus shouldBe IASak.Status.AVSLUTTET
                    versjon shouldBe HistorikkVersjon.NY_FLYT
                    årsak shouldBe null
                }
            }
        }
    }

    @Test
    fun `kan hente årsak med flere begrunnelser for en virksomhet`() {
        val virksomhet = settOppSlettetVirksomhetMedAktivitet()

        val hendelseId = virksomhet.hentHistorikk().historikkVirksomhet.hendelser[0].relatertHendelse!!.hendelseId

        // Finnes ikke en realistisk måte å få en årsak på i dag, så lager fake data
        postgresContainerHelper.performUpdate(
            """
            INSERT INTO hendelse_begrunnelse (hendelse_id, aarsak_enum, aarsak, begrunnelse_enum, begrunnelse)
            VALUES ('$hendelseId', '${ÅrsakType.VIRKSOMHETEN_TAKKET_NEI.name}', '${ÅrsakType.VIRKSOMHETEN_TAKKET_NEI.navn}', '${BegrunnelseType.AUTOMATISK_LUKKET.name}', '${BegrunnelseType.AUTOMATISK_LUKKET.navn}'),
                   ('$hendelseId', '${ÅrsakType.VIRKSOMHETEN_TAKKET_NEI.name}', '${ÅrsakType.VIRKSOMHETEN_TAKKET_NEI.navn}', '${BegrunnelseType.IKKE_TID.name}', '${BegrunnelseType.IKKE_TID.navn}');
            """.trimIndent(),
        )

        val historikk = virksomhet.hentHistorikk()
        historikk.historikkVirksomhet.hendelser[0].relatertHendelse!!.årsak.run {
            this shouldNotBe null
            this!!.beskrivelse shouldBe ÅrsakType.VIRKSOMHETEN_TAKKET_NEI.navn
            this.begrunnelser.toSet() shouldBe setOf(BegrunnelseType.AUTOMATISK_LUKKET.navn, BegrunnelseType.IKKE_TID.navn)
        }
    }

    @Test
    fun `historikk for en virksomhet inneholder samarbeidsperioder`() {
        val bruker = authContainerHelper.superbruker1
        val virksomhet = lastInnNyVirksomhet()

        val sak = vurderVirksomhet(virksomhet, token = bruker.token)

        sak.avsluttVurdering()

        val sak2 = vurderVirksomhet(virksomhet)

        sak2.bliEier(bruker.token)

        val historikk = virksomhet.hentHistorikk()
        historikk.historikkVirksomhet.samarbeidsperioder[0].should { nyesteSak ->
            nyesteSak.saksnummer shouldBe sak2.saksnummer
            nyesteSak.eier shouldBe bruker.navIdent
            nyesteSak.status shouldBe IASak.Status.VURDERES
        }
        historikk.historikkVirksomhet.samarbeidsperioder[1].should { eldsteSak ->
            eldsteSak.saksnummer shouldBe sak.saksnummer
            eldsteSak.eier shouldBe null
            eldsteSak.status shouldBe IASak.Status.VURDERT
        }
    }
}
