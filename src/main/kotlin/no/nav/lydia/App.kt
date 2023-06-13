/*
 * This Kotlin source file was generated by the Gradle 'init' task.
 */
package no.nav.lydia

import arrow.core.Either
import com.auth0.jwk.JwkProviderBuilder
import io.ktor.http.*
import io.ktor.serialization.kotlinx.json.*
import io.ktor.server.application.*
import io.ktor.server.auth.*
import io.ktor.server.auth.jwt.*
import io.ktor.server.engine.*
import io.ktor.server.metrics.micrometer.*
import io.ktor.server.netty.*
import io.ktor.server.plugins.callid.*
import io.ktor.server.plugins.callloging.*
import io.ktor.server.plugins.contentnegotiation.*
import io.ktor.server.plugins.statuspages.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import no.nav.lydia.NaisEnvironment.Companion.Environment.LOKAL
import no.nav.lydia.appstatus.*
import no.nav.lydia.exceptions.UautorisertException
import no.nav.lydia.ia.debug.debug
import no.nav.lydia.ia.eksport.*
import no.nav.lydia.ia.sak.IASakLeveranseObserver
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.api.iaSakRådgiver
import no.nav.lydia.ia.sak.db.IASakLeveranseRepository
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
import no.nav.lydia.statusoverikt.StatusoversiktRepository
import no.nav.lydia.statusoverikt.StatusoversiktService
import no.nav.lydia.statusoverikt.api.statusoversikt
import no.nav.lydia.sykefraversstatistikk.*
import no.nav.lydia.sykefraversstatistikk.api.SYKEFRAVERSSTATISTIKK_PATH
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService
import no.nav.lydia.sykefraversstatistikk.api.sykefraversstatistikk
import no.nav.lydia.sykefraversstatistikk.import.BrregOppdateringConsumer
import no.nav.lydia.sykefraversstatistikk.import.StatistikkConsumer
import no.nav.lydia.sykefraversstatistikk.import.StatistikkPerKategoriConsumer
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.integrasjoner.azure.navEnhet
import no.nav.lydia.virksomhet.VirksomhetRepository
import no.nav.lydia.virksomhet.VirksomhetService
import no.nav.lydia.virksomhet.api.VIRKSOMHET_PATH
import no.nav.lydia.virksomhet.api.virksomhet
import java.util.*
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

    val sistePubliseringService = SistePubliseringService(SistePubliseringRepository(dataSource = dataSource))
    val sykefraværsstatistikkService = SykefraværsstatistikkService(
        sistePubliseringService = sistePubliseringService,
        sykefraversstatistikkRepository = SykefraversstatistikkRepository(
            dataSource = dataSource
        ),
        virksomhetsinformasjonRepository = VirksomhetsinformasjonRepository(dataSource = dataSource)
    )
    statistikkConsumer(
        kafka = naisEnv.kafka,
        sykefraværsstatistikkService = sykefraværsstatistikkService
    ).also { HelseMonitor.leggTilHelsesjekk(it) }
    brregConsumer(naisEnv = naisEnv, dataSource = dataSource)

    StatistikkPerKategoriConsumer.apply {
        create(kafka = naisEnv.kafka, sykefraværsstatistikkService = sykefraværsstatistikkService)
        run()
    }.also { HelseMonitor.leggTilHelsesjekk(it) }

    embeddedServer(Netty, port = 8080) {
        lydiaRestApi(
            naisEnvironment = naisEnv,
            dataSource = dataSource,
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
) {
    val virksomhetService = VirksomhetService(virksomhetRepository = VirksomhetRepository(dataSource = dataSource))
    val næringsRepository = NæringsRepository(dataSource = dataSource)
    val virksomhetRepository = VirksomhetRepository(dataSource = dataSource)
    val iaSakRepository = IASakRepository(dataSource = dataSource)
    val sykefraværsstatistikkService =
        SykefraværsstatistikkService(
            sistePubliseringService = SistePubliseringService(sistePubliseringRepository = SistePubliseringRepository(dataSource = dataSource)),
            sykefraversstatistikkRepository = SykefraversstatistikkRepository(dataSource = dataSource),
            virksomhetsinformasjonRepository = VirksomhetsinformasjonRepository(dataSource = dataSource)
        )
    val årsakRepository = ÅrsakRepository(dataSource = dataSource)
    val auditLog = AuditLog(naisEnvironment.miljø)
    val sistePubliseringService = SistePubliseringService(SistePubliseringRepository(dataSource = dataSource))
    val kafkaProdusent = KafkaProdusent(naisEnvironment.kafka)
    val iaSakProdusent = IASakProdusent(produsent = kafkaProdusent, topic = naisEnvironment.kafka.iaSakTopic)
    val iaSakStatistikkProdusent = IASakStatistikkProdusent(
        produsent = kafkaProdusent,
        virksomhetService = virksomhetService,
        sykefraværsstatistikkService = sykefraværsstatistikkService,
        iaSakshendelseRepository = IASakshendelseRepository(dataSource = dataSource),
        geografiService = GeografiService(),
        sistePubliseringService = sistePubliseringService,
        topic = naisEnvironment.kafka.iaSakStatistikkTopic
    )
    val iaSakStatusProdusent = IASakStatusProdusent(
        produsent = kafkaProdusent,
        topic = naisEnvironment.kafka.iaSakStatusTopic,
    )
    val azureService = AzureService(
        tokenFetcher = AzureTokenFetcher(naisEnvironment = naisEnvironment),
        security = naisEnvironment.security
    )
    val iaSakLeveranseProdusent = IASakLeveranseProdusent(
        produsent = kafkaProdusent,
        topic = naisEnvironment.kafka.iaSakLeveranseTopic,
        azureService = azureService
    )
    val iaSakLeveranseObserver = IASakLeveranseObserver(iaSakRepository)

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
            listOf(SYKEFRAVERSSTATISTIKK_PATH, IA_SAK_RADGIVER_PATH, VIRKSOMHET_PATH).any {
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
            call.application.log.error("Det har skjedd en feil: ${cause.message}", cause)
            call.respond(HttpStatusCode.InternalServerError)
        }
    }

    routing {
        healthChecks(HelseMonitor)
        metrics()

        if (naisEnvironment.miljø == LOKAL)
            featureToggle()

        iaSakEksporterer(
            iaSakEksporterer = IASakEksporterer(
                iaSakRepository = iaSakRepository,
                iaSakProdusent = iaSakProdusent
            ),
            iaSakStatistikkEksporterer = IASakStatistikkEksporterer(
                iaSakRepository = iaSakRepository,
                iaSakshendelseRepository = IASakshendelseRepository(dataSource = dataSource),
                iaSakStatistikkProdusent = iaSakStatistikkProdusent,
            ),
            iaSakLeveranseEksportør = IASakLeveranseEksportør(
                iaSakLeveranseRepository = IASakLeveranseRepository(dataSource = dataSource),
                iaSakLeveranseProdusent = iaSakLeveranseProdusent,
            ),
            iaSakStatusExportør = IASakStatusEksportør(
                iaSakRepository = IASakRepository(dataSource = dataSource),
                iaSakStatusProdusent = iaSakStatusProdusent,
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
                azureService = azureService,
                sistePubliseringService = sistePubliseringService,
            )
            iaSakRådgiver(
                iaSakService = IASakService(
                    iaSakRepository = iaSakRepository,
                    iaSakshendelseRepository = IASakshendelseRepository(dataSource = dataSource),
                    iaSakLeveranseRepository = IASakLeveranseRepository(dataSource = dataSource),
                    årsakService = ÅrsakService(årsakRepository = årsakRepository)
                ).apply {
                    leggTilIASakObservers(iaSakProdusent, iaSakStatistikkProdusent, iaSakStatusProdusent)
                    leggTilIASakLeveranseObservers(iaSakLeveranseProdusent, iaSakLeveranseObserver)
                },
                adGrupper = naisEnvironment.security.adGrupper,
                auditLog = auditLog,
                azureService = azureService,
            )
            virksomhet(
                virksomhetService = VirksomhetService(virksomhetRepository = virksomhetRepository),
                auditLog = auditLog,
                adGrupper = naisEnvironment.security.adGrupper
            )
            statusoversikt(
                sistePubliseringService = sistePubliseringService,
                geografiService = GeografiService(),
                statusoversiktService = StatusoversiktService(
                    statusoversiktRepository = StatusoversiktRepository(dataSource = dataSource)
                ),
                auditLog = auditLog,
                naisEnvironment = naisEnvironment
            )
            navEnhet(azureService = azureService)
        }
    }
}

fun statistikkConsumer(kafka: Kafka, sykefraværsstatistikkService: SykefraværsstatistikkService) =
    StatistikkConsumer.apply {
        create(kafka = kafka, sykefraværsstatistikkService = sykefraværsstatistikkService)
        run()
    }

