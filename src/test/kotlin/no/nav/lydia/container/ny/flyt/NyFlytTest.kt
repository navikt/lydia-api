package no.nav.lydia.container.ny.flyt

import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.core.extensions.jsonBody
import ia.felles.definisjoner.bransjer.Bransje
import ia.felles.definisjoner.bransjer.BransjeId
import io.kotest.inspectors.forAll
import io.kotest.matchers.booleans.shouldBeTrue
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.kotest.matchers.string.shouldContain
import io.ktor.http.HttpStatusCode
import kotlinx.coroutines.runBlocking
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.container.ia.eksport.IASakStatistikkEksportererTest.Companion.hentFraKvartal
import no.nav.lydia.container.ia.eksport.IASakStatistikkEksportererTest.Companion.hentFraSiste4Kvartaler
import no.nav.lydia.helper.IASakSpørreundersøkelseHelper
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
import no.nav.lydia.helper.statuskode
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.eksport.IASakStatistikkProdusent
import no.nav.lydia.ia.eksport.SamarbeidBigqueryProdusent.SamarbeidValue
import no.nav.lydia.ia.eksport.SamarbeidDto
import no.nav.lydia.ia.eksport.SamarbeidProdusent.SamarbeidKafkaMeldingValue
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.ny.flyt.NY_FLYT_PATH
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetIATilstand
import no.nav.lydia.ia.sak.api.ny.flyt.VirksomhetTilstandDto
import no.nav.lydia.ia.sak.api.plan.PlanMedPubliseringStatusDto
import no.nav.lydia.ia.sak.api.samarbeid.IASamarbeidDto
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseDto
import no.nav.lydia.ia.sak.domene.IASak
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.plan.PlanMalDto
import no.nav.lydia.ia.sak.domene.samarbeid.IASamarbeid
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.ia.årsak.domene.BegrunnelseType
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.ÅrsakType
import no.nav.lydia.tilgangskontroll.fia.Rolle
import no.nav.lydia.virksomhet.domene.Næringsgruppe
import org.junit.AfterClass
import org.junit.BeforeClass
import java.time.LocalDate
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
    fun `skal kunne avslutte vurdering som ikke medfører et samarbeid`() {
        val sak = vurderVirksomhet(næringskode = "${(Bransje.ANLEGG.bransjeId as BransjeId.Næring).næring}.120")
        sak.status shouldBe IASak.Status.VURDERES

        val oppdatertSakDto = sak.avsluttVurdering(
            valgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_ER_FERDIG_VURDERT,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_HAR_TAKKET_NEI,
                    BegrunnelseType.IKKE_DOKUMENTERT_DIALOG_MELLOM_PARTENE,
                ),
                dato = LocalDate.now().plusDays(20).toKotlinLocalDate(),
            ),
        )
        oppdatertSakDto.status shouldBe IASak.Status.VURDERT

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
                    it.hendelse shouldBe IASakshendelseType.VURDERING_FULLFØRT_UTEN_SAMARBEID
                    it.ikkeAktuelBegrunnelse shouldBe
                        "[${BegrunnelseType.VIRKSOMHETEN_HAR_TAKKET_NEI.name}, ${BegrunnelseType.IKKE_DOKUMENTERT_DIALOG_MELLOM_PARTENE.name}]"
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

    // TODO: Sikre at nyTilstand blir oppdatert og satt riktig
    @Test
    fun `avslutt vurdering med gyldig årsak gir tilstand VirksomhetErVurdert og nesteTilstand VirksomhetKlarTilVurdering`() {
        val sak = vurderVirksomhet(næringskode = "${(Bransje.ANLEGG.bransjeId as BransjeId.Næring).næring}.120")
        sak.status shouldBe IASak.Status.VURDERES

        sak.avsluttVurdering(
            valgtÅrsak = ValgtÅrsak(
                type = ÅrsakType.VIRKSOMHETEN_ER_FERDIG_VURDERT,
                begrunnelser = listOf(
                    BegrunnelseType.VIRKSOMHETEN_HAR_TAKKET_NEI,
                    BegrunnelseType.IKKE_DOKUMENTERT_DIALOG_MELLOM_PARTENE,
                ),
                dato = LocalDate.now().plusDays(20).toKotlinLocalDate(),
            ),
        )

        val virksomhetsTilstand = hentVirksomhetTilstand(orgnr = sak.orgnr)
        virksomhetsTilstand.tilstand shouldBe VirksomhetIATilstand.VirksomhetErVurdert
        virksomhetsTilstand.nesteTilstand?.nyTilstand shouldBe VirksomhetIATilstand.VirksomhetKlarTilVurdering
        virksomhetsTilstand.nesteTilstand?.planlagtDato shouldBe LocalDate.now().plusDays(20).toKotlinLocalDate()
    }

    @Test
    fun `skal kunne vurdere en virksomhet som allerede er vurdert`() {
        val sak = vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES

        val avsluttVurderingRes = applikasjon.performPost("$NY_FLYT_PATH/${sak.orgnr}/avslutt-vurdering")
            .authentication().bearer(authContainerHelper.superbruker1.token)
            .jsonBody(
                Json.encodeToString(
                    ValgtÅrsak(
                        type = ÅrsakType.VIRKSOMHETEN_SKAL_VURDERES_SENERE,
                        begrunnelser = listOf(
                            BegrunnelseType.VIRKSOMHETEN_ØNSKER_SAMARBEID_SENERE,
                        ),
                        dato = LocalDate.now().plusDays(1).toKotlinLocalDate(),
                    ),
                ),
            )
            .tilSingelRespons<IASakDto>()
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

        hentVirksomhetTilstand(sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

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
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        val plan = samarbeid.opprettSamarbeidsplan(sak.orgnr)
        plan.status shouldBe IASamarbeid.Status.AKTIV
        hentVirksomhetTilstand(sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
    }

    @Test
    fun `opprettelse av samarbeidsplan når virksomheten er i status AKTIV skal ikke endre status`() {
        val sak = vurderVirksomhet()
        sak.status shouldBe IASak.Status.VURDERES

        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        sak.opprettSamarbeid(samarbeidsnavn = "Samarbeid med ${sak.orgnr}").opprettSamarbeidsplan(sak.orgnr)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        sak.opprettSamarbeid(samarbeidsnavn = "Nytt samarbeid for ${sak.orgnr}").opprettSamarbeidsplan(sak.orgnr)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
    }

    @Test
    fun `Tilstand og status er uendret etter sletting av samarbeidsplan`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        val samarbeid = sak.opprettSamarbeid()
        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr, planMal = PlanHelper.hentPlanMal())
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        sak.opprettSamarbeid(samarbeidsnavn = "Helt nytt").opprettSamarbeidsplan(orgnr = sak.orgnr)

        samarbeid.slettSamarbeidsplan(orgnr = sak.orgnr)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
    }

    @Test
    fun `status er fortsatt AKTIV dersom det gjenstår en eller flere samarbeid etter slett samarbeid`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        val samarbeid = sak.opprettSamarbeid()
        samarbeid.opprettSamarbeidsplan(orgnr = sak.orgnr, planMal = PlanHelper.hentPlanMal())
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        val etNyttSamarbeid = sak.opprettSamarbeid(samarbeidsnavn = "Helt nytt")

        etNyttSamarbeid.slettSamarbeid(orgnr = sak.orgnr)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
        sak.hentAlleSamarbeid() shouldHaveSize 1
    }

    @Test
    fun `sletting av eneste samarbeid i virksomhet som er i tilstand VirksomhetHarAktiveSamarbeid fører til VirksomhetVurderes`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        val samarbeid = sak.opprettSamarbeid()
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
        samarbeid.slettSamarbeid(orgnr = sak.orgnr)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes
        sak.hentAlleSamarbeid() shouldHaveSize 0
    }

    @Test
    fun `sletting av siste samarbeid i en virksomhet med fullførte samarbeid fører til AlleSamarbeidIVirksomhetErAvsluttet`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        val samarbeidSomSkalFullføres = sak.opprettSamarbeid()
        val samarbeidSomSkalSlettes = sak.opprettSamarbeid(samarbeidsnavn = "Slett meg!")
        samarbeidSomSkalFullføres.opprettSamarbeidsplan(orgnr = sak.orgnr, planMal = PlanHelper.hentPlanMal())
        samarbeidSomSkalFullføres.avsluttSamarbeid(orgnr = sak.orgnr, avslutningsType = IASamarbeid.Status.FULLFØRT)

        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
        samarbeidSomSkalSlettes.slettSamarbeid(orgnr = sak.orgnr)

        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.AlleSamarbeidIVirksomhetErAvsluttet
        sak.hentAlleSamarbeid() shouldHaveSize 1
    }

    @Test
    fun `ved avslutning(FULLFØR) av siste samarbeid i tilstand VirksomhetHarAktiveSamarbeid skal virksomheten gå til status AVSLUTTET`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
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
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
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
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
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
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
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
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
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
    fun `Opprettelse av behovsvurdering skal ikke endre status`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
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
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes

        val samarbeid = sak.opprettSamarbeid()
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        val opprettetBehovsvurdering = samarbeid.opprettKartlegging(
            orgnr = sak.orgnr,
            type = Spørreundersøkelse.Type.Behovsvurdering,
        )
        opprettetBehovsvurdering.status shouldBe Spørreundersøkelse.Status.OPPRETTET

        val startetBehovsvurdering = samarbeid.startKartlegging(
            orgnr = sak.orgnr,
            sporreundersokelseId = opprettetBehovsvurdering.id,
        )
        startetBehovsvurdering.status shouldBe Spørreundersøkelse.Status.PÅBEGYNT
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        val fullførtBehovsvurdering = samarbeid.fullførKartlegging(
            orgnr = sak.orgnr,
            sporreundersokelseId = opprettetBehovsvurdering.id,
        )

        fullførtBehovsvurdering.status shouldBe Spørreundersøkelse.Status.AVSLUTTET
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
    }

    @Test
    fun `Sletting av behovsvurdering skal ikke endre status på IASak`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetVurderes

        val samarbeid = sak.opprettSamarbeid()
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        val opprettetBehovsvurdering = samarbeid.opprettKartlegging(orgnr = sak.orgnr, type = Spørreundersøkelse.Type.Behovsvurdering)

        samarbeid.startKartlegging(
            orgnr = sak.orgnr,
            sporreundersokelseId = opprettetBehovsvurdering.id,
        )

        val slettetBehovsvurdering = samarbeid.slettKartlegging(orgnr = sak.orgnr, sporreundersokelseId = opprettetBehovsvurdering.id)

        slettetBehovsvurdering.status shouldBe Spørreundersøkelse.Status.SLETTET
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
    }

    @Test
    fun `Starting og fullføring av evaluering skal ikke endre status på IASak`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
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
            sporreundersokelseId = opprettetEvaluering.id,
        )
        startetEvaluering.status shouldBe Spørreundersøkelse.Status.PÅBEGYNT
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        val fullførtEvaluering = samarbeid.fullførKartlegging(
            orgnr = sak.orgnr,
            sporreundersokelseId = opprettetEvaluering.id,
        )

        fullførtEvaluering.status shouldBe Spørreundersøkelse.Status.AVSLUTTET
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
    }

    @Test
    fun `Sletting av evaluering skal ikke endre status på IASak`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
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
            sporreundersokelseId = opprettetEvaluering.id,
        )
        startetEvaluering.status shouldBe Spørreundersøkelse.Status.PÅBEGYNT
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid

        val slettetEvaluering = samarbeid.slettKartlegging(
            orgnr = sak.orgnr,
            sporreundersokelseId = opprettetEvaluering.id,
        )

        slettetEvaluering.status shouldBe Spørreundersøkelse.Status.SLETTET
        hentVirksomhetTilstand(orgnr = sak.orgnr).tilstand shouldBe VirksomhetIATilstand.VirksomhetHarAktiveSamarbeid
    }

    @Test
    fun `skal kunne revurdere en virksomhet som er i tilstand AlleSamarbeidIVirksomhetErAvsluttet`() {
        val sak = vurderVirksomhet()
        sak.leggTilFolger(authContainerHelper.superbruker1.token)
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

        val eierskapsendringResponse = sak.bliEier(token = saksbehandler.token)
        eierskapsendringResponse.second.statusCode shouldBe HttpStatusCode.OK.value

        val sakEtterEierskapendring = eierskapsendringResponse.third.get()
        sakEtterEierskapendring.eidAv shouldBe saksbehandler.navIdent
    }

    @Test
    fun `skal få feilmelding dersom man tar eierskap i en virksomhet som ikke har en aktiv sak`() {
        val superbruker = authContainerHelper.superbruker1
        val virksomhetUtenSak = VirksomhetHelper.nyttOrgnummer()

        val responseUtenSak = virksomhetUtenSak.bliEier(token = superbruker.token)
        responseUtenSak.statuskode() shouldBe HttpStatusCode.BadRequest.value

        val virksomhetMedAvsluttetSak = vurderVirksomhet().avsluttVurdering().orgnr
        val responseMedAvsluttetSak = virksomhetMedAvsluttetSak.bliEier(superbruker.token)
        responseMedAvsluttetSak.statuskode() shouldBe HttpStatusCode.BadRequest.value
    }

    @Test
    fun `lesebrukere skal ikke kunne bli eiere`() {
        val lesebruker = authContainerHelper.lesebruker
        val sak = vurderVirksomhet()

        val responseLesebruker = sak.bliEier(token = lesebruker.token)
        responseLesebruker.statuskode() shouldBe HttpStatusCode.Forbidden.value
    }

    private fun IASakDto.bliEier(token: String) = orgnr.bliEier(token)

    private fun String.bliEier(token: String) =
        applikasjon.performPost("$NY_FLYT_PATH/$this/bli-eier")
            .authentication().bearer(token = token)
            .tilSingelRespons<IASakDto>()

    private fun IASamarbeidDto.avsluttSamarbeid(
        orgnr: String,
        avslutningsType: IASamarbeid.Status,
        token: String = authContainerHelper.saksbehandler1.token,
    ) = applikasjon.performPost("$NY_FLYT_PATH/$orgnr/${this.id}/avslutt-samarbeid")
        .authentication().bearer(token)
        .jsonBody(
            Json.encodeToString(
                SamarbeidDto(
                    id = this.id,
                    status = avslutningsType,
                ),
            ),
        )
        .tilSingelRespons<IASamarbeidDto>().third.fold(
            success = { respons -> respons },
            failure = { fail(it.message) },
        )

    private fun IASamarbeidDto.slettSamarbeid(
        orgnr: String,
        token: String = authContainerHelper.saksbehandler1.token,
    ) = applikasjon.performDelete("$NY_FLYT_PATH/$orgnr/${this.id}/slett-samarbeid")
        .authentication().bearer(token)
        .tilSingelRespons<IASamarbeidDto>().third.fold(
            success = { respons -> respons },
            failure = { fail(it.message) },
        )

    private fun IASamarbeidDto.opprettKartlegging(
        orgnr: String,
        type: Spørreundersøkelse.Type,
        token: String = authContainerHelper.saksbehandler1.token,
    ) = applikasjon.performPost("$NY_FLYT_PATH/$orgnr/${this.id}/opprett-kartlegging/${type.name}")
        .authentication().bearer(token)
        .tilSingelRespons<SpørreundersøkelseDto>().third.fold(
            success = { respons -> respons },
            failure = { fail(it.message) },
        )

    private fun IASamarbeidDto.startKartlegging(
        orgnr: String,
        sporreundersokelseId: String,
        token: String = authContainerHelper.saksbehandler1.token,
    ) = applikasjon.performPost("$NY_FLYT_PATH/$orgnr/${this.id}/start-kartlegging/$sporreundersokelseId")
        .authentication().bearer(token)
        .tilSingelRespons<SpørreundersøkelseDto>().third.fold(
            success = { respons -> respons },
            failure = { fail(it.message) },
        )

    private fun IASamarbeidDto.fullførKartlegging(
        orgnr: String,
        sporreundersokelseId: String,
        token: String = authContainerHelper.saksbehandler1.token,
    ) = applikasjon.performPost("$NY_FLYT_PATH/$orgnr/${this.id}/fullfor-kartlegging/$sporreundersokelseId")
        .authentication().bearer(token)
        .tilSingelRespons<SpørreundersøkelseDto>().third.fold(
            success = { respons -> respons },
            failure = { fail(it.message) },
        )

    private fun IASamarbeidDto.slettKartlegging(
        orgnr: String,
        sporreundersokelseId: String,
        token: String = authContainerHelper.saksbehandler1.token,
    ) = applikasjon.performDelete("$NY_FLYT_PATH/$orgnr/${this.id}/slett-kartlegging/$sporreundersokelseId")
        .authentication().bearer(token)
        .tilSingelRespons<SpørreundersøkelseDto>().third.fold(
            success = { respons -> respons },
            failure = { fail(it.message) },
        )

    private fun IASamarbeidDto.slettSamarbeidsplan(
        orgnr: String,
        token: String = authContainerHelper.saksbehandler1.token,
    ) = applikasjon.performDelete("$NY_FLYT_PATH/$orgnr/${this.id}/slett-samarbeidsplan")
        .authentication().bearer(token)
        .tilSingelRespons<PlanMedPubliseringStatusDto>().third.fold(
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

    private fun hentVirksomhetTilstand(
        orgnr: String,
        token: String = authContainerHelper.superbruker1.token,
    ) = applikasjon.performGet("$NY_FLYT_PATH/$orgnr/tilstand")
        .authentication().bearer(token).tilSingelRespons<VirksomhetTilstandDto>().third.get()

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

    private fun IASakDto.avsluttVurdering(
        token: String = authContainerHelper.superbruker1.token,
        valgtÅrsak: ValgtÅrsak = ValgtÅrsak(
            type = ÅrsakType.VIRKSOMHETEN_SKAL_VURDERES_SENERE,
            begrunnelser = listOf(
                BegrunnelseType.VIRKSOMHETEN_ØNSKER_SAMARBEID_SENERE,
            ),
            dato = LocalDate.now().plusDays(90).toKotlinLocalDate(),
        ),
    ) = applikasjon.performPost("$NY_FLYT_PATH/$orgnr/avslutt-vurdering")
        .authentication().bearer(token)
        .jsonBody(
            Json.encodeToString(valgtÅrsak),
        )
        .tilSingelRespons<IASakDto>().third.fold(
            { it },
            { fail(it.message) },
        )

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
