/*
 * This Kotlin source file was generated by the Gradle 'init' task.
 */
package no.nav.lydia

import com.auth0.jwk.JwkProviderBuilder
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
import io.ktor.server.plugins.contentnegotiation.ContentNegotiation
import io.ktor.server.plugins.statuspages.StatusPages
import io.ktor.server.response.respond
import io.ktor.server.routing.IgnoreTrailingSlash
import io.ktor.server.routing.routing
import no.nav.lydia.appstatus.Metrics
import no.nav.lydia.appstatus.healthChecks
import no.nav.lydia.appstatus.metrics
import no.nav.lydia.exceptions.UatorisertException
import no.nav.lydia.ia.eksport.IASakProdusent
import no.nav.lydia.ia.eksport.IASakshendelseProdusent
import no.nav.lydia.ia.eksport.KafkaProdusent
import no.nav.lydia.ia.grunnlag.GrunnlagRepository
import no.nav.lydia.ia.grunnlag.GrunnlagService
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.api.iaSakRådgiver
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.årsak.db.ÅrsakRepository
import no.nav.lydia.ia.årsak.ÅrsakService
import no.nav.lydia.integrasjoner.brreg.BrregDownloader
import no.nav.lydia.integrasjoner.brreg.virksomhetsImport
import no.nav.lydia.integrasjoner.ssb.NæringsDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsRepository
import no.nav.lydia.integrasjoner.ssb.næringsImport
import no.nav.lydia.sykefraversstatistikk.SykefraversstatistikkRepository
import no.nav.lydia.sykefraversstatistikk.SykefraværsstatistikkService
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService
import no.nav.lydia.sykefraversstatistikk.api.sykefraversstatistikk
import no.nav.lydia.sykefraversstatistikk.import.BrregOppdateringConsumer
import no.nav.lydia.sykefraversstatistikk.import.StatistikkConsumer
import no.nav.lydia.virksomhet.VirksomhetRepository
import no.nav.lydia.virksomhet.VirksomhetService
import no.nav.lydia.virksomhet.api.virksomhet
import java.util.concurrent.TimeUnit
import javax.sql.DataSource

fun main() {
    startLydiaBackend()
}

fun startLydiaBackend() {
    val naisEnv = NaisEnvironment()

    val dataSource = createDataSource(database = naisEnv.database)
    runMigration(dataSource = dataSource)

    statistikkConsumer(
        kafka = naisEnv.kafka,
        sykefraværsstatistikkService = SykefraværsstatistikkService(
            sykefraversstatistikkRepository = SykefraversstatistikkRepository(
                dataSource = dataSource
            )
        )
    )
    brregConsumer(naisEnv = naisEnv, dataSource = dataSource)

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
                    require(credentials.payload.audience.contains(naisEnvironment.security.azureConfig.audience)) {
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
        exception<Throwable> { call, cause ->
            call.application.log.error("Det har skjedd en feil", cause)
            call.respond(HttpStatusCode.InternalServerError)
        }
        exception<UatorisertException> { call, cause ->
            call.application.log.error("Ikke autorisert", cause)
            call.respond(HttpStatusCode.Forbidden)
        }
    }
    val næringsRepository = NæringsRepository(dataSource = dataSource)
    val virksomhetRepository = VirksomhetRepository(dataSource = dataSource)
    val sykefraværsstatistikkService =
        SykefraværsstatistikkService(sykefraversstatistikkRepository = SykefraversstatistikkRepository(dataSource = dataSource))
    val grunnlagRepository = GrunnlagRepository(dataSource = dataSource)
    val årsakRepository = ÅrsakRepository(dataSource = dataSource)
    val auditLog = AuditLog(naisEnvironment.miljø)

    routing {
        healthChecks()
        metrics()
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
        authenticate {
            sykefraversstatistikk(
                geografiService = GeografiService(),
                sykefraværsstatistikkService = sykefraværsstatistikkService,
                næringsRepository = næringsRepository,
                auditLog = auditLog,
                fiaRoller = naisEnvironment.security.fiaRoller
            )
            iaSakRådgiver(
                iaSakService = IASakService(
                    iaSakRepository = IASakRepository(dataSource = dataSource),
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
        }
    }
}

fun statistikkConsumer(kafka: Kafka, sykefraværsstatistikkService: SykefraværsstatistikkService) =
    StatistikkConsumer.apply {
        create(kafka = kafka, sykefraværsstatistikkService = sykefraværsstatistikkService)
        run()
    }

