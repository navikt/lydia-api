package no.nav.lydia.helper

import com.github.kittinunf.fuel.core.Request
import com.github.kittinunf.fuel.core.ResponseResultOf
import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.core.extensions.jsonBody
import com.github.kittinunf.fuel.httpGet
import com.github.kittinunf.fuel.httpPost
import com.github.kittinunf.fuel.serialization.responseObject
import io.kotest.matchers.string.shouldContain
import kotlinx.serialization.InternalSerializationApi
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import kotlinx.serialization.serializer
import no.nav.lydia.helper.TestContainerHelper.Companion.httpMock
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.helper.TestVirksomhet.Companion.TESTVIRKSOMHET_FOR_OPPDATERING
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import no.nav.lydia.ia.sak.api.IASakshendelseOppsummeringDto
import no.nav.lydia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.api.SAK_HENDELSE_SUB_PATH
import no.nav.lydia.ia.sak.api.SAMARBEIDSHISTORIKK_PATH
import no.nav.lydia.ia.sak.api.SakshistorikkDto
import no.nav.lydia.ia.sak.domene.SaksHendelsestype
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.integrasjoner.brreg.BrregDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsRepository
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto
import no.nav.lydia.sykefraversstatistikk.api.SykefraværsstatistikkListResponseDto
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere
import no.nav.lydia.virksomhet.VirksomhetRepository
import no.nav.lydia.virksomhet.VirksomhetSøkeresultat
import no.nav.lydia.virksomhet.api.VIRKSOMHET_PATH
import no.nav.lydia.virksomhet.api.VirksomhetDto
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.testcontainers.Testcontainers
import org.testcontainers.containers.GenericContainer
import org.testcontainers.containers.Network
import org.testcontainers.containers.output.Slf4jLogConsumer
import org.testcontainers.containers.wait.strategy.HttpWaitStrategy
import org.testcontainers.images.builder.ImageFromDockerfile
import java.net.URLEncoder.encode
import java.nio.charset.Charset.defaultCharset
import kotlin.io.path.Path
import kotlin.test.fail

class TestContainerHelper {
    companion object {
        private var log: Logger = LoggerFactory.getLogger(this::class.java)

        private val network = Network.newNetwork()

        val oauth2ServerContainer = AuthContainerHelper(network = network, log = log)

        val kafkaContainerHelper = KafkaContainerHelper(network = network, log = log)

        val postgresContainer = PostgrestContainerHelper(network = network, log = log)

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
                        .plus(
                            kafkaContainerHelper.envVars()
                                .plus(
                                    mapOf(
                                        "BRREG_UNDERENHET_URL" to "/brregmock/enhetsregisteret/api/underenheter/lastned",
                                        "CONSUMER_LOOP_DELAY" to "1",
                                        "SSB_NARINGS_URL" to "/naringmock/api/klass/v1/30/json",
                                        "NAIS_CLUSTER_NAME" to "lokal",
                                    )
                                )
                        )
                )
                .waitingFor(HttpWaitStrategy().forPath("/internal/isready")).apply {
                    start()
                }

        val httpMock = HttpMock().also { httpMock ->
            httpMock.start()
        }

        val brregOppdateringContainer = PiaBrregOppdateringContainerHelper(network = network, log = log, httpMock = httpMock)

        private val dataSource = postgresContainer.getDataSource()
        val næringsRepository = NæringsRepository(dataSource = dataSource)
        val virksomhetRepository = VirksomhetRepository(dataSource = dataSource)

        init {
            Testcontainers.exposeHostPorts(httpMock.wireMockServer.port())
            VirksomhetHelper.lastInnStandardTestdata()

            brregOppdateringContainer.start()
        }

        private fun GenericContainer<*>.buildUrl(url: String) = "http://${this.host}:${this.getMappedPort(8080)}/$url"
        fun GenericContainer<*>.performGet(url: String) = buildUrl(url = url).httpGet()
        fun GenericContainer<*>.performPost(url: String) = buildUrl(url = url).httpPost()

        infix fun GenericContainer<*>.shouldContainLog(regex: Regex) = logs shouldContain regex
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
            token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
            lydiaApiContainer.performGet("$IA_SAK_RADGIVER_PATH/$orgnummer")
                .authentication().bearer(token = token)
                .tilListeRespons<IASakDto>()

        fun hentSamarbeidshistorikk(
            orgnummer: String,
            token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
            hentSamarbeidshistorikkRespons(orgnummer, token).third.fold(
                success = { respons -> respons },
                failure = { fail(it.stackTraceToString()) }
            )

        fun hentSamarbeidshistorikkRespons(
            orgnummer: String,
            token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
            lydiaApiContainer.performGet("$IA_SAK_RADGIVER_PATH/$SAMARBEIDSHISTORIKK_PATH/$orgnummer")
                .authentication().bearer(token = token)
                .tilListeRespons<SakshistorikkDto>()


        fun hentSamarbeidshistorikkForOrgnrRespons(
            orgnr: String,
            token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
            lydiaApiContainer.performGet("$IA_SAK_RADGIVER_PATH/$SAMARBEIDSHISTORIKK_PATH/$orgnr")
                .authentication().bearer(token = token)
                .tilListeRespons<IASakshendelseOppsummeringDto>()

        fun opprettSakForVirksomhetRespons(
            orgnummer: String,
            token: String
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

        fun nyHendelse(
            sakshendelse: IASakshendelseDto,
            token: String = oauth2ServerContainer.saksbehandler1.token
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
            hendelsestype: SaksHendelsestype,
            token: String = oauth2ServerContainer.saksbehandler1.token,
            payload: String? = null
        ): ResponseResultOf<IASakDto> {
            val request = nyHendelsePåSakRequest(token, sak, hendelsestype, payload)
            return request.tilSingelRespons()
        }

        fun nyHendelsePåSakRequest(
            token: String,
            sak: IASakDto,
            hendelsestype: SaksHendelsestype,
            payload: String?
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

        fun nyHendelsePåSak(
            sak: IASakDto,
            hendelsestype: SaksHendelsestype,
            token: String = oauth2ServerContainer.saksbehandler1.token,
            payload: String? = null,
        ) =
            nyHendelsePåSakMedRespons(sak = sak, hendelsestype = hendelsestype, payload = payload, token = token)
                .third.fold(success = { respons -> respons }, failure = {
                    fail(it.message)
                })

        fun IASakDto.nyHendelse(
            hendelsestype: SaksHendelsestype,
            token: String = oauth2ServerContainer.saksbehandler1.token,
            payload: String? = null
        ) =
            nyHendelsePåSak(sak = this, hendelsestype = hendelsestype, payload = payload, token = token)

        fun IASakDto.nyHendelseRespons(
            hendelsestype: SaksHendelsestype,
            token: String = oauth2ServerContainer.saksbehandler1.token,
            payload: String? = null
        ) =
            nyHendelsePåSakMedRespons(sak = this, hendelsestype = hendelsestype, payload = payload, token = token)

        fun ValgtÅrsak.toJson() = Json.encodeToString(value = this)
    }
}

class StatistikkHelper {
    companion object {
        fun hentSykefravær(
            success: (SykefraværsstatistikkListResponseDto) -> Unit,
            kvartal: String = "",
            årstall: String = "",
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
            kunMineVirksomheter: Boolean = false,
            bransjeProgram: String = "",
            skalInkludereTotaltAntall: Boolean = true,
            token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
            hentSykefraværRespons(
                kvartal = kvartal,
                årstall = årstall,
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
                kunMineVirksomheter = kunMineVirksomheter,
                bransjeProgram = bransjeProgram,
                skalInkludereTotaltAntall = skalInkludereTotaltAntall,
                token = token
            ).third
                .fold(success = { response -> success.invoke(response) }, failure = { fail(it.message) })


        fun hentSykefraværRespons(
            kvartal: String = "",
            årstall: String = "",
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
            kunMineVirksomheter: Boolean = false,
            bransjeProgram: String = "",
            token: String = oauth2ServerContainer.saksbehandler1.token,
            skalInkludereTotaltAntall: Boolean = true
        ) =
            lydiaApiContainer.performGet(
                SYKEFRAVERSSTATISTIKK_PATH +
                        "?${Søkeparametere.KVARTAL}=$kvartal" +
                        "&${Søkeparametere.ÅRSTALL}=$årstall" +
                        "&${Søkeparametere.KOMMUNER}=$kommuner" +
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
                        "&${Søkeparametere.KUN_MINE_VIRKSOMHETER}=$kunMineVirksomheter" +
                        "&${Søkeparametere.BRANSJEPROGRAM}=$bransjeProgram" +
                        "&${Søkeparametere.SKAL_INKLUDERE_TOTALT_ANTALL}=$skalInkludereTotaltAntall"
            )
                .authentication().bearer(token)
                .tilSingelRespons<SykefraværsstatistikkListResponseDto>()

        fun hentSykefraværForVirksomhetRespons(
            orgnummer: String,
            token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
            lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$orgnummer")
                .authentication().bearer(token)
                .tilListeRespons<SykefraversstatistikkVirksomhetDto>()

        fun hentSykefraværForVirksomhet(
            orgnummer: String,
            token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
            hentSykefraværForVirksomhetRespons(orgnummer = orgnummer, token = token).third
                .fold(success = { response -> response }, failure = { fail(it.message) })
    }
}

class VirksomhetHelper {
    companion object {
        fun søkEtterVirksomheter(
            success: (List<VirksomhetSøkeresultat>) -> Unit,
            søkestreng: String,
            token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
            lydiaApiContainer.performGet(url = "$VIRKSOMHET_PATH/finn?q=${encode(søkestreng, defaultCharset())}")
                .authentication().bearer(token)
                .tilListeRespons<VirksomhetSøkeresultat>()
                .third.fold(success = success, failure = { fail(it.message) })

        fun hentVirksomhetsinformasjonRespons(orgnummer: String, token: String) =
            lydiaApiContainer.performGet("$VIRKSOMHET_PATH/$orgnummer")
                .authentication().bearer(token)
                .tilSingelRespons<VirksomhetDto>()

        fun hentVirksomhetsinformasjon(orgnummer: String, token: String) =
            hentVirksomhetsinformasjonRespons(orgnummer = orgnummer, token = token)
                .third.fold(
                    success = { response -> response },
                    failure = { fail(it.message) }
                )

        fun nyttOrgnummer() = lastInnNyVirksomhet().orgnr

        fun lastInnNyVirksomhet(nyVirksomhet: TestVirksomhet = TestVirksomhet.nyVirksomhet()): TestVirksomhet {
            lastInnTestdata(TestData.fraVirksomhet(nyVirksomhet))
            return nyVirksomhet
        }

        fun lastInnStandardTestdata() {
            lastInnTestdata(TestData(inkluderStandardVirksomheter = true, antallTilfeldigeVirksomheter = 500))
        }

        fun lastInnTestdata(testData: TestData) {
            NæringsDownloader(
                url = IntegrationsHelper.mockKallMotSsbNæringer(
                    httpMock = httpMock,
                    testData = testData
                ),
                næringsRepository = TestContainerHelper.næringsRepository
            ).lastNedNæringer()

            BrregDownloader(
                url = IntegrationsHelper.mockKallMotBrregUnderenheterForNedlasting(
                    httpMock = httpMock,
                    testData = testData
                ),
                virksomhetRepository = TestContainerHelper.virksomhetRepository
            ).lastNed()

            IntegrationsHelper.mockKallMotBrregOppdaterteUnderenheter(
                httpMock = httpMock,
                testData = testData
            )
            IntegrationsHelper.mockKallMotBrregUnderenhet(
                httpMock = httpMock,
                testVirksomhet = TESTVIRKSOMHET_FOR_OPPDATERING
            )

            TestContainerHelper.kafkaContainerHelper.sendIBulkOgVentTilKonsumert(
                testData.sykefraværsStatistikkMeldinger().toList()
            )
        }
    }
}

@OptIn(InternalSerializationApi::class)
inline fun <reified T : Any> Request.tilListeRespons() =
    this.responseObject(loader = ListSerializer(T::class.serializer()), json = Json.Default)

@OptIn(InternalSerializationApi::class)
inline fun <reified T : Any> Request.tilSingelRespons() =
    this.responseObject(loader = T::class.serializer(), json = Json.Default)

