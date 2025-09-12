package no.nav.lydia.container.ia.sak.kartlegging

import com.github.kittinunf.fuel.core.extensions.authentication
import io.kotest.assertions.shouldFail
import io.kotest.inspectors.forAll
import io.kotest.matchers.collections.shouldContainAll
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.collections.shouldNotBeEmpty
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.kotest.matchers.string.shouldContain
import io.kotest.matchers.string.shouldMatch
import io.kotest.matchers.string.shouldNotBeEmpty
import io.ktor.http.HttpStatusCode
import kotlinx.coroutines.runBlocking
import kotlinx.datetime.toJavaLocalDateTime
import kotlinx.datetime.toKotlinLocalDateTime
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.helper.DokumentPubliseringHelper.Companion.hentDokumentPublisering
import no.nav.lydia.helper.DokumentPubliseringHelper.Companion.publiserDokument
import no.nav.lydia.helper.DokumentPubliseringHelper.Companion.sendKvittering
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.avslutt
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.flytt
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.hentKartleggingMedSvar
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.hentSpørreundersøkelse
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettBehovsvurdering
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettSpørreundersøkelse
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettSvarOgAvsluttSpørreundersøkelse
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.slett
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.start
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.svarPåSpørsmål
import no.nav.lydia.helper.SakHelper.Companion.leggTilFolger
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartlegges
import no.nav.lydia.helper.SakHelper.Companion.nySakIKartleggesMedEtSamarbeid
import no.nav.lydia.helper.SakHelper.Companion.nySakIViBistår
import no.nav.lydia.helper.TestContainerHelper.Companion.applikasjon
import no.nav.lydia.helper.TestContainerHelper.Companion.authContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.postgresContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.hentAlleSamarbeid
import no.nav.lydia.helper.opprettNyttSamarbeid
import no.nav.lydia.helper.statuskode
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.eksport.FullførtBehovsvurderingProdusent.FullførtBehovsvurdering
import no.nav.lydia.ia.eksport.SpørreundersøkelseProdusent.SpørreundersøkelseKafkaDto
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SPØRREUNDERSØKELSE_BASE_ROUTE
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseDto
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Spørreundersøkelse.Companion.ANTALL_TIMER_EN_SPØRREUNDERSØKELSE_ER_TILGJENGELIG
import org.junit.AfterClass
import org.junit.BeforeClass
import kotlin.test.Test

class BehovsvurderingApiTest {
    @Test
    fun `saksbehandlere som ikke er eier eller følger skal IKKKE kunne administrere behovsvurdering`() {
        val sak = nySakIKartleggesMedEtSamarbeid(token = authContainerHelper.saksbehandler1.token)
        val ikkeEierEllerFølger = authContainerHelper.saksbehandler2

        shouldFail { sak.opprettBehovsvurdering(token = ikkeEierEllerFølger.token) }

        val behovsvurdering = sak.opprettBehovsvurdering(token = authContainerHelper.saksbehandler1.token)

        shouldFail {
            behovsvurdering.start(token = ikkeEierEllerFølger.token, orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        }

        val påbegyntBehovsvurdering = behovsvurdering.start(
            token = authContainerHelper.saksbehandler1.token,
            orgnummer = sak.orgnr,
            saksnummer = sak.saksnummer,
        )

        shouldFail {
            påbegyntBehovsvurdering.avslutt(token = ikkeEierEllerFølger.token, orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        }
    }

    @Test
    fun `kun saksbehandlere som er eier eller følger skal kunne slette behovsvurdering`() {
        val sak = nySakIKartleggesMedEtSamarbeid(token = authContainerHelper.saksbehandler1.token)
        val ikkeEierEllerFølger = authContainerHelper.saksbehandler2
        val behovsvurdering = sak.opprettBehovsvurdering(token = authContainerHelper.saksbehandler1.token)

        shouldFail {
            behovsvurdering.slett(token = ikkeEierEllerFølger.token, orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        }

        val påbegyntBehovsvurdering = behovsvurdering.start(
            token = authContainerHelper.saksbehandler1.token,
            orgnummer = sak.orgnr,
            saksnummer = sak.saksnummer,
        )

        shouldFail {
            påbegyntBehovsvurdering.slett(token = ikkeEierEllerFølger.token, orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        }

        val følger = authContainerHelper.saksbehandler2
        sak.leggTilFolger(token = følger.token)

        påbegyntBehovsvurdering.slett(token = følger.token, orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        postgresContainerHelper.hentAlleRaderTilEnkelKolonne<String>(
            "select status from ia_sak_kartlegging where kartlegging_id = '${påbegyntBehovsvurdering.id}'",
        ).forAll { it shouldBe "SLETTET" }
    }

    @Test
    fun `kun saksbehandlere som er eier eller følger skal kunne flytte avsluttet behovsvurdering`() {
        val sak = nySakIKartleggesMedEtSamarbeid(token = authContainerHelper.saksbehandler1.token, navnPåSamarbeid = "samarbeid 1")
        sak.opprettNyttSamarbeid(navn = "Samarbeid 2")
        val alleSamarbeid = sak.hentAlleSamarbeid()
        val samarbeid1 = alleSamarbeid.first()
        val samarbeid2 = alleSamarbeid.last()
        val ikkeEierEllerFølger = authContainerHelper.saksbehandler2

        val behovsvurdering = sak.opprettBehovsvurdering(token = authContainerHelper.saksbehandler1.token, samarbeidId = samarbeid1.id)
        behovsvurdering.start(token = authContainerHelper.saksbehandler1.token, orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        behovsvurdering.avslutt(token = authContainerHelper.saksbehandler1.token, orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        shouldFail {
            behovsvurdering.flytt(token = ikkeEierEllerFølger.token, orgnummer = sak.orgnr, saksnummer = sak.saksnummer, samarbeidId = samarbeid2.id)
        }

        val følger = authContainerHelper.saksbehandler2
        sak.leggTilFolger(token = følger.token)

        val flyttetBehovsvurdering = behovsvurdering.flytt(
            token = følger.token,
            orgnummer = sak.orgnr,
            saksnummer = sak.saksnummer,
            samarbeidId = samarbeid2.id,
        )
        flyttetBehovsvurdering.samarbeidId shouldBe samarbeid2.id
    }

    @Test
    fun `følgere av sak som er sakbehandlere skal kunne administrere behovsvurdering`() {
        val sak = nySakIKartleggesMedEtSamarbeid(token = authContainerHelper.saksbehandler1.token)
        val følger = authContainerHelper.saksbehandler2
        sak.leggTilFolger(token = følger.token)
        val behovsvurdering = sak.opprettBehovsvurdering(token = følger.token)
        behovsvurdering.status shouldBe Spørreundersøkelse.Status.OPPRETTET

        val påbegyntBehovsvurdering = behovsvurdering.start(token = følger.token, orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        påbegyntBehovsvurdering.status shouldBe Spørreundersøkelse.Status.PÅBEGYNT

        val fullførtBehovsvurdering = påbegyntBehovsvurdering.avslutt(token = følger.token, orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        fullførtBehovsvurdering.status shouldBe Spørreundersøkelse.Status.AVSLUTTET
    }

    @Test
    fun `skal sette riktig gyldighetstid`() {
        val sak = nySakIKartleggesMedEtSamarbeid()

        val behovsvurdering = sak.opprettBehovsvurdering()
        val opprettet = behovsvurdering.opprettetTidspunkt
        val burdeVæreGyldigTil = opprettet.toJavaLocalDateTime().plusHours(ANTALL_TIMER_EN_SPØRREUNDERSØKELSE_ER_TILGJENGELIG).toKotlinLocalDateTime()
        behovsvurdering.gyldigTilTidspunkt shouldBe burdeVæreGyldigTil
    }

    @Test
    fun `kan opprette en spørreundersøkelse av type behovsvurdering i status KARTLEGGES`() {
        val sak = nySakIKartleggesMedEtSamarbeid()

        val behovsvurdering = sak.opprettBehovsvurdering()
        behovsvurdering.id.length shouldBe 36

        postgresContainerHelper.hentEnkelKolonne<String>(
            "select kartlegging_id from ia_sak_kartlegging where kartlegging_id = '${behovsvurdering.id}'",
        ) shouldNotBe null
    }

    @Test
    fun `kan opprette en spørreundersøkelse av type behovsvurdering i status VI_BISTÅR`() {
        val sak = nySakIViBistår()

        val behovsvurdering = sak.opprettBehovsvurdering()
        behovsvurdering.id.length shouldBe 36

        postgresContainerHelper.hentEnkelKolonne<String>(
            "select kartlegging_id from ia_sak_kartlegging where kartlegging_id = '${behovsvurdering.id}'",
        ) shouldNotBe null
    }

    @Test
    fun `kan opprette en spørreundersøkelse av type behovsvurdering med flere temaer`() {
        val behovsvurdering = nySakIKartleggesMedEtSamarbeid().opprettBehovsvurdering()

        behovsvurdering.type shouldBe Spørreundersøkelse.Type.Behovsvurdering.name.uppercase()
        behovsvurdering.temaer shouldHaveSize 3
        behovsvurdering.temaer.forAll {
            it.spørsmålOgSvaralternativer.shouldNotBeEmpty()
        }

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = behovsvurdering.id,
                konsument = spørreundersøkelseKonsument,
            ) { meldinger ->
                meldinger.forExactlyOne { melding ->
                    val spørreundersøkelse =
                        Json.decodeFromString<SpørreundersøkelseKafkaDto>(melding)
                    spørreundersøkelse.temaer shouldHaveSize 3
                    spørreundersøkelse.temaer.forAll {
                        it.spørsmål.shouldNotBeEmpty()
                        it.navn.shouldNotBeEmpty()
                    }
                    spørreundersøkelse.plan shouldBe null
                }
            }
        }
    }

    @Test
    fun `skal få feil når saksnummer er ukjent ved oppretting av behovsvurdering`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val resp = opprettSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = "ukjent",
            samarbeidId = sak.hentAlleSamarbeid().first().id,
            type = Spørreundersøkelse.Type.Behovsvurdering,
        ).tilSingelRespons<SpørreundersøkelseDto>()

        resp.second.statusCode shouldBe HttpStatusCode.BadRequest.value
        resp.second.body().asString("text/plain") shouldMatch "Ugyldig saksnummer"
    }

    @Test
    fun `skal få feil når orgnummer er feil ved oppretting av behovsvurdering`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val resp = opprettSpørreundersøkelse(
            orgnr = "222233334",
            saksnummer = sak.saksnummer,
            samarbeidId = sak.hentAlleSamarbeid().first().id,
            type = Spørreundersøkelse.Type.Behovsvurdering,
        ).tilSingelRespons<SpørreundersøkelseDto>()

        resp.second.statusCode shouldBe HttpStatusCode.BadRequest.value
        resp.second.body().asString("text/plain") shouldMatch "Ugyldig orgnummer"
    }

    @Test
    fun `kan opprette spørreundersøkelse av typen behovsvurdering og sende den på kafka`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val behovsvurdering = sak.opprettBehovsvurdering()

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = behovsvurdering.id,
                konsument = spørreundersøkelseKonsument,
            ) { liste ->
                liste.map { melding ->
                    val spørreundersøkelse = Json.decodeFromString<SpørreundersøkelseKafkaDto>(melding)
                    spørreundersøkelse.id shouldBe behovsvurdering.id
                    spørreundersøkelse.orgnummer shouldBe sak.orgnr
                    spørreundersøkelse.virksomhetsNavn shouldBe "Navn ${sak.orgnr}"
                    spørreundersøkelse.status shouldBe Spørreundersøkelse.Status.OPPRETTET
                    spørreundersøkelse.type shouldBe Spørreundersøkelse.Type.Behovsvurdering.name
                    spørreundersøkelse.temaer shouldHaveSize 3
                    spørreundersøkelse.temaer.forAll { tema ->
                        tema.spørsmål.shouldNotBeEmpty()
                        tema.spørsmål.forAll {
                            it.svaralternativer.shouldNotBeEmpty()
                        }
                    }
                }
            }
        }
    }

    @Test
    fun `kan hente liste av alle spørreundersøkelser av typen Behovsvurdering`() {
        val sak = nySakIKartleggesMedEtSamarbeid()

        val behvosvurdering = sak.opprettBehovsvurdering()

        val alleKartlegginger = hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            type = Spørreundersøkelse.Type.Behovsvurdering,
        )

        alleKartlegginger shouldHaveSize 1
        alleKartlegginger.first().id shouldBe behvosvurdering.id
        alleKartlegginger.first().samarbeidId shouldBe behvosvurdering.samarbeidId
        alleKartlegginger.first().opprettetAv shouldBe behvosvurdering.opprettetAv
        alleKartlegginger.first().opprettetTidspunkt shouldBe behvosvurdering.opprettetTidspunkt
        alleKartlegginger.first().status shouldBe Spørreundersøkelse.Status.OPPRETTET
        alleKartlegginger.first().publiseringStatus shouldBe DokumentPublisering.Status.IKKE_PUBLISERT
        alleKartlegginger.first().endretTidspunkt shouldBe null
    }

    @Test
    fun `skal returnere publiseringsstatus for behovsvurdering`() {
        val sak = nySakIKartleggesMedEtSamarbeid()

        val fullførtBehovsvurdering = sak.opprettSvarOgAvsluttSpørreundersøkelse(Spørreundersøkelse.Type.Behovsvurdering)

        val response = publiserDokument(
            dokumentReferanseId = fullførtBehovsvurdering.id,
            token = authContainerHelper.saksbehandler1.token,
        )
        response.statuskode() shouldBe HttpStatusCode.Created.value

        val alleSpørreundersøkelser = hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = fullførtBehovsvurdering.samarbeidId,
            type = Spørreundersøkelse.Type.Behovsvurdering,
        )

        alleSpørreundersøkelser.first().publiseringStatus shouldBe DokumentPublisering.Status.OPPRETTET
    }

    @Test
    fun `skal returnere publisertTidspunkt for en publisert behovsvurdering`() {
        val sak = nySakIKartleggesMedEtSamarbeid()

        val fullførtBehovsvurdering = sak.opprettSvarOgAvsluttSpørreundersøkelse(Spørreundersøkelse.Type.Behovsvurdering)

        val response = publiserDokument(
            dokumentReferanseId = fullførtBehovsvurdering.id,
            token = authContainerHelper.saksbehandler1.token,
        )
        response.statuskode() shouldBe HttpStatusCode.Created.value
        val dokumentPubliseringDto = response.third.get()

        val alleSpørreundersøkelser = hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = fullførtBehovsvurdering.samarbeidId,
            type = Spørreundersøkelse.Type.Behovsvurdering,
        )

        alleSpørreundersøkelser.first().publiseringStatus shouldBe DokumentPublisering.Status.OPPRETTET
        alleSpørreundersøkelser.first().publisertTidspunkt shouldBe null

        sendKvittering(dokument = dokumentPubliseringDto)

        val publisertDokument = hentDokumentPublisering(
            dokumentReferanseId = dokumentPubliseringDto.referanseId,
            token = authContainerHelper.saksbehandler1.token,
        )

        val hentAlleSpørreundersøkelserIgjen = hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = fullførtBehovsvurdering.samarbeidId,
            type = Spørreundersøkelse.Type.Behovsvurdering,
        )

        hentAlleSpørreundersøkelserIgjen.first().publiseringStatus shouldBe DokumentPublisering.Status.PUBLISERT
        hentAlleSpørreundersøkelserIgjen.first().publisertTidspunkt shouldBe publisertDokument.publisertTidspunkt
    }

    @Test
    fun `nylig opprettet behovsvurdering får alle spørsmål med riktige svaralternativer knyttet til seg`() {
        val sak = nySakIKartleggesMedEtSamarbeid()

        val behovsvurdering = sak.opprettBehovsvurdering()
        behovsvurdering.temaer.shouldNotBeEmpty()
        behovsvurdering.temaer.forEach { spørsmålOgSvarPerTema ->
            val temaId: Int = postgresContainerHelper.hentEnkelKolonne(
                "select tema_id from ia_sak_kartlegging_tema where navn = '${spørsmålOgSvarPerTema.navn}' and status = 'AKTIV' and type = 'Behovsvurdering'",
            )

            postgresContainerHelper.hentAlleRaderTilEnkelKolonne<Int>(
                """
                select undertema_id from ia_sak_kartlegging_undertema where tema_id = $temaId
                """.trimIndent(),
            ).forAll { undertemaId ->
                val spørsmålIderForEtUndertema: List<String> = postgresContainerHelper.hentAlleRaderTilEnkelKolonne(
                    "select sporsmal_id from ia_sak_kartlegging_sporsmal_til_undertema where undertema_id = $undertemaId",
                )
                spørsmålOgSvarPerTema.spørsmålOgSvaralternativer.map { spørsmålMedSvar ->
                    spørsmålMedSvar.id
                }.toList() shouldContainAll spørsmålIderForEtUndertema
            }
        }

        behovsvurdering.temaer.forEach { spørsmålMedSvarPerTema ->
            spørsmålMedSvarPerTema.spørsmålOgSvaralternativer.forEach { spørsmålMedSvar ->
                val svarIderForEtSpørsmål: List<String> = postgresContainerHelper.hentAlleRaderTilEnkelKolonne(
                    "select svaralternativ_id from ia_sak_kartlegging_svaralternativer where sporsmal_id = '${spørsmålMedSvar.id}'",
                )
                spørsmålMedSvar.svaralternativer.map { it.svarId }.toList() shouldContainAll svarIderForEtSpørsmål
            }
        }
    }

    @Test
    fun `skal ikke kunne hente resultat før kartlegging er avsluttet`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val påbegyntBehovsvurdering = sak.opprettBehovsvurdering()
            .start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
            .also { it.svarPåSpørsmål(antallSvarPåSpørsmål = 4) }

        shouldFail {
            hentKartleggingMedSvar(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                kartleggingId = påbegyntBehovsvurdering.id,
            )
        }
    }

    @Test
    fun `skal ikke kunne få antall svar dersom antall deltakere er færre enn 3`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val fullførtBehovsvurdering = sak.opprettSvarOgAvsluttSpørreundersøkelse(Spørreundersøkelse.Type.Behovsvurdering, antallSvarPåSpørsmål = 2)

        val spørreundersøkelseResultat = hentKartleggingMedSvar(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            kartleggingId = fullførtBehovsvurdering.id,
        )

        spørreundersøkelseResultat.spørsmålMedSvarPerTema.forAll { tema ->
            tema.spørsmålMedSvar.forAll { spørsmål ->
                spørsmål.antallDeltakereSomHarSvart shouldBe 0
                spørsmål.svarListe.forAll { svar ->
                    svar.antallSvar shouldBe 0
                }
            }
        }
    }

    @Test
    fun `skal få svardetaljer for et spørsmål dersom antall besvarelser er 3 eller flere`() {
        val sak = nySakIKartleggesMedEtSamarbeid()

        val antallSvar = 3
        val temaIdx = 0
        val spørsmålIdx = 0
        val svaralternativIdx = 0

        val fullførtBehovsvurdering = sak.opprettSvarOgAvsluttSpørreundersøkelse(
            Spørreundersøkelse.Type.Behovsvurdering,
            antallSvarPåSpørsmål = 3,
            temaIdx = temaIdx,
            spørsmålIdx = spørsmålIdx,
            svaralternativIdx = svaralternativIdx,
        )

        val spørreundersøkelseResultat = hentKartleggingMedSvar(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            kartleggingId = fullførtBehovsvurdering.id,
        )

        spørreundersøkelseResultat.spørsmålMedSvarPerTema.forAll { tema ->
            tema.spørsmålMedSvar.forAll { spørsmål ->
                if (spørsmål.id == spørreundersøkelseResultat
                        .spørsmålMedSvarPerTema[temaIdx]
                        .spørsmålMedSvar[spørsmålIdx].id
                ) {
                    spørsmål.antallDeltakereSomHarSvart shouldBe antallSvar
                    spørsmål.svarListe.first().antallSvar shouldBe antallSvar
                } else {
                    spørsmål.antallDeltakereSomHarSvart shouldBe 0
                    spørsmål.svarListe.forAll { svar ->
                        svar.antallSvar shouldBe 0
                    }
                }
            }
        }
    }

    @Test
    fun `alle med tilgang til fia skal kunne hente resultater av kartlegging`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val behovsvurdering = sak.opprettBehovsvurdering()
        behovsvurdering.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        behovsvurdering.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val resultater = hentKartleggingMedSvar(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            kartleggingId = behovsvurdering.id,
        )
        resultater.id shouldBe behovsvurdering.id

        val behovsvurderingResultat = hentKartleggingMedSvar(
            token = authContainerHelper.saksbehandler2.token,
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            kartleggingId = behovsvurdering.id,
        )
        behovsvurderingResultat.id shouldBe behovsvurdering.id
    }

    @Test
    fun `kan starte en Spørreundersøkelse av type Behovsvurdering`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val behovsvurdering = sak.opprettBehovsvurdering()
        behovsvurdering.type shouldBe Spørreundersøkelse.Type.Behovsvurdering.name.uppercase()
        behovsvurdering.status shouldBe Spørreundersøkelse.Status.OPPRETTET

        val påbegyntBehovsvurdering = behovsvurdering.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        påbegyntBehovsvurdering.status shouldBe Spørreundersøkelse.Status.PÅBEGYNT

        hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            type = Spørreundersøkelse.Type.Behovsvurdering,
        ).forExactlyOne {
            it.status shouldBe Spørreundersøkelse.Status.PÅBEGYNT
            it.endretTidspunkt shouldNotBe null
        }

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = behovsvurdering.id,
                konsument = spørreundersøkelseKonsument,
            ) {
                it.forExactlyOne { melding ->
                    val spørreundersøkelse =
                        Json.decodeFromString<SpørreundersøkelseKafkaDto>(melding)
                    spørreundersøkelse.status shouldBe Spørreundersøkelse.Status.PÅBEGYNT
                }
            }
        }
    }

    @Test
    fun `skal kunne avslutte en påbegynt kartlegging`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val kartleggingDto = sak.opprettBehovsvurdering()
        val påbegyntKartlegging = kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        påbegyntKartlegging.status shouldBe Spørreundersøkelse.Status.PÅBEGYNT

        val avsluttetKartlegging = påbegyntKartlegging.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        avsluttetKartlegging.status shouldBe Spørreundersøkelse.Status.AVSLUTTET

        hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            type = Spørreundersøkelse.Type.Behovsvurdering,
        ).forExactlyOne {
            it.status shouldBe Spørreundersøkelse.Status.AVSLUTTET
            it.endretTidspunkt shouldNotBe null
        }

        runBlocking {
            // -- topic for fia-arbeidsgiver
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = kartleggingDto.id,
                konsument = spørreundersøkelseKonsument,
            ) {
                it.forExactlyOne { melding ->
                    val spørreundersøkelse = Json.decodeFromString<SpørreundersøkelseKafkaDto>(melding)
                    spørreundersøkelse.status shouldBe Spørreundersøkelse.Status.AVSLUTTET
                }
            }
        }
    }

    @Test
    fun `skal ikke kunne avslutte kartlegging med status OPPRETTET`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val kartleggingDto = sak.opprettBehovsvurdering()
        kartleggingDto.status shouldBe Spørreundersøkelse.Status.OPPRETTET

        val response = applikasjon.performPost("$SPØRREUNDERSØKELSE_BASE_ROUTE/${sak.orgnr}/${sak.saksnummer}/${kartleggingDto.id}/avslutt")
            .authentication().bearer(authContainerHelper.saksbehandler1.token)
            .tilSingelRespons<SpørreundersøkelseDto>()

        response.second.statusCode shouldBe HttpStatusCode.Forbidden.value

        applikasjon shouldContainLog
            "Spørreundersøkelse er ikke i status '${Spørreundersøkelse.Status.PÅBEGYNT.name}', kan ikke avslutte".toRegex()
    }

    @Test
    fun `skal kunne slette en kartlegging`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val pågåendeKartlegging = sak.opprettBehovsvurdering()
            .start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
            .also { it.svarPåSpørsmål(antallSvarPåSpørsmål = 1) }

        postgresContainerHelper.hentAlleRaderTilEnkelKolonne<String>(
            "select kartlegging_id from ia_sak_kartlegging_svar where kartlegging_id = '${pågåendeKartlegging.id}'",
        ) shouldHaveSize 1

        pågåendeKartlegging.slett(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = pågåendeKartlegging.id,
                konsument = spørreundersøkelseKonsument,
            ) {
                it.forExactlyOne { melding ->
                    val spørreundersøkelse =
                        Json.decodeFromString<SpørreundersøkelseKafkaDto>(melding)
                    spørreundersøkelse.status shouldBe Spørreundersøkelse.Status.SLETTET
                }
            }
        }

        postgresContainerHelper.hentAlleRaderTilEnkelKolonne<String>(
            "select kartlegging_id from ia_sak_kartlegging_svar where kartlegging_id = '${pågåendeKartlegging.id}'",
        ).shouldNotBeEmpty()

        postgresContainerHelper.hentAlleRaderTilEnkelKolonne<String>(
            "select status from ia_sak_kartlegging where kartlegging_id = '${pågåendeKartlegging.id}'",
        ).forAll { it shouldBe "SLETTET" }

        hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            type = Spørreundersøkelse.Type.Behovsvurdering,
        ) shouldHaveSize 0
    }

    @Test
    fun `skal kunne slette en kartlegging i status VI_BISTÅR`() {
        val sak = nySakIViBistår()
        val kartleggingDto = sak.opprettBehovsvurdering()
        kartleggingDto.status shouldBe Spørreundersøkelse.Status.OPPRETTET
        kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        kartleggingDto.slett(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        postgresContainerHelper.hentAlleRaderTilEnkelKolonne<String>(
            "select kartlegging_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingDto.id}'",
        ) shouldHaveSize 0
        postgresContainerHelper.hentAlleRaderTilEnkelKolonne<String>(
            "select status from ia_sak_kartlegging where kartlegging_id = '${kartleggingDto.id}'",
        ).forAll { it shouldBe "SLETTET" }

        hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = sak.hentAlleSamarbeid().first().id,
            type = Spørreundersøkelse.Type.Behovsvurdering,
        ) shouldHaveSize 0
    }

    @Test
    fun `skal kunne opprette behovsvurdering for to forskjellige prosesser`() {
        val sak = nySakIKartlegges()
            .opprettNyttSamarbeid(navn = "Først")
            .opprettNyttSamarbeid(navn = "Sist")

        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 2
        alleSamarbeid.forEach { samarbeid ->
            sak.opprettBehovsvurdering(samarbeidId = samarbeid.id)

            hentSpørreundersøkelse(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                prosessId = samarbeid.id,
                type = Spørreundersøkelse.Type.Behovsvurdering,
            ) shouldHaveSize 1
        }
    }

    @Test
    fun `skal kunne flytte en spørreundersøkelse fra et samarbeid til et annet`() {
        val sak = nySakIKartlegges()
            .opprettNyttSamarbeid(navn = "Først")
            .opprettNyttSamarbeid(navn = "Sist")
        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 2
        val førsteSamarbeid = alleSamarbeid.first()
        val sisteSamarbeid = alleSamarbeid.last()

        val behovsvurdering = sak.opprettBehovsvurdering(samarbeidId = førsteSamarbeid.id)
        val type = Spørreundersøkelse.Type.Behovsvurdering
        hentSpørreundersøkelse(orgnr = sak.orgnr, saksnummer = sak.saksnummer, prosessId = førsteSamarbeid.id, type = type)
            .map { it.id } shouldBe listOf(behovsvurdering.id)
        behovsvurdering.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        behovsvurdering.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        val oppdatertBehovsvurdering = behovsvurdering.flytt(
            orgnummer = sak.orgnr,
            saksnummer = sak.saksnummer,
            samarbeidId = sisteSamarbeid.id,
        )
        oppdatertBehovsvurdering.endretTidspunkt shouldNotBe oppdatertBehovsvurdering.fullførtTidspunkt

        hentSpørreundersøkelse(orgnr = sak.orgnr, saksnummer = sak.saksnummer, prosessId = førsteSamarbeid.id, type = type)
            .map { it.id } shouldBe emptyList()
        hentSpørreundersøkelse(orgnr = sak.orgnr, saksnummer = sak.saksnummer, prosessId = sisteSamarbeid.id, type = type)
            .map { it.id } shouldBe listOf(behovsvurdering.id)
    }

    @Test
    fun `skal sende på nytt til SF en Kafka melding om at en fullført behhovsvurdering er flyttet`() {
        val sak = nySakIKartlegges()
            .opprettNyttSamarbeid(navn = "Først")
            .opprettNyttSamarbeid(navn = "Sist")
        val alleSamarbeid = sak.hentAlleSamarbeid()
        val førsteSamarbeid = alleSamarbeid.first()
        val sisteSamarbeid = alleSamarbeid.last()

        val behovsvurdering = sak.opprettBehovsvurdering(samarbeidId = førsteSamarbeid.id)
        behovsvurdering.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        behovsvurdering.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = behovsvurdering.id,
                konsument = fullførtBehovsvurderingKonsument,
            ) {
                it.forExactlyOne { melding ->
                    val behovsvurderingIKafkaMelding = Json.decodeFromString<FullførtBehovsvurdering>(melding)
                    behovsvurderingIKafkaMelding.behovsvurderingId shouldBe behovsvurdering.id
                    behovsvurderingIKafkaMelding.prosessId shouldBe førsteSamarbeid.id.toString()
                }
            }
        }

        behovsvurdering.flytt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer, samarbeidId = sisteSamarbeid.id)

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = behovsvurdering.id,
                konsument = fullførtBehovsvurderingKonsument,
            ) {
                it.forExactlyOne { melding ->
                    val behovsvurderingIKafkaMelding = Json.decodeFromString<FullførtBehovsvurdering>(melding)
                    behovsvurderingIKafkaMelding.behovsvurderingId shouldBe behovsvurdering.id
                    behovsvurderingIKafkaMelding.prosessId shouldBe sisteSamarbeid.id.toString()
                }
            }
        }
    }

    @Test
    fun `skal ikke kunne flytte kartlegging en ugyldig prosess eller som lesebruker`() {
        val sak = nySakIKartlegges()
            .opprettNyttSamarbeid()
        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 1
        val behovsvurdering = sak.opprettBehovsvurdering(alleSamarbeid.first().id)

        // -- skal ikke kunne flytte til ikke eksisterende prosess
        shouldFail {
            behovsvurdering.flytt(
                orgnummer = sak.orgnr,
                saksnummer = sak.saksnummer,
                samarbeidId = 100000,
            )
        }

        // -- Lesebruker skal ikke kunne flytte behovsuvurdering
        shouldFail {
            behovsvurdering.flytt(
                token = authContainerHelper.lesebruker.token,
                orgnummer = sak.orgnr,
                saksnummer = sak.saksnummer,
                samarbeidId = sak.hentAlleSamarbeid().first().id,
            )
        }

        // -- skal ikke kunne flytte til prosess i en annen sak
        val nysak = nySakIKartlegges()
            .opprettNyttSamarbeid()
        shouldFail {
            behovsvurdering.flytt(
                orgnummer = sak.orgnr,
                saksnummer = sak.saksnummer,
                samarbeidId = nysak.hentAlleSamarbeid().first().id,
            )
        }
    }

    @Test
    fun `skal IKKE kunne flytte en behovsvurdering som ikke er avsluttet (fullført)`() {
        val sak = nySakIKartlegges()
            .opprettNyttSamarbeid(navn = "Først")
            .opprettNyttSamarbeid(navn = "Sist")

        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 2

        val førsteSamarbeid = alleSamarbeid.first()
        val andreSamarbeid = alleSamarbeid.last()

        val behovsvurdering = sak.opprettBehovsvurdering(samarbeidId = førsteSamarbeid.id)
        behovsvurdering.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        shouldFail { behovsvurdering.flytt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer, samarbeidId = andreSamarbeid.id) }.message shouldContain
            "kan ikke bytte samarbeid"

        val type = Spørreundersøkelse.Type.Behovsvurdering
        hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = førsteSamarbeid.id,
            type = type,
        ).forExactlyOne {
            it.status shouldBe Spørreundersøkelse.Status.PÅBEGYNT
            it.samarbeidId shouldBe førsteSamarbeid.id
        }

        hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            prosessId = andreSamarbeid.id,
            type = type,
        ) shouldHaveSize 0
    }

    @Test
    fun `Skal IKKE kunne flytte en avsluttet (fullført) behovsvurdering som er publisert`() {
        val sak = nySakIKartlegges()
            .opprettNyttSamarbeid(navn = "Først")
            .opprettNyttSamarbeid(navn = "Sist")

        val alleSamarbeid = sak.hentAlleSamarbeid()
        alleSamarbeid shouldHaveSize 2

        val førsteSamarbeid = alleSamarbeid.first()
        val andreSamarbeid = alleSamarbeid.last()

        val type = Spørreundersøkelse.Type.Behovsvurdering
        val avsluttetBehovsvurdering = sak.opprettSvarOgAvsluttSpørreundersøkelse(type = type, samarbeidId = førsteSamarbeid.id)
        avsluttetBehovsvurdering.status shouldBe Spørreundersøkelse.Status.AVSLUTTET

        val response = publiserDokument(
            dokumentReferanseId = avsluttetBehovsvurdering.id,
            token = authContainerHelper.saksbehandler1.token,
        )

        response.statuskode() shouldBe HttpStatusCode.Created.value
        val dokumentPubliseringDto = response.third.get()
        dokumentPubliseringDto.referanseId shouldBe avsluttetBehovsvurdering.id
        dokumentPubliseringDto.status shouldNotBe DokumentPublisering.Status.IKKE_PUBLISERT

        shouldFail {
            avsluttetBehovsvurdering.flytt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer, samarbeidId = andreSamarbeid.id)
        }.message shouldContain "er publisert, kan ikke bytte samarbeid"
    }

    @Test
    fun `Oppretting, start og fullføring av spørreundersøkelse oppdaterer rette tidspunktfelter`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val spørreundersøkelseDto = sak.opprettBehovsvurdering()
        spørreundersøkelseDto.status shouldBe Spørreundersøkelse.Status.OPPRETTET
        spørreundersøkelseDto.endretTidspunkt shouldBe null
        spørreundersøkelseDto.påbegyntTidspunkt shouldBe null
        spørreundersøkelseDto.fullførtTidspunkt shouldBe null

        val påbegyntSpørreundersøkelse = spørreundersøkelseDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        påbegyntSpørreundersøkelse.status shouldBe Spørreundersøkelse.Status.PÅBEGYNT
        påbegyntSpørreundersøkelse.endretTidspunkt shouldNotBe null
        påbegyntSpørreundersøkelse.påbegyntTidspunkt shouldNotBe null
        påbegyntSpørreundersøkelse.fullførtTidspunkt shouldBe null
        påbegyntSpørreundersøkelse.endretTidspunkt shouldBe påbegyntSpørreundersøkelse.påbegyntTidspunkt

        val fullførtSpørreundersøkelse = påbegyntSpørreundersøkelse.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        fullførtSpørreundersøkelse.status shouldBe Spørreundersøkelse.Status.AVSLUTTET
        fullførtSpørreundersøkelse.endretTidspunkt shouldNotBe null
        fullførtSpørreundersøkelse.påbegyntTidspunkt shouldNotBe null
        fullførtSpørreundersøkelse.fullførtTidspunkt shouldNotBe null
        fullførtSpørreundersøkelse.endretTidspunkt shouldBe fullførtSpørreundersøkelse.fullførtTidspunkt

        runBlocking {
            // -- topic for fia-arbeidsgiver
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = spørreundersøkelseDto.id,
                konsument = spørreundersøkelseKonsument,
            ) {
                it.forExactlyOne { melding ->
                    val spørreundersøkelse = Json.decodeFromString<SpørreundersøkelseKafkaDto>(melding)
                    spørreundersøkelse.status shouldBe Spørreundersøkelse.Status.AVSLUTTET
                }
            }
        }
    }

    companion object {
        const val ID_TIL_SPØRSMÅL_MED_FLERVALG_MULIGHETER = "01939c0b-21f2-728d-aa91-3c84fef3bb18"
        private val spørreundersøkelseTopic = Topic.SPORREUNDERSOKELSE_TOPIC
        private val fullførtBehovsvurderingTopic = Topic.FULLFØRT_BEHOVSVURDERING_TOPIC
        private val spørreundersøkelseKonsument = kafkaContainerHelper.nyKonsument(topic = spørreundersøkelseTopic)
        private val fullførtBehovsvurderingKonsument = kafkaContainerHelper.nyKonsument(topic = fullførtBehovsvurderingTopic)

        @BeforeClass
        @JvmStatic
        fun setUp() {
            spørreundersøkelseKonsument.subscribe(mutableListOf(spørreundersøkelseTopic.navn))
            fullførtBehovsvurderingKonsument.subscribe(mutableListOf(fullførtBehovsvurderingTopic.navn))
        }

        @AfterClass
        @JvmStatic
        fun tearDown() {
            spørreundersøkelseKonsument.unsubscribe()
            spørreundersøkelseKonsument.close()
            fullførtBehovsvurderingKonsument.unsubscribe()
            fullførtBehovsvurderingKonsument.close()
        }
    }
}
