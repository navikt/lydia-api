package no.nav.lydia.container.ny.flyt

import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.core.extensions.jsonBody
import ia.felles.definisjoner.bransjer.Bransje
import ia.felles.definisjoner.bransjer.BransjeId
import ia.felles.integrasjoner.jobbsender.Jobb
import io.kotest.assertions.shouldFail
import io.kotest.matchers.booleans.shouldBeTrue
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.kotest.matchers.string.shouldMatch
import io.ktor.http.HttpStatusCode
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.serialization.json.Json
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.angreVurdering
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.avsluttSamarbeid
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.avsluttVurdering
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.avsluttVurderingResponse
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.endreSamarbeidsNavn
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.hentVirksomhetTilstand
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.opprettSamarbeid
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.slettSamarbeid
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.slettSamarbeidRespons
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.verifiserIASakObserversErVarslet
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.verifiserSamarbeidObserversErVarslet
import no.nav.lydia.container.ny.flyt.NyFlytTestUtils.Companion.vurderVirksomhet
import no.nav.lydia.helper.PlanHelper
import no.nav.lydia.helper.PlanHelper.Companion.inkluderEttTemaOgEttInnhold
import no.nav.lydia.helper.PlanHelper.Companion.opprettSamarbeidsplan
import no.nav.lydia.helper.SakHelper.Companion.bliEier
import no.nav.lydia.helper.SakHelper.Companion.bliEierResponse
import no.nav.lydia.helper.SakHelper.Companion.hentSamarbeidshistorikkNyFlyt
import no.nav.lydia.helper.SakHelper.Companion.leggTilFolger
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performDelete
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.performPut
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.helper.VirksomhetHelper.Companion.lastInnNyVirksomhet
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.helper.statuskode
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.NY_FLYT_PATH
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetIATilstand
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetTilstandAutomatiskOppdateringDto
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetTilstandDto
import no.nav.lydia.ia.sak.api.ny.flyt.tilstandsmaskin.hendelse.GjørVirksomhetKlarTilNyVurdering
import no.nav.lydia.ia.sak.api.samarbeid.IASamarbeidDto
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.årsak.domene.BegrunnelseType
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.ÅrsakType
import no.nav.lydia.tilgangskontroll.fia.Rolle
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import org.junit.AfterClass
import org.junit.BeforeClass
import java.time.LocalDate
import kotlin.test.Ignore
import kotlin.test.Test

class NyFlytTest {
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
    fun `hent tilstand for virksomhet som finnes, men ikke har tilstand i tilstand_virksomhet, returnerer VirksomhetKlarTilVurdering`() {
        val næringskode = "${(Bransje.ANLEGG.bransjeId as BransjeId.Næring).næring}.120"
        val virksomhet = TestVirksomhet.nyVirksomhet(
            næringer = listOf(Næringsgruppe(kode = næringskode, navn = "Bygging av jernbaner og undergrunnsbaner")),
        )
        lastInnNyVirksomhet(virksomhet)

        val response = applikasjon.performGet("$NY_FLYT_PATH/${virksomhet.orgnr}/tilstand")
            .authentication().bearer(authContainerHelper.saksbehandler1.token)
            .tilSingelRespons<VirksomhetTilstandDto>()

        response.statuskode() shouldBe HttpStatusCode.OK.value
        val virksomhetTilstandDto = response.third.get()
        virksomhetTilstandDto.orgnr shouldBe virksomhet.orgnr
        virksomhetTilstandDto.tilstand shouldBe VirksomhetIATilstand.VirksomhetKlarTilVurdering
        virksomhetTilstandDto.nesteTilstand shouldBe null
    }

    @Test
    fun `hent tilstand for virksomhet som ikke finnes returnerer 404`() {
        val orgnrSomIkkeFinnes = "999888777"

        val response = applikasjon.performGet("$NY_FLYT_PATH/$orgnrSomIkkeFinnes/tilstand")
            .authentication().bearer(authContainerHelper.saksbehandler1.token)
            .tilSingelRespons<VirksomhetTilstandDto>()

        response.statuskode() shouldBe HttpStatusCode.NotFound.value
    }

    @Test
    fun `Batch jobb - automatisk oppdatering av virksomhet tilstand fra VirksomhetErVurdert til VirksomhetVurderes`() {
        val sak = vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES

        sak.avsluttVurdering(
            valgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_VURDERES_PÅ_ET_SENERE_TIDSPUNKT,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_ØNSKER_Å_BLI_KONTAKTET_SENERE,
                ),
                dato = LocalDate.now().plusDays(1).toKotlinLocalDate(),
            ),
        )
        val virksomhetsTilstand = hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstand.tilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        virksomhetsTilstand.nesteTilstand!!.startTilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        virksomhetsTilstand.nesteTilstand.planlagtHendelse shouldBe "VurderVirksomhet"
        virksomhetsTilstand.nesteTilstand.nyTilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes
        virksomhetsTilstand.nesteTilstand.planlagtDato shouldBe LocalDate.now().plusDays(1).toKotlinLocalDate()

        // Oppdater planlagt_dato til i dag slik at batch jobben vil prosessere hendelsen
        postgresContainerHelper.performUpdate(
            """
            UPDATE tilstand_automatisk_oppdatering 
            SET planlagt_dato = CURRENT_DATE
            WHERE orgnr = '${sak.orgnr}'
            """.trimIndent(),
        )

        // send jobbmelding
        kafkaContainerHelper.sendJobbMelding(Jobb.prosesserPlanlagteHendelser)

        // tilstand = vurderes
        val virksomhetsTilstandOppdatert = hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstandOppdatert.tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes
    }

    @Test
    fun `Batch jobb - automatisk oppdatering av virksomhet tilstand fra VirksomhetErVurdert til VirksomhetKlarTilVurdering`() {
        val sak = vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES

        sak.avsluttVurdering(
            valgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_ER_FERDIG_VURDERT_OG_TAKKET_NEI,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_FERDIG_VURDERT_TAKKET_NEI_ANNET,
                    BegrunnelseType.VIRKSOMHETEN_ØNSKER_KUN_INFORMASJON_OG_VEILEDNING,
                ),
                dato = LocalDate.now().plusDays(1).toKotlinLocalDate(),
            ),
        )
        val virksomhetsTilstand = hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstand.tilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        virksomhetsTilstand.nesteTilstand!!.startTilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        virksomhetsTilstand.nesteTilstand.planlagtHendelse shouldBe "GjørVirksomhetKlarTilNyVurdering"
        virksomhetsTilstand.nesteTilstand.nyTilstand shouldBe VirksomhetIATilstand.VirksomhetKlarTilVurdering
        virksomhetsTilstand.nesteTilstand.planlagtDato shouldBe LocalDate.now().plusDays(1).toKotlinLocalDate()

        // Oppdater planlagt_dato til i dag slik at batch jobben vil prosessere hendelsen
        postgresContainerHelper.performUpdate(
            """
            UPDATE tilstand_automatisk_oppdatering 
            SET planlagt_dato = CURRENT_DATE
            WHERE orgnr = '${sak.orgnr}'
            """.trimIndent(),
        )

        // send jobbmelding
        kafkaContainerHelper.sendJobbMelding(Jobb.prosesserPlanlagteHendelser)

        val virksomhetsTilstandOppdatert = hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstandOppdatert.tilstand shouldBe VirksomhetIATilstand.VirksomhetKlarTilVurdering
    }

    @Test
    fun `Batch jobb - automatisk oppdatering av tilstand fra AlleSamarbeidIVirksomhetErAvsluttet til VirksomhetKlarTilVurdering ved slettSamarbeid`() {
        val sak = vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeidSomSkalFullføres = sak.opprettSamarbeid()
        val samarbeidSomSkalSlettes = sak.opprettSamarbeid(samarbeidsnavn = "Slett meg!")
        samarbeidSomSkalFullføres.opprettSamarbeidsplan(orgnr = sak.orgnr, planMal = PlanHelper.hentPlanMal())
        samarbeidSomSkalFullføres.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT)

        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
        samarbeidSomSkalSlettes.slettSamarbeid(orgnr = sak.orgnr, token = authContainerHelper.superbruker1.token)

        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet

        val virksomhetsTilstand = hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstand.tilstand shouldBe VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet
        virksomhetsTilstand.nesteTilstand?.startTilstand shouldBe VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet
        virksomhetsTilstand.nesteTilstand?.planlagtHendelse shouldBe "GjørVirksomhetKlarTilNyVurdering"
        virksomhetsTilstand.nesteTilstand?.nyTilstand shouldBe VirksomhetIATilstand.VirksomhetKlarTilVurdering
        virksomhetsTilstand.nesteTilstand?.planlagtDato shouldBe LocalDate.now().plusDays(90).toKotlinLocalDate()

        // Oppdater planlagt_dato til i dag slik at batch jobben vil prosessere hendelsen
        postgresContainerHelper.performUpdate(
            """
            UPDATE tilstand_automatisk_oppdatering 
            SET planlagt_dato = CURRENT_DATE
            WHERE orgnr = '${sak.orgnr}'
            """.trimIndent(),
        )

        val oppdatertTilstand = hentVirksomhetTilstand(orgnr = sak.orgnr)
        oppdatertTilstand.nesteTilstand?.planlagtDato shouldBe LocalDate.now().toKotlinLocalDate()

        // send jobbmelding
        kafkaContainerHelper.sendJobbMelding(Jobb.prosesserPlanlagteHendelser)

        val virksomhetsTilstandOppdatert = hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstandOppdatert.tilstand shouldBe VirksomhetIATilstand.VirksomhetKlarTilVurdering
    }

    @Test
    fun `Batch jobb - automatisk oppdatering av tilstand fra AlleSamarbeidIVirksomhetErAvsluttet til VirksomhetKlarTilVurdering ved avsluttSamarbeid`() {
        val sak = vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)

        samarbeid.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT)

        val virksomhetsTilstand = hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstand.tilstand shouldBe VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet
        virksomhetsTilstand.nesteTilstand?.startTilstand shouldBe VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet
        virksomhetsTilstand.nesteTilstand?.planlagtHendelse shouldBe "GjørVirksomhetKlarTilNyVurdering"
        virksomhetsTilstand.nesteTilstand?.nyTilstand shouldBe VirksomhetIATilstand.VirksomhetKlarTilVurdering
        virksomhetsTilstand.nesteTilstand?.planlagtDato shouldBe LocalDate.now().plusDays(90).toKotlinLocalDate()

        // Oppdater planlagt_dato til i dag slik at batch jobben vil prosessere hendelsen
        postgresContainerHelper.performUpdate(
            """
            UPDATE tilstand_automatisk_oppdatering 
            SET planlagt_dato = CURRENT_DATE
            WHERE orgnr = '${sak.orgnr}'
            """.trimIndent(),
        )

        val oppdatertTilstand = hentVirksomhetTilstand(orgnr = sak.orgnr)
        oppdatertTilstand.nesteTilstand?.planlagtDato shouldBe LocalDate.now().toKotlinLocalDate()

        // send jobbmelding
        kafkaContainerHelper.sendJobbMelding(Jobb.prosesserPlanlagteHendelser)

        val virksomhetsTilstandOppdatert = hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstandOppdatert.tilstand shouldBe VirksomhetIATilstand.VirksomhetKlarTilVurdering
    }

    @Test
    fun `Batch jobb - skal IKKE prosessere hendelser med planlagt dato i fremtiden`() {
        val sak = vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES

        sak.avsluttVurdering(
            valgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_VURDERES_PÅ_ET_SENERE_TIDSPUNKT,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_ØNSKER_Å_BLI_KONTAKTET_SENERE,
                ),
                dato = LocalDate.now().plusDays(1).toKotlinLocalDate(),
            ),
        )
        val virksomhetsTilstand = hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstand.tilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        virksomhetsTilstand.nesteTilstand!!.planlagtDato shouldBe LocalDate.now().plusDays(1).toKotlinLocalDate()

        kafkaContainerHelper.sendJobbMelding(Jobb.prosesserPlanlagteHendelser)

        val virksomhetsTilstandEtterJobb = hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstandEtterJobb.tilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        virksomhetsTilstandEtterJobb.nesteTilstand shouldNotBe null
        virksomhetsTilstandEtterJobb.nesteTilstand!!.planlagtDato shouldBe LocalDate.now().plusDays(1).toKotlinLocalDate()
    }

    @Test
    fun `Batch jobb - skal prosessere hendelser med planlagt dato i fortiden`() {
        val sak = vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES

        sak.avsluttVurdering(
            valgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_VURDERES_PÅ_ET_SENERE_TIDSPUNKT,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_ØNSKER_Å_BLI_KONTAKTET_SENERE,
                ),
                dato = LocalDate.now().plusDays(1).toKotlinLocalDate(),
            ),
        )
        val virksomhetsTilstand = hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstand.tilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert

        postgresContainerHelper.performUpdate(
            """
            UPDATE tilstand_automatisk_oppdatering 
            SET planlagt_dato = CURRENT_DATE - INTERVAL '1 day'
            WHERE orgnr = '${sak.orgnr}'
            """.trimIndent(),
        )

        kafkaContainerHelper.sendJobbMelding(Jobb.prosesserPlanlagteHendelser)

        val virksomhetsTilstandEtterJobb = hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstandEtterJobb.tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes
        virksomhetsTilstandEtterJobb.nesteTilstand shouldBe null
    }

    @Test
    fun `nesteTilstand skal være null ved Hendelse vurderVirksomhet fra tilstand VirksomhetErVurdert`() {
        val sak = vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES

        sak.avsluttVurdering(
            valgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_ER_FERDIG_VURDERT_OG_TAKKET_NEI,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_FERDIG_VURDERT_TAKKET_NEI_ANNET,
                    BegrunnelseType.VIRKSOMHETEN_ER_IKKE_MOTIVERT_ELLER_HAR_IKKE_KAPASITET,
                ),
                dato = LocalDate.now().plusDays(1).toKotlinLocalDate(),
            ),
        )
        val virksomhetsTilstand = hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstand.tilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        virksomhetsTilstand.nesteTilstand!!.startTilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        virksomhetsTilstand.nesteTilstand.planlagtHendelse shouldBe "GjørVirksomhetKlarTilNyVurdering"
        virksomhetsTilstand.nesteTilstand.nyTilstand shouldBe VirksomhetIATilstand.VirksomhetKlarTilVurdering
        virksomhetsTilstand.nesteTilstand.planlagtDato shouldBe LocalDate.now().plusDays(1).toKotlinLocalDate()

        val nySak = applikasjon.performPost("$NY_FLYT_PATH/${sak.orgnr}/vurder")
            .authentication().bearer(authContainerHelper.superbruker1.token)
            .tilSingelRespons<IASakDto>().third.get()

        nySak.orgnr shouldBe sak.orgnr

        val oppdatertTilstand = hentVirksomhetTilstand(orgnr = nySak.orgnr)
        oppdatertTilstand.tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes
        oppdatertTilstand.nesteTilstand shouldBe null
    }

    @Test
    fun `nesteTilstand skal være null ved Hendelse vurderVirksomhet fra tilstand AlleSamarbeidIVirksomhetErAvsluttet`() {
        val sak = vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)

        samarbeid.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT)

        val virksomhetsTilstand = hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstand.tilstand shouldBe VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet
        virksomhetsTilstand.nesteTilstand?.startTilstand shouldBe VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet
        virksomhetsTilstand.nesteTilstand?.planlagtHendelse shouldBe "GjørVirksomhetKlarTilNyVurdering"
        virksomhetsTilstand.nesteTilstand?.nyTilstand shouldBe VirksomhetIATilstand.VirksomhetKlarTilVurdering
        virksomhetsTilstand.nesteTilstand?.planlagtDato shouldBe LocalDate.now().plusDays(90).toKotlinLocalDate()

        val nySak = applikasjon.performPost("$NY_FLYT_PATH/${sak.orgnr}/vurder")
            .authentication().bearer(authContainerHelper.superbruker1.token)
            .tilSingelRespons<IASakDto>().third.get()

        nySak.orgnr shouldBe sak.orgnr

        val oppdatertTilstand = hentVirksomhetTilstand(orgnr = nySak.orgnr)
        oppdatertTilstand.tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes
        oppdatertTilstand.nesteTilstand shouldBe null
    }

    @Test
    fun `Hendelse EndrePlanlagtDatoForNesteTilstand fra Tilstand AlleSamarbeidIVirksomhetErAvsluttet skal gi en nyPlanlagtDato`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)
        samarbeid.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT)

        val tilstandFørEndring = hentVirksomhetTilstand(orgnr = sak.orgnr)
        tilstandFørEndring.tilstand shouldBe VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet
        tilstandFørEndring.nesteTilstand shouldNotBe null
        tilstandFørEndring.nesteTilstand!!.planlagtDato shouldBe LocalDate.now().plusDays(90).toKotlinLocalDate()

        val nyPlanlagtDato = LocalDate.now().plusDays(30).toKotlinLocalDate()
        val response = endrePlanlagtDato(
            orgnr = sak.orgnr,
            nesteTilstand = tilstandFørEndring.nesteTilstand,
            nyPlanlagtDato = nyPlanlagtDato,
        )

        response.statuskode() shouldBe HttpStatusCode.OK.value
        val oppdatertAutomatiskOppdatering = response.third.get()
        oppdatertAutomatiskOppdatering.planlagtDato shouldBe nyPlanlagtDato
        oppdatertAutomatiskOppdatering.startTilstand shouldBe VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet
        oppdatertAutomatiskOppdatering.nyTilstand shouldBe VirksomhetIATilstand.VirksomhetKlarTilVurdering

        val tilstandEtterEndring = hentVirksomhetTilstand(orgnr = sak.orgnr)
        tilstandEtterEndring.tilstand shouldBe VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet
        tilstandEtterEndring.nesteTilstand!!.planlagtDato shouldBe nyPlanlagtDato
    }

    @Test
    fun `Hendelse EndrePlanlagtDatoForNesteTilstand fra Tilstand VirksomhetErVurdert skal gi en nyPlanlagtDato`() {
        val sak = vurderVirksomhet()

        sak.avsluttVurdering(
            valgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_ER_FERDIG_VURDERT_OG_TAKKET_NEI,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_FERDIG_VURDERT_TAKKET_NEI_ANNET,
                ),
                dato = LocalDate.now().plusDays(90).toKotlinLocalDate(),
            ),
        )

        val tilstandFørEndring = hentVirksomhetTilstand(orgnr = sak.orgnr)
        tilstandFørEndring.tilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        tilstandFørEndring.nesteTilstand shouldNotBe null
        tilstandFørEndring.nesteTilstand!!.planlagtDato shouldBe LocalDate.now().plusDays(90).toKotlinLocalDate()
        tilstandFørEndring.nesteTilstand.planlagtHendelse shouldBe GjørVirksomhetKlarTilNyVurdering::class.simpleName
        tilstandFørEndring.nesteTilstand.startTilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        tilstandFørEndring.nesteTilstand.nyTilstand shouldBe VirksomhetIATilstand.VirksomhetKlarTilVurdering

        val nyPlanlagtDato = LocalDate.now().plusDays(14).toKotlinLocalDate()
        val response = endrePlanlagtDato(
            orgnr = sak.orgnr,
            nesteTilstand = tilstandFørEndring.nesteTilstand,
            nyPlanlagtDato = nyPlanlagtDato,
        )

        response.statuskode() shouldBe HttpStatusCode.OK.value
        val automatiskOppdatering = response.third.get()
        automatiskOppdatering.planlagtDato shouldBe nyPlanlagtDato
        automatiskOppdatering.planlagtHendelse shouldBe GjørVirksomhetKlarTilNyVurdering::class.simpleName
        automatiskOppdatering.startTilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        automatiskOppdatering.nyTilstand shouldBe VirksomhetIATilstand.VirksomhetKlarTilVurdering

        val tilstandEtterEndring = hentVirksomhetTilstand(orgnr = sak.orgnr)
        tilstandEtterEndring.tilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        tilstandEtterEndring.nesteTilstand!!.planlagtDato shouldBe nyPlanlagtDato
        tilstandEtterEndring.nesteTilstand.planlagtHendelse shouldBe GjørVirksomhetKlarTilNyVurdering::class.simpleName
        tilstandEtterEndring.nesteTilstand.startTilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        tilstandEtterEndring.nesteTilstand.nyTilstand shouldBe VirksomhetIATilstand.VirksomhetKlarTilVurdering
    }

    @Test
    fun `Hendelse EndrePlanlagtDatoForNesteTilstand to ganger på rad skal fungere`() {
        val sak = vurderVirksomhet()

        sak.avsluttVurdering(
            valgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_ER_FERDIG_VURDERT_MED_INTERN_VURDERING,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_HAR_IKKE_SVART_PÅ_HENVENDELSER,
                ),
                dato = LocalDate.now().plusDays(90).toKotlinLocalDate(),
            ),
        )

        val tilstand = hentVirksomhetTilstand(orgnr = sak.orgnr)
        tilstand.tilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        tilstand.nesteTilstand shouldNotBe null

        val førsteDato = LocalDate.now().plusDays(14).toKotlinLocalDate()
        val førsteResponse = endrePlanlagtDato(
            orgnr = sak.orgnr,
            nesteTilstand = tilstand.nesteTilstand!!,
            nyPlanlagtDato = førsteDato,
        )
        førsteResponse.statuskode() shouldBe HttpStatusCode.OK.value

        val tilstandEtterFørste = hentVirksomhetTilstand(orgnr = sak.orgnr)
        tilstandEtterFørste.nesteTilstand shouldNotBe null

        val andreDato = LocalDate.now().plusDays(30).toKotlinLocalDate()
        val andreResponse = endrePlanlagtDato(
            orgnr = sak.orgnr,
            nesteTilstand = tilstandEtterFørste.nesteTilstand!!,
            nyPlanlagtDato = andreDato,
        )
        andreResponse.statuskode() shouldBe HttpStatusCode.OK.value
        andreResponse.third.get().planlagtDato shouldBe andreDato

        val historikk = hentSamarbeidshistorikkNyFlyt(orgnummer = sak.orgnr)
        val hendelser = historikk.flatMap { it.sakshendelser }
        hendelser.filter { it.hendelsestype == IASakshendelseType.ENDRE_PLANLAGT_DATO } shouldHaveSize 2
    }

    @Test
    fun `Hendelse EndrePlanlagtDatoForNesteTilstand skal ikke fungere dersom nyPlanlagtDato settes til i dag`() {
        val sak = vurderVirksomhet()

        sak.avsluttVurdering(
            valgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_ER_FERDIG_VURDERT_OG_TAKKET_NEI,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_FERDIG_VURDERT_TAKKET_NEI_ANNET,
                ),
                dato = LocalDate.now().plusDays(90).toKotlinLocalDate(),
            ),
        )

        val tilstandFørEndring = hentVirksomhetTilstand(orgnr = sak.orgnr)
        tilstandFørEndring.tilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        tilstandFørEndring.nesteTilstand shouldNotBe null
        tilstandFørEndring.nesteTilstand!!.planlagtDato shouldBe LocalDate.now().plusDays(90).toKotlinLocalDate()

        val nyPlanlagtDato = LocalDate.now().toKotlinLocalDate()
        val response = endrePlanlagtDato(
            orgnr = sak.orgnr,
            nesteTilstand = tilstandFørEndring.nesteTilstand,
            nyPlanlagtDato = nyPlanlagtDato,
        )

        response.statuskode() shouldBe HttpStatusCode.BadRequest.value

        val tilstandEtterEndring = hentVirksomhetTilstand(orgnr = sak.orgnr)
        tilstandEtterEndring.tilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        tilstandEtterEndring.nesteTilstand!!.planlagtDato shouldBe LocalDate.now().plusDays(90).toKotlinLocalDate()
    }

    @Test
    fun `EndrePlanlagtDato fra VirksomhetErVurdert lagrer IASakshendelse med type ENDRE_PLANLAGT_DATO og status VURDERT`() {
        val sak = vurderVirksomhet()

        sak.avsluttVurdering(
            valgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_ER_FERDIG_VURDERT_OG_TAKKET_NEI,
                begrunnelser = listOf(BegrunnelseType.VIRKSOMHETEN_FERDIG_VURDERT_TAKKET_NEI_ANNET),
                dato = LocalDate.now().plusDays(90).toKotlinLocalDate(),
            ),
        )

        val tilstand = hentVirksomhetTilstand(orgnr = sak.orgnr)
        tilstand.tilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert

        val nyPlanlagtDato = LocalDate.now().plusDays(30).toKotlinLocalDate()
        val response = endrePlanlagtDato(
            orgnr = sak.orgnr,
            nesteTilstand = tilstand.nesteTilstand!!,
            nyPlanlagtDato = nyPlanlagtDato,
        )
        response.statuskode() shouldBe HttpStatusCode.OK.value

        val historikk = hentSamarbeidshistorikkNyFlyt(orgnummer = sak.orgnr)
        val sisteHendelse = historikk.flatMap { it.sakshendelser }.last()
        sisteHendelse.hendelsestype shouldBe IASakshendelseType.ENDRE_PLANLAGT_DATO
        sisteHendelse.status shouldBe IASak.Status.VURDERT
    }

    @Test
    fun `EndrePlanlagtDato fra AlleSamarbeidIVirksomhetErAvsluttet lagrer IASakshendelse med type ENDRE_PLANLAGT_DATO og status AVSLUTTET`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)
        samarbeid.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT)

        val tilstand = hentVirksomhetTilstand(orgnr = sak.orgnr)
        tilstand.tilstand shouldBe VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet

        val nyPlanlagtDato = LocalDate.now().plusDays(30).toKotlinLocalDate()
        val response = endrePlanlagtDato(
            orgnr = sak.orgnr,
            nesteTilstand = tilstand.nesteTilstand!!,
            nyPlanlagtDato = nyPlanlagtDato,
        )
        response.statuskode() shouldBe HttpStatusCode.OK.value

        val historikk = hentSamarbeidshistorikkNyFlyt(orgnummer = sak.orgnr)
        val sisteHendelse = historikk.flatMap { it.sakshendelser }.last()
        sisteHendelse.hendelsestype shouldBe IASakshendelseType.ENDRE_PLANLAGT_DATO
        sisteHendelse.status shouldBe IASak.Status.AVSLUTTET
    }

    @Test
    fun `Hendelse EndreSamarbeidsNavn fra Tilstand VirksomhetHarAktiveSamarbeid skal gi et nytt samarbeidsNavn og lagre IASakshendelseType ENDRE_PROSESS`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid(samarbeidsnavn = "Opprinnelig navn")

        val tilstandFørEndring = hentVirksomhetTilstand(orgnr = sak.orgnr)
        tilstandFørEndring.tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        val nyttNavn = "Nytt navn 123"
        samarbeid.endreSamarbeidsNavn(
            orgnr = sak.orgnr,
            nyttNavn = nyttNavn,
            token = authContainerHelper.superbruker1.token,
        ).navn shouldBe nyttNavn

        val tilstandEtterEndring = hentVirksomhetTilstand(orgnr = sak.orgnr)
        tilstandEtterEndring.tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        val historikk = hentSamarbeidshistorikkNyFlyt(orgnummer = sak.orgnr)
        val sisteHendelse = historikk.flatMap { it.sakshendelser }.last()
        sisteHendelse.hendelsestype shouldBe IASakshendelseType.ENDRE_PROSESS
        sisteHendelse.status shouldBe IASak.Status.AKTIV
    }

    @Test
    fun `vurder virksomhet returnerer 201 - CREATED`() {
        val virksomhet = lastInnNyVirksomhet()
        val orgnummer = virksomhet.orgnr
        val res = applikasjon.performPost("$NY_FLYT_PATH/$orgnummer/vurder")
            .authentication().bearer(authContainerHelper.superbruker1.token)
            .tilSingelRespons<IASakDto>()

        res.second.statusCode shouldBe HttpStatusCode.Created.value
    }

    @Test
    fun `skal kunne vurdere samarbeid med en virksomhet`() {
        val sak = vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES

        verifiserIASakObserversErVarslet(
            iASakDto = sak,
            forventedeIASakStatuser = listOf(IASak.Status.VURDERES),
            forventetIASakStatusIStatistikk = IASak.Status.VURDERES,
            rolle = Rolle.SUPERBRUKER,
        )
    }

    @Test
    fun `skal ikke kunne vurdere samarbeid med en virksomhet uten å være superbruker`() {
        val orgnummer = VirksomhetHelper.nyttOrgnummer()
        val res1 = applikasjon.performPost("$NY_FLYT_PATH/$orgnummer/vurder")
            .authentication().bearer(authContainerHelper.lesebruker.token)
            .tilSingelRespons<IASakDto>()
        res1.second.statusCode shouldBe HttpStatusCode.Forbidden.value

        val res2 = applikasjon.performPost("$NY_FLYT_PATH/$orgnummer/vurder")
            .authentication().bearer(authContainerHelper.saksbehandler1.token)
            .tilSingelRespons<IASakDto>()
        res2.second.statusCode shouldBe HttpStatusCode.Forbidden.value
    }

    @Test
    fun `skal kunne angre vurdering av samarbeid med en virksomhet`() {
        val sak = vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES

        sak.angreVurdering()

        val sakenErSlettet = postgresContainerHelper.hentEnkelKolonne<Boolean>(
            """
            SELECT count(*) = 0
                 FROM IA_SAK 
                 WHERE orgnr = '${sak.orgnr}'
            """.trimIndent(),
        )
        sakenErSlettet.shouldBeTrue()

        // Sjekk avhengigheter er varslet
        verifiserIASakObserversErVarslet(
            iASakDto = sak,
            forventedeIASakStatuser = listOf(IASak.Status.VURDERES, IASak.Status.SLETTET),
            forventetIASakStatusIStatistikk = IASak.Status.SLETTET,
            rolle = Rolle.SUPERBRUKER,
        )
    }

    @Test
    fun `skal kunne angre vurdering med en virksomhet som har en følger`() {
        val eierAvSak = authContainerHelper.superbruker1
        val følgerAvSak = authContainerHelper.saksbehandler2
        val sak = vurderVirksomhet(
            token = eierAvSak.token,
        )
        sak.status shouldBe IASak.Status.VURDERES

        sak.leggTilFolger(token = følgerAvSak.token)

        val harFølgereFør = postgresContainerHelper.hentEnkelKolonne<Boolean>(
            """
            SELECT count(*) > 0
                 FROM ia_sak_team
                 WHERE saksnummer = '${sak.saksnummer}'
            """.trimIndent(),
        )
        harFølgereFør.shouldBeTrue()

        sak.angreVurdering(token = eierAvSak.token)

        val sakenErSlettet = postgresContainerHelper.hentEnkelKolonne<Boolean>(
            """
            SELECT count(*) = 0
                 FROM ia_sak
                 WHERE orgnr = '${sak.orgnr}'
            """.trimIndent(),
        )
        sakenErSlettet.shouldBeTrue()
    }

    @Test
    fun `skal kunne angre vurdering med en virksomhet som har flere følgere`() {
        val eierAvSak = authContainerHelper.superbruker1
        val sak = vurderVirksomhet(
            token = eierAvSak.token,
        )
        sak.status shouldBe IASak.Status.VURDERES

        sak.leggTilFolger(token = authContainerHelper.saksbehandler1.token)
        sak.leggTilFolger(token = authContainerHelper.saksbehandler2.token)

        sak.angreVurdering(token = eierAvSak.token)

        val virksomhetsTilstand = hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstand.tilstand shouldBe VirksomhetIATilstand.VirksomhetKlarTilVurdering
    }

    // TODO: Implementer logikk for angre vurdering slik at denne testen blir grønn
    @Ignore
    fun `skal kunne angre vurdering etter å ha opprettet og slettet et samarbeid`() {
        val eierAvSak = authContainerHelper.superbruker1
        val sak = vurderVirksomhet(
            token = eierAvSak.token,
        )
        sak.status shouldBe IASak.Status.VURDERES

        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)

        val samarbeid = sak.opprettSamarbeid(token = eierAvSak.token)
        samarbeid.slettSamarbeid(orgnr = sak.orgnr, token = eierAvSak.token)

        sak.angreVurdering(token = eierAvSak.token)

        val virksomhetsTilstand = hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstand.tilstand shouldBe VirksomhetIATilstand.VirksomhetKlarTilVurdering
    }

    @Test
    fun `skal kunne avslutte vurdering som ikke medfører et samarbeid`() {
        val sak = vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES

        val oppdatertSakDto = sak.avsluttVurdering(
            valgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_ER_FERDIG_VURDERT_OG_TAKKET_NEI,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_FERDIG_VURDERT_TAKKET_NEI_ANNET,
                    BegrunnelseType.VIRKSOMHETEN_SAMARBEIDER_MED_ANDRE_ELLER_GJØR_EGNE_TILTAK,
                ),
                dato = LocalDate.now().plusDays(20).toKotlinLocalDate(),
            ),
        )
        oppdatertSakDto.status shouldBe IASak.Status.VURDERT

        verifiserIASakObserversErVarslet(
            iASakDto = oppdatertSakDto,
            forventedeIASakStatuser = listOf(IASak.Status.VURDERES, IASak.Status.VURDERT),
            forventetIASakStatusIStatistikk = IASak.Status.VURDERT,
            rolle = Rolle.SUPERBRUKER,
            hendelseType = IASakshendelseType.VURDERING_FULLFØRT_UTEN_SAMARBEID,
            begrunnelser = listOf(
                BegrunnelseType.VIRKSOMHETEN_FERDIG_VURDERT_TAKKET_NEI_ANNET,
                BegrunnelseType.VIRKSOMHETEN_SAMARBEIDER_MED_ANDRE_ELLER_GJØR_EGNE_TILTAK,
            ),
        )
    }

    @Test
    fun `avslutt vurdering med gyldig årsak gir tilstand VirksomhetErVurdert og nesteTilstand VirksomhetKlarTilVurdering`() {
        val sak = vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES

        sak.avsluttVurdering(
            valgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_ER_FERDIG_VURDERT_OG_TAKKET_NEI,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_FERDIG_VURDERT_TAKKET_NEI_ANNET,
                    BegrunnelseType.VIRKSOMHETEN_ER_IKKE_MOTIVERT_ELLER_HAR_IKKE_KAPASITET,
                ),
                dato = LocalDate.now().plusDays(20).toKotlinLocalDate(),
            ),
        )

        val virksomhetsTilstand = hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstand.tilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        virksomhetsTilstand.nesteTilstand!!.startTilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        virksomhetsTilstand.nesteTilstand.planlagtHendelse shouldBe "GjørVirksomhetKlarTilNyVurdering"
        virksomhetsTilstand.nesteTilstand.nyTilstand shouldBe VirksomhetIATilstand.VirksomhetKlarTilVurdering
        virksomhetsTilstand.nesteTilstand.planlagtDato shouldBe LocalDate.now().plusDays(20).toKotlinLocalDate()
    }

    @Test
    fun `avslutt vurdering med årsak 'skal vurderes senere' gir tilstand VirksomhetErVurdert og nesteTilstand VirksomhetVurderes`() {
        val sak = vurderVirksomhet()
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

        val virksomhetsTilstand = hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstand.tilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        virksomhetsTilstand.nesteTilstand!!.startTilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        virksomhetsTilstand.nesteTilstand.planlagtHendelse shouldBe "VurderVirksomhet"
        virksomhetsTilstand.nesteTilstand.nyTilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes
        virksomhetsTilstand.nesteTilstand.planlagtDato shouldBe LocalDate.now().plusDays(20).toKotlinLocalDate()
    }

    @Test
    fun `skal kunne vurdere en virksomhet som allerede er vurdert`() {
        val sak = vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES

        val avsluttVurderingRes = sak.avsluttVurderingResponse(
            valgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_VURDERES_PÅ_ET_SENERE_TIDSPUNKT,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_ØNSKER_Å_BLI_KONTAKTET_SENERE,
                ),
                dato = LocalDate.now().plusDays(20).toKotlinLocalDate(),
            ),
        )

        avsluttVurderingRes.second.statusCode shouldBe HttpStatusCode.OK.value
        avsluttVurderingRes.third.get().status shouldBe IASak.Status.VURDERT

        val revurderRes = applikasjon.performPost("$NY_FLYT_PATH/${sak.orgnr}/vurder")
            .authentication().bearer(authContainerHelper.superbruker1.token)
            .tilSingelRespons<IASakDto>()
        revurderRes.second.statusCode shouldBe HttpStatusCode.Created.value
        revurderRes.third.get().status shouldBe IASak.Status.VURDERES

        revurderRes.third.get().saksnummer shouldNotBe sak.saksnummer
    }

    @Test
    fun `skal kunne opprette et samarbeid`() {
        val eierAvSak = authContainerHelper.superbruker1
        val følgerAvSak = authContainerHelper.saksbehandler2
        val sak = vurderVirksomhet(
            token = eierAvSak.token,
        )
        sak.status shouldBe IASak.Status.VURDERES

        val oppdatertSak = sak.leggTilFolger(token = følgerAvSak.token)
        val samarbeidsnavn = "Samarbeid med avdeling A"
        val samarbeidRespons = applikasjon.performPost("$NY_FLYT_PATH/${sak.orgnr}/opprett-samarbeid")
            .authentication().bearer(følgerAvSak.token)
            .jsonBody(
                Json.encodeToString(
                    IASamarbeidDto(
                        id = 0,
                        saksnummer = oppdatertSak.saksnummer,
                        navn = samarbeidsnavn,
                    ),
                ),
            ).tilSingelRespons<IASamarbeidDto>()

        samarbeidRespons.second.statusCode shouldBe HttpStatusCode.Created.value
        val samarbeid = samarbeidRespons.third.get()
        samarbeid.saksnummer shouldBe sak.saksnummer
        samarbeid.status shouldBe IASamarbeid.Status.AKTIV

        hentVirksomhetTilstand(sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        verifiserSamarbeidObserversErVarslet(
            iASakDto = sak,
            iaSamarbeidDto = samarbeid,
            samarbeidsnavn = samarbeidsnavn,
            forventetSamarbeidStatus = IASamarbeid.Status.AKTIV,
        )
    }

    @Test
    fun `både eier og følger av sak skal kunne opprette samarbeid`() {
        val eierAvSak = authContainerHelper.superbruker1
        val følgerAvSak = authContainerHelper.saksbehandler2
        val sak = vurderVirksomhet(token = authContainerHelper.superbruker1.token)

        sak.leggTilFolger(følgerAvSak.token)
        sak.bliEier(eierAvSak.token)

        listOf(eierAvSak, følgerAvSak).forEach { bruker ->
            val samarbeid = sak.opprettSamarbeid(
                samarbeidsnavn = "Samarbeid ${bruker.navIdent}",
                token = bruker.token,
            )
            samarbeid.navn shouldBe "Samarbeid ${bruker.navIdent}"
        }

        hentVirksomhetTilstand(sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
    }

    @Test
    fun `skal ikke kunne slette et samarbeid med plan`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        samarbeid.opprettSamarbeidsplan(
            orgnr = sak.orgnr,
            planMal = PlanHelper.hentPlanMal().inkluderEttTemaOgEttInnhold(temanummer = 3, innholdnummer = 1),
        )

        shouldFail {
            samarbeid.slettSamarbeid(orgnr = sak.orgnr, token = authContainerHelper.superbruker1.token)
        }.message shouldMatch ("HTTP Exception 400 Bad Request")

        hentVirksomhetTilstand(sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
    }

    @Test
    fun `status er fortsatt AKTIV dersom det gjenstår en eller flere samarbeid etter slett samarbeid`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr, planMal = PlanHelper.hentPlanMal())
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        val etNyttSamarbeid = sak.opprettSamarbeid(samarbeidsnavn = "Helt nytt")

        etNyttSamarbeid.slettSamarbeid(orgnr = sak.orgnr, token = authContainerHelper.superbruker1.token)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
        sak.hentAlleSamarbeid() shouldHaveSize 1
    }

    @Test
    fun `sletting av eneste samarbeid i virksomhet som er i tilstand VirksomhetHarAktiveSamarbeid fører til VirksomhetVurderes`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
        samarbeid.slettSamarbeid(orgnr = sak.orgnr, token = authContainerHelper.superbruker1.token)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes
        sak.hentAlleSamarbeid() shouldHaveSize 0
    }

    @Test
    fun `sletting av siste samarbeid i en virksomhet med fullførte samarbeid fører til AlleSamarbeidIVirksomhetErAvsluttet`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeidSomSkalFullføres = sak.opprettSamarbeid()
        val samarbeidSomSkalSlettes = sak.opprettSamarbeid(samarbeidsnavn = "Slett meg!")
        samarbeidSomSkalFullføres.opprettSamarbeidsplan(orgnr = sak.orgnr, planMal = PlanHelper.hentPlanMal())
        samarbeidSomSkalFullføres.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT)

        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
        samarbeidSomSkalSlettes.slettSamarbeid(orgnr = sak.orgnr, token = authContainerHelper.superbruker1.token)

        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet
        sak.hentAlleSamarbeid() shouldHaveSize 1
    }

    @Test
    fun `ved avslutning(FULLFØR) av siste samarbeid i tilstand VirksomhetHarAktiveSamarbeid skal virksomheten gå til status AVSLUTTET`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes

        val samarbeid = sak.opprettSamarbeid()
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)

        samarbeid.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet

        sak.hentAlleSamarbeid().first { it.id == samarbeid.id }.status shouldBe IASamarbeid.Status.FULLFØRT
    }

    @Test
    fun `ved avslutning(AVBRYT) av siste samarbeid i tilstand VirksomhetHarAktiveSamarbeid skal virksomheten gå til status AVSLUTTET`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes

        val samarbeid = sak.opprettSamarbeid()
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)

        samarbeid.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.AVBRUTT)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet

        sak.hentAlleSamarbeid().first { it.id == samarbeid.id }.status shouldBe IASamarbeid.Status.AVBRUTT
    }

    @Test
    fun `avslutning(AVBRYT) av samarbeid i tilstand VirksomhetHarAktiveSamarbeid med flere samarbeid skal ikke endre tilstand`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes

        val samarbeidSomSkalAvbrytes = sak.opprettSamarbeid()
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
        samarbeidSomSkalAvbrytes.opprettSamarbeidsplan(orgnr = sak.orgnr)
        val aktivtSamarbeid = sak.opprettSamarbeid(samarbeidsnavn = "Nytt samarbeid")

        samarbeidSomSkalAvbrytes.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.AVBRUTT)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        sak.hentAlleSamarbeid().first { it.id == samarbeidSomSkalAvbrytes.id }.status shouldBe IASamarbeid.Status.AVBRUTT
        sak.hentAlleSamarbeid().first { it.id == aktivtSamarbeid.id }.status shouldBe IASamarbeid.Status.AKTIV
    }

    @Test
    fun `avslutning(FULLFØR) av samarbeid i tilstand VirksomhetHarAktiveSamarbeid med flere samarbeid skal ikke endre tilstand`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes

        val samarbeidSomSkalFullføres = sak.opprettSamarbeid()
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
        samarbeidSomSkalFullføres.opprettSamarbeidsplan(orgnr = sak.orgnr)

        val aktivtSamarbeid = sak.opprettSamarbeid(samarbeidsnavn = "Nytt samarbeid")
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        samarbeidSomSkalFullføres.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT)

        sak.hentAlleSamarbeid().first { it.id == samarbeidSomSkalFullføres.id }.status shouldBe IASamarbeid.Status.FULLFØRT
        sak.hentAlleSamarbeid().first { it.id == aktivtSamarbeid.id }.status shouldBe IASamarbeid.Status.AKTIV
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
    }

    @Test
    fun `avslutning av alle samarbeid i tilstand VirksomhetHarAktiveSamarbeid skal føre til status AVSLUTTET`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes

        val samarbeidSomSkalFullføres = sak.opprettSamarbeid()
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
        samarbeidSomSkalFullføres.opprettSamarbeidsplan(orgnr = sak.orgnr)

        val samarbeidSomSkalAvbrytes = sak.opprettSamarbeid(samarbeidsnavn = "Nytt samarbeid")
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        samarbeidSomSkalFullføres.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT)
        samarbeidSomSkalAvbrytes.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.AVBRUTT)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet

        sak.hentAlleSamarbeid().first { it.id == samarbeidSomSkalAvbrytes.id }.status shouldBe IASamarbeid.Status.AVBRUTT
        sak.hentAlleSamarbeid().first { it.id == samarbeidSomSkalFullføres.id }.status shouldBe IASamarbeid.Status.FULLFØRT
    }

    @Test
    fun `avsluttSamarbeid med dato setter planlagtDato til angitt dato`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)
        val planlagtDato = LocalDate.now().plusDays(30)

        samarbeid.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT, dato = planlagtDato)
        val virksomhetsTilstand = hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstand.tilstand shouldBe VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet
        virksomhetsTilstand.nesteTilstand!!.planlagtHendelse shouldBe GjørVirksomhetKlarTilNyVurdering::class.simpleName
        virksomhetsTilstand.nesteTilstand.nyTilstand shouldBe VirksomhetIATilstand.VirksomhetKlarTilVurdering
        virksomhetsTilstand.nesteTilstand.planlagtDato shouldBe planlagtDato.toKotlinLocalDate()
    }

    @Test
    fun `avsluttSamarbeid uten dato bruker default 90 dager`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)

        samarbeid.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT)
        val virksomhetsTilstand = hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstand.tilstand shouldBe VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet
        virksomhetsTilstand.nesteTilstand!!.planlagtDato shouldBe LocalDate.now().plusDays(90).toKotlinLocalDate()
    }

    @Test
    fun `slettSamarbeid med dato setter planlagtDato til angitt dato`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeidSomSkalFullføres = sak.opprettSamarbeid()
        val samarbeidSomSkalSlettes = sak.opprettSamarbeid(samarbeidsnavn = "Slett meg!")
        samarbeidSomSkalFullføres.opprettSamarbeidsplan(orgnr = sak.orgnr, planMal = PlanHelper.hentPlanMal())
        samarbeidSomSkalFullføres.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT)
        val planlagtDato = LocalDate.now().plusDays(45)

        samarbeidSomSkalSlettes.slettSamarbeid(
            orgnr = sak.orgnr,
            token = authContainerHelper.superbruker1.token,
            dato = planlagtDato,
        )

        val virksomhetsTilstand = hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstand.tilstand shouldBe VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet
        virksomhetsTilstand.nesteTilstand!!.planlagtDato shouldBe planlagtDato.toKotlinLocalDate()
    }

    @Test
    fun `avsluttSamarbeid med dato i fortiden gir BadRequest`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)

        val response = applikasjon.performPost(
            "$NY_FLYT_PATH/${sak.orgnr}/${samarbeid.id}/avslutt-samarbeid?dato=${LocalDate.now()}",
        )
            .authentication().bearer(authContainerHelper.saksbehandler1.token)
            .jsonBody(
                Json.encodeToString(
                    no.nav.lydia.ia.eksport.SamarbeidDto(
                        id = samarbeid.id,
                        status = IASamarbeid.Status.FULLFØRT,
                    ),
                ),
            )
            .tilSingelRespons<IASamarbeidDto>()
        response.second.statusCode shouldBe HttpStatusCode.BadRequest.value
    }

    @Test
    fun `slettSamarbeid med dato i fortiden gir BadRequest`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeidSomSkalFullføres = sak.opprettSamarbeid()
        val samarbeidSomSkalSlettes = sak.opprettSamarbeid(samarbeidsnavn = "Slett meg!")
        samarbeidSomSkalFullføres.opprettSamarbeidsplan(orgnr = sak.orgnr, planMal = PlanHelper.hentPlanMal())
        samarbeidSomSkalFullføres.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT)

        val response = samarbeidSomSkalSlettes.slettSamarbeidRespons(
            orgnr = sak.orgnr,
            token = authContainerHelper.superbruker1.token,
            dato = LocalDate.now(),
        )
        response.second.statusCode shouldBe HttpStatusCode.BadRequest.value
    }

    @Test
    fun `slettSamarbeid med ugyldig datoformat gir BadRequest`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeidSomSkalFullføres = sak.opprettSamarbeid()
        val samarbeidSomSkalSlettes = sak.opprettSamarbeid(samarbeidsnavn = "Slett meg!")
        samarbeidSomSkalFullføres.opprettSamarbeidsplan(orgnr = sak.orgnr, planMal = PlanHelper.hentPlanMal())
        samarbeidSomSkalFullføres.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT)

        val response = applikasjon.performDelete("$NY_FLYT_PATH/${sak.orgnr}/${samarbeidSomSkalSlettes.id}/slett-samarbeid?dato=tulletekst")
            .authentication().bearer(authContainerHelper.superbruker1.token)
            .tilSingelRespons<IASamarbeidDto>()
        response.second.statusCode shouldBe HttpStatusCode.BadRequest.value
    }

    @Test
    fun `avsluttSamarbeid med ugyldig datoformat gir BadRequest`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)

        val response = applikasjon.performPost("$NY_FLYT_PATH/${sak.orgnr}/${samarbeid.id}/avslutt-samarbeid?dato=tulletekst")
            .authentication().bearer(authContainerHelper.saksbehandler1.token)
            .jsonBody(
                Json.encodeToString(
                    no.nav.lydia.ia.eksport.SamarbeidDto(
                        id = samarbeid.id,
                        status = IASamarbeid.Status.FULLFØRT,
                    ),
                ),
            )
            .tilSingelRespons<IASamarbeidDto>()
        response.second.statusCode shouldBe HttpStatusCode.BadRequest.value
    }

    @Test
    fun `automatisk oppdatering slettes når virksomhet revurderes fra AlleSamarbeidIVirksomhetErAvsluttet`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)
        samarbeid.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT)

        val tilstandFørRevurdering = hentVirksomhetTilstand(orgnr = sak.orgnr)
        tilstandFørRevurdering.tilstand shouldBe VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet
        tilstandFørRevurdering.nesteTilstand shouldNotBe null
        tilstandFørRevurdering.nesteTilstand?.planlagtHendelse shouldBe "GjørVirksomhetKlarTilNyVurdering"

        val revurderRes = applikasjon.performPost("$NY_FLYT_PATH/${sak.orgnr}/vurder")
            .authentication().bearer(authContainerHelper.superbruker1.token)
            .tilSingelRespons<IASakDto>()
        revurderRes.second.statusCode shouldBe HttpStatusCode.Created.value

        val tilstandEtterRevurdering = hentVirksomhetTilstand(orgnr = sak.orgnr)
        tilstandEtterRevurdering.tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes
        tilstandEtterRevurdering.nesteTilstand shouldBe null
    }

    @Test
    fun `skal kunne revurdere en virksomhet som er i tilstand AlleSamarbeidIVirksomhetErAvsluttet`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.saksbehandler1.token)
        val samarbeid = sak.opprettSamarbeid()
        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr)
        samarbeid.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT)

        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet

        val revurderRes = applikasjon.performPost("$NY_FLYT_PATH/${sak.orgnr}/vurder")
            .authentication().bearer(authContainerHelper.superbruker1.token)
            .tilSingelRespons<IASakDto>()
        revurderRes.second.statusCode shouldBe HttpStatusCode.Created.value
        revurderRes.third.get().status shouldBe IASak.Status.VURDERES

        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes

        revurderRes.third.get().saksnummer shouldNotBe sak.saksnummer
    }

    @Test
    fun `skal kunne ta eierskap i en sak`() {
        val superBruker = authContainerHelper.superbruker1
        val saksbehandler = authContainerHelper.saksbehandler1

        val sak = vurderVirksomhet(token = superBruker.token)
        sak.eidAv shouldBe null

        sak.bliEier(token = saksbehandler.token).eidAv shouldBe saksbehandler.navIdent
    }

    @Test
    fun `skal få feilmelding dersom man tar eierskap i en virksomhet som ikke har en aktiv sak`() {
        val superbruker = authContainerHelper.superbruker1
        val virksomhetUtenSak = VirksomhetHelper.nyttOrgnummer()

        val responseUtenSak = bliEier(orgnr = virksomhetUtenSak, token = superbruker.token)
        responseUtenSak.statuskode() shouldBe HttpStatusCode.BadRequest.value

        val virksomhetMedAvsluttetSak = vurderVirksomhet().avsluttVurdering().orgnr
        val responseMedAvsluttetSak = bliEier(orgnr = virksomhetMedAvsluttetSak, superbruker.token)
        responseMedAvsluttetSak.statuskode() shouldBe HttpStatusCode.BadRequest.value
    }

    @Test
    fun `lesebrukere skal ikke kunne bli eiere`() {
        val lesebruker = authContainerHelper.lesebruker
        val sak = vurderVirksomhet()

        val responseLesebruker = sak.bliEierResponse(token = lesebruker.token)
        responseLesebruker.statuskode() shouldBe HttpStatusCode.Forbidden.value
    }

    private fun bliEier(
        orgnr: String,
        token: String,
    ) = applikasjon.performPost("$NY_FLYT_PATH/$orgnr/bli-eier")
        .authentication().bearer(token = token)
        .tilSingelRespons<IASakDto>()

    private fun endrePlanlagtDato(
        orgnr: String,
        nesteTilstand: VirksomhetTilstandAutomatiskOppdateringDto,
        nyPlanlagtDato: kotlinx.datetime.LocalDate,
        token: String = authContainerHelper.saksbehandler1.token,
    ) = applikasjon.performPut("$NY_FLYT_PATH/virksomhet/$orgnr/endre-planlagt-dato")
        .authentication().bearer(token)
        .jsonBody(
            Json.encodeToString(
                VirksomhetTilstandAutomatiskOppdateringDto(
                    startTilstand = nesteTilstand.startTilstand,
                    planlagtHendelse = nesteTilstand.planlagtHendelse,
                    nyTilstand = nesteTilstand.nyTilstand,
                    planlagtDato = nyPlanlagtDato,
                ),
            ),
        ).tilSingelRespons<VirksomhetTilstandAutomatiskOppdateringDto>()
}
