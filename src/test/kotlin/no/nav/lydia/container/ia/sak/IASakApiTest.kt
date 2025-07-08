package no.nav.lydia.container.ia.sak

import com.github.guepardoapps.kulid.ULID
import io.kotest.assertions.shouldFail
import io.kotest.assertions.shouldFailWithMessage
import io.kotest.inspectors.forAll
import io.kotest.inspectors.forAtLeastOne
import io.kotest.inspectors.shouldForAtLeastOne
import io.kotest.matchers.collections.shouldBeEmpty
import io.kotest.matchers.collections.shouldContain
import io.kotest.matchers.collections.shouldContainAll
import io.kotest.matchers.collections.shouldContainExactly
import io.kotest.matchers.collections.shouldContainExactlyInAnyOrder
import io.kotest.matchers.collections.shouldHaveAtLeastSize
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.toKotlinLocalDate
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.avslutt
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettBehovsvurdering
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.start
import no.nav.lydia.helper.PlanHelper.Companion.opprettEnPlan
import no.nav.lydia.helper.PlanHelper.Companion.planleggOgFullførAlleUndertemaer
import no.nav.lydia.helper.SakHelper.Companion.avbrytSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.fullførSak
import no.nav.lydia.helper.SakHelper.Companion.fullførSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.hentSak
import no.nav.lydia.helper.SakHelper.Companion.hentSakRespons
import no.nav.lydia.helper.SakHelper.Companion.hentSaksStatus
import no.nav.lydia.helper.SakHelper.Companion.hentSamarbeidshistorikk
import no.nav.lydia.helper.SakHelper.Companion.hentSamarbeidshistorikkForOrgnrRespons
import no.nav.lydia.helper.SakHelper.Companion.nyHendelse
import no.nav.lydia.helper.SakHelper.Companion.nyHendelsePåSak
import no.nav.lydia.helper.SakHelper.Companion.nyHendelsePåSakMedRespons
import no.nav.lydia.helper.SakHelper.Companion.nyHendelseRespons
import no.nav.lydia.helper.SakHelper.Companion.nyIkkeAktuellHendelse
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.SakHelper.Companion.nySakIKontaktes
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.SakHelper.Companion.oppdaterHendelsesTidspunkter
import no.nav.lydia.helper.SakHelper.Companion.opprettSakForVirksomhet
import no.nav.lydia.helper.SakHelper.Companion.opprettSakForVirksomhetRespons
import no.nav.lydia.helper.SakHelper.Companion.slettSak
import no.nav.lydia.helper.SakHelper.Companion.slettSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.toJson
import no.nav.lydia.helper.StatistikkHelper.Companion.hentSykefravær
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldNotContainLog
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.hentVirksomhetsinformasjon
import no.nav.lydia.helper.VirksomhetHelper.Companion.lastInnNyVirksomhet
import no.nav.lydia.helper.VirksomhetHelper.Companion.nyttOrgnummer
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.helper.nyttNavnPåSamarbeid
import no.nav.lydia.helper.opprettNyttSamarbeid
import no.nav.lydia.helper.statuskode
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import no.nav.lydia.ia.sak.api.ÅrsakTilAtSakIkkeKanAvsluttes
import no.nav.lydia.ia.sak.api.ÅrsaksType
import no.nav.lydia.ia.sak.domene.ANTALL_DAGER_FØR_SAK_LÅSES
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelseType.FULLFØR_BISTAND
import no.nav.lydia.ia.sak.domene.IASakshendelseType.OPPRETT_SAK_FOR_VIRKSOMHET
import no.nav.lydia.ia.sak.domene.IASakshendelseType.SLETT_SAK
import no.nav.lydia.ia.sak.domene.IASakshendelseType.TA_EIERSKAP_I_SAK
import no.nav.lydia.ia.sak.domene.IASakshendelseType.TILBAKE
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_ER_IKKE_AKTUELL
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_KARTLEGGES
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_SKAL_BISTÅS
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_VURDERES
import no.nav.lydia.ia.årsak.domene.BegrunnelseType.FOR_FÅ_TAPTE_DAGSVERK
import no.nav.lydia.ia.årsak.domene.BegrunnelseType.IKKE_DIALOG_MELLOM_PARTENE
import no.nav.lydia.ia.årsak.domene.BegrunnelseType.SAKEN_ER_FEILREGISTRERT
import no.nav.lydia.ia.årsak.domene.BegrunnelseType.VIRKSOMHETEN_HAR_IKKE_RESPONDERT
import no.nav.lydia.ia.årsak.domene.BegrunnelseType.VIRKSOMHETEN_ØNSKER_IKKE_SAMARBEID
import no.nav.lydia.ia.årsak.domene.GyldigBegrunnelse.Companion.somBegrunnelseType
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.ÅrsakType.NAV_IGANGSETTER_IKKE_TILTAK
import no.nav.lydia.ia.årsak.domene.ÅrsakType.VIRKSOMHETEN_TAKKET_NEI
import no.nav.lydia.sykefraværsstatistikk.api.geografi.Kommune
import no.nav.lydia.tilgangskontroll.fia.Rolle
import kotlin.test.Test
import kotlin.test.assertTrue

class IASakApiTest {
    @Test
    fun `skal ikke kunne fullføre sak uten å fullføre alle samarbeid først`() {
        val sak = nySakIKartlegges().opprettNyttSamarbeid().also { it.opprettEnPlan() }.nyHendelse(hendelsestype = VIRKSOMHET_SKAL_BISTÅS)
        shouldFailWithMessage("HTTP Exception 400 Bad Request Kan ikke avslutte sak med aktive samarbeid") {
            sak.nyHendelse(hendelsestype = FULLFØR_BISTAND)
        }
    }

    @Test
    fun `skal gå tilbake til forrige status uavhengig av hendelsesrekke`() {
        nySakIKontaktes()
            .nyHendelse(TILBAKE).status shouldBe IASak.Status.VURDERES

        nySakIKontaktes()
            .nyHendelse(TA_EIERSKAP_I_SAK, token = authContainerHelper.saksbehandler2.token)
            .nyHendelse(TA_EIERSKAP_I_SAK, token = authContainerHelper.saksbehandler1.token)
            .nyHendelse(TILBAKE).status shouldBe IASak.Status.VURDERES

        nySakIKartlegges()
            .opprettNyttSamarbeid()
            .slettSamarbeid()
            .opprettNyttSamarbeid()
            .nyttNavnPåSamarbeid(nyttNavn = "Test")
            .nyHendelse(TILBAKE).status shouldBe IASak.Status.KONTAKTES

        val sakIViBistårFørTilbake = nySakIViBistår()
        sakIViBistårFørTilbake.opprettEnPlan()
        sakIViBistårFørTilbake
            .fullførSamarbeid()
            .nyHendelse(TILBAKE).status shouldBe IASak.Status.KARTLEGGES
    }

    @Test
    fun `skal få saksnummer på en aktiv sak`() {
        val sak = nySakIKartlegges()
        val virksomhet = hentVirksomhetsinformasjon(orgnummer = sak.orgnr)
        virksomhet.aktivtSaksnummer shouldBe sak.saksnummer
    }

    @Test
    fun `skal få riktig saksnummer dersom saken har en aktiv og en lukket sak`() {
        val ikkeAktivSak = nySakIKartlegges().nyIkkeAktuellHendelse()
        ikkeAktivSak.oppdaterHendelsesTidspunkter(antallDagerTilbake = 30)

        val aktivSak = nySakIKartlegges()
        val virksomhet = hentVirksomhetsinformasjon(orgnummer = aktivSak.orgnr)
        virksomhet.aktivtSaksnummer shouldBe aktivSak.saksnummer
    }

    @Test
    fun `skal ikke få saksnummer hvis det finnes lukkede saker`() {
        val ikkeAktivSak = nySakIKartlegges().nyIkkeAktuellHendelse()
        ikkeAktivSak.oppdaterHendelsesTidspunkter(antallDagerTilbake = 30)
        val virksomhet = hentVirksomhetsinformasjon(orgnummer = ikkeAktivSak.orgnr)
        virksomhet.aktivtSaksnummer shouldBe null
    }

    @Test
    fun `skal lagre resulterende status i ia_sak_hendelse`() {
        val sak = nySakIKartlegges()

        val resulterendeStatuser = postgresContainerHelper.hentAlleRaderTilEnkelKolonne<String>(
            """
            select resulterende_status from ia_sak_hendelse where saksnummer = '${sak.saksnummer}'
            """.trimIndent(),
        )

        resulterendeStatuser shouldHaveSize 5
        resulterendeStatuser shouldBe listOf(
            IASak.Status.NY.name,
            IASak.Status.VURDERES.name,
            IASak.Status.VURDERES.name,
            IASak.Status.KONTAKTES.name,
            IASak.Status.KARTLEGGES.name,
        )
    }

    @Test
    fun `returnerer riktig saksstatus`() {
        val sak = nySakIKartlegges().opprettNyttSamarbeid(navn = "Nytt samarbeid")
        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 1

        val saksStatusUtenNoe = sak.hentSaksStatus()
        saksStatusUtenNoe.kanFullføres shouldBe false
        saksStatusUtenNoe.årsaker.map { it.type } shouldContainExactlyInAnyOrder listOf(
            ÅrsaksType.INGEN_FULLFØRT_SAMARBEIDSPLAN,
        )

        val førsteSamarbeid = alleSamarbeid.first()
        val behovsvurdering = sak.opprettBehovsvurdering(prosessId = førsteSamarbeid.id)
        val saksStatusMedBehovsvurdering = sak.hentSaksStatus()
        saksStatusMedBehovsvurdering.kanFullføres shouldBe false
        saksStatusMedBehovsvurdering.årsaker.map { it.type } shouldContainExactlyInAnyOrder listOf(
            ÅrsaksType.INGEN_FULLFØRT_SAMARBEIDSPLAN,
            ÅrsaksType.BEHOVSVURDERING_IKKE_FULLFØRT,
        )
        saksStatusMedBehovsvurdering.årsaker.forExactlyOne {
            it shouldBe ÅrsakTilAtSakIkkeKanAvsluttes(
                samarbeidsId = førsteSamarbeid.id,
                samarbeidsNavn = førsteSamarbeid.navn,
                type = ÅrsaksType.BEHOVSVURDERING_IKKE_FULLFØRT,
                id = behovsvurdering.id,
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

        behovsvurdering.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        behovsvurdering.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        plan.planleggOgFullførAlleUndertemaer(orgnummer = sak.orgnr, saksnummer = sak.saksnummer, førsteSamarbeid.id)
        val sakstatusFullførtBehovsvurderingOgPlan = sak.hentSaksStatus()
        sakstatusFullførtBehovsvurderingOgPlan.kanFullføres shouldBe true
        sakstatusFullførtBehovsvurderingOgPlan.årsaker shouldHaveSize 0
    }

    @Test
    fun `skal ikke få feil ved journalføring av hendelser`() {
        nySakIViBistår()
        applikasjon shouldNotContainLog "Noe gikk feil ved journalføring av hendelse".toRegex()
    }

    @Test
    fun `skal lagre navenhet på hendelser`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
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
    fun `skal validere at begrunnelse tilhører riktig årsak`() {
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelseRespons(
                hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL,
                payload = ValgtÅrsak(
                    type = NAV_IGANGSETTER_IKKE_TILTAK,
                    begrunnelser = listOf(VIRKSOMHETEN_HAR_IKKE_RESPONDERT),
                ).toJson(),
            ).statuskode() shouldBe 400
    }

    @Test
    fun `skal kunne åpne en ny sak etter at en sak er slettet`() {
        val orgnummer = nyttOrgnummer()
        opprettSakForVirksomhet(orgnummer = orgnummer).slettSak()
        hentSakRespons(orgnummer = orgnummer).statuskode() shouldBe HttpStatusCode.NoContent.value
        opprettSakForVirksomhet(orgnummer = orgnummer).also { it.status shouldBe IASak.Status.VURDERES }
        hentSak(orgnummer).status shouldBe IASak.Status.VURDERES
    }

    @Test
    fun `skal kunne slette en sak med status Vurderes (uten eier)`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer()).slettSak()
        hentSakRespons(sak.orgnr).statuskode() shouldBe HttpStatusCode.NoContent.value
    }

    @Test
    fun `skal ikke kunne slette sak dersom man ikke er superbruker`() {
        shouldFail {
            opprettSakForVirksomhet(orgnummer = nyttOrgnummer(), token = authContainerHelper.superbruker1.token)
                .nyHendelse(hendelsestype = SLETT_SAK, token = authContainerHelper.saksbehandler1.token)
        }
        shouldFail {
            opprettSakForVirksomhet(orgnummer = nyttOrgnummer(), token = authContainerHelper.superbruker1.token)
                .nyHendelse(hendelsestype = SLETT_SAK, token = authContainerHelper.lesebruker.token)
        }
    }

    @Test
    fun `skal ikke kunne slette sak etter at eierskap er tatt`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer()).nyHendelse(hendelsestype = TA_EIERSKAP_I_SAK)

        shouldFail {
            sak.slettSak()
        }
    }

    @Test
    fun `skal kunne sette en virksomhet i kontaktes status`() {
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .also { it.status shouldBe IASak.Status.KONTAKTES }
    }

    @Test
    fun `en virksomhet skal ikke kunne kontaktes før saken har et eierskap`() {
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .also { shouldFail { it.nyHendelse(VIRKSOMHET_SKAL_KONTAKTES) } }
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .also { it.status shouldBe IASak.Status.KONTAKTES }
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
        val sak = opprettSakForVirksomhet(orgnummer = virksomhet.orgnr)
        assertTrue(ULID.isValid(ulid = sak.saksnummer))
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
    fun `skal ikke kunne opprette ny sak hvis det allerede finnes en åpen sak`() {
        val orgnummer = nyttOrgnummer()
        opprettSakForVirksomhetRespons(
            orgnummer = orgnummer,
            token = authContainerHelper.superbruker1.token,
        ).statuskode() shouldBe 201

        opprettSakForVirksomhetRespons(
            orgnummer = orgnummer,
            token = authContainerHelper.superbruker1.token,
        ).statuskode() shouldBe 501
    }

    @Test
    fun `skal kunne opprette ny sak dersom de andre sakene regnes som ikke aktuell`() {
        val orgnummer = nyttOrgnummer()
        var sak = opprettSakForVirksomhet(orgnummer = orgnummer)
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .also { sak -> shouldFail { sak.nyHendelse(FULLFØR_BISTAND) } }
            .nyHendelse(VIRKSOMHET_SKAL_BISTÅS)

        sak.status shouldBe IASak.Status.VI_BISTÅR

        opprettSakForVirksomhetRespons(orgnummer = orgnummer, token = authContainerHelper.superbruker1.token)
            .statuskode() shouldBe 501

        sak = sak.nyHendelse(
            hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL,
            payload = ValgtÅrsak(
                type = VIRKSOMHETEN_TAKKET_NEI,
                begrunnelser = listOf(VIRKSOMHETEN_ØNSKER_IKKE_SAMARBEID),
            ).toJson(),
        )
        sak.status shouldBe IASak.Status.IKKE_AKTUELL

        val nySak = opprettSakForVirksomhet(orgnummer = orgnummer, token = authContainerHelper.superbruker1.token)

        hentSak(orgnummer = orgnummer, saksnummer = sak.saksnummer).status shouldBe IASak.Status.IKKE_AKTUELL
        hentSak(orgnummer = orgnummer, saksnummer = nySak.saksnummer).status shouldBe IASak.Status.VURDERES
    }

    @Test
    fun `skal logge doble eventer`() {
        val orgnummer = nyttOrgnummer()
        val sak = nySakIViBistår(orgnummer = orgnummer)

        postgresContainerHelper.performUpdate(
            """
            INSERT INTO ia_sak_hendelse (
                id,
                saksnummer,
                orgnr,
                type,
                opprettet_av,
                opprettet_av_rolle,
                opprettet
            )
            VALUES (
                '777',
                '${sak.saksnummer}',
                '${sak.orgnr}',
                '${VIRKSOMHET_SKAL_BISTÅS.name}',
                '${sak.eidAv}',
                '${Rolle.SUPERBRUKER}',
                '${sak.endretTidspunkt}'
            ) 
            """.trimIndent(),
        )
        sak.status shouldBe IASak.Status.VI_BISTÅR

        val response = hentSamarbeidshistorikkForOrgnrRespons(orgnr = orgnummer)
        response.statuskode() shouldBe HttpStatusCode.InternalServerError.value
        applikasjon shouldContainLog ("Feil! IASak ${sak.saksnummer} har doble hendelser i databasen med følgende ider:").toRegex()
        postgresContainerHelper.performUpdate("DELETE FROM ia_sak_hendelse WHERE id = '777'")
    }

    @Test
    fun `skal logge feilmelding ved statusendring om saken har to like hendelser på rad i historikken (som ikke er TILBAKE)`() {
        val orgnummer = nyttOrgnummer()
        val sak = nySakIViBistår(orgnummer = orgnummer)

        postgresContainerHelper.performUpdate(
            """
            INSERT INTO ia_sak_hendelse (
                id,
                saksnummer,
                orgnr,
                type,
                opprettet_av,
                opprettet_av_rolle,
                opprettet
            )
            VALUES (
                '888',
                '${sak.saksnummer}',
                '${sak.orgnr}',
                '${VIRKSOMHET_SKAL_BISTÅS.name}',
                '${sak.eidAv}',
                '${Rolle.SUPERBRUKER}',
                '${sak.endretTidspunkt}'
            ) 
            """.trimIndent(),
        )
        sak.status shouldBe IASak.Status.VI_BISTÅR
        shouldFail { sak.nyHendelse(TILBAKE) }

        applikasjon shouldContainLog ("Feil! IASak ${sak.saksnummer} har doble hendelser i databasen med følgende ider:").toRegex()
        postgresContainerHelper.performUpdate("DELETE FROM ia_sak_hendelse WHERE id = '888'")
    }

    @Test
    fun `skal takle dobbelt tilbake event`() {
        val orgnummer = nyttOrgnummer()
        val sak = nySakIViBistår(orgnummer = orgnummer)
            .nyHendelse(TILBAKE)
            .nyHendelse(TILBAKE)

        sak.status shouldBe IASak.Status.KONTAKTES

        val response = hentSamarbeidshistorikkForOrgnrRespons(orgnr = orgnummer)
        response.statuskode() shouldBe HttpStatusCode.OK.value
        val resultat = response.third.get()
        resultat.size shouldBe 1
        resultat[0].sakshendelser.size shouldBe 9
    }

    @Test
    fun `skal takle dobbelt ta eierskap event`() {
        val orgnummer = nyttOrgnummer()
        val sak = nySakIViBistår(orgnummer = orgnummer)
            .nyHendelse(TA_EIERSKAP_I_SAK, token = authContainerHelper.saksbehandler2.token)
            .nyHendelse(TA_EIERSKAP_I_SAK, token = authContainerHelper.saksbehandler1.token)

        sak.status shouldBe IASak.Status.VI_BISTÅR

        val response = hentSamarbeidshistorikkForOrgnrRespons(orgnr = orgnummer)
        response.statuskode() shouldBe HttpStatusCode.OK.value
        val resultat = response.third.get()
        resultat.size shouldBe 1
        resultat[0].sakshendelser.size shouldBe 9
    }

    @Test
    fun `skal takle endre eller opprett prosess (samarbeid) event`() {
        val orgnummer = nyttOrgnummer()
        val sak = nySakIKartlegges(orgnummer = orgnummer).opprettNyttSamarbeid()
        val førsteSamarbeid = sak.hentAlleSamarbeid().first()
        sak.nyttNavnPåSamarbeid(iaSamarbeidDto = førsteSamarbeid, nyttNavn = "Nytt navn")
        sak.status shouldBe IASak.Status.KARTLEGGES

        val oppdatertSak = hentSak(orgnummer).nyHendelse(VIRKSOMHET_SKAL_BISTÅS).nyHendelse(TILBAKE)

        oppdatertSak.status shouldBe IASak.Status.KARTLEGGES
    }

    @Test
    fun `skal IKKE kunne opprette ny sak dersom de andre sakene regnes som ikke fullført`() {
        // TODO Testrydding:
        //  Vi testar to ting: skal kun kunne fullføre sakar frå Vi Bistår, og ikkje kunne lage ny sak før status er fullført.
        //  Denne testen burde bu saman med dei andre som testar oppretting av ny sak.
        val orgnummer = nyttOrgnummer()
        var sak = opprettSakForVirksomhet(orgnummer = orgnummer)
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .also { sak ->
                shouldFail {
                    sak.nyHendelse(FULLFØR_BISTAND)
                }
            }
            .opprettNyttSamarbeid()
            .nyHendelse(VIRKSOMHET_SKAL_BISTÅS)
        sak.status shouldBe IASak.Status.VI_BISTÅR

        opprettSakForVirksomhetRespons(orgnummer = orgnummer, token = authContainerHelper.superbruker1.token)
            .statuskode() shouldBe 501
        sak = sak.fullførSak()
        sak.status shouldBe IASak.Status.FULLFØRT

        val sak2Respons =
            opprettSakForVirksomhetRespons(orgnummer = orgnummer, token = authContainerHelper.superbruker1.token)
        sak2Respons.statuskode() shouldBe 201
        val sak2 = sak2Respons.third.get()

        hentSak(orgnummer = orgnummer, saksnummer = sak.saksnummer).status shouldBe IASak.Status.FULLFØRT
        hentSak(orgnummer = orgnummer, saksnummer = sak2.saksnummer).status shouldBe IASak.Status.VURDERES
    }

    @Test
    fun `tilgangskontroll - bare superbruker skal kunne sette virksomheter til VURDERES`() {
        val orgnr = nyttOrgnummer()
        opprettSakForVirksomhetRespons(
            orgnummer = orgnr,
            token = authContainerHelper.lesebruker.token,
        ).statuskode() shouldBe 403
        opprettSakForVirksomhetRespons(
            orgnummer = orgnr,
            token = authContainerHelper.saksbehandler1.token,
        ).statuskode() shouldBe 403
        opprettSakForVirksomhetRespons(
            orgnummer = orgnr,
            token = authContainerHelper.superbruker1.token,
        ).statuskode() shouldBe 201
    }

    @Test
    fun `tilgangskontroll - en sak skal ikke kunne oppdateres av brukere med lesetilgang`() {
        val orgnummer = nyttOrgnummer()
        opprettSakForVirksomhet(orgnummer = orgnummer, token = authContainerHelper.superbruker1.token).also {
            nyHendelsePåSakMedRespons(
                sak = it,
                hendelsestype = TA_EIERSKAP_I_SAK,
                token = authContainerHelper.lesebrukerAudit.token,
            ).statuskode() shouldBe 403

            nyHendelsePåSakMedRespons(
                sak = it,
                hendelsestype = TA_EIERSKAP_I_SAK,
                token = authContainerHelper.saksbehandler1.token,
            ).statuskode() shouldBe 201
        }
    }

    @Test
    fun `tilgangskontroll - en sak skal ikke kunne oppdateres av andre enn de som eier den`() {
        val orgnummer = nyttOrgnummer()
        opprettSakForVirksomhet(orgnummer = orgnummer, token = authContainerHelper.superbruker1.token).also { sak ->
            nyHendelsePåSak(
                sak = sak,
                hendelsestype = TA_EIERSKAP_I_SAK,
                token = authContainerHelper.saksbehandler1.token,
            ).also { sakEtterTattEierskap ->
                nyHendelsePåSakMedRespons(
                    sak = sakEtterTattEierskap,
                    hendelsestype = VIRKSOMHET_SKAL_KONTAKTES,
                    token = authContainerHelper.saksbehandler2.token,
                )
                    .statuskode() shouldBe 422
                nyHendelsePåSakMedRespons(
                    sak = sakEtterTattEierskap,
                    hendelsestype = VIRKSOMHET_SKAL_KONTAKTES,
                    token = authContainerHelper.saksbehandler1.token,
                )
                    .statuskode() shouldBe 201
            }
        }
    }

    @Test
    fun `tilgangskontroll - alle brukere skal kunne se saker UTEN eier`() {
        val orgnummer = nyttOrgnummer()
        opprettSakForVirksomhet(orgnummer = orgnummer, token = authContainerHelper.superbruker1.token).also { sak ->
            hentSakRespons(orgnummer = orgnummer, saksnummer = sak.saksnummer, token = authContainerHelper.lesebruker.token).statuskode() shouldBe 200
            hentSakRespons(
                orgnummer = orgnummer,
                saksnummer = sak.saksnummer,
                token = authContainerHelper.saksbehandler1.token,
            ).statuskode() shouldBe 200
            hentSakRespons(
                orgnummer = orgnummer,
                saksnummer = sak.saksnummer,
                token = authContainerHelper.superbruker1.token,
            ).statuskode() shouldBe 200
            hentSakRespons(
                orgnummer = orgnummer,
                saksnummer = sak.saksnummer,
                token = authContainerHelper.brukerUtenTilgangsrolle.token,
            ).statuskode() shouldBe 403

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
    }

    @Test
    fun `tilgangskontroll - alle brukere skal kunne se saker MED eier`() {
        val orgnummer = nyttOrgnummer()
        opprettSakForVirksomhet(orgnummer = orgnummer, token = authContainerHelper.superbruker1.token).also { sak ->
            nyHendelsePåSak(sak, TA_EIERSKAP_I_SAK, token = authContainerHelper.saksbehandler1.token).also { sakMedEier ->
                hentSakRespons(
                    orgnummer = orgnummer,
                    saksnummer = sakMedEier.saksnummer,
                    token = authContainerHelper.lesebruker.token,
                ).statuskode() shouldBe 200
                hentSakRespons(
                    orgnummer = orgnummer,
                    saksnummer = sakMedEier.saksnummer,
                    token = authContainerHelper.saksbehandler1.token,
                ).statuskode() shouldBe 200
                hentSakRespons(
                    orgnummer = orgnummer,
                    saksnummer = sakMedEier.saksnummer,
                    token = authContainerHelper.superbruker1.token,
                ).statuskode() shouldBe 200
                hentSakRespons(
                    orgnummer = orgnummer,
                    saksnummer = sakMedEier.saksnummer,
                    token = authContainerHelper.brukerUtenTilgangsrolle.token,
                ).statuskode() shouldBe 403

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
        }
    }

    @Test
    fun `tilgangskontroll - man skal kunne se en sak man selv eier`() {
        nyttOrgnummer().also { orgnummer ->
            opprettSakForVirksomhet(orgnummer, token = authContainerHelper.superbruker2.token)
                .nyHendelse(TA_EIERSKAP_I_SAK, token = authContainerHelper.saksbehandler1.token).also { sakMedEier ->
                    hentSakRespons(
                        orgnummer = orgnummer,
                        saksnummer = sakMedEier.saksnummer,
                        token = authContainerHelper.saksbehandler1.token,
                    ).statuskode() shouldBe 200
                    hentSamarbeidshistorikkForOrgnrRespons(
                        orgnr = orgnummer,
                        token = authContainerHelper.saksbehandler1.token,
                    ).statuskode() shouldBe 200
                }
        }

        nyttOrgnummer().also { orgnummer ->
            opprettSakForVirksomhet(orgnummer, token = authContainerHelper.superbruker2.token)
                .nyHendelse(TA_EIERSKAP_I_SAK, token = authContainerHelper.superbruker1.token).also { sakMedEier ->
                    hentSakRespons(
                        orgnummer = orgnummer,
                        saksnummer = sakMedEier.saksnummer,
                        token = authContainerHelper.superbruker1.token,
                    ).statuskode() shouldBe 200
                    hentSamarbeidshistorikkForOrgnrRespons(
                        orgnr = orgnummer,
                        token = authContainerHelper.superbruker1.token,
                    ).statuskode() shouldBe 200
                }
        }
    }

    @Test
    fun `skal kunne spore endringene som har skjedd på en sak`() {
        val orgnummer = nyttOrgnummer()
        val sak = opprettSakForVirksomhet(orgnummer = orgnummer)

        val aktivSak = hentSak(orgnummer)
        aktivSak.orgnr shouldBe orgnummer
        aktivSak.status shouldBe IASak.Status.VURDERES
        aktivSak.opprettetAv shouldBe authContainerHelper.superbruker1.navIdent
        aktivSak.saksnummer shouldBe sak.saksnummer

        nyHendelsePåSak(sak, TA_EIERSKAP_I_SAK, token = authContainerHelper.saksbehandler1.token).also {
            it.orgnr shouldBe orgnummer
            it.saksnummer shouldBe sak.saksnummer
            it.status shouldBe IASak.Status.VURDERES
            it.opprettetAv shouldBe sak.opprettetAv
            it.eidAv shouldBe authContainerHelper.saksbehandler1.navIdent
            it.endretAvHendelseId shouldNotBe sak.endretAvHendelseId
        }
    }

    @Test
    fun `skal kunne hente en oppsummering av alle hendelsene som har skjedd på en sak`() {
        val orgnummer = nyttOrgnummer()
        val superbruker = authContainerHelper.superbruker1
        opprettSakForVirksomhet(orgnummer = orgnummer, token = superbruker.token).also { sak ->
            val valgtÅrsak = ValgtÅrsak(
                type = VIRKSOMHETEN_TAKKET_NEI,
                begrunnelser = listOf(VIRKSOMHETEN_ØNSKER_IKKE_SAMARBEID, VIRKSOMHETEN_HAR_IKKE_RESPONDERT),
            )
            val sakIkkeAktuell = sak
                .nyHendelse(TA_EIERSKAP_I_SAK)
                .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
                .nyHendelse(
                    hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL,
                    payload = valgtÅrsak.toJson(),
                )
            val alleHendelsesTyper = listOf(
                OPPRETT_SAK_FOR_VIRKSOMHET,
                VIRKSOMHET_VURDERES,
                TA_EIERSKAP_I_SAK,
                VIRKSOMHET_SKAL_KONTAKTES,
                VIRKSOMHET_ER_IKKE_AKTUELL,
            )
            hentSamarbeidshistorikk(orgnummer = orgnummer, token = authContainerHelper.superbruker1.token).also { sakshistorikkForVirksomhet ->
                val historikkForSak = sakshistorikkForVirksomhet.find { it.saksnummer == sakIkkeAktuell.saksnummer }
                historikkForSak shouldNotBe null
                historikkForSak!!.sakshendelser.map { it.hendelsestype } shouldContainExactly alleHendelsesTyper
                historikkForSak.sakshendelser.forAtLeastOne {
                    it.hendelsestype shouldBe OPPRETT_SAK_FOR_VIRKSOMHET
                    it.tidspunktForSnapshot shouldBe sakIkkeAktuell.opprettetTidspunkt
                    it.hendelseOpprettetAv shouldBe superbruker.navIdent
                }
            }
        }
    }

    @Test
    fun `skal få samarbeidshistorikken til en virksomhet`() {
        val valgtÅrsak = ValgtÅrsak(
            type = NAV_IGANGSETTER_IKKE_TILTAK,
            begrunnelser = listOf(FOR_FÅ_TAPTE_DAGSVERK, IKKE_DIALOG_MELLOM_PARTENE),
        )
        val orgnummer = nyttOrgnummer()
        val sak = opprettSakForVirksomhet(orgnummer = orgnummer)
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(
                hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL,
                payload = valgtÅrsak.toJson(),
            )

        hentSamarbeidshistorikk(orgnummer = orgnummer).also { samarbeidshistorikk ->
            samarbeidshistorikk shouldHaveSize 1
            val sakshistorikk = samarbeidshistorikk.first()
            sakshistorikk.sakshendelser.map { it.status } shouldContainExactly listOf(
                IASak.Status.NY,
                IASak.Status.VURDERES,
                IASak.Status.VURDERES,
                IASak.Status.KONTAKTES,
                IASak.Status.IKKE_AKTUELL,
            )
            sakshistorikk.sakshendelser.map { it.hendelsestype } shouldContainExactly listOf(
                OPPRETT_SAK_FOR_VIRKSOMHET,
                VIRKSOMHET_VURDERES,
                TA_EIERSKAP_I_SAK,
                VIRKSOMHET_SKAL_KONTAKTES,
                VIRKSOMHET_ER_IKKE_AKTUELL,
            )
            sakshistorikk.sakshendelser.forExactlyOne { sakSnapshot ->
                sakSnapshot.begrunnelser shouldBe valgtÅrsak.begrunnelser.map { it.navn }
            }
            sakshistorikk.sistEndret shouldBe sak.endretTidspunkt
        }
    }

    @Test
    fun `skal kunne ta eierskap i en sak`() {
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer()).also { sak ->
            sak.eidAv shouldBe null

            val sakEtterTattEierskap = sak.nyHendelse(hendelsestype = TA_EIERSKAP_I_SAK)
            sakEtterTattEierskap.eidAv shouldBe authContainerHelper.saksbehandler1.navIdent

            sakEtterTattEierskap.nyHendelse(
                hendelsestype = TA_EIERSKAP_I_SAK,
                token = authContainerHelper.saksbehandler2.token,
            ).also {
                it.eidAv shouldBe authContainerHelper.saksbehandler2.navIdent
            }
        }
    }

    @Test
    fun `skal få gyldige neste hendelser i retur - avhengig av hvem man er`() {
        val orgnummer = nyttOrgnummer()
        opprettSakForVirksomhet(orgnummer = orgnummer, token = authContainerHelper.superbruker1.token).also { sak ->
            hentSak(
                sak.orgnr,
                token = authContainerHelper.superbruker1.token,
            ).also { aktivSak ->
                aktivSak.gyldigeNesteHendelser.map { it.saksHendelsestype }
                    .shouldContainExactlyInAnyOrder(TA_EIERSKAP_I_SAK, SLETT_SAK)
            }

            hentSak(
                sak.orgnr,
                token = authContainerHelper.saksbehandler1.token,
            ).also { aktivSak ->
                aktivSak.gyldigeNesteHendelser.forAll {
                    it.saksHendelsestype shouldBe TA_EIERSKAP_I_SAK
                }
            }

            hentSak(orgnummer, token = authContainerHelper.lesebruker.token).also { aktivSak ->
                aktivSak.gyldigeNesteHendelser.shouldBeEmpty()
            }
        }
    }

    @Test
    fun `skal få liste med mulige årsaker og begrunnelser sammen med virksomhet ikke aktuell-hendelsen`() {
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK).also { sakEtterTattEierskap ->
                sakEtterTattEierskap.gyldigeNesteHendelser
                    .shouldForAtLeastOne { hendelse ->
                        hendelse.saksHendelsestype shouldBe VIRKSOMHET_ER_IKKE_AKTUELL
                        hendelse.gyldigeÅrsaker.shouldForAtLeastOne { årsak ->
                            årsak.type shouldBe NAV_IGANGSETTER_IKKE_TILTAK
                            årsak.navn shouldBe NAV_IGANGSETTER_IKKE_TILTAK.navn
                            årsak.begrunnelser.somBegrunnelseType().shouldContainExactly(
                                IKKE_DIALOG_MELLOM_PARTENE,
                                FOR_FÅ_TAPTE_DAGSVERK,
                                SAKEN_ER_FEILREGISTRERT,
                            )
                        }
                        hendelse.gyldigeÅrsaker.shouldForAtLeastOne { årsak ->
                            årsak.type shouldBe VIRKSOMHETEN_TAKKET_NEI
                            årsak.navn shouldBe VIRKSOMHETEN_TAKKET_NEI.navn
                            årsak.begrunnelser.somBegrunnelseType().shouldContainExactly(
                                VIRKSOMHETEN_ØNSKER_IKKE_SAMARBEID,
                                VIRKSOMHETEN_HAR_IKKE_RESPONDERT,
                            )
                        }
                    }.shouldForAtLeastOne { hendelse ->
                        hendelse.saksHendelsestype shouldBe VIRKSOMHET_SKAL_KONTAKTES
                        hendelse.gyldigeÅrsaker.shouldBeEmpty()
                    }
            }
    }

    @Test
    fun `skal kunne se valgte begrunnelser i samarbeidshistorikken for når en virksomhet ikke er aktuell`() {
        val begrunnelser = listOf(VIRKSOMHETEN_ØNSKER_IKKE_SAMARBEID)
        val orgnummer = nyttOrgnummer()
        opprettSakForVirksomhet(orgnummer = orgnummer).also { sak ->
            val sakIkkeAktuell = sak
                .nyHendelse(TA_EIERSKAP_I_SAK)
                .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
                .nyHendelse(
                    hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL,
                    payload = ValgtÅrsak(
                        type = VIRKSOMHETEN_TAKKET_NEI,
                        begrunnelser = begrunnelser,
                    ).toJson(),
                )
            hentSamarbeidshistorikk(orgnummer, authContainerHelper.superbruker1.token).first().sakshendelser
                .forAtLeastOne { hendelseOppsummering ->
                    hendelseOppsummering.hendelsestype shouldBe VIRKSOMHET_ER_IKKE_AKTUELL
                    hendelseOppsummering.tidspunktForSnapshot shouldBe sakIkkeAktuell.endretTidspunkt
                    hendelseOppsummering.begrunnelser shouldContainAll begrunnelser.map { it.navn }
                }
        }
    }

    @Test
    fun `skal ikke kunne legge til hendelser på en sak som er oppdatert av en annen hendelse`() {
        // TODO Testrydding: kva tester denne testen? At ein ikkje kan setje ting til ikke-aktuell to gonger på rad?
        // TODO Testrydding: Testane over og under denne handlar om begrunnelsar for ikke-aktuell, kanskje denne kan få bu ein annan stad?
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer()).also { sak ->
            val gammelSakshendelse = IASakshendelseDto(
                orgnummer = sak.orgnr,
                saksnummer = sak.saksnummer,
                hendelsesType = VIRKSOMHET_ER_IKKE_AKTUELL,
                endretAvHendelseId = "ugyldig ID",
            )
            shouldFail {
                nyHendelse(gammelSakshendelse)
            }
        }
    }

    @Test
    fun `for å sette en sak til ikke aktuell må man ha en begrunnelse`() {
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelseRespons(
                hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL,
                payload = ValgtÅrsak(
                    type = VIRKSOMHETEN_TAKKET_NEI,
                    begrunnelser = emptyList(),
                ).toJson(),
            ).statuskode() shouldBe HttpStatusCode.UnprocessableEntity.value
    }

    @Test
    fun `en sak skal bare godta gyldige begrunnelser`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
        shouldFail {
            sak.nyHendelse(
                hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL,
                payload =
                    """
                    {"type":"VIRKSOMHETEN_TAKKET_NEI","begrunnelser":["IKKE_ET_FAKTISK_TILTAK"]}
                    """.trimIndent(),
            )
        }
    }

    @Test
    fun `saksbehandler som eier sak skal kunne gå tilbake i prosessflyten`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(TILBAKE)
        sak.status shouldBe IASak.Status.VURDERES
    }

    @Test
    fun `tilgangskontroll - saksbehandler som ikke eier sak skal ikke kunne gå tilbake i prosessflyten`() {
        val saksbehandler1 = authContainerHelper.saksbehandler1.token
        val saksbehandler2 = authContainerHelper.saksbehandler2.token
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(hendelsestype = TA_EIERSKAP_I_SAK, token = saksbehandler1)
            .nyHendelse(hendelsestype = VIRKSOMHET_SKAL_KONTAKTES, token = saksbehandler1)
        shouldFail {
            sak.nyHendelse(hendelsestype = TILBAKE, token = saksbehandler2)
        }
    }

    @Test
    fun `skal ikke kunne gå tilbake i prosessflyten dersom man er i vurderes status`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
        shouldFail {
            sak.nyHendelse(TILBAKE)
        }
    }

    @Test
    fun `skal kunne gå tilbake til vurderes fra ikke aktuell`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(
                hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL,
                payload = ValgtÅrsak(
                    type = VIRKSOMHETEN_TAKKET_NEI,
                    begrunnelser = listOf(VIRKSOMHETEN_ØNSKER_IKKE_SAMARBEID),
                ).toJson(),
            )
            .nyHendelse(TILBAKE)
        sak.status shouldBe IASak.Status.VURDERES
    }

    @Test
    fun `skal IKKE kunne gå tilbake til vi bistår fra fullført etter fristen har gått`() {
        // TODO Testrydding: Kanskje presisere "saken er lukket" i staden for "fristen har gått"?  (+ capslock her på IKKE, i motsetning til resten av testane)
        val sak = nySakIViBistår().fullførSak()
            .oppdaterHendelsesTidspunkter(antallDagerTilbake = ANTALL_DAGER_FØR_SAK_LÅSES + 1)

        shouldFail {
            sak.nyHendelse(TILBAKE)
        }

        hentSakRespons(orgnummer = sak.orgnr).statuskode() shouldBe HttpStatusCode.NoContent.value
    }

    @Test
    fun `skal IKKE kunne gå tilbake til forrige tilstand fra ikke aktuell etter fristen har gått`() {
        // TODO Testrydding: Kanskje presisere "saken er lukket" i staden for "fristen har gått"? (+ capslock her på IKKE, i motsetning til resten av testane)
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyIkkeAktuellHendelse()
            .oppdaterHendelsesTidspunkter(antallDagerTilbake = ANTALL_DAGER_FØR_SAK_LÅSES + 1)

        shouldFail {
            sak.nyHendelse(TILBAKE)
        }

        hentSakRespons(orgnummer = sak.orgnr).statuskode() shouldBe HttpStatusCode.NoContent.value
    }

    @Test
    fun `skal ikke få OPPRETT_SAK_FOR_VIRKSOMHET som gyldig neste hendelse`() {
        // TODO Testrydding: Trur denne testen kom frå då vi fjerna OPPRETT_SAK frå nesteHendelser-lista til verksemder utan opne sakar.
        // treng vi denne no, og i såfall: kan vi skildre litt meir i tittelen /når/ dette gjeld og kvifor vi har den?
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyIkkeAktuellHendelse()
        sak.gyldigeNesteHendelser.map { it.saksHendelsestype } shouldBe listOf(TILBAKE)

        hentSak(sak.orgnr, token = authContainerHelper.superbruker1.token)
            .also { sakDto ->
                sakDto.gyldigeNesteHendelser.map { it.saksHendelsestype } shouldBe listOf(TA_EIERSKAP_I_SAK)
            }

        sak.oppdaterHendelsesTidspunkter(
            antallDagerTilbake = ANTALL_DAGER_FØR_SAK_LÅSES + 1,
            token = authContainerHelper.superbruker1.token,
        ).also { sakDto ->
            sakDto.gyldigeNesteHendelser.map { it.saksHendelsestype } shouldBe emptyList()
        }
    }

    @Test
    fun `skal kunne gå tilbake til vi bistår fra fullført`() {
        val sak = nySakIViBistår().fullførSak()
            .nyHendelse(TILBAKE)
        sak.status shouldBe IASak.Status.VI_BISTÅR
    }

    @Test
    fun `skal kunne overta sak som står som fullført og deretter tilbake til vi bistår`() {
        val sak = nySakIViBistår().fullførSak()
        val sakEtterOvertakelse = sak.nyHendelse(hendelsestype = TA_EIERSKAP_I_SAK, token = authContainerHelper.saksbehandler2.token)

        sakEtterOvertakelse.status shouldBe IASak.Status.FULLFØRT
        sakEtterOvertakelse.eidAv shouldBe authContainerHelper.saksbehandler2.navIdent

        val sakEtterTilbake = sakEtterOvertakelse.nyHendelse(hendelsestype = TILBAKE, token = authContainerHelper.saksbehandler2.token)

        sakEtterTilbake.status shouldBe IASak.Status.VI_BISTÅR
        sakEtterTilbake.eidAv shouldBe authContainerHelper.saksbehandler2.navIdent
    }

    @Test
    fun `skal ikke kunne gå tilbake fra fullført status dersom virksomheten har en annen åpen sak`() {
        val virksomhet = lastInnNyVirksomhet()
        val fullførtSak = nySakIViBistår(orgnummer = virksomhet.orgnr).fullførSak()

        // Dette skal kunne skje etter 10 dager på frontend (men sjekkes ikke backend)
        opprettSakForVirksomhet(orgnummer = virksomhet.orgnr)
        shouldFail {
            fullførtSak.nyHendelse(TILBAKE)
        }
    }

    @Test
    fun `skal kunne sette en sak i 'Vi bistår'`() {
        opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .also { sak -> shouldFail { sak.nyHendelse(VIRKSOMHET_SKAL_BISTÅS) } }
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .also { sak -> sak.status shouldBe IASak.Status.KARTLEGGES }
            .nyHendelse(VIRKSOMHET_SKAL_BISTÅS)
            .also { sak -> sak.status shouldBe IASak.Status.VI_BISTÅR }
    }

    @Test
    fun `skal kunne fullføre en sak selvom ingen leveranse er levert`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .nyHendelse(VIRKSOMHET_SKAL_BISTÅS)
            .nyHendelse(FULLFØR_BISTAND)
        sak.status shouldBe IASak.Status.FULLFØRT
    }

    @Test
    fun `skal kunne fullføre en sak fra 'Vi Bistår' status`() {
        nySakIViBistår().also {
            it.status shouldBe IASak.Status.VI_BISTÅR
        }
            .fullførSak()
            .also { sak -> sak.status shouldBe IASak.Status.FULLFØRT }
    }

    @Test
    fun `skal ikke kunne sette en sak til ikke aktuell fra 'Vi bistår' uten å avslutte alle samarbeid`() {
        val orgnummer = nyttOrgnummer()
        val begrunnelser = listOf(VIRKSOMHETEN_ØNSKER_IKKE_SAMARBEID)

        val sakIStatusViBistår = nySakIViBistår(orgnummer)
            .also { sak -> sak.status shouldBe IASak.Status.VI_BISTÅR }

        // Sjekk at 'Ikke aktuell' er en gyldig neste hendelse
        sakIStatusViBistår.gyldigeNesteHendelser.map { it.saksHendelsestype } shouldContain VIRKSOMHET_ER_IKKE_AKTUELL

        shouldFail {
            sakIStatusViBistår.nyHendelse(
                hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL,
                payload = ValgtÅrsak(
                    type = VIRKSOMHETEN_TAKKET_NEI,
                    begrunnelser = begrunnelser,
                ).toJson(),
            )
        }

        // -- Lukk aktivt samarbeid
        val samarbeid = sakIStatusViBistår.hentAlleSamarbeid().first()
        val sakEtterAvslutning = sakIStatusViBistår.avbrytSamarbeid(samarbeid)

        // Trykk på 'Ikke aktuell', med begrunnelse
        val sakIkkeAktuell = sakEtterAvslutning.nyHendelse(
            hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL,
            payload = ValgtÅrsak(
                type = VIRKSOMHETEN_TAKKET_NEI,
                begrunnelser = begrunnelser,
            ).toJson(),
        ).also { sak -> sak.status shouldBe IASak.Status.IKKE_AKTUELL }

        // Sjekk at begrunnelsen blir lagret
        hentSamarbeidshistorikk(orgnummer, authContainerHelper.superbruker1.token).first().sakshendelser
            .forAtLeastOne { hendelseOppsummering ->
                hendelseOppsummering.hendelsestype shouldBe VIRKSOMHET_ER_IKKE_AKTUELL
                hendelseOppsummering.tidspunktForSnapshot shouldBe sakIkkeAktuell.endretTidspunkt
                hendelseOppsummering.begrunnelser shouldContainAll begrunnelser.map { it.navn }
            }
    }

    @Test
    fun `skal kunne sette en sak til ikke aktuell fra 'Kartlegges'`() {
        val orgnummer = nyttOrgnummer()
        val begrunnelser = listOf(VIRKSOMHETEN_ØNSKER_IKKE_SAMARBEID)

        val sakIStatusKartlegges = opprettSakForVirksomhet(orgnummer = orgnummer)
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .also { sak -> sak.status shouldBe IASak.Status.KARTLEGGES }

        // Sjekk at 'Ikke aktuell' er en gyldig neste hendelse
        sakIStatusKartlegges.gyldigeNesteHendelser.map { it.saksHendelsestype } shouldContain VIRKSOMHET_ER_IKKE_AKTUELL

        // Trykk på 'Ikke aktuell', med begrunnelse
        val sakIkkeAktuell = sakIStatusKartlegges.nyHendelse(
            hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL,
            payload = ValgtÅrsak(
                type = VIRKSOMHETEN_TAKKET_NEI,
                begrunnelser = begrunnelser,
            ).toJson(),
        ).also { sak -> sak.status shouldBe IASak.Status.IKKE_AKTUELL }

        // Sjekk at begrunnelsen blir lagret
        hentSamarbeidshistorikk(orgnummer, authContainerHelper.superbruker1.token).first().sakshendelser
            .forAtLeastOne { hendelseOppsummering ->
                hendelseOppsummering.hendelsestype shouldBe VIRKSOMHET_ER_IKKE_AKTUELL
                hendelseOppsummering.tidspunktForSnapshot shouldBe sakIkkeAktuell.endretTidspunkt
                hendelseOppsummering.begrunnelser shouldContainAll begrunnelser.map { it.navn }
            }
    }

    @Test
    fun `skal vise bare èn riktig status gjennom livsløpet til en ny sak`() {
        // TODO Testrydding: Kva meines med "èn riktig status gjennom livsløpet til en ny sak"?
        val superbruker = authContainerHelper.superbruker1.token
        val saksbehandler = authContainerHelper.saksbehandler1.token

        hentSykefravær(
            token = superbruker,
            success = { mainResponse ->
                val org = mainResponse.data.filter { it.status == IASak.Status.IKKE_AKTIV }.random()
                val sak = nySakIViBistår(orgnummer = org.orgnr, token = saksbehandler).fullførSak(token = saksbehandler)
                hentSykefravær( // Tester at vi får se FULLFØRT intil fristen går ut
                    token = superbruker,
                    success = { response ->
                        response.data.filter { it.orgnr == org.orgnr }.forExactlyOne { it.status shouldBe IASak.Status.FULLFØRT }
                    },
                )

                sak.oppdaterHendelsesTidspunkter(ANTALL_DAGER_FØR_SAK_LÅSES + 1)
                hentSykefravær( // Tester at vi faller tilbake til IKKE_AKTIV når fristen har gått ut
                    token = superbruker,
                    success = { response ->
                        response.data.filter { it.orgnr == org.orgnr }.forExactlyOne { it.status shouldBe IASak.Status.IKKE_AKTIV }
                    },
                )

                opprettSakForVirksomhet(orgnummer = org.orgnr)
                    .nyHendelse(TA_EIERSKAP_I_SAK)
                    .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
                    .nyHendelse(VIRKSOMHET_KARTLEGGES)

                hentSykefravær( // Viser siste status når vi har fått en ny sak
                    token = superbruker,
                    success = { response ->
                        response.data.filter { it.orgnr == org.orgnr }.forExactlyOne { it.status shouldBe IASak.Status.KARTLEGGES }
                    },
                )
            },
        )
    }

    @Test
    fun `nye versjoner av tilstandsmaskinen skal ikke gi andre statuser for gammel eventrekke`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer())
            .nyHendelse(TA_EIERSKAP_I_SAK)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(TILBAKE)
            .nyHendelse(VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .nyHendelse(TILBAKE)
            .nyHendelse(VIRKSOMHET_KARTLEGGES)
            .nyHendelse(
                hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL,
                payload = ValgtÅrsak(
                    type = VIRKSOMHETEN_TAKKET_NEI,
                    begrunnelser = listOf(VIRKSOMHETEN_ØNSKER_IKKE_SAMARBEID),
                ).toJson(),
            )
            .nyHendelse(TILBAKE)
            .nyHendelse(VIRKSOMHET_SKAL_BISTÅS)
            .nyHendelse(TILBAKE)
            .nyHendelse(VIRKSOMHET_SKAL_BISTÅS)
            .opprettNyttSamarbeid()
            .fullførSak()

        hentSak(orgnummer = sak.orgnr).also { enSak ->
            enSak.status shouldBe IASak.Status.FULLFØRT
        }
    }

    @Test
    fun `rolle til innlogget ansatt skal bli lagret på hendelsene`() {
        val sak = opprettSakForVirksomhet(orgnummer = nyttOrgnummer(), token = authContainerHelper.superbruker1.token)
            .nyHendelse(TA_EIERSKAP_I_SAK, token = authContainerHelper.saksbehandler1.token)

        postgresContainerHelper.hentAlleRaderTilEnkelKolonne<String>(
            "select opprettet_av_rolle from ia_sak_hendelse where saksnummer = '${sak.saksnummer}' order by opprettet",
        ) shouldBe listOf(
            "SUPERBRUKER",
            "SUPERBRUKER",
            "SAKSBEHANDLER",
        )
    }
}
