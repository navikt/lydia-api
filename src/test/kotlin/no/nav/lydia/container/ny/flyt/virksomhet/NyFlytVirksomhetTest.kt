package no.nav.lydia.container.ny.flyt.virksomhet

import io.kotest.inspectors.shouldForAll
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.toKotlinLocalDate
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.aktivSamarbeidsperiode
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.avsluttSamarbeid
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.avsluttVurdering
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.hentVirksomhet
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.hentVirksomhetTilstand
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.opprettOgFullførSamarbeidsperiode
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.opprettSamarbeid
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.vurderVirksomhet
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.vurderVirksomhetResponse
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.fullfør
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.opprettBehovsvurdering
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.opprettEvaluering
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.opprettKartlegging
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.start
import no.nav.lydia.helper.PlanHelper.Companion.hentPlanMal
import no.nav.lydia.helper.PlanHelper.Companion.inkluderAlt
import no.nav.lydia.helper.PlanHelper.Companion.opprettEnPlan
import no.nav.lydia.helper.PlanHelper.Companion.planleggOgFullførAlleUndertemaer
import no.nav.lydia.helper.SakHelper.Companion.hentSak
import no.nav.lydia.helper.SakHelper.Companion.hentSamarbeidshistorikkNyFlyt
import no.nav.lydia.helper.SakHelper.Companion.leggTilFolger
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.VirksomhetHelper.Companion.lastInnNyVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.sendSlettingForVirksomhet
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.helper.statuskode
import no.nav.lydia.kartlegging.Spørreundersøkelse
import no.nav.lydia.prioritering.virksomhet.domene.VirksomhetStatus
import no.nav.lydia.samarbeid.IASamarbeid
import no.nav.lydia.samarbeid.IASamarbeidDto
import no.nav.lydia.samarbeidsperiode.BegrunnelseType
import no.nav.lydia.samarbeidsperiode.IASak
import no.nav.lydia.samarbeidsperiode.IASakDto
import no.nav.lydia.samarbeidsperiode.IASakshendelseType
import no.nav.lydia.samarbeidsperiode.ValgtÅrsak
import no.nav.lydia.samarbeidsperiode.ÅrsakType
import no.nav.lydia.tilgangskontroll.fia.Rolle
import no.nav.lydia.tilstandsmaskin.VirksomhetIATilstand
import org.junit.AfterClass
import org.junit.BeforeClass
import java.time.LocalDate
import kotlin.test.Test

class NyFlytVirksomhetTest {
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
    fun `skal kunne avslutte vurdering som ikke medfører et samarbeid`() {
        val sak = NyFlytTestUtils.vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES

        val oppdatertSakDto = sak.avsluttVurdering(
            valgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_ER_FERDIG_VURDERT_OG_TAKKET_NEI,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_ER_IKKE_MOTIVERT_ELLER_HAR_IKKE_KAPASITET,
                    BegrunnelseType.VIRKSOMHETEN_FERDIG_VURDERT_TAKKET_NEI_ANNET,
                ),
                dato = LocalDate.now().plusDays(20).toKotlinLocalDate(),
            ),
        )
        oppdatertSakDto.status shouldBe IASak.Status.VURDERT

        NyFlytTestUtils.verifiserIASakObserversErVarslet(
            iASakDto = oppdatertSakDto,
            forventedeIASakStatuser = listOf(IASak.Status.VURDERES, IASak.Status.VURDERT),
            forventetIASakStatusIStatistikk = IASak.Status.VURDERT,
            rolle = Rolle.SUPERBRUKER,
            hendelseType = IASakshendelseType.VURDERING_FULLFØRT_UTEN_SAMARBEID,
            begrunnelser = listOf(
                BegrunnelseType.VIRKSOMHETEN_ER_IKKE_MOTIVERT_ELLER_HAR_IKKE_KAPASITET,
                BegrunnelseType.VIRKSOMHETEN_FERDIG_VURDERT_TAKKET_NEI_ANNET,
            ),
        )
    }

    @Test
    fun `avslutt vurdering med gyldig årsak gir tilstand VirksomhetErVurdert og nesteTilstand VirksomhetKlarTilVurdering`() {
        val sak = NyFlytTestUtils.vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES

        sak.avsluttVurdering(
            valgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_ER_FERDIG_VURDERT_MED_INTERN_VURDERING,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_HAR_FOR_LAVT_POTENSIALE,
                    BegrunnelseType.VIRKSOMHETEN_MANGLER_REPRESANTANTER_ELLER_ETABLERT_PARTSGRUPPE,
                ),
                dato = LocalDate.now().plusDays(20).toKotlinLocalDate(),
            ),
        )

        val virksomhetsTilstand = NyFlytTestUtils.hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstand.tilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        virksomhetsTilstand.nesteTilstand!!.startTilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        virksomhetsTilstand.nesteTilstand.planlagtHendelse shouldBe "GjørVirksomhetKlarTilNyVurdering"
        virksomhetsTilstand.nesteTilstand.nyTilstand shouldBe VirksomhetIATilstand.VirksomhetKlarTilVurdering
        virksomhetsTilstand.nesteTilstand.planlagtDato shouldBe LocalDate.now().plusDays(20).toKotlinLocalDate()
    }

    @Test
    fun `avslutt vurdering med årsak 'skal vurderes senere' gir tilstand VirksomhetErVurdert og nesteTilstand VirksomhetVurderes`() {
        val sak = NyFlytTestUtils.vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES

        sak.avsluttVurdering(
            valgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_VURDERES_PÅ_ET_SENERE_TIDSPUNKT,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_ØNSKER_Å_BLI_KONTAKTET_SENERE,
                ),
                dato = LocalDate.now().plusDays(20).toKotlinLocalDate(),
            ),
        )

        val virksomhetsTilstand = NyFlytTestUtils.hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstand.tilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        virksomhetsTilstand.nesteTilstand!!.startTilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        virksomhetsTilstand.nesteTilstand.planlagtHendelse shouldBe "VurderVirksomhet"
        virksomhetsTilstand.nesteTilstand.nyTilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes
        virksomhetsTilstand.nesteTilstand.planlagtDato shouldBe LocalDate.now().plusDays(20).toKotlinLocalDate()
    }

    @Test
    fun `skal avslutte aktiv sak for virksomheter som blir slettet`() {
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

        // TODO: Skulle noe vært logget? Skulle det i så fall vært testet på?

        hentVirksomhetTilstand(
            orgnr = iASakDto.orgnr,
            token = authContainerHelper.saksbehandler1.token,
        ).tilstand shouldBe VirksomhetIATilstand.VirksomhetErSlettet

        hentVirksomhet(
            orgnr = iASakDto.orgnr,
            token = authContainerHelper.saksbehandler1.token,
        ).status shouldBe VirksomhetStatus.SLETTET

        val historikk = hentSamarbeidshistorikkNyFlyt(iASakDto.orgnr)
        val samarbeid: List<IASamarbeidDto> = historikk.flatMap { it.samarbeid }
        samarbeid.shouldForAll { it.status shouldNotBe IASamarbeid.Status.AKTIV }

        val sak = hentSak(orgnummer = iASakDto.orgnr, iASakDto.saksnummer)
        sak.status.regnesSomAvsluttet() shouldBe true
    }

    @Test
    fun `skal sette virksomhet til VirksomhetErSlettet fra VirksomhetKlarTilVurdering`() {
        val virksomhet = lastInnNyVirksomhet()

        sendSlettingForVirksomhet(virksomhet)

        hentVirksomhetTilstand(
            orgnr = virksomhet.orgnr,
            token = authContainerHelper.saksbehandler1.token,
        ).tilstand shouldBe VirksomhetIATilstand.VirksomhetErSlettet
        hentVirksomhet(
            orgnr = virksomhet.orgnr,
            token = authContainerHelper.saksbehandler1.token,
        ).status shouldBe VirksomhetStatus.SLETTET
    }

    @Test
    fun `skal sette virksomhet til VirksomhetErSlettet fra VirksomhetVurderes`() {
        val virksomhet = lastInnNyVirksomhet()
        val sak = vurderVirksomhet(virksomhet = virksomhet)

        hentVirksomhetTilstand(
            orgnr = virksomhet.orgnr,
            token = authContainerHelper.saksbehandler1.token,
        ).tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes

        sendSlettingForVirksomhet(virksomhet)

        hentVirksomhetTilstand(
            orgnr = virksomhet.orgnr,
            token = authContainerHelper.saksbehandler1.token,
        ).tilstand shouldBe VirksomhetIATilstand.VirksomhetErSlettet
        hentSak(
            orgnummer = virksomhet.orgnr,
            saksnummer = sak.saksnummer,
        ).status shouldBe IASak.Status.AVSLUTTET
    }

    @Test
    fun `skal sette virksomhet til VirksomhetErSlettet fra VirksomhetErVurdert`() {
        val virksomhet = lastInnNyVirksomhet()
        vurderVirksomhet(virksomhet = virksomhet).avsluttVurdering()

        hentVirksomhetTilstand(
            orgnr = virksomhet.orgnr,
            token = authContainerHelper.saksbehandler1.token,
        ).tilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert

        sendSlettingForVirksomhet(virksomhet)

        hentVirksomhetTilstand(
            orgnr = virksomhet.orgnr,
            token = authContainerHelper.saksbehandler1.token,
        ).tilstand shouldBe VirksomhetIATilstand.VirksomhetErSlettet
        hentVirksomhet(
            orgnr = virksomhet.orgnr,
            token = authContainerHelper.saksbehandler1.token,
        ).status shouldBe VirksomhetStatus.SLETTET
    }

    @Test
    fun `skal sette virksomhet til VirksomhetErSlettet fra AlleSamarbeidIVirksomhetErAvsluttet`() {
        val virksomhet = lastInnNyVirksomhet()
        virksomhet.opprettOgFullførSamarbeidsperiode()

        hentVirksomhetTilstand(
            orgnr = virksomhet.orgnr,
            token = authContainerHelper.saksbehandler1.token,
        ).tilstand shouldBe VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet

        sendSlettingForVirksomhet(virksomhet)

        hentVirksomhetTilstand(
            orgnr = virksomhet.orgnr,
            token = authContainerHelper.saksbehandler1.token,
        ).tilstand shouldBe VirksomhetIATilstand.VirksomhetErSlettet
    }

    @Test
    fun `VirksomhetErSlettet er en terminal tilstand som avviser alle hendelser`() {
        val virksomhet = lastInnNyVirksomhet()
        sendSlettingForVirksomhet(virksomhet)

        hentVirksomhetTilstand(
            orgnr = virksomhet.orgnr,
            token = authContainerHelper.saksbehandler1.token,
        ).tilstand shouldBe VirksomhetIATilstand.VirksomhetErSlettet

        vurderVirksomhetResponse(virksomhet).statuskode() shouldBe HttpStatusCode.BadRequest.value
    }

    @Test
    fun `skal ikke røre ikke aktive saker når virksomhet blir slettet`() {
        val virksomhet = lastInnNyVirksomhet()

        val sak = aktivSamarbeidsperiode(virksomhet)
        val samarbeid = sak.hentAlleSamarbeid().first()
        val behovsvurdering = sak.opprettBehovsvurdering()
        behovsvurdering.start(
            orgnummer = sak.orgnr,
            saksnummer = sak.saksnummer,
        )
        behovsvurdering.fullfør(
            orgnummer = sak.orgnr,
            saksnummer = sak.saksnummer,
        )
        val plan = sak.opprettEnPlan(plan = hentPlanMal().inkluderAlt())
        plan.planleggOgFullførAlleUndertemaer(
            orgnummer = sak.orgnr,
            saksnummer = sak.saksnummer,
            samarbeidId = samarbeid.id,
        )
        val evaluering = sak.opprettEvaluering()
        evaluering.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        evaluering.fullfør(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        samarbeid.avsluttSamarbeid(
            orgnr = sak.orgnr,
            avslutningsType = IASamarbeid.Status.FULLFØRT,
        )

        val sakFørSletting = hentSak(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        sendSlettingForVirksomhet(virksomhet)

        postgresContainerHelper.hentEnkelKolonne<String>(
            "select status from ia_sak where saksnummer = '${sak.saksnummer}'",
        ) shouldBe IASak.Status.AVSLUTTET.name
        postgresContainerHelper.hentEnkelKolonne<String>(
            "select endret_av_hendelse from ia_sak where saksnummer = '${sak.saksnummer}'",
        ) shouldBe sakFørSletting.endretAvHendelseId
    }
}
