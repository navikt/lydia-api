package no.nav.lydia.helper

import com.github.kittinunf.fuel.core.Request
import com.github.kittinunf.fuel.core.ResponseResultOf
import com.github.kittinunf.fuel.core.extensions.authentication
import com.github.kittinunf.fuel.core.extensions.jsonBody
import com.github.kittinunf.fuel.httpGet
import com.github.kittinunf.fuel.httpPost
import com.github.kittinunf.fuel.serialization.responseObject
import io.kotest.matchers.string.shouldContain
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.InternalSerializationApi
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import kotlinx.serialization.serializer
import no.nav.lydia.Kafka
import no.nav.lydia.appstatus.FEATURE_TOGGLE_DISABLE_PATH
import no.nav.lydia.appstatus.FEATURE_TOGGLE_ENABLE_PATH
import no.nav.lydia.helper.TestContainerHelper.Companion.httpMock
import no.nav.lydia.helper.TestContainerHelper.Companion.lydiaApiContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.oauth2ServerContainer
import no.nav.lydia.helper.TestContainerHelper.Companion.performGet
import no.nav.lydia.helper.TestContainerHelper.Companion.performPost
import no.nav.lydia.ia.sak.api.*
import no.nav.lydia.ia.sak.domene.IASakshendelseType
import no.nav.lydia.ia.sak.domene.IASakshendelseType.VIRKSOMHET_ER_IKKE_AKTUELL
import no.nav.lydia.ia.årsak.domene.BegrunnelseType.HAR_IKKE_KAPASITET
import no.nav.lydia.ia.årsak.domene.ValgtÅrsak
import no.nav.lydia.ia.årsak.domene.ÅrsakType.VIRKSOMHETEN_TAKKET_NEI
import no.nav.lydia.integrasjoner.brreg.BrregDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsRepository
import no.nav.lydia.sykefraversstatistikk.api.*
import no.nav.lydia.sykefraversstatistikk.api.Søkeparametere.Companion.VIRKSOMHETER_PER_SIDE
import no.nav.lydia.veileder.VEILEDERE_PATH
import no.nav.lydia.veileder.VeilederDTO
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

        private val azureMockServer = WireMockContainerHelper()

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
                        .plus(azureMockServer.envVars())
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
            VirksomhetHelper.lastInnTestdata(PiaBrregOppdateringTestData.lagTestDataForPiaBrregOppdatering(httpMock = httpMock))
            brregOppdateringContainer.start()
            runBlocking {
                log.info("Venter på at alle meldinger fra brregOppdatering er konsumert")
                kafkaContainerHelper.ventTilAlleMeldingerErKonsumert(Kafka.brregConsumerGroupId)
                log.info("Alle meldinger fra brregOppdatering er konsumert")
            }
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
            hendelsestype: IASakshendelseType,
            token: String = oauth2ServerContainer.saksbehandler1.token,
            payload: String? = null
        ): ResponseResultOf<IASakDto> {
            val request = nyHendelsePåSakRequest(token, sak, hendelsestype, payload)
            return request.tilSingelRespons()
        }

        fun nyHendelsePåSakRequest(
            token: String,
            sak: IASakDto,
            hendelsestype: IASakshendelseType,
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
            payload: String? = null
        ) =
            nyHendelsePåSak(sak = this, hendelsestype = hendelsestype, payload = payload, token = token)

        fun IASakDto.nyHendelseRespons(
            hendelsestype: IASakshendelseType,
            token: String = oauth2ServerContainer.saksbehandler1.token,
            payload: String? = null
        ) =
            nyHendelsePåSakMedRespons(sak = this, hendelsestype = hendelsestype, payload = payload, token = token)

        fun IASakDto.nyIkkeAktuellHendelse(
            token: String = oauth2ServerContainer.saksbehandler1.token
        ) = this.nyHendelse(
                hendelsestype = VIRKSOMHET_ER_IKKE_AKTUELL,
                token = token,
                payload = ValgtÅrsak(
                    type = VIRKSOMHETEN_TAKKET_NEI,
                    begrunnelser = listOf(HAR_IKKE_KAPASITET)).toJson()
            )

        fun IASakDto.oppdaterHendelsesTidspunkter(
            antallDagerTilbake: Long,
            token: String = oauth2ServerContainer.saksbehandler1.token
        ): IASakDto {
            TestContainerHelper.postgresContainer.performUpdate(
                """
                    update ia_sak_hendelse 
                        set opprettet=(current_date - interval '$antallDagerTilbake' day)
                        where saksnummer='${this.saksnummer}';
                """.trimIndent())
            TestContainerHelper.postgresContainer.performUpdate(
                """
                    update ia_sak 
                        set endret=(current_date - interval '$antallDagerTilbake' day)
                        where saksnummer='${this.saksnummer}';
                """.trimIndent())
            return requireNotNull(hentSaker(this.orgnr, token = token).find { it.saksnummer == this.saksnummer })
        }

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
            bransjeProgram: String = "",
            eiere: String = "",
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
                bransjeProgram = bransjeProgram,
                eiere = eiere,
                token = token
            ).third
                .fold(success = { response -> success.invoke(response) }, failure = {
                    fail("${it.message} - ${it.response.body().asString("text/plain")}")
                })

        fun hentSykefravær(
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
            bransjeProgram: String = "",
            eiere: String = "",
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
                bransjeProgram = bransjeProgram,
                eiere = eiere,
                token = token
            ).third.get()

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
            bransjeProgram: String = "",
            eiere: String = "",
            token: String = oauth2ServerContainer.saksbehandler1.token,
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
                        "&${Søkeparametere.BRANSJEPROGRAM}=$bransjeProgram" +
                        "&${Søkeparametere.IA_SAK_EIERE}=$eiere"
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

        fun hentSykefraværForVirksomhetSiste4KvartalerRespons(
            orgnummer: String,
            token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
            lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$orgnummer/$SISTE_4_KVARTALER")
                .authentication().bearer(token)
                .tilListeRespons<SykefraversstatistikkForVirksomhetSite4KvartalerDto>()

        fun hentGjeldendePeriodeForSiste4KvartalerRespons(
            token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
            lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$GJELDENDE_PERIODE_SISTE_4_KVARTALER")
                .authentication().bearer(token)
                .tilSingelRespons<KvartalerFraTilDto>()

        fun hentSykefraværForVirksomhetSisteTilgjengeligKvartalRespons(
            orgnummer: String,
            token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
            lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$orgnummer/$SISTE_TILGJENGELIGE_KVARTAL")
                .authentication().bearer(token)
                .tilSingelRespons<SykefraversstatistikkVirksomhetDto>()

        fun hentSykefraværForVirksomhet(
            orgnummer: String,
            token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
            hentSykefraværForVirksomhetRespons(orgnummer = orgnummer, token = token).third
                .fold(success = { response -> response }, failure = { fail(it.message) })

        fun hentSykefraværForVirksomhetSiste4Kvartaler(
            orgnummer: String,
            token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
            hentSykefraværForVirksomhetSiste4KvartalerRespons(orgnummer = orgnummer, token = token).third
                .fold(success = { response -> response }, failure = { fail(it.message) })

        fun hentGjeldendePeriodeForSiste4Kvartaler(
            token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
            hentGjeldendePeriodeForSiste4KvartalerRespons(token).third
                .fold(success = { response -> response }, failure = { fail(it.message) })

        fun hentSykefraværForVirksomhetSisteTilgjengeligKvartal(
            orgnummer: String,
            token: String = oauth2ServerContainer.saksbehandler1.token
        ) =
            hentSykefraværForVirksomhetSisteTilgjengeligKvartalRespons(orgnummer = orgnummer, token = token).third
                .fold(success = { response -> response }, failure = { fail(it.message) })

        fun hentSykefraværForAlleVirksomheter(): List<SykefraversstatistikkVirksomhetDto> {
            var side = 1
            val liste = mutableListOf<SykefraversstatistikkVirksomhetDto>()

            do {
                val sykefravær = hentSykefravær(side = "${side++}")
                liste.addAll(sykefravær.data)
            } while (sykefravær.data.size == VIRKSOMHETER_PER_SIDE)

            return liste.toList()
        }

        fun hentTotaltAntallTreffISykefravær(
            token: String = oauth2ServerContainer.saksbehandler1.token
        ): Int {
            return lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$ANTALL_TREFF")
                .authentication().bearer(token)
                .tilSingelRespons<Int>()
                .third
                .fold(success = { response -> response }, failure = { fail(it.message) })
        }


        fun hentFilterverdier(token: String = oauth2ServerContainer.saksbehandler1.token) =
            lydiaApiContainer.performGet("$SYKEFRAVERSSTATISTIKK_PATH/$FILTERVERDIER_PATH")
                .authentication().bearer(token)
                .tilSingelRespons<FilterverdierDto>()
                .third
                .fold(success = { response -> response }, failure = { fail(it.message) })
    }
}

class FeatureToggleHelper {
    companion object {
        private fun skruPåToggle(toggleKey: String) =
            lydiaApiContainer.performGet("$FEATURE_TOGGLE_ENABLE_PATH/$toggleKey")
                .response()
                .third.fold(
                    success = { response -> response },
                    failure = { fail(it.message) }
                )
        private fun skruAvToggle(toggleKey: String) =
            lydiaApiContainer.performGet("$FEATURE_TOGGLE_DISABLE_PATH/$toggleKey")
                .response()
                .third.fold(
                    success = { response -> response },
                    failure = { fail(it.message) }
                )

        fun medFeatureToggleEnablet(toggleKey: String, block: () -> Unit) {
            skruPåToggle(toggleKey = toggleKey).also {
                block()
            }.also {
                skruAvToggle(toggleKey = toggleKey)
            }
        }
    }
}

class VirksomhetHelper {
    companion object {
        fun søkEtterVirksomheter(
            søkestreng: String,
            token: String = oauth2ServerContainer.saksbehandler1.token,
            success: (List<VirksomhetSøkeresultat>) -> Unit
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

        fun lastInnNyeVirksomheter(vararg virksomheter: TestVirksomhet): List<TestVirksomhet> {
            return virksomheter.toList()
                .onEach(this::lastInnNyVirksomhet)
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

            TestContainerHelper.kafkaContainerHelper.sendIBulkOgVentTilKonsumert(
                testData.sykefraværsStatistikkMeldinger().toList()
            )

            TestContainerHelper.kafkaContainerHelper.sendSykefraversstatistikkPerKategoriIBulkOgVentTilKonsumert(
                testData.sykefraværsstatistikkPerKategoriMeldinger().toList()
            )
        }
    }
}

class VeilederHelper {

    companion object {
        fun hentVeiledere(token: String = oauth2ServerContainer.superbruker1.token) = lydiaApiContainer.performGet(VEILEDERE_PATH)
            .authentication().bearer(token)
            .tilListeRespons<VeilederDTO>()
            .third.fold(
                success = {
                    it
                },
                failure = {
                    fail(it.message)
                }
            )
    }

}

@OptIn(InternalSerializationApi::class)
inline fun <reified T : Any> Request.tilListeRespons() =
    this.responseObject(loader = ListSerializer(T::class.serializer()), json = Json.Default)

@OptIn(InternalSerializationApi::class)
inline fun <reified T : Any> Request.tilSingelRespons() =
    this.responseObject(loader = T::class.serializer(), json = Json.Default)

