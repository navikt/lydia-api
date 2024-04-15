package no.nav.lydia.helper

import com.github.kittinunf.fuel.core.Request
import com.github.kittinunf.fuel.core.ResponseResultOf
import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.core.extensions.jsonBody
import com.github.kittinunf.fuel.httpDelete
import com.github.kittinunf.fuel.httpGet
import com.github.kittinunf.fuel.httpPost
import com.github.kittinunf.fuel.httpPut
import com.github.kittinunf.fuel.serialization.responseObject
import ia.felles.definisjoner.bransjer.Bransjer
import io.kotest.matchers.collections.shouldHaveSize
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldContain
import io.kotest.matchers.string.shouldNotContain
import kotlinx.datetime.LocalDate
import kotlinx.datetime.toKotlinLocalDate
import kotlinx.serialization.InternalSerializationApi
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import kotlinx.serialization.serializer
import no.nav.lydia.Topic
import no.nav.lydia.container.ia.sak.kartlegging.IASakKartleggingApiTest.Companion.ID_TIL_SPØRSMÅL_MED_FLERVALG_MULIGHETER
import no.nav.lydia.helper.TestContainerHelper.Companion.kafkaContainerHelper
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.performDelete
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestContainerHelper.Companion.performPut
import no.nav.lydia.helper.TestData.Companion.lagPerioder
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.IASakLeveranseDto
import no.nav.lydia.ia.sak.api.IASakLeveranseOppdateringsDto
import no.nav.lydia.ia.sak.api.IASakLeveranseOpprettelsesDto
import no.nav.lydia.ia.sak.api.IASakLeveranserPerTjenesteDto
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import no.nav.lydia.ia.sak.api.IATjenesteDto
import no.nav.lydia.ia.sak.api.IA_MODULER_PATH
import no.nav.lydia.ia.sak.api.IA_SAK_LEVERANSE_PATH
import no.nav.lydia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.api.IA_TJENESTER_PATH
import no.nav.lydia.ia.sak.api.ModulDto
import no.nav.lydia.ia.sak.api.SAK_HENDELSE_SUB_PATH
import no.nav.lydia.ia.sak.api.SAMARBEIDSHISTORIKK_PATH
import no.nav.lydia.ia.sak.api.SakshistorikkDto
import no.nav.lydia.ia.sak.api.kartlegging.IASakKartleggingDto
import no.nav.lydia.ia.sak.api.kartlegging.IASakKartleggingOversiktDto
import no.nav.lydia.ia.sak.api.kartlegging.KARTLEGGING_BASE_ROUTE
import no.nav.lydia.ia.sak.api.kartlegging.KartleggingOversiktMedAntallSvarDto
import no.nav.lydia.ia.sak.domene.IAProsessStatus
import no.nav.lydia.ia.sak.domene.IASakLeveranseStatus
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.IASakshendelseType.FULLFØR_BISTAND
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_ER_IKKE_AKTUELL
import no.nav.lydia.ia.sak.domene.spørreundersøkelse.Temanavn
import no.nav.lydia.ia.årsak.domene.BegrunnelseType.VIRKSOMHETEN_ØNSKER_IKKE_SAMARBEID
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.ÅrsakType.VIRKSOMHETEN_TAKKET_NEI
import no.nav.lydia.iatjenesteoversikt.IATjenesteoversiktDto
import no.nav.lydia.iatjenesteoversikt.api.IATJENESTEOVERSIKT_PATH
import no.nav.lydia.iatjenesteoversikt.api.MINE_IATJENESTER_PATH
import no.nav.lydia.integrasjoner.kartlegging.HendelsType
import no.nav.lydia.integrasjoner.kartlegging.KartleggingMedSvar
import no.nav.lydia.integrasjoner.kartlegging.SpørreundersøkelseHendeleseNøkkel
import no.nav.lydia.integrasjoner.kartlegging.SpørreundersøkelseSvarDto
import no.nav.lydia.integrasjoner.ssb.NæringsDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsRepository
import no.nav.lydia.statusoversikt.StatusoversiktResponsDto
import no.nav.lydia.statusoversikt.api.STATUSOVERSIKT_PATH
import no.nav.lydia.sykefraværsstatistikk.LANDKODE_NO
import no.nav.lydia.sykefraværsstatistikk.Publiseringsinfo
import no.nav.lydia.sykefraværsstatistikk.api.ANTALL_TREFF
import no.nav.lydia.sykefraværsstatistikk.api.FILTERVERDIER_PATH
import no.nav.lydia.sykefraværsstatistikk.api.FilterverdierDto
import no.nav.lydia.sykefraværsstatistikk.api.HISTORISK_STATISTIKK
import no.nav.lydia.sykefraværsstatistikk.api.PUBLISERINGSINFO
import no.nav.lydia.sykefraværsstatistikk.api.SISTE_4_KVARTALER
import no.nav.lydia.sykefraværsstatistikk.api.SISTE_TILGJENGELIGE_KVARTAL
import no.nav.lydia.sykefraværsstatistikk.api.SYKEFRAVÆRSSTATISTIKK_PATH
import no.nav.lydia.sykefraværsstatistikk.api.Søkeparametere
import no.nav.lydia.sykefraværsstatistikk.api.Søkeparametere.Companion.VIRKSOMHETER_PER_SIDE
import no.nav.lydia.sykefraværsstatistikk.api.VirksomhetsoversiktDto
import no.nav.lydia.sykefraværsstatistikk.api.VirksomhetsoversiktResponsDto
import no.nav.lydia.sykefraværsstatistikk.api.VirksomhetsstatistikkSiste4KvartalDto
import no.nav.lydia.sykefraværsstatistikk.domene.HistoriskStatistikk
import no.nav.lydia.sykefraværsstatistikk.domene.VirksomhetsstatistikkSisteKvartal
import no.nav.lydia.sykefraværsstatistikk.import.Kategori
import no.nav.lydia.virksomhet.domene.Sektor
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.testcontainers.containers.GenericContainer
import org.testcontainers.containers.Network
import org.testcontainers.containers.output.Slf4jLogConsumer
import org.testcontainers.containers.wait.strategy.HttpWaitStrategy
import org.testcontainers.images.builder.ImageFromDockerfile
import java.util.*
import kotlin.io.path.Path
import kotlin.test.fail

class TestContainerHelper {
    companion object {
        private const val ANTALL_NÆRINGS_PERIODER = 10
        private const val ANTALL_BRANSJE_PERIODER = 11
        private const val ANTALL_SEKTOR_PERIODER = 9
        private const val ANTALL_TEST_VIRKSOMHETER = 150

        private var log: Logger = LoggerFactory.getLogger(this::class.java)

        private val network = Network.newNetwork()

        val oauth2ServerContainer = AuthContainerHelper(network = network, log = log)

        val kafkaContainerHelper = KafkaContainerHelper(network = network, log = log)

        val postgresContainer = PostgrestContainerHelper(network = network, log = log)

        private val wiremockServer = WiremockContainerHelper()

        val lydiaApiContainer: GenericContainer<*> =
                GenericContainer(ImageFromDockerfile().withDockerfile(Path("./Dockerfile")))
                        .dependsOn(
                                kafkaContainerHelper.kafkaContainer,
                                postgresContainer.postgresContainer,
                                oauth2ServerContainer.mockOath2Server
                        )
                        .withLogConsumer(Slf4jLogConsumer(log).withPrefix("lydiaApiContainer").withSeparateOutputStreams())
                        .withNetwork(network)
                        .withExposedPorts(8080)
                        .withCreateContainerCmdModifier { cmd -> cmd.withName("lydia-${System.currentTimeMillis()}") }
                        .withEnv(
                                postgresContainer.envVars()
                                        .plus(oauth2ServerContainer.envVars())
                                        .plus(wiremockServer.envVars())
                                        .plus(
                                                kafkaContainerHelper.envVars()
                                                        .plus(
                                                                mapOf(
                                                                        "CONSUMER_LOOP_DELAY" to "1",
                                                                        "NAIS_CLUSTER_NAME" to "lokal",
                                                                )
                                                        )
                                        )
                        )
                        .waitingFor(HttpWaitStrategy().forPath("/internal/isready")).apply {
                            start()
                        }

        private val dataSource = postgresContainer.nyDataSource()
        private val næringsRepository = NæringsRepository(dataSource = dataSource)

        init {
            // -- generer testdata for land
            kafkaContainerHelper.sendSykefraværsstatistikkPerKategoriIBulkOgVentTilKonsumert(
                TestData.gjeldendePeriode.lagPerioder(20).map { periode ->
                    lagSykefraværsstatistikkPerKategoriImportDto(
                            kategori = Kategori.LAND,
                            kode = LANDKODE_NO,
                            periode = periode,
                            sykefraværsProsent = (4..7).random().toDouble(),
                            antallPersoner = 1000,
                            muligeDagsverk = 250_000.0,
                            tapteDagsverk = 12_500.0,
                    )
                },
                topic = Topic.STATISTIKK_LAND_TOPIC
            )

            // -- Last inn alle næringer
            NæringsDownloader(url = "", næringsRepository = næringsRepository).lastInnNæringerFraFil()

            // -- generer statistikk for næringer
            kafkaContainerHelper.sendSykefraværsstatistikkPerKategoriIBulkOgVentTilKonsumert(
                importDtoer = næringsRepository.hentNæringer().flatMap { næring ->
                    TestData.gjeldendePeriode.lagPerioder(ANTALL_NÆRINGS_PERIODER).map { periode ->
                        lagSykefraværsstatistikkPerKategoriImportDto(
                                kategori = Kategori.NÆRING,
                                kode = næring.kode,
                                periode = periode,
                                sykefraværsProsent = 5.0,
                                antallPersoner = 1000,
                                muligeDagsverk = 250_000.0,
                                tapteDagsverk = 12_500.0,
                        )
                    }
                },
                topic = Topic.STATISTIKK_NARING_TOPIC
            )
            // -- generer statistikk for bransjer
            kafkaContainerHelper.sendSykefraværsstatistikkPerKategoriIBulkOgVentTilKonsumert(
                importDtoer = Bransjer.entries.flatMap { bransje ->
                    TestData.gjeldendePeriode.lagPerioder(ANTALL_BRANSJE_PERIODER).map { periode ->
                        lagSykefraværsstatistikkPerKategoriImportDto(
                                kategori = Kategori.BRANSJE,
                                kode = bransje.name,
                                periode = periode,
                                sykefraværsProsent = 6.0,
                                antallPersoner = 100000,
                                muligeDagsverk = 250_000.0,
                                tapteDagsverk = 15_000.0,
                        )
                    }
                },
                topic = Topic.STATISTIKK_BRANSJE_TOPIC
            )
            // -- generer statistikk for sektorer
            kafkaContainerHelper.sendSykefraværsstatistikkPerKategoriIBulkOgVentTilKonsumert(
                importDtoer = Sektor.entries.flatMap { sektor ->
                    TestData.gjeldendePeriode.lagPerioder(ANTALL_SEKTOR_PERIODER).map { periode ->
                        lagSykefraværsstatistikkPerKategoriImportDto(
                                kategori = Kategori.SEKTOR,
                                kode = sektor.kode,
                                periode = periode,
                                sykefraværsProsent = 4.9,
                                antallPersoner = 100000,
                                muligeDagsverk = 250_000.0,
                                tapteDagsverk = 12_250.0,
                        )
                    }
                },
                topic = Topic.STATISTIKK_SEKTOR_TOPIC
            )

            // -- laster inn standard virksomheter (med statistikk)
            VirksomhetHelper.lastInnStandardTestdata(ANTALL_TEST_VIRKSOMHETER)
        }

        private fun GenericContainer<*>.buildUrl(url: String) = "http://${this.host}:${this.getMappedPort(8080)}/$url"
        fun GenericContainer<*>.performGet(url: String) = buildUrl(url = url).httpGet()
        fun GenericContainer<*>.performPost(url: String) = buildUrl(url = url).httpPost()
        fun GenericContainer<*>.performDelete(url: String) = buildUrl(url = url).httpDelete()
        fun GenericContainer<*>.performPut(url: String) = buildUrl(url = url).httpPut()

        infix fun GenericContainer<*>.shouldContainLog(regex: Regex) = logs shouldContain regex
        infix fun GenericContainer<*>.shouldNotContainLog(regex: Regex) = logs shouldNotContain regex
    }
}

class SakHelper {

    companion object {
        fun hentSaker(orgnummer: String, token: String = oauth2ServerContainer.saksbehandler1.token) =
                hentSakerRespons(orgnummer = orgnummer, token = token).third.fold(
                        success = { respons -> respons },
                        failure = {
                            fail(it.stackTraceToString())
                        })

        fun hentSakerRespons(
                orgnummer: String,
                token: String = oauth2ServerContainer.saksbehandler1.token,
        ) =
                lydiaApiContainer.performGet("$IA_SAK_RADGIVER_PATH/$orgnummer")
                        .authentication().bearer(token = token)
                        .tilListeRespons<IASakDto>()

        fun hentAktivSak(orgnummer: String, token: String = oauth2ServerContainer.saksbehandler1.token): IASakDto {
            val triple = hentAktivSakRespons(orgnummer = orgnummer, token = token)

            if (triple.statuskode() == 200) {
                return triple.third.get()
            } else if (triple.statuskode() == 204) {
                fail("Ingen aktive saker funnet")
            } else {
                fail(triple.third.toString())
            }
        }

        fun hentAktivSakRespons(
                orgnummer: String,
                token: String = oauth2ServerContainer.saksbehandler1.token,
        ) =
                lydiaApiContainer.performGet("$IA_SAK_RADGIVER_PATH/$orgnummer/aktiv")
                        .authentication().bearer(token = token)
                        .responseObject(IASakDto.serializer())

        fun hentIASakLeveranser(
                orgnr: String,
                saksnummer: String,
                token: String = oauth2ServerContainer.saksbehandler1.token) =
                lydiaApiContainer.performGet("$IA_SAK_RADGIVER_PATH/$IA_SAK_LEVERANSE_PATH/$orgnr/$saksnummer")
                        .authentication().bearer(token = token)
                        .tilListeRespons<IASakLeveranserPerTjenesteDto>().third.fold(
                                success = { respons -> respons },
                                failure = {
                                    fail(it.stackTraceToString())
                                })

        fun hentIATjenester(token: String = oauth2ServerContainer.saksbehandler1.token) =
                lydiaApiContainer.performGet("$IA_SAK_RADGIVER_PATH/$IA_SAK_LEVERANSE_PATH/$IA_TJENESTER_PATH")
                        .authentication().bearer(token = token)
                        .tilListeRespons<IATjenesteDto>().third.fold(
                                success = { respons -> respons },
                                failure = {
                                    fail(it.stackTraceToString())
                                })

        fun hentModuler(token: String = oauth2ServerContainer.saksbehandler1.token) =
                lydiaApiContainer.performGet("$IA_SAK_RADGIVER_PATH/$IA_SAK_LEVERANSE_PATH/$IA_MODULER_PATH")
                        .authentication().bearer(token = token)
                        .tilListeRespons<ModulDto>().third.fold(
                                success = { respons -> respons },
                                failure = {
                                    fail(it.stackTraceToString())
                                })

        fun hentSamarbeidshistorikk(
                orgnummer: String,
                token: String = oauth2ServerContainer.saksbehandler1.token,
        ) =
                hentSamarbeidshistorikkRespons(orgnummer, token).third.fold(
                        success = { respons -> respons },
                        failure = { fail(it.stackTraceToString()) }
                )

        fun hentSamarbeidshistorikkRespons(
                orgnummer: String,
                token: String = oauth2ServerContainer.saksbehandler1.token,
        ) =
                lydiaApiContainer.performGet("$IA_SAK_RADGIVER_PATH/$SAMARBEIDSHISTORIKK_PATH/$orgnummer")
                        .authentication().bearer(token = token)
                        .tilListeRespons<SakshistorikkDto>()


        fun hentSamarbeidshistorikkForOrgnrRespons(
                orgnr: String,
                token: String = oauth2ServerContainer.saksbehandler1.token,
        ) =
                lydiaApiContainer.performGet("$IA_SAK_RADGIVER_PATH/$SAMARBEIDSHISTORIKK_PATH/$orgnr")
                        .authentication().bearer(token = token)
                        .tilListeRespons<SakshistorikkDto>()

        fun opprettSakForVirksomhetRespons(
                orgnummer: String,
                token: String,
        ) = lydiaApiContainer.performPost("$IA_SAK_RADGIVER_PATH/$orgnummer")
                .authentication().bearer(token = token)
                .tilSingelRespons<IASakDto>()

        fun opprettSakForVirksomhet(
                orgnummer: String,
                token: String = oauth2ServerContainer.superbruker1.token,
        ): IASakDto = opprettSakForVirksomhetRespons(orgnummer = orgnummer, token = token).third.fold(
                success = { respons -> respons },
                failure = { fail(it.message) }
        )

        fun nySakIKartlegges(
            orgnummer: String = VirksomhetHelper.nyttOrgnummer(),
            token: String = oauth2ServerContainer.saksbehandler1.token,
        ) = opprettSakForVirksomhet(orgnummer)
            .nyHendelse(IASakshendelseType.TA_EIERSKAP_I_SAK, token = token)
            .nyHendelse(IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES)
            .nyHendelse(IASakshendelseType.VIRKSOMHET_KARTLEGGES)
            .also {
                it.status shouldBe IAProsessStatus.KARTLEGGES
            }

        fun nySakIViBistår(
                orgnummer: String = VirksomhetHelper.nyttOrgnummer(),
                token: String = oauth2ServerContainer.saksbehandler1.token,
        ) = opprettSakForVirksomhet(orgnummer)
                .nyHendelse(IASakshendelseType.TA_EIERSKAP_I_SAK, token = token)
                .nyHendelse(IASakshendelseType.VIRKSOMHET_SKAL_KONTAKTES)
                .nyHendelse(IASakshendelseType.VIRKSOMHET_KARTLEGGES)
                .nyHendelse(IASakshendelseType.VIRKSOMHET_SKAL_BISTÅS)
                .also {
                    it.status shouldBe IAProsessStatus.VI_BISTÅR
                }

        fun nyHendelse(
                sakshendelse: IASakshendelseDto,
                token: String = oauth2ServerContainer.saksbehandler1.token,
        ) =
                lydiaApiContainer.performPost("$IA_SAK_RADGIVER_PATH/$SAK_HENDELSE_SUB_PATH")
                        .authentication().bearer(token)
                        .jsonBody(Json.encodeToString(sakshendelse))
                        .tilSingelRespons<IASakDto>().third.fold(
                                success = { respons -> respons },
                                failure = {
                                    fail(it.message)
                                })

        fun nyHendelsePåSakMedRespons(
                sak: IASakDto,
                hendelsestype: IASakshendelseType,
                token: String = oauth2ServerContainer.saksbehandler1.token,
                payload: String? = null,
        ): ResponseResultOf<IASakDto> {
            val request = nyHendelsePåSakRequest(token, sak, hendelsestype, payload)
            return request.tilSingelRespons()
        }

        private fun nyHendelsePåSakRequest(
                token: String,
                sak: IASakDto,
                hendelsestype: IASakshendelseType,
                payload: String?,
        ): Request {
            return lydiaApiContainer.performPost("$IA_SAK_RADGIVER_PATH/$SAK_HENDELSE_SUB_PATH")
                    .authentication().bearer(token)
                    .jsonBody(
                            Json.encodeToString(
                                    IASakshendelseDto(
                                            orgnummer = sak.orgnr,
                                            saksnummer = sak.saksnummer,
                                            hendelsesType = hendelsestype,
                                            endretAvHendelseId = sak.endretAvHendelseId,
                                            payload = payload
                                    )
                            )
                    )
        }

        fun oppdaterIASakLeveranse(
                orgnr: String,
                saksnummer: String,
                iaSakLeveranseId: Int,
                status: IASakLeveranseStatus,
                token: String = oauth2ServerContainer.saksbehandler1.token
        ) = lydiaApiContainer.performPut("$IA_SAK_RADGIVER_PATH/$IA_SAK_LEVERANSE_PATH/$orgnr/$saksnummer/$iaSakLeveranseId")
                .authentication().bearer(token)
                .jsonBody(Json.encodeToString(
                        IASakLeveranseOppdateringsDto(
                                status = status
                        )
                ))

        fun IASakLeveranseDto.oppdaterIASakLeveranse(
                orgnr: String,
                status: IASakLeveranseStatus,
                token: String = oauth2ServerContainer.saksbehandler1.token
        ) = oppdaterIASakLeveranse(
                orgnr = orgnr,
                saksnummer = saksnummer,
                iaSakLeveranseId = id,
                status = status,
                token = token,
        ).tilSingelRespons<IASakLeveranseDto>().third.fold(
                success = { it },
                failure = {
                    fail("${it.message} ${it.response.body().asString("text/plain")}")
                })

        fun slettIASakLeveranse(
                orgnr: String,
                saksnummer: String,
                iaSakLeveranseId: Int,
                token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
                lydiaApiContainer.performDelete("$IA_SAK_RADGIVER_PATH/$IA_SAK_LEVERANSE_PATH/$orgnr/$saksnummer/$iaSakLeveranseId")
                        .authentication().bearer(token)

        fun IASakLeveranseDto.slettIASakLeveranse(
                orgnr: String,
                token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
                slettIASakLeveranse(orgnr = orgnr, saksnummer = saksnummer, iaSakLeveranseId = id, token = token).tilSingelRespons<Int>().third.fold(
                        success = { it },
                        failure = {
                            fail("${it.message} ${it.response.body().asString("text/plain")}")
                        })

        fun IASakDto.opprettIASakLeveranse(
                frist: LocalDate = java.time.LocalDate.now().toKotlinLocalDate(),
                modulId: Int,
                token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
                opprettIASakLeveranse(
                        orgnr = orgnr,
                        saksnummer = saksnummer,
                        frist = frist,
                        modulId = modulId,
                        token = token
                ).tilSingelRespons<IASakLeveranseDto>().third.fold(
                        success = { it },
                        failure = {
                            fail("${it.message} ${it.response.body().asString("text/plain")}")
                        })

        fun opprettIASakLeveranse(
                orgnr: String,
                saksnummer: String,
                frist: LocalDate,
                modulId: Int,
                token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
                lydiaApiContainer.performPost("$IA_SAK_RADGIVER_PATH/$IA_SAK_LEVERANSE_PATH/$orgnr/$saksnummer")
                        .authentication().bearer(token)
                        .jsonBody(
                                Json.encodeToString(
                                        IASakLeveranseOpprettelsesDto(
                                                saksnummer = saksnummer,
                                                modulId = modulId,
                                                frist = frist
                                        ))
                        )


        fun nyHendelsePåSak(
                sak: IASakDto,
                hendelsestype: IASakshendelseType,
                token: String = oauth2ServerContainer.saksbehandler1.token,
                payload: String? = null,
        ) =
                nyHendelsePåSakMedRespons(sak = sak, hendelsestype = hendelsestype, payload = payload, token = token)
                        .third.fold(success = { respons -> respons }, failure = {
                            fail("${it.message} ${it.response.body().asString(null)}")
                        })

        fun IASakDto.slettSak(token: String = oauth2ServerContainer.superbruker1.token) =
                nyHendelsePåSak(sak = this, hendelsestype = IASakshendelseType.SLETT_SAK, token = token)

        fun IASakDto.nyHendelse(
                hendelsestype: IASakshendelseType,
                token: String = oauth2ServerContainer.saksbehandler1.token,
                payload: String? = null,
        ) =
                nyHendelsePåSak(sak = this, hendelsestype = hendelsestype, payload = payload, token = token)

        fun IASakDto.nyHendelseRespons(
                hendelsestype: IASakshendelseType,
                token: String = oauth2ServerContainer.saksbehandler1.token,
                payload: String? = null,
        ) =
                nyHendelsePåSakMedRespons(sak = this, hendelsestype = hendelsestype, payload = payload, token = token)

        fun IASakDto.nyIkkeAktuellHendelse(
                token: String = oauth2ServerContainer.saksbehandler1.token,
        ) = this.nyHendelse(
                hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL,
                token = token,
                payload = ValgtÅrsak(
                        type = VIRKSOMHETEN_TAKKET_NEI,
                        begrunnelser = listOf(VIRKSOMHETEN_ØNSKER_IKKE_SAMARBEID)).toJson()
        )

        fun IASakDto.oppdaterHendelsesTidspunkter(
                antallDagerTilbake: Long,
                token: String = oauth2ServerContainer.saksbehandler1.token,
        ): IASakDto {
            TestContainerHelper.postgresContainer.performUpdate(
                    """
                    update ia_sak_hendelse 
                        set opprettet=(opprettet - interval '$antallDagerTilbake' day)
                        where saksnummer='${this.saksnummer}';
                """.trimIndent())
            TestContainerHelper.postgresContainer.performUpdate(
                    """
                    update ia_sak 
                        set endret=(opprettet - interval '$antallDagerTilbake' day)
                        where saksnummer='${this.saksnummer}';
                """.trimIndent())
            return requireNotNull(hentSaker(this.orgnr, token = token).find { it.saksnummer == this.saksnummer })
        }

        fun IASakDto.oppdaterHendelsespunkterTilDato(dato : java.time.LocalDate) : IASakDto {
            val dagerSomSkalTrekkesFra = java.time.LocalDate.now().toEpochDay() - dato.toEpochDay()
            return this.oppdaterHendelsesTidspunkter(antallDagerTilbake = dagerSomSkalTrekkesFra)
        }

        fun IASakDto.leggTilLeveranseOgFullførSak(modulId: Int = TestData.AKTIV_MODUL.id, token: String = oauth2ServerContainer.saksbehandler1.token): IASakDto {
            val leveranse = this.opprettIASakLeveranse(modulId = modulId)
            leveranse.oppdaterIASakLeveranse(this.orgnr, IASakLeveranseStatus.LEVERT)
            return nyHendelse(FULLFØR_BISTAND, token)
        }

        fun ValgtÅrsak.toJson() = Json.encodeToString(value = this)
    }
}

class IASakKartleggingHelper {
    companion object {
        fun opprettIASakKartlegging(
            orgnr: String,
            saksnummer: String,
            temaer: List<Temanavn> = listOf(Temanavn.UTVIKLE_PARTSSAMARBEID),
            token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
            lydiaApiContainer.performPost("$KARTLEGGING_BASE_ROUTE/$orgnr/$saksnummer/opprett")
                .jsonBody(Json.encodeToString(temaer))
                .authentication().bearer(token)

        fun hentIASakKartlegginger(
            orgnr: String,
            saksnummer: String,
            token: String = oauth2ServerContainer.saksbehandler1.token,
        ) =
            lydiaApiContainer.performGet("$KARTLEGGING_BASE_ROUTE/$orgnr/$saksnummer")
                .authentication().bearer(token)
                .tilListeRespons<IASakKartleggingOversiktDto>().third.fold(
                    success = { it },
                    failure = { fail(it.message) }
                )

        fun IASakDto.opprettKartlegging(
            temaer: List<Temanavn> = listOf(Temanavn.UTVIKLE_PARTSSAMARBEID, Temanavn.REDUSERE_SYKEFRAVÆR),
            token: String = oauth2ServerContainer.saksbehandler1.token
        ) = opprettIASakKartlegging(
            orgnr = orgnr,
            saksnummer = saksnummer,
            temaer = temaer,
            token = token,
        ).tilSingelRespons<IASakKartleggingDto>().third.fold(
            success = { respons -> respons },
            failure = { fail(it.message) }
        )

        fun IASakKartleggingDto.start(
            token: String = oauth2ServerContainer.saksbehandler1.token,
            orgnummer: String,
            saksnummer: String
        ) =
            lydiaApiContainer.performPost("$KARTLEGGING_BASE_ROUTE/$orgnummer/$saksnummer/$kartleggingId/start")
                .authentication().bearer(token)
                .tilSingelRespons<IASakKartleggingDto>().third.fold(
                    success = { it },
                    failure = { fail(it.message) }
                )

        fun IASakKartleggingDto.avslutt(
            token: String = oauth2ServerContainer.saksbehandler1.token,
            orgnummer: String,
            saksnummer: String
        ) =
            lydiaApiContainer.performPost("$KARTLEGGING_BASE_ROUTE/$orgnummer/$saksnummer/$kartleggingId/avslutt")
                .authentication().bearer(token)
                .tilSingelRespons<IASakKartleggingDto>().third.fold(
                    success = { it },
                    failure = { fail(it.message) }
                )

        fun IASakKartleggingDto.svarAlternativerTilEtFlervalgSpørsmål(): List<String> =
            this.svarAlternativerTilEtSpørsmål(ID_TIL_SPØRSMÅL_MED_FLERVALG_MULIGHETER).map { it.svarId }

        fun IASakKartleggingDto.svarAlternativerTilEtSpørsmål(spørsmålId: String) =
            this.temaMedSpørsmålOgSvaralternativer.map { tema ->
                tema.spørsmålOgSvaralternativer.firstOrNull { it.id == spørsmålId }
            }.first()!!.svaralternativer

        fun IASakKartleggingDto.sendKartleggingFlervalgSvarTilKafka(
            sesjonId: String = UUID.randomUUID().toString(),
            svarIder: List<String> = this.svarAlternativerTilEtFlervalgSpørsmål(),
        ) = sendKartleggingSvarTilKafka(
                kartleggingId = kartleggingId,
                spørsmålId = ID_TIL_SPØRSMÅL_MED_FLERVALG_MULIGHETER,
                sesjonId = sesjonId,
                svarIder = svarIder
        )

        fun IASakKartleggingDto.sendKartleggingSvarTilKafka(
	        spørsmålId: String = temaMedSpørsmålOgSvaralternativer.first().spørsmålOgSvaralternativer.first().id,
	        sesjonId: String = UUID.randomUUID().toString(),
            svarIder: List<String> = listOf(temaMedSpørsmålOgSvaralternativer.first().spørsmålOgSvaralternativer.first().svaralternativer.first().svarId)
        ) = sendKartleggingSvarTilKafka(
            kartleggingId = kartleggingId,
            spørsmålId = spørsmålId,
            sesjonId = sesjonId,
            svarIder = svarIder
        )

        fun IASakKartleggingDto.stengTema(
            temaId: Int
        ) {
            temaMedSpørsmålOgSvaralternativer.filter { it.temaId == temaId } shouldHaveSize 1
            kafkaContainerHelper.sendOgVentTilKonsumert(
                nøkkel = Json.encodeToString(SpørreundersøkelseHendeleseNøkkel(this.kartleggingId, HendelsType.STENG_TEMA)),
                melding = Json.encodeToString(temaId),
                topic = Topic.SPORREUNDERSOKELSE_HENDELSE_TOPIC
            )
        }

        fun sendKartleggingSvarTilKafka(
            kartleggingId: String = UUID.randomUUID().toString(),
            spørsmålId: String = UUID.randomUUID().toString(),
            sesjonId: String = UUID.randomUUID().toString(),
            svarIder: List<String> = listOf(UUID.randomUUID().toString(), UUID.randomUUID().toString()),
        ): SpørreundersøkelseSvarDto {

            val spørreundersøkelseSvarDto = SpørreundersøkelseSvarDto(
                spørreundersøkelseId = kartleggingId,
                spørsmålId = spørsmålId,
                sesjonId = sesjonId,
                svarIder = svarIder
            )
            kafkaContainerHelper.sendOgVentTilKonsumert(
                nøkkel = "${sesjonId}_${spørsmålId}",
                melding = Json.encodeToString(
                    spørreundersøkelseSvarDto
                ),
                topic = Topic.SPORREUNDERSOKELSE_SVAR_TOPIC
            )
            return spørreundersøkelseSvarDto
        }

        fun hentKartleggingMedDetaljer(
            token: String = oauth2ServerContainer.saksbehandler1.token,
            orgnr: String,
            saksnummer: String,
            kartleggingId: String
        ) =
            lydiaApiContainer.performGet("$KARTLEGGING_BASE_ROUTE/$orgnr/$saksnummer/$kartleggingId")
                .authentication().bearer(token)
                .tilSingelRespons<KartleggingMedSvar>().third.fold(
                    success = { respons -> respons },
                    failure = { fail(it.message) }
                )

        fun hentKartleggingOversiktMedAntallSvar(
            token: String = oauth2ServerContainer.saksbehandler1.token,
            orgnr: String,
            saksnummer: String,
            kartleggingId: String
        ) =
            lydiaApiContainer.performGet("$KARTLEGGING_BASE_ROUTE/$orgnr/$saksnummer/$kartleggingId/oversikt")
                .authentication().bearer(token)
                .tilSingelRespons<KartleggingOversiktMedAntallSvarDto>().third.fold(
                    success = { respons -> respons },
                    failure = { fail(it.message) }
                )
    }
}

class IATjenesteoversiktHelper {
    companion object {
        fun hentMineIATjenester(
           token: String = oauth2ServerContainer.saksbehandler1.token,
        ) =
            lydiaApiContainer.performGet("$IATJENESTEOVERSIKT_PATH/$MINE_IATJENESTER_PATH")
                .authentication().bearer(token)
                .tilListeRespons<IATjenesteoversiktDto>()

    }
}

class LeveranseHelper {
    companion object {
        fun hentIATjenesterFraDatabase() =
            TestContainerHelper.postgresContainer.hentAlleRaderTilEnkelKolonne<String>("select navn from ia_tjeneste")

        fun leggTilModul(modul: ModulDto) =
            TestContainerHelper.postgresContainer.performUpdate(
                """
                insert into modul (id, ia_tjeneste, navn, deaktivert) values (
                    ${modul.id},
                    ${modul.iaTjeneste},
                    '${modul.navn}',
                    ${modul.deaktivert}
                )
            """.trimIndent()
            )

        fun leggTilIATjeneste(iaTjeneste: IATjenesteDto) =
            TestContainerHelper.postgresContainer.performUpdate(
                """
                insert into ia_tjeneste (id, navn, deaktivert) values (
                    ${iaTjeneste.id},
                    '${iaTjeneste.navn}',
                    ${iaTjeneste.deaktivert}
                )
            """.trimIndent()
            )

        fun deaktiverModul(modul: ModulDto) =
            TestContainerHelper.postgresContainer.performUpdate("""
            update modul set deaktivert = true where id = ${modul.id}
        """.trimIndent())

        fun deaktiverIATjeneste(iaTjeneste: IATjenesteDto) =
            TestContainerHelper.postgresContainer.performUpdate("""
            update ia_tjeneste set deaktivert = true where id = ${iaTjeneste.id}
        """.trimIndent())
    }
}

class StatusoversiktHelper {
    companion object {
        fun hentStatusoversikt(
                kommuner: String = "",
                fylker: String = "",
                næringsgrupper: String = "",
                sykefraværsprosentFra: String = "",
                sykefraværsprosentTil: String = "",
                ansatteFra: String = "",
                ansatteTil: String = "",
                bransjeProgram: String = "",
                snittFilter: String = "",
                eiere: String = "",
                sektor: String = "",
                token: String = oauth2ServerContainer.saksbehandler1.token,
        ) = hentStatusoversiktRespons(
                kommuner = kommuner,
                fylker = fylker,
                næringsgrupper = næringsgrupper,
                sykefraværsprosentFra = sykefraværsprosentFra,
                sykefraværsprosentTil = sykefraværsprosentTil,
                ansatteFra = ansatteFra,
                ansatteTil = ansatteTil,
                bransjeProgram = bransjeProgram,
                snittFilter = snittFilter,
                eiere = eiere,
                sektor = sektor,
                token = token
        )

        private fun hentStatusoversiktRespons(
                kommuner: String = "",
                fylker: String = "",
                næringsgrupper: String = "",
                sykefraværsprosentFra: String = "",
                sykefraværsprosentTil: String = "",
                ansatteFra: String = "",
                ansatteTil: String = "",
                bransjeProgram: String = "",
                snittFilter: String = "",
                eiere: String = "",
                sektor: String = "",
                token: String = oauth2ServerContainer.saksbehandler1.token,
        ) =
                lydiaApiContainer.performGet(
                        STATUSOVERSIKT_PATH +
                                "?${Søkeparametere.KOMMUNER}=$kommuner" +
                                "&${Søkeparametere.FYLKER}=$fylker" +
                                "&${Søkeparametere.NÆRINGSGRUPPER}=$næringsgrupper" +
                                "&${Søkeparametere.SYKEFRAVÆRSPROSENT_FRA}=$sykefraværsprosentFra" +
                                "&${Søkeparametere.SYKEFRAVÆRSPROSENT_TIL}=$sykefraværsprosentTil" +
                                "&${Søkeparametere.ANSATTE_FRA}=$ansatteFra" +
                                "&${Søkeparametere.ANSATTE_TIL}=$ansatteTil" +
                                "&${Søkeparametere.BRANSJEPROGRAM}=$bransjeProgram" +
                                "&${Søkeparametere.SNITT_FILTER}=$snittFilter" +
                                "&${Søkeparametere.IA_SAK_EIERE}=$eiere" +
                                "&${Søkeparametere.SEKTOR}=$sektor"
                )
                        .authentication().bearer(token)
                        .tilSingelRespons<StatusoversiktResponsDto>()
    }
}

class StatistikkHelper {
    companion object {
        fun hentSykefravær(
                success: (VirksomhetsoversiktResponsDto) -> Unit,
                kommuner: String = "",
                fylker: String = "",
                næringsgrupper: String = "",
                sorteringsnokkel: String = "",
                sorteringsretning: String = "",
                sykefraværsprosentFra: String = "",
                sykefraværsprosentTil: String = "",
                ansatteFra: String = "",
                ansatteTil: String = "",
                iaStatus: String = "",
                side: String = "",
                bransjeProgram: String = "",
                eiere: String = "",
                token: String = oauth2ServerContainer.saksbehandler1.token,
        ) =
                hentSykefraværRespons(
                        kommuner = kommuner,
                        fylker = fylker,
                        næringsgrupper = næringsgrupper,
                        sorteringsnokkel = sorteringsnokkel,
                        sorteringsretning = sorteringsretning,
                        sykefraværsprosentFra = sykefraværsprosentFra,
                        sykefraværsprosentTil = sykefraværsprosentTil,
                        ansatteFra = ansatteFra,
                        ansatteTil = ansatteTil,
                        iaStatus = iaStatus,
                        side = side,
                        bransjeProgram = bransjeProgram,
                        eiere = eiere,
                        token = token
                ).third
                        .fold(success = { response -> success.invoke(response) }, failure = {
                            fail("${it.message} - ${it.response.body().asString("text/plain")}")
                        })

        fun hentSykefravær(
                kommuner: String = "",
                fylker: String = "",
                næringsgrupper: String = "",
                sorteringsnokkel: String = "",
                sorteringsretning: String = "",
                sykefraværsprosentFra: String = "",
                sykefraværsprosentTil: String = "",
                snittFilter: String = "",
                ansatteFra: String = "",
                ansatteTil: String = "",
                iaStatus: String = "",
                side: String = "",
                bransjeProgram: String = "",
                eiere: String = "",
                sektor: List<Sektor> = listOf(),
                token: String = oauth2ServerContainer.saksbehandler1.token,
        ) =
                hentSykefraværRespons(
                        kommuner = kommuner,
                        fylker = fylker,
                        næringsgrupper = næringsgrupper,
                        sorteringsnokkel = sorteringsnokkel,
                        sorteringsretning = sorteringsretning,
                        sykefraværsprosentFra = sykefraværsprosentFra,
                        sykefraværsprosentTil = sykefraværsprosentTil,
                        snittFilter = snittFilter,
                        ansatteFra = ansatteFra,
                        ansatteTil = ansatteTil,
                        iaStatus = iaStatus,
                        side = side,
                        bransjeProgram = bransjeProgram,
                        eiere = eiere,
                        sektor = sektor,
                        token = token
                ).third.get()

        fun hentSykefraværRespons(
                kommuner: String = "",
                fylker: String = "",
                næringsgrupper: String = "",
                sorteringsnokkel: String = "",
                sorteringsretning: String = "",
                sykefraværsprosentFra: String = "",
                sykefraværsprosentTil: String = "",
                snittFilter: String = "",
                ansatteFra: String = "",
                ansatteTil: String = "",
                iaStatus: String = "",
                side: String = "",
                bransjeProgram: String = "",
                eiere: String = "",
                sektor: List<Sektor> = listOf(),
                token: String = oauth2ServerContainer.saksbehandler1.token,
        ) =
                lydiaApiContainer.performGet(
                        SYKEFRAVÆRSSTATISTIKK_PATH +
                                "?${Søkeparametere.KOMMUNER}=$kommuner" +
                                "&${Søkeparametere.FYLKER}=$fylker" +
                                "&${Søkeparametere.NÆRINGSGRUPPER}=$næringsgrupper" +
                                "&${Søkeparametere.SORTERINGSNØKKEL}=$sorteringsnokkel" +
                                "&${Søkeparametere.SORTERINGSRETNING}=$sorteringsretning" +
                                "&${Søkeparametere.SYKEFRAVÆRSPROSENT_FRA}=$sykefraværsprosentFra" +
                                "&${Søkeparametere.SYKEFRAVÆRSPROSENT_TIL}=$sykefraværsprosentTil" +
                                "&${Søkeparametere.SNITT_FILTER}=$snittFilter" +
                                "&${Søkeparametere.ANSATTE_FRA}=$ansatteFra" +
                                "&${Søkeparametere.ANSATTE_TIL}=$ansatteTil" +
                                "&${Søkeparametere.IA_STATUS}=$iaStatus" +
                                "&${Søkeparametere.SIDE}=$side" +
                                "&${Søkeparametere.BRANSJEPROGRAM}=$bransjeProgram" +
                                "&${Søkeparametere.IA_SAK_EIERE}=$eiere" +
                                "&${Søkeparametere.SEKTOR}=${sektor.joinToString(separator = ",") { it.kode }}"
                )
                        .authentication().bearer(token)
                        .tilSingelRespons<VirksomhetsoversiktResponsDto>()

        fun hentStatistikkHistorikk(orgnr: String) = hentStatistikkHistorikkRespons(orgnr).third.get()
        private fun hentStatistikkHistorikkRespons(
                orgnr: String,
                token: String = oauth2ServerContainer.saksbehandler1.token,
        ) =
                lydiaApiContainer.performGet(
                        "$SYKEFRAVÆRSSTATISTIKK_PATH/$orgnr/$HISTORISK_STATISTIKK"
                )
                        .authentication().bearer(token)
                        .tilSingelRespons<HistoriskStatistikk>()


        fun hentSykefraværForVirksomhetSiste4KvartalerRespons(
                orgnummer: String,
                token: String = oauth2ServerContainer.saksbehandler1.token,
        ) =
                lydiaApiContainer.performGet("$SYKEFRAVÆRSSTATISTIKK_PATH/$orgnummer/$SISTE_4_KVARTALER")
                        .authentication().bearer(token)
                        .tilSingelRespons<VirksomhetsstatistikkSiste4KvartalDto>()

        private fun hentPubliseringsinfoRespons(
                token: String = oauth2ServerContainer.saksbehandler1.token,
        ) =
                lydiaApiContainer.performGet("$SYKEFRAVÆRSSTATISTIKK_PATH/$PUBLISERINGSINFO")
                        .authentication().bearer(token)
                        .tilSingelRespons<Publiseringsinfo>()

        fun hentSykefraværForVirksomhetSisteTilgjengeligKvartalRespons(
                orgnummer: String,
                token: String = oauth2ServerContainer.saksbehandler1.token,
        ) =
                lydiaApiContainer.performGet("$SYKEFRAVÆRSSTATISTIKK_PATH/$orgnummer/$SISTE_TILGJENGELIGE_KVARTAL")
                        .authentication().bearer(token)
                        .tilSingelRespons<VirksomhetsstatistikkSisteKvartal>()

        fun hentSykefraværForVirksomhetSiste4Kvartaler(
                orgnummer: String,
                token: String = oauth2ServerContainer.saksbehandler1.token,
        ) =
                hentSykefraværForVirksomhetSiste4KvartalerRespons(orgnummer = orgnummer, token = token).third
                        .fold(success = { response -> response }, failure = { fail(it.message) })

        fun hentPubliseringsinfo(
                token: String = oauth2ServerContainer.saksbehandler1.token,
        ) =
                hentPubliseringsinfoRespons(token).third
                        .fold(success = { response -> response }, failure = { fail(it.message) })

        fun hentSykefraværForVirksomhetSisteTilgjengeligKvartal(
                orgnummer: String,
                token: String = oauth2ServerContainer.saksbehandler1.token,
        ) =
                hentSykefraværForVirksomhetSisteTilgjengeligKvartalRespons(orgnummer = orgnummer, token = token).third
                        .fold(success = { response -> response }, failure = { fail(it.message) })

        fun hentSykefraværForAlleVirksomheter(): List<VirksomhetsoversiktDto> {
            var side = 1
            val liste = mutableListOf<VirksomhetsoversiktDto>()

            do {
                val sykefravær = hentSykefravær(side = "${side++}")
                liste.addAll(sykefravær.data)
            } while (sykefravær.data.size == VIRKSOMHETER_PER_SIDE)

            return liste.toList()
        }

        // Defaultverdiane her er standard-verdiane i kall frå frontend per 2023-11-09
        fun hentSykefraværForAlleVirksomheterMedFilter(
                                                            side: Int = 1,
                                                            kommuner: String = "",
                                                            fylker: String = "",
                                                            næringsgrupper: String = "",
                                                            sorteringsnokkel: String = "",
                                                            sorteringsretning: String = "",
                                                            sykefraværsprosentFra: String = "0.00",
                                                            sykefraværsprosentTil: String = "100.00",
                                                            snittFilter: String = "",
                                                            ansatteFra: String = "5",
                                                            ansatteTil: String = "",
                                                            iaStatus: String = "",
                                                            bransjeProgram: String = "",
                                                            eiere: String = "",
                                                            sektor: List<Sektor> = listOf(),
                                                            token: String = oauth2ServerContainer.saksbehandler1.token,): List<VirksomhetsoversiktDto> {
            var itererbarSide = side
            val liste = mutableListOf<VirksomhetsoversiktDto>()

            do {
                val sykefravær = hentSykefravær(
                    side = "${itererbarSide++}",
                    kommuner = kommuner,
                    fylker = fylker,
                    næringsgrupper = næringsgrupper,
                    sorteringsnokkel = sorteringsnokkel,
                    sorteringsretning = sorteringsretning,
                    sykefraværsprosentFra = sykefraværsprosentFra,
                    sykefraværsprosentTil = sykefraværsprosentTil,
                    snittFilter = snittFilter,
                    ansatteFra = ansatteFra,
                    ansatteTil = ansatteTil,
                    iaStatus = iaStatus,
                    bransjeProgram = bransjeProgram,
                    eiere = eiere,
                    sektor = sektor,
                    token = token,
            )
                liste.addAll(sykefravær.data)
            } while (sykefravær.data.size == VIRKSOMHETER_PER_SIDE)

            return liste.toList()
        }

        fun hentTotaltAntallTreffISykefravær(
                kommuner: String = "",
                fylker: String = "",
                næringsgrupper: String = "",
                sorteringsnokkel: String = "",
                sorteringsretning: String = "",
                sykefraværsprosentFra: String = "",
                sykefraværsprosentTil: String = "",
                ansatteFra: String = "",
                ansatteTil: String = "",
                iaStatus: String = "",
                side: String = "",
                bransjeProgram: String = "",
                eiere: String = "",
                sektor: List<Sektor> = listOf(),
                token: String = oauth2ServerContainer.saksbehandler1.token,
        ): Int {
            return lydiaApiContainer.performGet("$SYKEFRAVÆRSSTATISTIKK_PATH/$ANTALL_TREFF" +
                    "?${Søkeparametere.KOMMUNER}=$kommuner" +
                    "&${Søkeparametere.FYLKER}=$fylker" +
                    "&${Søkeparametere.NÆRINGSGRUPPER}=$næringsgrupper" +
                    "&${Søkeparametere.SORTERINGSNØKKEL}=$sorteringsnokkel" +
                    "&${Søkeparametere.SORTERINGSRETNING}=$sorteringsretning" +
                    "&${Søkeparametere.SYKEFRAVÆRSPROSENT_FRA}=$sykefraværsprosentFra" +
                    "&${Søkeparametere.SYKEFRAVÆRSPROSENT_TIL}=$sykefraværsprosentTil" +
                    "&${Søkeparametere.ANSATTE_FRA}=$ansatteFra" +
                    "&${Søkeparametere.ANSATTE_TIL}=$ansatteTil" +
                    "&${Søkeparametere.IA_STATUS}=$iaStatus" +
                    "&${Søkeparametere.SIDE}=$side" +
                    "&${Søkeparametere.BRANSJEPROGRAM}=$bransjeProgram" +
                    "&${Søkeparametere.IA_SAK_EIERE}=$eiere" +
                    "&${Søkeparametere.SEKTOR}=${sektor.joinToString(separator = ",") { it.kode }}"
            )
                    .authentication().bearer(token)
                    .tilSingelRespons<Int>()
                    .third
                    .fold(success = { response -> response }, failure = { fail(it.message) })
        }


        fun hentFilterverdier(token: String = oauth2ServerContainer.saksbehandler1.token) =
                lydiaApiContainer.performGet("$SYKEFRAVÆRSSTATISTIKK_PATH/$FILTERVERDIER_PATH")
                        .authentication().bearer(token)
                        .tilSingelRespons<FilterverdierDto>()
                        .third
                        .fold(success = { response -> response }, failure = { fail(it.message) })
    }
}

@OptIn(InternalSerializationApi::class)
inline fun <reified T : Any> Request.tilListeRespons() =
        this.responseObject(loader = ListSerializer(T::class.serializer()), json = Json.Default)

@OptIn(InternalSerializationApi::class)
inline fun <reified T : Any> Request.tilSingelRespons() =
        this.responseObject(loader = T::class.serializer(), json = Json.Default)

