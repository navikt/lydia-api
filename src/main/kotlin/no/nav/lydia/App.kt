/*
 * This Kotlin source file was generated by the Gradle 'init' task.
 */
package no.nav.lydia

import arrow.core.Either
import com.auth0.jwk.JwkProviderBuilder
import io.ktor.http.HttpHeaders
import io.ktor.http.HttpStatusCode
import io.ktor.serialization.kotlinx.json.json
import io.ktor.server.application.Application
import io.ktor.server.application.install
import io.ktor.server.application.log
import io.ktor.server.auth.Authentication
import io.ktor.server.auth.authenticate
import io.ktor.server.auth.jwt.JWTPrincipal
import io.ktor.server.auth.jwt.jwt
import io.ktor.server.engine.addShutdownHook
import io.ktor.server.engine.embeddedServer
import io.ktor.server.engine.stop
import io.ktor.server.metrics.micrometer.MicrometerMetrics
import io.ktor.server.netty.Netty
import io.ktor.server.plugins.callid.CallId
import io.ktor.server.plugins.callid.callIdMdc
import io.ktor.server.plugins.callloging.CallLogging
import io.ktor.server.plugins.contentnegotiation.ContentNegotiation
import io.ktor.server.plugins.statuspages.StatusPages
import io.ktor.server.request.path
import io.ktor.server.response.respond
import io.ktor.server.routing.IgnoreTrailingSlash
import io.ktor.server.routing.routing
import no.nav.lydia.NaisEnvironment.Companion.Environment.`DEV-GCP`
import no.nav.lydia.NaisEnvironment.Companion.Environment.LOKAL
import no.nav.lydia.appstatus.*
import no.nav.lydia.exceptions.UautorisertException
import no.nav.lydia.ia.debug.debug
import no.nav.lydia.ia.eksport.IASakEksporterer
import no.nav.lydia.ia.eksport.IASakProdusent
import no.nav.lydia.ia.eksport.IASakshendelseProdusent
import no.nav.lydia.ia.eksport.KafkaProdusent
import no.nav.lydia.ia.eksport.iaSakEksporterer
import no.nav.lydia.ia.grunnlag.GrunnlagRepository
import no.nav.lydia.ia.grunnlag.GrunnlagService
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.api.iaSakRådgiver
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.årsak.db.ÅrsakRepository
import no.nav.lydia.ia.årsak.ÅrsakService
import no.nav.lydia.integrasjoner.azure.AzureTokenFetcher
import no.nav.lydia.integrasjoner.brreg.BrregDownloader
import no.nav.lydia.integrasjoner.brreg.virksomhetsImport
import no.nav.lydia.integrasjoner.ssb.NæringsDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsRepository
import no.nav.lydia.integrasjoner.ssb.næringsImport
import no.nav.lydia.sykefraversstatistikk.SykefraversstatistikkRepository
import no.nav.lydia.sykefraversstatistikk.SykefraværsstatistikkSiste4KvartalRepository
import no.nav.lydia.sykefraversstatistikk.SykefraværsstatistikkService
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService
import no.nav.lydia.sykefraversstatistikk.api.sykefraversstatistikk
import no.nav.lydia.sykefraversstatistikk.import.BrregOppdateringConsumer
import no.nav.lydia.sykefraversstatistikk.import.StatistikkConsumer
import no.nav.lydia.sykefraversstatistikk.import.StatistikkPerKategoriConsumer
import no.nav.lydia.veileder.VEILEDERE_PATH
import no.nav.lydia.veileder.veileder
import no.nav.lydia.virksomhet.VirksomhetRepository
import no.nav.lydia.virksomhet.VirksomhetService
import no.nav.lydia.virksomhet.api.VIRKSOMHET_PATH
import no.nav.lydia.virksomhet.api.virksomhet
import java.util.UUID
import java.util.concurrent.TimeUnit
import javax.sql.DataSource

fun main() {
    startLydiaBackend()
}

fun startLydiaBackend() {
    val naisEnv = NaisEnvironment()

    val dataSource = createDataSource(database = naisEnv.database)
    runMigration(dataSource = dataSource)

    HelseMonitor.leggTilHelsesjekk(DatabaseHelsesjekk(dataSource))

    val sykefraværsstatistikkService = SykefraværsstatistikkService(
        sykefraversstatistikkRepository = SykefraversstatistikkRepository(
            dataSource = dataSource
        ),
        sykefraværsstatistikkSiste4KvartalRepository = SykefraværsstatistikkSiste4KvartalRepository(dataSource = dataSource)
    )
    statistikkConsumer(
        kafka = naisEnv.kafka,
        sykefraværsstatistikkService = sykefraværsstatistikkService
    ).also { HelseMonitor.leggTilHelsesjekk(it) }
    brregConsumer(naisEnv = naisEnv, dataSource = dataSource)

    if (naisEnv.miljø == LOKAL || naisEnv.miljø == `DEV-GCP`) {
        StatistikkPerKategoriConsumer.apply {
            create(kafka = naisEnv.kafka, sykefraværsstatistikkService = sykefraværsstatistikkService)
            run()
        }
    }

    val kafkaProdusent = KafkaProdusent(naisEnv.kafka)
    val iaSakshendelseProdusent =
        IASakshendelseProdusent(produsent = kafkaProdusent, topic = naisEnv.kafka.iaSakHendelseTopic)
    val iaSakProdusent = IASakProdusent(produsent = kafkaProdusent, topic = naisEnv.kafka.iaSakTopic)

    embeddedServer(Netty, port = 8080) {
        lydiaRestApi(
            naisEnvironment = naisEnv,
            dataSource = dataSource,
            iaSakshendelseProdusent = iaSakshendelseProdusent,
            iaSakProdusent = iaSakProdusent
        )
    }.also {
        // https://doc.nais.io/nais-application/good-practices/#handles-termination-gracefully
        it.addShutdownHook {
            it.stop(3, 5, TimeUnit.SECONDS)
        }
    }.start(wait = true)
}

private fun brregConsumer(naisEnv: NaisEnvironment, dataSource: DataSource) {
    BrregOppdateringConsumer.apply {
        create(
            kafka = naisEnv.kafka,
            repository = VirksomhetRepository(dataSource)
        )
        run()
    }
}

fun Application.lydiaRestApi(
    naisEnvironment: NaisEnvironment,
    dataSource: DataSource,
    iaSakshendelseProdusent: IASakshendelseProdusent? = null,
    iaSakProdusent: IASakProdusent? = null
) {
    install(ContentNegotiation) {
        json()
    }
    install(CallId) {
        header(HttpHeaders.XRequestId)
        verify { callId: String ->
            callId.isNotEmpty() && Either.catch { UUID.fromString(callId) }.isRight()
        }
        generate {
            UUID.randomUUID().toString()
        }
    }
    install(CallLogging) {
        callIdMdc("requestId")
        disableDefaultColors()
        filter { call ->
            listOf(SYKEFRAVERSSTATISTIKK_PATH, IA_SAK_RADGIVER_PATH, VIRKSOMHET_PATH, VEILEDERE_PATH).any() {
                call.request.path().startsWith(it)
            }
        }
    }
    install(IgnoreTrailingSlash)

    install(MicrometerMetrics) {
        registry = Metrics.appMicrometerRegistry
    }

    val jwkProvider = JwkProviderBuilder(naisEnvironment.security.azureConfig.jwksUri)
        .cached(10, 24, TimeUnit.HOURS)
        .rateLimited(10, 1, TimeUnit.MINUTES)
        .build()
    install(Authentication) {
        jwt {
            verifier(jwkProvider, naisEnvironment.security.azureConfig.issuer)
            validate { credentials ->
                try {
                    requireNotNull(credentials.payload.audience) {
                        "Auth: Missing audience in token"
                    }
                    require(credentials.payload.audience.contains(naisEnvironment.security.azureConfig.clientId)) {
                        "Auth: Valid audience not found in claims"
                    }
                    JWTPrincipal(credentials.payload)
                } catch (e: Throwable) {
                    application.log.error("Feil under autentisering")
                    application.log.error(e.message)
                    null
                }
            }
        }
    }
    install(StatusPages) {
        exception<UautorisertException> { call, cause ->
            call.application.log.error("Ikke autorisert", cause)
            call.respond(HttpStatusCode.Forbidden)
        }
        exception<Throwable> { call, cause ->
            call.application.log.error("Det har skjedd en feil", cause)
            call.respond(HttpStatusCode.InternalServerError)
        }
    }
    val næringsRepository = NæringsRepository(dataSource = dataSource)
    val virksomhetRepository = VirksomhetRepository(dataSource = dataSource)
    val iaSakRepository = IASakRepository(dataSource = dataSource)
    val sykefraværsstatistikkService =
        SykefraværsstatistikkService(
            sykefraversstatistikkRepository = SykefraversstatistikkRepository(dataSource = dataSource),
            sykefraværsstatistikkSiste4KvartalRepository = SykefraværsstatistikkSiste4KvartalRepository(dataSource = dataSource)
        )
    val grunnlagRepository = GrunnlagRepository(dataSource = dataSource)
    val årsakRepository = ÅrsakRepository(dataSource = dataSource)
    val auditLog = AuditLog(naisEnvironment.miljø)
    val azureTokenFetcher = AzureTokenFetcher(naisEnvironment = naisEnvironment)

    routing {
        healthChecks(HelseMonitor)
        metrics()

        if (naisEnvironment.miljø == LOKAL)
            featureToggle()

        iaSakEksporterer(
            IASakEksporterer(
                iaSakRepository = iaSakRepository,
                iaSakProdusent = iaSakProdusent
            )
        )
        virksomhetsImport(
            BrregDownloader(
                url = naisEnvironment.integrasjoner.brregUnderEnhetUrl,
                virksomhetRepository = virksomhetRepository
            )
        )
        næringsImport(
            næringsDownloader = NæringsDownloader(
                url = naisEnvironment.integrasjoner.ssbNæringsUrl,
                næringsRepository = næringsRepository
            )
        )
        debug(iaSakRepository = iaSakRepository, iaSakshendelseRepository = IASakshendelseRepository(dataSource))

        authenticate {
            sykefraversstatistikk(
                geografiService = GeografiService(),
                sykefraværsstatistikkService = sykefraværsstatistikkService,
                næringsRepository = næringsRepository,
                auditLog = auditLog,
                naisEnvironment = naisEnvironment,
                azureTokenFetcher = azureTokenFetcher
            )
            iaSakRådgiver(
                iaSakService = IASakService(
                    iaSakRepository = iaSakRepository,
                    iaSakshendelseRepository = IASakshendelseRepository(dataSource = dataSource),
                    grunnlagService = GrunnlagService(
                        grunnlagRepository = grunnlagRepository,
                        sykefraværsstatistikkService = sykefraværsstatistikkService
                    ),
                    årsakService = ÅrsakService(årsakRepository = årsakRepository)
                ).apply {
                    iaSakshendelseProdusent?.also { leggTilIASakshendelseObserver(it) }
                    iaSakProdusent?.also { leggTilIASakObserver(it) }
                },
                fiaRoller = naisEnvironment.security.fiaRoller,
                auditLog = auditLog
            )
            virksomhet(
                virksomhetService = VirksomhetService(virksomhetRepository = virksomhetRepository),
                auditLog = auditLog,
                fiaRoller = naisEnvironment.security.fiaRoller
            )
            veileder(tokenFetcher = azureTokenFetcher, naisEnvironment = naisEnvironment)
        }
    }
}

fun statistikkConsumer(kafka: Kafka, sykefraværsstatistikkService: SykefraværsstatistikkService) =
    StatistikkConsumer.apply {
        create(kafka = kafka, sykefraværsstatistikkService = sykefraværsstatistikkService)
        run()
    }

