package no.nav.lydia.container.ia.sak

import io.kotest.inspectors.forAll
import io.kotest.inspectors.shouldForAtLeastOne
import io.kotest.matchers.collections.shouldContainExactly
import io.kotest.matchers.collections.shouldContainExactlyInAnyOrder
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import kotlinx.datetime.toKotlinLocalDate
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.aktivSamarbeidsperiode
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.avsluttVurdering
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.fullførSamarbeidsperiode
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.opprettSamarbeidResponse
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.vurderVirksomhet
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.vurderVirksomhetResponse
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.fullfør
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.opprettBehovsvurdering
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper.Companion.start
import no.nav.lydia.helper.PlanHelper.Companion.opprettEnPlan
import no.nav.lydia.helper.PlanHelper.Companion.planleggOgFullførAlleUndertemaer
import no.nav.lydia.helper.SakHelper.Companion.hentIASakLeveranser
import no.nav.lydia.helper.SakHelper.Companion.hentSaksStatus
import no.nav.lydia.helper.SakHelper.Companion.hentSamarbeidshistorikk
import no.nav.lydia.helper.SakHelper.Companion.hentSamarbeidshistorikkForOrgnrRespons
import no.nav.lydia.helper.SakHelper.Companion.oppdaterHendelsesTidspunkter
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefravær
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.hentVirksomhetsinformasjon
import no.nav.lydia.helper.VirksomhetHelper.Companion.lastInnNyVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.nyttOrgnummer
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.helper.statuskode
import no.nav.lydia.ia.sak.api.ÅrsakTilAtSakIkkeKanAvsluttes
import no.nav.lydia.ia.sak.api.ÅrsaksType
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus
import no.nav.lydia.ia.sak.domene.IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_VURDERES
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VURDERING_FULLFØRT_UTEN_SAMARBEID
import no.nav.lydia.ia.årsak.domene.BegrunnelseType.FOR_FÅ_TAPTE_DAGSVERK
import no.nav.lydia.ia.årsak.domene.BegrunnelseType.IKKE_DIALOG_MELLOM_PARTENE
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.ÅrsakType.NAV_IGANGSETTER_IKKE_TILTAK
import no.nav.lydia.sykefraværsstatistikk.api.geografi.Kommune
import kotlin.test.Test

class IASakApiTest {
    @Test
    fun `skal få saksnummer på en aktiv sak`() {
        val sak = vurderVirksomhet()
        val virksomhet = hentVirksomhetsinformasjon(orgnummer = sak.orgnr)
        virksomhet.aktivtSaksnummer shouldBe sak.saksnummer
    }

    @Test
    fun `skal få riktig saksnummer dersom saken har en aktiv og en lukket sak`() {
        val ikkeAktivSak = vurderVirksomhet().avsluttVurdering()
        ikkeAktivSak.oppdaterHendelsesTidspunkter(antallDagerTilbake = 30)

        val aktivSak = vurderVirksomhet()
        val virksomhet = hentVirksomhetsinformasjon(orgnummer = aktivSak.orgnr)
        virksomhet.aktivtSaksnummer shouldBe aktivSak.saksnummer
    }

    @Test
    fun `skal ikke få saksnummer hvis det finnes lukkede saker`() {
        val ikkeAktivSak = vurderVirksomhet().avsluttVurdering()
        ikkeAktivSak.oppdaterHendelsesTidspunkter(antallDagerTilbake = 30)
        val virksomhet = hentVirksomhetsinformasjon(orgnummer = ikkeAktivSak.orgnr)
        virksomhet.aktivtSaksnummer shouldBe null
    }

    @Test
    fun `skal lagre resulterende status i ia_sak_hendelse`() {
        val sak = vurderVirksomhet()

        val resulterendeStatuser = postgresContainerHelper.hentAlleRaderTilEnkelKolonne<String>(
            """
            select resulterende_status from ia_sak_hendelse where saksnummer = '${sak.saksnummer}'
            """.trimIndent(),
        )

        resulterendeStatuser shouldHaveSize 2
        resulterendeStatuser shouldBe listOf(
            IASak.Status.NY.name,
            IASak.Status.VURDERES.name,
        )
    }

    @Test
    fun `returnerer riktig saksstatus`() {
        val sak = aktivSamarbeidsperiode()
        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 1

        val saksStatusUtenNoe = sak.hentSaksStatus()
        saksStatusUtenNoe.kanFullføres shouldBe false
        saksStatusUtenNoe.årsaker.map { it.type } shouldContainExactlyInAnyOrder listOf(
            ÅrsaksType.INGEN_FULLFØRT_SAMARBEIDSPLAN,
        )

        val førsteSamarbeid = alleSamarbeid.first()
        val kartlegging = sak.opprettBehovsvurdering(samarbeidId = førsteSamarbeid.id)
        val saksStatusMedEnKartlegging = sak.hentSaksStatus()
        saksStatusMedEnKartlegging.kanFullføres shouldBe false
        saksStatusMedEnKartlegging.årsaker.map { it.type } shouldContainExactlyInAnyOrder listOf(
            ÅrsaksType.INGEN_FULLFØRT_SAMARBEIDSPLAN,
            ÅrsaksType.BEHOVSVURDERING_IKKE_FULLFØRT,
        )
        saksStatusMedEnKartlegging.årsaker.forExactlyOne {
            it shouldBe ÅrsakTilAtSakIkkeKanAvsluttes(
                samarbeidsId = førsteSamarbeid.id,
                samarbeidsNavn = førsteSamarbeid.navn,
                type = ÅrsaksType.BEHOVSVURDERING_IKKE_FULLFØRT,
                id = kartlegging.id,
            )
        }

        val plan = sak.opprettEnPlan()
        val saksStatusMedPlanOgKartlegging = sak.hentSaksStatus()
        saksStatusMedPlanOgKartlegging.kanFullføres shouldBe false
        saksStatusMedPlanOgKartlegging.årsaker.map { it.type } shouldContainExactlyInAnyOrder listOf(
            ÅrsaksType.SAMARBEIDSPLAN_IKKE_FULLFØRT,
            ÅrsaksType.BEHOVSVURDERING_IKKE_FULLFØRT,
        )
        saksStatusMedPlanOgKartlegging.årsaker.forExactlyOne {
            it shouldBe ÅrsakTilAtSakIkkeKanAvsluttes(
                samarbeidsId = førsteSamarbeid.id,
                samarbeidsNavn = førsteSamarbeid.navn,
                type = ÅrsaksType.SAMARBEIDSPLAN_IKKE_FULLFØRT,
                id = plan.id,
            )
        }

        kartlegging.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        kartlegging.fullfør(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        plan.planleggOgFullførAlleUndertemaer(orgnummer = sak.orgnr, saksnummer = sak.saksnummer, førsteSamarbeid.id)
        val sakstatusFullførtBehovsvurderingOgPlan = sak.hentSaksStatus()
        sakstatusFullførtBehovsvurderingOgPlan.kanFullføres shouldBe true
        sakstatusFullførtBehovsvurderingOgPlan.årsaker shouldHaveSize 0
    }

    @Test
    fun `skal lagre navenhet på hendelser`() {
        val sak = vurderVirksomhet(token = authContainerHelper.superbruker1.token)
        postgresContainerHelper.hentAlleRaderTilEnkelKolonne<String>(
            """
            select nav_enhet_nummer from ia_sak_hendelse
              where saksnummer = '${sak.saksnummer}'
            """.trimIndent(),
        ).forAll {
            it shouldBe "2900"
        }
    }

    @Test
    fun `skal kunne vise at en virksomhet vurderes og vise status i listevisning`() {
        val utsiraKommune = Kommune(navn = "Utsira", nummer = "1151")
        val virksomhet =
            lastInnNyVirksomhet(TestVirksomhet.nyVirksomhet(TestVirksomhet.beliggenhet(kommune = utsiraKommune)))
        hentSykefravær(success = { listeFørVirksomhetVurderes ->
            listeFørVirksomhetVurderes.data shouldHaveAtLeastSize 1
            listeFørVirksomhetVurderes.data.shouldForAtLeastOne { sykefraværsstatistikkVirksomhetDto ->
                sykefraværsstatistikkVirksomhetDto.orgnr shouldBe virksomhet.orgnr
                sykefraværsstatistikkVirksomhetDto.status shouldBe IASak.Status.IKKE_AKTIV
                sykefraværsstatistikkVirksomhetDto.sistEndret shouldBe null
            }
        }, kommuner = utsiraKommune.nummer)

        vurderVirksomhet(virksomhet = virksomhet)
        hentSykefravær(success = { listeEtterVirksomhetVurderes ->
            listeEtterVirksomhetVurderes.data shouldHaveAtLeastSize 1
            listeEtterVirksomhetVurderes.data.shouldForAtLeastOne { sykefraværsstatistikkVirksomhetDto ->
                sykefraværsstatistikkVirksomhetDto.orgnr shouldBe virksomhet.orgnr
                sykefraværsstatistikkVirksomhetDto.status shouldBe IASak.Status.VURDERES
                sykefraværsstatistikkVirksomhetDto.sistEndret shouldBe java.time.LocalDate.now().toKotlinLocalDate()
            }
        }, kommuner = utsiraKommune.nummer)
    }

    @Test
    fun `skal kunne hente gamle leveranser på historiske saker`() {
        val sak = vurderVirksomhet().fullførSamarbeidsperiode()

        // forutsetter data fra migrering i V65__legg_til_ia_tjeneste_utvikle_partssamarbeid.sql
        postgresContainerHelper.performUpdate(
            """
            insert into iasak_leveranse values (
                1, '${sak.saksnummer}', 18, now(), 'LEVERT', '${authContainerHelper.saksbehandler1.navIdent}',
                now(), '${authContainerHelper.saksbehandler1.navIdent}'
            )
            """.trimIndent(),
        )

        val leveranser = hentIASakLeveranser(sak.orgnr, sak.saksnummer)
        leveranser.forExactlyOne { tjeneste ->
            tjeneste.iaTjeneste.navn shouldBe "Utvikle partssamarbeid"
            tjeneste.leveranser.forExactlyOne { leveranse ->
                leveranse.status shouldBe IASakLeveranseStatus.LEVERT
                leveranse.modul.navn shouldBe "Utvikle partssamarbeid"
            }
        }
    }

    @Test
    fun `tilgangskontroll - bare superbruker skal kunne sette virksomheter til VURDERES`() {
        val virksomhet = lastInnNyVirksomhet()
        vurderVirksomhetResponse(
            virksomhet = virksomhet,
            token = authContainerHelper.lesebruker.token,
        ).statuskode() shouldBe 403
        vurderVirksomhetResponse(
            virksomhet = virksomhet,
            token = authContainerHelper.saksbehandler1.token,
        ).statuskode() shouldBe 403
        vurderVirksomhetResponse(
            virksomhet = virksomhet,
            token = authContainerHelper.superbruker1.token,
        ).statuskode() shouldBe 201
    }

    @Test
    fun `tilgangskontroll - en sak skal ikke kunne oppdateres av brukere med lesetilgang`() {
        val virksomhet = lastInnNyVirksomhet()
        val sak = vurderVirksomhet(token = authContainerHelper.superbruker1.token)
        sak.opprettSamarbeidResponse(authContainerHelper.lesebrukerAudit.token).statuskode() shouldBe 403
    }

    @Test
    fun `tilgangskontroll - brukere skal kunne hente historikk`() {
        val virksomhet = lastInnNyVirksomhet()
        val orgnummer = virksomhet.orgnr
        vurderVirksomhet(virksomhet = virksomhet, token = authContainerHelper.superbruker1.token)
        hentSamarbeidshistorikkForOrgnrRespons(
            orgnr = orgnummer,
            token = authContainerHelper.lesebruker.token,
        ).statuskode() shouldBe 200
        hentSamarbeidshistorikkForOrgnrRespons(
            orgnr = orgnummer,
            token = authContainerHelper.saksbehandler1.token,
        ).statuskode() shouldBe 200
        hentSamarbeidshistorikkForOrgnrRespons(
            orgnr = orgnummer,
            token = authContainerHelper.superbruker1.token,
        ).statuskode() shouldBe 200
        hentSamarbeidshistorikkForOrgnrRespons(
            orgnr = orgnummer,
            token = authContainerHelper.brukerUtenTilgangsrolle.token,
        ).statuskode() shouldBe 403
    }

    @Test
    fun `skal få samarbeidshistorikken til en virksomhet`() {
        val valgtÅrsak = ValgtÅrsak(
            type = NAV_IGANGSETTER_IKKE_TILTAK,
            begrunnelser = listOf(FOR_FÅ_TAPTE_DAGSVERK, IKKE_DIALOG_MELLOM_PARTENE),
        )
        val orgnummer = nyttOrgnummer()
        val sak = vurderVirksomhet().avsluttVurdering()

        hentSamarbeidshistorikk(orgnummer = orgnummer).also { samarbeidshistorikk ->
            samarbeidshistorikk shouldHaveSize 1
            val sakshistorikk = samarbeidshistorikk.first()
            sakshistorikk.sakshendelser.map { it.status } shouldContainExactly listOf(
                IASak.Status.NY,
                IASak.Status.VURDERES,
                IASak.Status.VURDERT,
            )
            sakshistorikk.sakshendelser.map { it.hendelsestype } shouldContainExactly listOf(
                OPPRETT_SAK_FOR_VIRKSOMHET,
                VIRKSOMHET_VURDERES,
                VURDERING_FULLFØRT_UTEN_SAMARBEID,
            )
            sakshistorikk.sakshendelser.forExactlyOne { sakSnapshot ->
                sakSnapshot.begrunnelser shouldBe valgtÅrsak.begrunnelser.map { it.navn }
            }
            sakshistorikk.sistEndret shouldBe sak.endretTidspunkt
        }
    }

    @Test
    fun `rolle til innlogget ansatt skal bli lagret på hendelsene`() {
        val sak = vurderVirksomhet(token = authContainerHelper.superbruker1.token)

        postgresContainerHelper.hentAlleRaderTilEnkelKolonne<String>(
            "select opprettet_av_rolle from ia_sak_hendelse where saksnummer = '${sak.saksnummer}' order by opprettet",
        ) shouldBe listOf(
            "SUPERBRUKER",
            "SUPERBRUKER",
        )
    }
}
