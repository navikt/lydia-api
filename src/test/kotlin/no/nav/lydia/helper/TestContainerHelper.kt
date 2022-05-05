package no.nav.lydia.helper

import com.github.kittinunf.fuel.core.Request
import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.gson.jsonBody
import com.github.kittinunf.fuel.gson.responseObject
import com.github.kittinunf.fuel.httpGet
import com.github.kittinunf.fuel.httpPost
import io.kotest.matchers.string.shouldContain
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.sak.api.IASakDto
import no.nav.lydia.ia.sak.api.IASakshendelseDto
import no.nav.lydia.ia.sak.api.IASakshendelseOppsummeringDto
import no.nav.lydia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.api.SAK_HENDELSER_SUB_PATH
import no.nav.lydia.ia.sak.api.SAK_HENDELSE_SUB_PATH
import no.nav.lydia.ia.sak.domene.SaksHendelsestype
import no.nav.lydia.integrasjoner.brreg.BrregDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsRepository
import no.nav.lydia.sykefraversstatistikk.api.ListResponse
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.lydia.sykefraversstatistikk.api.SykefraversstatistikkVirksomhetDto
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere
import no.nav.lydia.virksomhet.VirksomhetRepository
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.testcontainers.containers.GenericContainer
import org.testcontainers.containers.Network
import org.testcontainers.containers.output.Slf4jLogConsumer
import org.testcontainers.containers.wait.strategy.HttpWaitStrategy
import org.testcontainers.images.builder.ImageFromDockerfile
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
                                        "CONSUMER_LOOP_DELAY" to "10",
                                        "SSB_NARINGS_URL" to "/naringmock/api/klass/v1/30/json",
                                        "NAIS_CLUSTER_NAME" to "lokal",
                                    )
                                )
                        )
                )
                .waitingFor(HttpWaitStrategy().forPath("/internal/isready")).apply {
                    start()
                }

        init {
            val testData = TestData(inkluderStandardVirksomheter = true, antallTilfeldigeVirksomheter = 100)
            HttpMock().also { httpMock ->
                httpMock.start()
                postgresContainer.getDataSource().use { dataSource ->
                    NæringsDownloader(
                        url = IntegrationsHelper.mockKallMotSsbNæringer(httpMock = httpMock, testData = testData),
                        næringsRepository = NæringsRepository(dataSource = dataSource)
                    ).lastNedNæringer()

                    BrregDownloader(
                        url = IntegrationsHelper.mockKallMotBrregUnderhenter(httpMock = httpMock, testData = testData),
                        virksomhetRepository = VirksomhetRepository(dataSource = dataSource)
                    ).lastNed()
                }
                httpMock.stop()
            }

            testData.sykefraværsStatistikkMeldinger().forEach { melding ->
                kafkaContainerHelper.sendSykefraversstatistikkKafkaMelding(melding)
            }
        }

        private fun GenericContainer<*>.buildUrl(url: String) = "http://${this.host}:${this.getMappedPort(8080)}/$url"
        fun GenericContainer<*>.performGet(url: String) = buildUrl(url = url).httpGet()
        fun GenericContainer<*>.performPost(url: String) = buildUrl(url = url).httpPost()

        fun Request.withLydiaToken(): Request = this.authentication().bearer(oauth2ServerContainer.saksbehandler1.token)
        infix fun GenericContainer<*>.shouldContainLog(regex: Regex) = logs shouldContain regex
    }
}

class SakHelper {

    companion object {
        fun hentSaker(orgnummer: String, token: String = oauth2ServerContainer.saksbehandler1.token) =
            hentSakerRespons(orgnummer = orgnummer, token = token).third.fold(
                success = { respons -> respons },
                failure = {
                    fail(it.message)
                })

        fun hentSakerRespons(
            orgnummer: String,
            token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
            lydiaApiContainer.performGet("$IA_SAK_RADGIVER_PATH/$orgnummer")
                .authentication().bearer(token = token)
                .responseObject<List<IASakDto>>(localDateTimeTypeAdapter)

        fun hentHendelserPåSakRespons(
            saksnummer: String,
            token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
            lydiaApiContainer.performGet("$IA_SAK_RADGIVER_PATH/$SAK_HENDELSER_SUB_PATH/$saksnummer")
                .authentication().bearer(token = token)
                .responseObject<List<IASakshendelseOppsummeringDto>>(localDateTimeTypeAdapter)


        fun hentHendelserPåSak(
            saksnummer: String,
            token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
            hentHendelserPåSakRespons(saksnummer = saksnummer, token = token).third.fold(
                success = { respons -> respons },
                failure = {
                    fail(it.message)
                })

        fun opprettSakForVirksomhetRespons(
            orgnummer: String,
            token: String
        ) = lydiaApiContainer.performPost("$IA_SAK_RADGIVER_PATH/$orgnummer")
            .authentication().bearer(token = token)
            .responseObject<IASakDto>(localDateTimeTypeAdapter)

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
                .jsonBody(
                    src = sakshendelse,
                    gson = localDateTimeTypeAdapter
                )
                .responseObject<IASakDto>(localDateTimeTypeAdapter).third.fold(
                    success = { respons -> respons },
                    failure = {
                        fail(it.message)
                    })

        fun nyHendelsePåSakMedRespons(
            sak: IASakDto,
            hendelsestype: SaksHendelsestype,
            token: String = oauth2ServerContainer.saksbehandler1.token,
            payload: String? = null,
        ) = lydiaApiContainer.performPost("$IA_SAK_RADGIVER_PATH/$SAK_HENDELSE_SUB_PATH")
            .authentication().bearer(token)
            .jsonBody(
                IASakshendelseDto(
                    orgnummer = sak.orgnr,
                    saksnummer = sak.saksnummer,
                    hendelsesType = hendelsestype,
                    endretAvHendelseId = sak.endretAvHendelseId,
                    payload = payload
                ),
                localDateTimeTypeAdapter
            )
            .responseObject<IASakDto>(localDateTimeTypeAdapter)


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

        fun ValgtÅrsak.toJson() = Json.encodeToString(value = this)
    }
}

class StatistikkHelper{
    companion object {
        fun hentSykefravær(
            success: (ListResponse<SykefraversstatistikkVirksomhetDto>) -> Unit,
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
            token: String = oauth2ServerContainer.saksbehandler1.token
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
                        "&${Søkeparametere.SIDE}=$side"
            )
                .authentication().bearer(token)
                .responseObject<ListResponse<SykefraversstatistikkVirksomhetDto>>(localDateTimeTypeAdapter)

        fun hentSykefraværForVirksomhetRespons(
            orgnummer: String,
            token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
            lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$orgnummer")
                .authentication().bearer(token)
                .responseObject<List<SykefraversstatistikkVirksomhetDto>>(localDateTimeTypeAdapter)

        fun hentSykefraværForVirksomhet(
            orgnummer: String,
            token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
            hentSykefraværForVirksomhetRespons(orgnummer = orgnummer, token = token).third
                .fold(success = { response -> response }, failure = { fail(it.message) })
    }
}
