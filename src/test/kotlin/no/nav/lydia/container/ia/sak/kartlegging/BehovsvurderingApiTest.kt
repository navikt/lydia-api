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
import no.nav.lydia.helper.DokumentPubliseringHelper.Companion.opprettDokumentPubliseringRespons
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.avslutt
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.flytt
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.hentKartleggingMedSvar
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.hentSpørreundersøkelse
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettBehovsvurdering
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettSpørreundersøkelse
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.sendKartleggingSvarTilKafka
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.slett
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.start
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
import no.nav.lydia.ia.eksport.SpørreundersøkelseProdusent.SerializableSpørreundersøkelse
import no.nav.lydia.ia.sak.api.dokument.DokumentPublisering
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SPØRREUNDERSØKELSE_BASE_ROUTE
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseDto
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseDomene
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.SpørreundersøkelseDomene.Companion.ANTALL_TIMER_EN_SPØRREUNDERSØKELSE_ER_TILGJENGELIG
import org.junit.AfterClass
import org.junit.BeforeClass
import java.util.UUID
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

        val behovsvurdering = sak.opprettBehovsvurdering(token = authContainerHelper.saksbehandler1.token, prosessId = samarbeid1.id)
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
        behovsvurdering.status shouldBe SpørreundersøkelseDomene.Status.OPPRETTET

        val påbegyntBehovsvurdering = behovsvurdering.start(token = følger.token, orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        påbegyntBehovsvurdering.status shouldBe SpørreundersøkelseDomene.Status.PÅBEGYNT

        val fullførtBehovsvurdering = påbegyntBehovsvurdering.avslutt(token = følger.token, orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        fullførtBehovsvurdering.status shouldBe SpørreundersøkelseDomene.Status.AVSLUTTET
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

        behovsvurdering.type shouldBe SpørreundersøkelseDomene.Type.Behovsvurdering
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
                        Json.decodeFromString<SerializableSpørreundersøkelse>(melding)
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
            prosessId = sak.hentAlleSamarbeid().first().id,
            type = SpørreundersøkelseDomene.Type.Behovsvurdering,
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
            prosessId = sak.hentAlleSamarbeid().first().id,
            type = SpørreundersøkelseDomene.Type.Behovsvurdering,
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
                    val spørreundersøkelse =
                        Json.decodeFromString<SerializableSpørreundersøkelse>(melding)
                    spørreundersøkelse.id shouldBe behovsvurdering.id
                    spørreundersøkelse.orgnummer shouldBe sak.orgnr
                    spørreundersøkelse.virksomhetsNavn shouldBe "Navn ${sak.orgnr}"
                    spørreundersøkelse.status shouldBe SpørreundersøkelseDomene.Status.OPPRETTET
                    spørreundersøkelse.type shouldBe SpørreundersøkelseDomene.Type.Behovsvurdering.name
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
            samarbeidId = sak.hentAlleSamarbeid().first().id,
            type = SpørreundersøkelseDomene.Type.Behovsvurdering,
        )

        alleKartlegginger shouldHaveSize 1
        alleKartlegginger.first().id shouldBe behvosvurdering.id
        alleKartlegginger.first().samarbeidId shouldBe behvosvurdering.samarbeidId
        alleKartlegginger.first().opprettetAv shouldBe behvosvurdering.opprettetAv
        alleKartlegginger.first().opprettetTidspunkt shouldBe behvosvurdering.opprettetTidspunkt
        alleKartlegginger.first().status shouldBe SpørreundersøkelseDomene.Status.OPPRETTET
        alleKartlegginger.first().publiseringStatus shouldBe DokumentPublisering.Status.IKKE_PUBLISERT
        alleKartlegginger.first().endretTidspunkt shouldBe null
    }

    @Test
    fun `skal returnere publiseringsstatus for behovsvurdering`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val fullførtBehovsvurdering = sak.opprettBehovsvurdering()
            .start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
            .avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        val response = opprettDokumentPubliseringRespons(
            dokumentReferanseId = fullførtBehovsvurdering.id,
            token = authContainerHelper.saksbehandler1.token,
        )
        response.statuskode() shouldBe HttpStatusCode.Created.value

        val alleSpørreundersøkelser = hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            samarbeidId = fullførtBehovsvurdering.samarbeidId,
            type = SpørreundersøkelseDomene.Type.Behovsvurdering,
        )

        alleSpørreundersøkelser.first().publiseringStatus shouldBe DokumentPublisering.Status.OPPRETTET
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
            .also { it.status shouldBe SpørreundersøkelseDomene.Status.OPPRETTET }
            .start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
            .also { it.status shouldBe SpørreundersøkelseDomene.Status.PÅBEGYNT }

        listOf(UUID.randomUUID(), UUID.randomUUID(), UUID.randomUUID()).forEach { sesjonId ->
            enDeltakerSvarerPåEtSpørsmål(kartleggingDto = påbegyntBehovsvurdering, UUID.randomUUID().toString())
        }

        val førsteSpørsmål = påbegyntBehovsvurdering.temaer.first().spørsmålOgSvaralternativer.first()
        val førsteSvaralternativ = førsteSpørsmål.svaralternativer.first()
        val sesjonId = UUID.randomUUID()
        sendKartleggingSvarTilKafka(
            kartleggingId = påbegyntBehovsvurdering.id,
            spørsmålId = førsteSpørsmål.id,
            sesjonId = sesjonId.toString(),
            svarIder = listOf(førsteSvaralternativ.svarId),
        )

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
        val påbegyntBehovsvurdering = sak.opprettBehovsvurdering()
            .also { it.status shouldBe SpørreundersøkelseDomene.Status.OPPRETTET }
            .start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
            .also { it.status shouldBe SpørreundersøkelseDomene.Status.PÅBEGYNT }

        val førsteSpørsmål = påbegyntBehovsvurdering.temaer.first().spørsmålOgSvaralternativer.first()
        val førsteSvaralternativ = førsteSpørsmål.svaralternativer.first()

        val antallSvar = 2

        repeat(antallSvar) {
            val sesjonId = UUID.randomUUID()
            sendKartleggingSvarTilKafka(
                kartleggingId = påbegyntBehovsvurdering.id,
                spørsmålId = førsteSpørsmål.id,
                sesjonId = sesjonId.toString(),
                svarIder = listOf(førsteSvaralternativ.svarId),
            )
        }

        påbegyntBehovsvurdering.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        val spørreundersøkelseResultat = hentKartleggingMedSvar(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            kartleggingId = påbegyntBehovsvurdering.id,
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
        val påbegyntBehovsvurdering = sak.opprettBehovsvurdering()
            .also { it.status shouldBe SpørreundersøkelseDomene.Status.OPPRETTET }
            .start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
            .also { it.status shouldBe SpørreundersøkelseDomene.Status.PÅBEGYNT }

        val førsteSpørsmål = påbegyntBehovsvurdering.temaer.first().spørsmålOgSvaralternativer.first()
        val førsteSvaralternativ = førsteSpørsmål.svaralternativer.first()

        val antallSvar = 3

        repeat(antallSvar) {
            val sesjonId = UUID.randomUUID()
            sendKartleggingSvarTilKafka(
                kartleggingId = påbegyntBehovsvurdering.id,
                spørsmålId = førsteSpørsmål.id,
                sesjonId = sesjonId.toString(),
                svarIder = listOf(førsteSvaralternativ.svarId),
            )
        }

        påbegyntBehovsvurdering.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        val spørreundersøkelseResultat = hentKartleggingMedSvar(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            kartleggingId = påbegyntBehovsvurdering.id,
        )

        spørreundersøkelseResultat.spørsmålMedSvarPerTema.forAll { tema ->
            tema.spørsmålMedSvar.forAll { spørsmål ->
                if (spørsmål.id == førsteSpørsmål.id) {
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
        behovsvurdering.type shouldBe SpørreundersøkelseDomene.Type.Behovsvurdering
        behovsvurdering.status shouldBe SpørreundersøkelseDomene.Status.OPPRETTET

        val påbegyntBehovsvurdering = behovsvurdering.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        påbegyntBehovsvurdering.status shouldBe SpørreundersøkelseDomene.Status.PÅBEGYNT

        hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            samarbeidId = sak.hentAlleSamarbeid().first().id,
            type = SpørreundersøkelseDomene.Type.Behovsvurdering,
        ).forExactlyOne {
            it.status shouldBe SpørreundersøkelseDomene.Status.PÅBEGYNT
            it.endretTidspunkt shouldNotBe null
        }

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = behovsvurdering.id,
                konsument = spørreundersøkelseKonsument,
            ) {
                it.forExactlyOne { melding ->
                    val spørreundersøkelse =
                        Json.decodeFromString<SerializableSpørreundersøkelse>(melding)
                    spørreundersøkelse.status shouldBe SpørreundersøkelseDomene.Status.PÅBEGYNT
                }
            }
        }
    }

    @Test
    fun `skal kunne avslutte en påbegynt kartlegging`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val kartleggingDto = sak.opprettBehovsvurdering()
        val påbegyntKartlegging = kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        påbegyntKartlegging.status shouldBe SpørreundersøkelseDomene.Status.PÅBEGYNT

        val avsluttetKartlegging = påbegyntKartlegging.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        avsluttetKartlegging.status shouldBe SpørreundersøkelseDomene.Status.AVSLUTTET

        hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            samarbeidId = sak.hentAlleSamarbeid().first().id,
            type = SpørreundersøkelseDomene.Type.Behovsvurdering,
        ).forExactlyOne {
            it.status shouldBe SpørreundersøkelseDomene.Status.AVSLUTTET
            it.endretTidspunkt shouldNotBe null
        }

        runBlocking {
            // -- topic for fia-arbeidsgiver
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = kartleggingDto.id,
                konsument = spørreundersøkelseKonsument,
            ) {
                it.forExactlyOne { melding ->
                    val spørreundersøkelse = Json.decodeFromString<SerializableSpørreundersøkelse>(melding)
                    spørreundersøkelse.status shouldBe SpørreundersøkelseDomene.Status.AVSLUTTET
                }
            }
        }
    }

    @Test
    fun `skal ikke kunne avslutte kartlegging med status OPPRETTET`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val kartleggingDto = sak.opprettBehovsvurdering()
        kartleggingDto.status shouldBe SpørreundersøkelseDomene.Status.OPPRETTET

        val response = applikasjon.performPost("$SPØRREUNDERSØKELSE_BASE_ROUTE/${sak.orgnr}/${sak.saksnummer}/${kartleggingDto.id}/avslutt")
            .authentication().bearer(authContainerHelper.saksbehandler1.token)
            .tilSingelRespons<SpørreundersøkelseDto>()

        response.second.statusCode shouldBe HttpStatusCode.Forbidden.value

        applikasjon shouldContainLog
            "Spørreundersøkelse er ikke i status '${SpørreundersøkelseDomene.Status.PÅBEGYNT.name}', kan ikke avslutte".toRegex()
    }

    @Test
    fun `skal kunne slette en kartlegging`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val kartleggingDto = sak.opprettBehovsvurdering()
        kartleggingDto.status shouldBe SpørreundersøkelseDomene.Status.OPPRETTET

        val pågåendeKartlegging = kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        val førsteSpørsmål = pågåendeKartlegging.temaer.first().spørsmålOgSvaralternativer.first()
        sendKartleggingSvarTilKafka(
            kartleggingId = pågåendeKartlegging.id,
            spørsmålId = førsteSpørsmål.id,
            sesjonId = UUID.randomUUID().toString(),
            svarIder = listOf(
                førsteSpørsmål.svaralternativer.first().svarId,
            ),
        )

        postgresContainerHelper.hentAlleRaderTilEnkelKolonne<String>(
            "select kartlegging_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingDto.id}'",
        ) shouldHaveSize 1

        pågåendeKartlegging.slett(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        runBlocking {
            kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = kartleggingDto.id,
                konsument = spørreundersøkelseKonsument,
            ) {
                it.forExactlyOne { melding ->
                    val spørreundersøkelse =
                        Json.decodeFromString<SerializableSpørreundersøkelse>(melding)
                    spørreundersøkelse.status shouldBe SpørreundersøkelseDomene.Status.SLETTET
                }
            }
        }

        postgresContainerHelper.hentAlleRaderTilEnkelKolonne<String>(
            "select kartlegging_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingDto.id}'",
        ).shouldNotBeEmpty()

        postgresContainerHelper.hentAlleRaderTilEnkelKolonne<String>(
            "select status from ia_sak_kartlegging where kartlegging_id = '${kartleggingDto.id}'",
        ).forAll { it shouldBe "SLETTET" }

        hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            samarbeidId = sak.hentAlleSamarbeid().first().id,
            type = SpørreundersøkelseDomene.Type.Behovsvurdering,
        ) shouldHaveSize 0
    }

    @Test
    fun `skal kunne slette en kartlegging i status VI_BISTÅR`() {
        val sak = nySakIViBistår()
        val kartleggingDto = sak.opprettBehovsvurdering()
        kartleggingDto.status shouldBe SpørreundersøkelseDomene.Status.OPPRETTET
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
            samarbeidId = sak.hentAlleSamarbeid().first().id,
            type = SpørreundersøkelseDomene.Type.Behovsvurdering,
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
            sak.opprettBehovsvurdering(prosessId = samarbeid.id)

            hentSpørreundersøkelse(
                orgnr = sak.orgnr,
                saksnummer = sak.saksnummer,
                samarbeidId = samarbeid.id,
                type = SpørreundersøkelseDomene.Type.Behovsvurdering,
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

        val behovsvurdering = sak.opprettBehovsvurdering(prosessId = førsteSamarbeid.id)
        val type = SpørreundersøkelseDomene.Type.Behovsvurdering
        hentSpørreundersøkelse(orgnr = sak.orgnr, saksnummer = sak.saksnummer, samarbeidId = førsteSamarbeid.id, type = type)
            .map { it.id } shouldBe listOf(behovsvurdering.id)
        behovsvurdering.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        behovsvurdering.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        val oppdatertBehovsvurdering = behovsvurdering.flytt(
            orgnummer = sak.orgnr,
            saksnummer = sak.saksnummer,
            samarbeidId = sisteSamarbeid.id,
        )
        oppdatertBehovsvurdering.endretTidspunkt shouldNotBe oppdatertBehovsvurdering.fullførtTidspunkt

        hentSpørreundersøkelse(orgnr = sak.orgnr, saksnummer = sak.saksnummer, samarbeidId = førsteSamarbeid.id, type = type)
            .map { it.id } shouldBe emptyList()
        hentSpørreundersøkelse(orgnr = sak.orgnr, saksnummer = sak.saksnummer, samarbeidId = sisteSamarbeid.id, type = type)
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

        val behovsvurdering = sak.opprettBehovsvurdering(prosessId = førsteSamarbeid.id)
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

        val behovsvurdering = sak.opprettBehovsvurdering(prosessId = førsteSamarbeid.id)
        behovsvurdering.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        shouldFail { behovsvurdering.flytt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer, samarbeidId = andreSamarbeid.id) }.message shouldContain
            "kan ikke bytte samarbeid"

        val type = SpørreundersøkelseDomene.Type.Behovsvurdering
        hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            samarbeidId = førsteSamarbeid.id,
            type = type,
        ).forExactlyOne {
            it.status shouldBe SpørreundersøkelseDomene.Status.PÅBEGYNT
            it.samarbeidId shouldBe førsteSamarbeid.id
        }
        hentSpørreundersøkelse(
            orgnr = sak.orgnr,
            saksnummer = sak.saksnummer,
            samarbeidId = andreSamarbeid.id,
            type = type,
        ) shouldHaveSize 0
    }

    @Test
    fun `Oppretting, start og fullføring av spørreundersøkelse oppdaterer rette tidspunktfelter`() {
        val sak = nySakIKartleggesMedEtSamarbeid()
        val spørreundersøkelseDto = sak.opprettBehovsvurdering()
        spørreundersøkelseDto.status shouldBe SpørreundersøkelseDomene.Status.OPPRETTET
        spørreundersøkelseDto.endretTidspunkt shouldBe null
        spørreundersøkelseDto.påbegyntTidspunkt shouldBe null
        spørreundersøkelseDto.fullførtTidspunkt shouldBe null

        val påbegyntSpørreundersøkelse = spørreundersøkelseDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        påbegyntSpørreundersøkelse.status shouldBe SpørreundersøkelseDomene.Status.PÅBEGYNT
        påbegyntSpørreundersøkelse.endretTidspunkt shouldNotBe null
        påbegyntSpørreundersøkelse.påbegyntTidspunkt shouldNotBe null
        påbegyntSpørreundersøkelse.fullførtTidspunkt shouldBe null
        påbegyntSpørreundersøkelse.endretTidspunkt shouldBe påbegyntSpørreundersøkelse.påbegyntTidspunkt

        val fullførtSpørreundersøkelse = påbegyntSpørreundersøkelse.avslutt(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        fullførtSpørreundersøkelse.status shouldBe SpørreundersøkelseDomene.Status.AVSLUTTET
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
                    val spørreundersøkelse = Json.decodeFromString<SerializableSpørreundersøkelse>(melding)
                    spørreundersøkelse.status shouldBe SpørreundersøkelseDomene.Status.AVSLUTTET
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

        private fun enDeltakerSvarerPåEtSpørsmål(
            kartleggingDto: SpørreundersøkelseDto,
            sesjonId: String = UUID.randomUUID().toString(),
        ) {
            val førsteTema = kartleggingDto.temaer.first()
            val førsteSpørsmålId = førsteTema.spørsmålOgSvaralternativer.first().id
            val førsteSvarId = førsteTema.spørsmålOgSvaralternativer.first().svaralternativer.first().svarId
            sendKartleggingSvarTilKafka(
                kartleggingId = kartleggingDto.id,
                spørsmålId = førsteSpørsmålId,
                sesjonId = sesjonId,
                svarIder = listOf(førsteSvarId),
            )
        }
    }
}
