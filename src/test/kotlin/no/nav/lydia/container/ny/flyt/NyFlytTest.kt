package no.nav.lydia.container.ny.flyt

import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.core.extensions.jsonBody
import ia.felles.definisjoner.bransjer.Bransje
import ia.felles.definisjoner.bransjer.BransjeId
import io.kotest.inspectors.forAll
import io.kotest.matchers.booleans.shouldBeTrue
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldContain
import io.ktor.http.HttpStatusCode
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.container.ia.eksport.IASakStatistikkEksportererTest.Companion.hentFraKvartal
import no.nav.lydia.container.ia.eksport.IASakStatistikkEksportererTest.Companion.hentFraSiste4Kvartaler
import no.nav.lydia.helper.PlanHelper
import no.nav.lydia.helper.PlanHelper.Companion.inkluderAlt
import no.nav.lydia.helper.SakHelper.Companion.leggTilFolger
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performDelete
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.TestVirksomhet
import no.nav.lydia.helper.VirksomhetHelper
import no.nav.lydia.helper.VirksomhetHelper.Companion.lastInnNyVirksomhet
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.eksport.IASakStatistikkProdusent
import no.nav.lydia.ia.eksport.SamarbeidBigqueryProdusent.SamarbeidValue
import no.nav.lydia.ia.eksport.SamarbeidProdusent.SamarbeidKafkaMeldingValue
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.NY_FLYT_PATH
import no.nav.lydia.ia.sak.api.plan.PlanMedPubliseringStatusDto
import no.nav.lydia.ia.sak.api.samarbeid.IASamarbeidDto
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.årsak.domene.BegrunnelseType.VIRKSOMHETEN_ØNSKER_IKKE_SAMARBEID
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.ÅrsakType.VIRKSOMHETEN_TAKKET_NEI
import no.nav.lydia.tilgangskontroll.fia.Rolle
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test
import kotlin.test.fail

class NyFlytTest {
    companion object {
        private val iaSakTopic = Topic.IA_SAK_TOPIC
        private val iaSakStatistikkTopic = Topic.IA_SAK_STATISTIKK_TOPIC
        private val samarbeidsplanTopic = Topic.SAMARBEIDSPLAN_TOPIC
        private val samarbeidBigqueryTopic = Topic.SAMARBEID_BIGQUERY_TOPIC
        private val iaSakKonsument = kafkaContainerHelper.nyKonsument(topic = iaSakTopic)
        private val iaSakStatistikkKonsument = kafkaContainerHelper.nyKonsument(topic = iaSakStatistikkTopic)
        private val samarbeidsplanKonsument = kafkaContainerHelper.nyKonsument(topic = samarbeidsplanTopic)
        private val samarbeidBigqueryKonsument = kafkaContainerHelper.nyKonsument(topic = samarbeidBigqueryTopic)

        @BeforeClass
        @JvmStatic
        fun setUp() {
            iaSakKonsument.subscribe(mutableListOf(iaSakTopic.navn))
            iaSakStatistikkKonsument.subscribe(mutableListOf(iaSakStatistikkTopic.navn))
            samarbeidsplanKonsument.subscribe(mutableListOf(samarbeidsplanTopic.navn))
            samarbeidBigqueryKonsument.subscribe(mutableListOf(samarbeidBigqueryTopic.navn))
        }

        @AfterClass
        @JvmStatic
        fun tearDown() {
            iaSakKonsument.unsubscribe()
            iaSakKonsument.close()

            iaSakStatistikkKonsument.unsubscribe()
            iaSakStatistikkKonsument.close()

            samarbeidsplanKonsument.unsubscribe()
            samarbeidsplanKonsument.close()

            samarbeidBigqueryKonsument.unsubscribe()
            samarbeidBigqueryKonsument.close()
        }
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
        val sak = vurderVirksomhet(næringskode = "${(Bransje.ANLEGG.bransjeId as BransjeId.Næring).næring}.120")
        sak.status shouldBe IASak.Status.VURDERES

        // Sjekk avhengigheter er varslet
        runBlocking {
            // Sak observer - IASakProdusent
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(key = sak.saksnummer, konsument = iaSakKonsument) { meldinger ->
                meldinger.forAll { hendelse ->
                    hendelse shouldContain sak.saksnummer
                    hendelse shouldContain sak.orgnr
                }
                meldinger shouldHaveSize 2
                meldinger[0] shouldContain IASak.Status.NY.name
                meldinger[1] shouldContain IASak.Status.VURDERES.name
            }
            // IASakStatistikkProdusent
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = iaSakStatistikkKonsument,
            ) { meldinger ->
                val objektene = meldinger.map {
                    Json.decodeFromString<IASakStatistikkProdusent.IASakStatistikkValue>(it)
                }
                objektene shouldHaveSize 2
                objektene.forExactlyOne {
                    it.orgnr shouldBe sak.orgnr
                    it.saksnummer shouldBe sak.saksnummer
                    it.eierAvSak shouldBe null
                    it.status shouldBe IASak.Status.VURDERES
                    it.antallPersoner shouldBe hentFraKvartal(it, "antall_personer")
                    it.sykefraversprosent shouldBe hentFraKvartal(it, "sykefravarsprosent")
                    it.sykefraversprosentSiste4Kvartal shouldBe hentFraSiste4Kvartaler(it, "prosent")
                    it.bransjeprogram shouldBe Bransje.ANLEGG
                    it.endretAvRolle shouldBe Rolle.SUPERBRUKER
                    it.enhetsnummer shouldBe "2900"
                    it.enhetsnavn shouldBe "IT-avdelingen" // -- Bør ha fallback til minst spesifikk avdeling
                }
            }
        }
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

        val angreVurderRes = applikasjon.performPost("$NY_FLYT_PATH/${sak.orgnr}/angre-vurdering")
            .authentication().bearer(authContainerHelper.superbruker1.token)
            .tilSingelRespons<IASakDto>()
        angreVurderRes.second.statusCode shouldBe HttpStatusCode.OK.value

        val sakenErSlettet = postgresContainerHelper.hentEnkelKolonne<Boolean>(
            """
            SELECT count(*) = 0
                 FROM IA_SAK 
                 WHERE orgnr = '${sak.orgnr}'
            """.trimIndent(),
        )
        sakenErSlettet.shouldBeTrue()

        // Sjekk avhengigheter er varslet
        runBlocking {
            // Sak observer - IASakProdusent
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(key = sak.saksnummer, konsument = iaSakKonsument) { meldinger ->
                meldinger.forAll { hendelse ->
                    hendelse shouldContain sak.saksnummer
                    hendelse shouldContain sak.orgnr
                }
                meldinger shouldHaveSize 3
                meldinger[0] shouldContain IASak.Status.NY.name
                meldinger[1] shouldContain IASak.Status.VURDERES.name
                meldinger[2] shouldContain IASak.Status.SLETTET.name
            }
            // IASakStatistikkProdusent
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = sak.saksnummer,
                konsument = iaSakStatistikkKonsument,
            ) { meldinger ->
                val objektene = meldinger.map {
                    Json.decodeFromString<IASakStatistikkProdusent.IASakStatistikkValue>(it)
                }
                objektene shouldHaveSize 3
                objektene.forExactlyOne {
                    it.orgnr shouldBe sak.orgnr
                    it.saksnummer shouldBe sak.saksnummer
                    it.eierAvSak shouldBe null
                    it.status shouldBe IASak.Status.SLETTET
                }
            }
        }
    }

    @Test
    fun `skal kunne fullføre vurdering som ikke medfører et samarbeid`() {
        val sak = vurderVirksomhet(næringskode = "${(Bransje.ANLEGG.bransjeId as BransjeId.Næring).næring}.120")
        sak.status shouldBe IASak.Status.VURDERES

        val fullførVurderingRes = applikasjon.performPost("$NY_FLYT_PATH/${sak.orgnr}/fullfor-vurdering")
            .authentication().bearer(authContainerHelper.superbruker1.token)
            .jsonBody(
                Json.encodeToString(
                    ValgtÅrsak(
                        type = VIRKSOMHETEN_TAKKET_NEI,
                        begrunnelser = listOf(
                            VIRKSOMHETEN_ØNSKER_IKKE_SAMARBEID,
                        ),
                    ),
                ),
            )
            .tilSingelRespons<IASakDto>()
        fullførVurderingRes.second.statusCode shouldBe HttpStatusCode.OK.value
        fullførVurderingRes.third.get().status shouldBe IASak.Status.VURDERT

        val oppdatertSakDto = fullførVurderingRes.third.get()

        runBlocking {
            // Sak observer - IASakProdusent
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(key = oppdatertSakDto.saksnummer, konsument = iaSakKonsument) { meldinger ->
                meldinger.forAll { hendelse ->
                    hendelse shouldContain oppdatertSakDto.saksnummer
                    hendelse shouldContain oppdatertSakDto.orgnr
                }
                meldinger shouldHaveSize 3
                meldinger[0] shouldContain IASak.Status.NY.name
                meldinger[1] shouldContain IASak.Status.VURDERES.name
                meldinger[2] shouldContain IASak.Status.VURDERT.name
            }

            // IASakStatistikkProdusent
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = oppdatertSakDto.saksnummer,
                konsument = iaSakStatistikkKonsument,
            ) { meldinger ->
                val objektene = meldinger.map {
                    Json.decodeFromString<IASakStatistikkProdusent.IASakStatistikkValue>(it)
                }
                objektene shouldHaveSize 3
                objektene.forExactlyOne {
                    it.orgnr shouldBe oppdatertSakDto.orgnr
                    it.saksnummer shouldBe oppdatertSakDto.saksnummer
                    it.eierAvSak shouldBe null
                    it.status shouldBe IASak.Status.VURDERT
                    it.ikkeAktuelBegrunnelse shouldBe "[${VIRKSOMHETEN_ØNSKER_IKKE_SAMARBEID.name}]"
                    it.antallPersoner shouldBe hentFraKvartal(it, "antall_personer")
                    it.sykefraversprosent shouldBe hentFraKvartal(it, "sykefravarsprosent")
                    it.sykefraversprosentSiste4Kvartal shouldBe hentFraSiste4Kvartaler(it, "prosent")
                    it.bransjeprogram shouldBe Bransje.ANLEGG
                    it.endretAvRolle shouldBe Rolle.SUPERBRUKER
                    it.enhetsnummer shouldBe "2900"
                    it.enhetsnavn shouldBe "IT-avdelingen" // -- Bør ha fallback til minst spesifikk avdeling
                }
            }
        }
    }

    @Test
    fun `skal kunne opprette et samarbeid`() {
        val eierAvSak = authContainerHelper.superbruker1
        val følgerAvSak = authContainerHelper.saksbehandler2
        val sak = vurderVirksomhet(
            næringskode = "${(Bransje.ANLEGG.bransjeId as BransjeId.Næring).næring}.120",
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

        runBlocking {
            // Samarbeid salesforce observer
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger("${sak.saksnummer}-${samarbeid.id}", samarbeidsplanKonsument) { meldinger ->
                val samarbeidKafka = meldinger.map { Json.decodeFromString<SamarbeidKafkaMeldingValue>(it) }
                samarbeidKafka.forExactlyOne {
                    it.samarbeid.id shouldBe samarbeid.id
                    it.samarbeid.navn shouldBe samarbeidsnavn
                    it.samarbeid.status shouldBe IASamarbeid.Status.AKTIV
                }
            }

            // Samarbeid big query observer
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(sak.saksnummer, samarbeidBigqueryKonsument) { meldinger ->
                val samarbeidKafka = meldinger.map { Json.decodeFromString<SamarbeidValue>(it) }
                samarbeidKafka.forExactlyOne {
                    it.id shouldBe samarbeid.id
                    it.navn shouldBe samarbeidsnavn
                    it.status shouldBe IASamarbeid.Status.AKTIV.name
                }
            }
        }
    }

    @Test
    fun `opprettelse av samarbeidsplan når virksomheten er i status VURDERES skal gjøre virksomheten AKTIV`() {
        val sak = vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES

        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        val samarbeid = sak.opprettSamarbeid()
        hentAktivSak(orgnr = sak.orgnr).status shouldBe IASak.Status.VURDERES

        val plan = samarbeid.opprettSamarbeidsplan(sak.orgnr)
        plan.status shouldBe IASamarbeid.Status.AKTIV
        hentAktivSak(sak.orgnr).status shouldBe IASak.Status.AKTIV
    }

    @Test
    fun `opprettelse av samarbeidsplan når virksomheten er i status AKTIV skal ikke endre status`() {
        val sak = vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES

        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        sak.opprettSamarbeid(samarbeidsnavn = "Samarbeid med ${sak.orgnr}").opprettSamarbeidsplan(sak.orgnr)
        val oppdatertSak = hentAktivSak(orgnr = sak.orgnr)
        oppdatertSak.status shouldBe IASak.Status.AKTIV

        oppdatertSak.opprettSamarbeid(samarbeidsnavn = "Nytt samarbeid for ${oppdatertSak.orgnr}").opprettSamarbeidsplan(oppdatertSak.orgnr)
        val sakMedToSamarbeid = hentAktivSak(orgnr = sak.orgnr)
        sakMedToSamarbeid.status shouldBe IASak.Status.AKTIV
    }

    @Test
    fun `sletting av siste samarbeidsplan fører til at virksomheten går tilbake til status VURDERES`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        val samarbeid = sak.opprettSamarbeid()
        val plan = samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr, planMal = PlanHelper.hentPlanMal())
        hentAktivSak(orgnr = sak.orgnr).status shouldBe IASak.Status.AKTIV

        samarbeid.slettSamarbeidsplan(orgnr = sak.orgnr)
        postgresContainerHelper.hentEnkelKolonne<String>(
            """
            SELECT status from ia_sak_plan where plan_id = '${plan.id}'
            """.trimIndent(),
        ) shouldBe "SLETTET"
        hentAktivSak(orgnr = sak.orgnr).status shouldBe IASak.Status.VURDERES
    }

    @Test
    fun `status er fortsatt AKTIV dersom det gjenstår en eller flere samarbeidsplaner etter sletting`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        val samarbeid = sak.opprettSamarbeid()
        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr, planMal = PlanHelper.hentPlanMal())
        hentAktivSak(orgnr = sak.orgnr).status shouldBe IASak.Status.AKTIV

        sak.opprettSamarbeid(samarbeidsnavn = "Helt nytt").opprettSamarbeidsplan(orgnr = sak.orgnr)

        samarbeid.slettSamarbeidsplan(orgnr = sak.orgnr)
        hentAktivSak(orgnr = sak.orgnr).status shouldBe IASak.Status.AKTIV
    }

    @Test
    fun `status er fortsatt AKTIV dersom det gjenstår en eller flere samarbeid etter slett samarbeid`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        val samarbeid = sak.opprettSamarbeid()
        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr, planMal = PlanHelper.hentPlanMal())
        hentAktivSak(orgnr = sak.orgnr).status shouldBe IASak.Status.AKTIV

        val etNyttSamarbeid = sak.opprettSamarbeid(samarbeidsnavn = "Helt nytt")

        etNyttSamarbeid.slettSamarbeid(orgnr = sak.orgnr)
        hentAktivSak(orgnr = sak.orgnr).status shouldBe IASak.Status.AKTIV
        sak.hentAlleSamarbeid() shouldHaveSize 1
    }

    @Test
    fun `skal kunne slette samarbeid når virksomhet er i tilstand VirksomhetVurderes`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        val samarbeid = sak.opprettSamarbeid()
        samarbeid.slettSamarbeid(orgnr = sak.orgnr)
        hentAktivSak(orgnr = sak.orgnr).status shouldBe IASak.Status.VURDERES
        sak.hentAlleSamarbeid() shouldHaveSize 0
    }

    private fun IASamarbeidDto.slettSamarbeid(
        orgnr: String,
        token: String = authContainerHelper.saksbehandler1.token,
    ) = applikasjon.performDelete("$NY_FLYT_PATH/$orgnr/${this.id}/slett-samarbeid")
        .authentication().bearer(token)
        .tilSingelRespons<IASamarbeidDto>().third.fold(
            success = { respons -> respons },
            failure = { fail(it.message) },
        )

    private fun IASamarbeidDto.slettSamarbeidsplan(
        orgnr: String,
        token: String = authContainerHelper.saksbehandler1.token,
    ) = applikasjon.performDelete("$NY_FLYT_PATH/$orgnr/${this.id}/slett-samarbeidsplan")
        .authentication().bearer(token)
        .tilSingelRespons<Int>().third.fold(
            success = { respons -> respons },
            failure = { fail(it.message) },
        )

    private fun IASamarbeidDto.opprettSamarbeidsplan(
        orgnr: String,
        planMal: PlanMalDto = PlanHelper.hentPlanMal().inkluderAlt(),
        token: String = authContainerHelper.superbruker1.token,
    ): PlanMedPubliseringStatusDto {
        val plan = applikasjon.performPost("$NY_FLYT_PATH/$orgnr/${this.id}/opprett-samarbeidsplan")
            .authentication().bearer(token)
            .jsonBody(
                Json.encodeToString(planMal),
            ).tilSingelRespons<PlanMedPubliseringStatusDto>().third.get()
        return plan
    }

    private fun hentAktivSak(
        orgnr: String,
        token: String = authContainerHelper.superbruker1.token,
    ) = applikasjon.performGet("$NY_FLYT_PATH/$orgnr")
        .authentication().bearer(token).tilSingelRespons<IASakDto>().third.get()

    private fun IASakDto.opprettSamarbeid(
        token: String = authContainerHelper.superbruker1.token,
        samarbeidsnavn: String = "Samarbeid med $orgnr",
    ): IASamarbeidDto =
        applikasjon.performPost("$NY_FLYT_PATH/$orgnr/opprett-samarbeid")
            .authentication().bearer(token)
            .jsonBody(
                Json.encodeToString(
                    IASamarbeidDto(
                        id = 0,
                        saksnummer = saksnummer,
                        navn = samarbeidsnavn,
                    ),
                ),
            ).tilSingelRespons<IASamarbeidDto>().third.get()

    private fun vurderVirksomhet(
        næringskode: String = "${(Bransje.ANLEGG.bransjeId as BransjeId.Næring).næring}.120",
        token: String = authContainerHelper.superbruker1.token,
    ): IASakDto {
        val virksomhet = TestVirksomhet.nyVirksomhet(
            næringer = listOf(Næringsgruppe(kode = næringskode, navn = "Bygging av jernbaner og undergrunnsbaner")),
        )
        lastInnNyVirksomhet(virksomhet)
        val orgnummer = virksomhet.orgnr
        val res = applikasjon.performPost("$NY_FLYT_PATH/$orgnummer/vurder")
            .authentication().bearer(token)
            .tilSingelRespons<IASakDto>()

        return res.third.get()
    }
}
