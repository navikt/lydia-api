package no.nav.lydia.container.ia.sak.kartlegging

import com.github.kittinunf.fuel.core.extensions.authentication
import ia.felles.integrasjoner.kafkameldinger.spørreundersøkelse.SpørreundersøkelseStatus.PÅBEGYNT
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.Topic
import no.nav.lydia.container.ia.sak.kartlegging.BehovsvurderingApiTest.Companion.ID_TIL_SPØRSMÅL_MED_FLERVALG_MULIGHETER
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.opprettSpørreundersøkelse
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.sendKartleggingFlervalgSvarTilKafka
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.sendKartleggingSvarTilKafka
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.start
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.svarAlternativerTilEtFlervalgSpørsmål
import no.nav.lydia.helper.IASakKartleggingHelper.Companion.svarAlternativerTilEtSpørsmål
import no.nav.lydia.helper.SakHelper
import no.nav.lydia.helper.TestContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.performDelete
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.shouldContainLog
import no.nav.lydia.helper.forExactlyOne
import no.nav.lydia.helper.tilSingelRespons
import no.nav.lydia.ia.eksport.SpørreundersøkelseOppdateringProdusent.OppdateringsType.ANTALL_SVAR
import no.nav.lydia.ia.eksport.SpørreundersøkelseOppdateringProdusent.SpørreundersøkelseAntallSvarDto
import no.nav.lydia.ia.eksport.SpørreundersøkelseOppdateringProdusent.SpørreundersøkelseOppdateringNøkkel
import no.nav.lydia.ia.eksport.SpørreundersøkelseProdusent.SerializableSpørreundersøkelse
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SPØRREUNDERSØKELSE_BASE_ROUTE
import no.nav.lydia.ia.sak.api.spørreundersøkelse.SpørreundersøkelseDto
import org.junit.After
import org.junit.Before
import org.postgresql.util.PGobject
import java.util.UUID
import kotlin.test.Test

class SpørreundersøkelseSvarKonsumentTestDto {
    val kartleggingKonsument = TestContainerHelper.kafkaContainerHelper.nyKonsument("spørreundersøkelse")
    val spørreundersøkelseOppdateringKonsument =
        TestContainerHelper.kafkaContainerHelper.nyKonsument("spørreundersøkelseOppdatering")

    @Before
    fun setUp() {
        kartleggingKonsument.subscribe(mutableListOf(Topic.SPORREUNDERSOKELSE_TOPIC.navn))
        spørreundersøkelseOppdateringKonsument.subscribe(mutableListOf(Topic.SPORREUNDERSOKELSE_OPPDATERING_TOPIC.navn))
    }

    @After
    fun tearDown() {
        kartleggingKonsument.unsubscribe()
        kartleggingKonsument.close()
        spørreundersøkelseOppdateringKonsument.unsubscribe()
        spørreundersøkelseOppdateringKonsument.close()
    }

    @Test
    fun `skal lagre svar mottatt på Kafka topic`() {
        val sak = SakHelper.nySakIKartleggesMedEtSamarbeid()
        val kartlegging = sak.opprettSpørreundersøkelse()
        kartlegging.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val kartleggingSvarDto = kartlegging.sendKartleggingSvarTilKafka()

        TestContainerHelper.postgresContainer
            .hentEnkelKolonne<String>(
                "select kartlegging_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'",
            ) shouldBe kartleggingSvarDto.spørreundersøkelseId
    }

    @Test
    fun `Skal ikke kunne svare på kartlegging som ikke eksisterer`() {
        val kartleggingSvarDto = sendKartleggingSvarTilKafka()

        TestContainerHelper.postgresContainer
            .hentAlleRaderTilEnkelKolonne<String>(
                "select kartlegging_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'",
            ) shouldHaveSize 0
        TestContainerHelper.lydiaApiContainer.shouldContainLog("Fant ikke kartlegging på denne iden".toRegex())
    }

    @Test
    fun `Skal bare kunne svare på kartlegging dersom den er i pågående status`() {
        val sak = SakHelper.nySakIKartleggesMedEtSamarbeid()
        val kartlegging = sak.opprettSpørreundersøkelse()

        // OPRETTET
        kartlegging.sendKartleggingSvarTilKafka()
        TestContainerHelper.lydiaApiContainer.shouldContainLog("Kan ikke svare på en kartlegging i status OPPRETTET".toRegex())

        // PÅBEGYNT (ok å sende svar)
        kartlegging.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        kartlegging.sendKartleggingSvarTilKafka()
        TestContainerHelper.postgresContainer
            .hentAlleRaderTilEnkelKolonne<String>(
                "select kartlegging_id from ia_sak_kartlegging_svar where kartlegging_id = '${kartlegging.id}'",
            ) shouldHaveSize 1

        // AVSLUTTET
        TestContainerHelper.lydiaApiContainer.performPost(
            "$SPØRREUNDERSØKELSE_BASE_ROUTE/${sak.orgnr}/${sak.saksnummer}/${kartlegging.id}/avslutt",
        )
            .authentication().bearer(TestContainerHelper.oauth2ServerContainer.saksbehandler1.token)
            .tilSingelRespons<SpørreundersøkelseDto>()
        kartlegging.sendKartleggingSvarTilKafka()
        TestContainerHelper.lydiaApiContainer.shouldContainLog("Kan ikke svare på en kartlegging i status AVSLUTTET".toRegex())

        // SLETTET
        TestContainerHelper.lydiaApiContainer.performDelete(
            "$SPØRREUNDERSØKELSE_BASE_ROUTE/${sak.orgnr}/${sak.saksnummer}/${kartlegging.id}",
        )
            .authentication().bearer(TestContainerHelper.oauth2ServerContainer.saksbehandler1.token)
            .tilSingelRespons<SpørreundersøkelseDto>()
        kartlegging.sendKartleggingSvarTilKafka()
        TestContainerHelper.lydiaApiContainer.shouldContainLog("Kan ikke svare på en kartlegging i status SLETTET".toRegex())
    }

    @Test
    fun `Skal ikke lagre svar som ikke er et svaralternativ til spørsmål`() {
        val sak = SakHelper.nySakIKartleggesMedEtSamarbeid()
        val kartlegging = sak.opprettSpørreundersøkelse()
        kartlegging.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        val svarIderHvorMinstEnIdErUkjent = listOf(
            kartlegging.svarAlternativerTilEtSpørsmål(ID_TIL_SPØRSMÅL_MED_FLERVALG_MULIGHETER).first().svarId,
            kartlegging.svarAlternativerTilEtSpørsmål(ID_TIL_SPØRSMÅL_MED_FLERVALG_MULIGHETER).last().svarId,
            UUID.randomUUID().toString(),
        )

        kartlegging.sendKartleggingFlervalgSvarTilKafka(
            svarIder = svarIderHvorMinstEnIdErUkjent,
        )

        val lagredeSvarIder = TestContainerHelper.postgresContainer
            .hentAlleRaderTilEnkelKolonne<PGobject>(
                "select svar_ider from ia_sak_kartlegging_svar where kartlegging_id = '${kartlegging.id}'",
            )
        lagredeSvarIder.size shouldBe 0
        TestContainerHelper.lydiaApiContainer.shouldContainLog("Funnet noen ukjente svarIder".toRegex())
    }

    @Test
    fun `Skal ikke lagre svar dersom spørsmål ikke er funnet i behovsvurdering`() {
        val sak = SakHelper.nySakIKartleggesMedEtSamarbeid()
        val spørreundersøkelse = sak.opprettSpørreundersøkelse()
        spørreundersøkelse.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        val ukjentSpørsmålId = UUID.randomUUID().toString()
        spørreundersøkelse.sendKartleggingSvarTilKafka(
            spørsmålId = ukjentSpørsmålId,
            svarIder = listOf(
                spørreundersøkelse.temaer.first().spørsmålOgSvaralternativer.first().svaralternativer.first().svarId,
            ),
        )

        TestContainerHelper.lydiaApiContainer.shouldContainLog(
            "Finner ikke spørsmål '$ukjentSpørsmålId' svaret er knyttet til, hopper over".toRegex(),
        )
        val lagredeSvarIder = TestContainerHelper.postgresContainer
            .hentAlleRaderTilEnkelKolonne<PGobject>(
                "select svar_ider from ia_sak_kartlegging_svar where kartlegging_id = '${spørreundersøkelse.id}'",
            )
        lagredeSvarIder.size shouldBe 0
    }

    @Test
    fun `Skal ikke lagre svar med flere svarIder på et enkeltvalg spørsmål i en kartlegging`() {
        val sak = SakHelper.nySakIKartleggesMedEtSamarbeid()
        val spørreundersøkelse = sak.opprettSpørreundersøkelse()
        spørreundersøkelse.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val spørsmålSomIkkeErFlervalg = spørreundersøkelse.temaer.first().spørsmålOgSvaralternativer.first()
        spørsmålSomIkkeErFlervalg.flervalg shouldBe false

        spørreundersøkelse.sendKartleggingSvarTilKafka(
            spørsmålId = spørsmålSomIkkeErFlervalg.id,
            svarIder = spørsmålSomIkkeErFlervalg.svaralternativer.map { it.svarId },
        )

        TestContainerHelper.lydiaApiContainer.shouldContainLog("Kan ikke lagre flere svar til et ikke flervalg spørsmål".toRegex())
        val lagredeSvarIder = TestContainerHelper.postgresContainer
            .hentAlleRaderTilEnkelKolonne<PGobject>(
                "select svar_ider from ia_sak_kartlegging_svar where kartlegging_id = '${spørreundersøkelse.id}'",
            )
        lagredeSvarIder.size shouldBe 0
    }

    @Test
    fun `svar skal overskrives i DB ved nytt svar til et flervalg spørsmål mottatt på Kafka topic`() {
        val sak = SakHelper.nySakIKartleggesMedEtSamarbeid()
        val kartleggingDto = sak.opprettSpørreundersøkelse()
        kartleggingDto.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        val kartleggingSvarDto = kartleggingDto.sendKartleggingFlervalgSvarTilKafka(
            svarIder = kartleggingDto.svarAlternativerTilEtFlervalgSpørsmål(),
        )

        val lagredeSvarIder = TestContainerHelper.postgresContainer
            .hentEnkelKolonne<PGobject>(
                "select svar_ider from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'",
            )
        lagredeSvarIder.value shouldNotBe null
        lagredeSvarIder.value?.let { Json.decodeFromString<List<String>>(it) shouldBe kartleggingSvarDto.svarIder }

        TestContainerHelper.postgresContainer
            .hentEnkelKolonne<String>(
                "select endret from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'",
            ) shouldBe null

        val nyeSvarIder = listOf(kartleggingDto.svarAlternativerTilEtFlervalgSpørsmål().first())
        sendKartleggingSvarTilKafka(
            kartleggingId = kartleggingSvarDto.spørreundersøkelseId,
            spørsmålId = kartleggingSvarDto.spørsmålId,
            sesjonId = kartleggingSvarDto.sesjonId,
            svarIder = nyeSvarIder,
        )

        val oppdaterteSvarIderEtterNyttSvar = TestContainerHelper.postgresContainer
            .hentEnkelKolonne<PGobject>(
                "select svar_ider from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'",
            )
        oppdaterteSvarIderEtterNyttSvar.value shouldNotBe null
        oppdaterteSvarIderEtterNyttSvar.value?.let { Json.decodeFromString<List<String>>(it) shouldBe nyeSvarIder }

        TestContainerHelper.postgresContainer
            .hentEnkelKolonne<String>(
                "select endret from ia_sak_kartlegging_svar where kartlegging_id = '${kartleggingSvarDto.spørreundersøkelseId}'",
            ) shouldNotBe null
    }

    @Test
    fun `svar skal overskrives i DB ved nytt svar mottatt på Kafka topic`() {
        val sak = SakHelper.nySakIKartleggesMedEtSamarbeid()
        val spørreundersøkelse = sak.opprettSpørreundersøkelse()
        val førsteSvarId = spørreundersøkelse.temaer.first().spørsmålOgSvaralternativer.first().svaralternativer.first().svarId
        val andreSvarId = spørreundersøkelse.temaer.first().spørsmålOgSvaralternativer.first().svaralternativer.first().svarId
        spørreundersøkelse.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)
        val spørreundersøkelseSvarDto = spørreundersøkelse.sendKartleggingSvarTilKafka(svarIder = listOf(førsteSvarId))

        val lagredeSvarIder = TestContainerHelper.postgresContainer
            .hentEnkelKolonne<PGobject>(
                "select svar_ider from ia_sak_kartlegging_svar where kartlegging_id = '${spørreundersøkelseSvarDto.spørreundersøkelseId}'",
            )
        lagredeSvarIder.value shouldNotBe null
        lagredeSvarIder.value?.let { Json.decodeFromString<List<String>>(it) shouldBe spørreundersøkelseSvarDto.svarIder }

        TestContainerHelper.postgresContainer
            .hentEnkelKolonne<String>(
                "select endret from ia_sak_kartlegging_svar where kartlegging_id = '${spørreundersøkelseSvarDto.spørreundersøkelseId}'",
            ) shouldBe null

        val nyeSvarIder = listOf(andreSvarId)

        sendKartleggingSvarTilKafka(
            kartleggingId = spørreundersøkelseSvarDto.spørreundersøkelseId,
            spørsmålId = spørreundersøkelseSvarDto.spørsmålId,
            sesjonId = spørreundersøkelseSvarDto.sesjonId,
            svarIder = nyeSvarIder,
        )

        val oppdaterteSvarIderEtterNyttSvar = TestContainerHelper.postgresContainer
            .hentEnkelKolonne<PGobject>(
                "select svar_ider from ia_sak_kartlegging_svar where kartlegging_id = '${spørreundersøkelseSvarDto.spørreundersøkelseId}'",
            )
        oppdaterteSvarIderEtterNyttSvar.value shouldNotBe null
        oppdaterteSvarIderEtterNyttSvar.value?.let { Json.decodeFromString<List<String>>(it) shouldBe nyeSvarIder }

        TestContainerHelper.postgresContainer
            .hentEnkelKolonne<String>(
                "select endret from ia_sak_kartlegging_svar where kartlegging_id = '${spørreundersøkelseSvarDto.spørreundersøkelseId}'",
            ) shouldNotBe null
    }

    @Test
    fun `skal få oppdatert antall som har svart på et spørsmål i en kartlegging`() {
        val sak = SakHelper.nySakIKartleggesMedEtSamarbeid()
        val spørreundersøkelse = sak.opprettSpørreundersøkelse()
        spørreundersøkelse.start(orgnummer = sak.orgnr, saksnummer = sak.saksnummer)

        runBlocking {
            TestContainerHelper.kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = spørreundersøkelse.id,
                konsument = kartleggingKonsument,
            ) {
                it.forExactlyOne { melding ->
                    val spørreundersøkelse =
                        Json.decodeFromString<SerializableSpørreundersøkelse>(melding)
                    spørreundersøkelse.status shouldBe PÅBEGYNT
                }
            }
        }

        val spørsmålId = spørreundersøkelse.temaer.first().spørsmålOgSvaralternativer.first().id
        spørreundersøkelse.sendKartleggingSvarTilKafka(
            spørsmålId = spørsmålId,
        )

        runBlocking {
            TestContainerHelper.kafkaContainerHelper.ventOgKonsumerKafkaMeldinger(
                key = Json.encodeToString(
                    SpørreundersøkelseOppdateringNøkkel(
                        spørreundersøkelse.id,
                        ANTALL_SVAR,
                    ),
                ),
                konsument = spørreundersøkelseOppdateringKonsument,
            ) {
                it.forExactlyOne { melding ->
                    val antallSvarForSpørsmål =
                        Json.decodeFromString<SpørreundersøkelseAntallSvarDto>(
                            melding,
                        )
                    antallSvarForSpørsmål.spørreundersøkelseId shouldBe spørreundersøkelse.id
                    antallSvarForSpørsmål.spørsmålId shouldBe spørsmålId
                    antallSvarForSpørsmål.antallSvar shouldBe 1
                }
            }
        }
    }
}
