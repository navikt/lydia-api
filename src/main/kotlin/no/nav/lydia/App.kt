/*
 * This Kotlin source file was generated by the Gradle 'init' task.
 */
package no.nav.lydia

import com.auth0.jwk.JwkProviderBuilder
import io.ktor.http.*
import io.ktor.serialization.kotlinx.json.*
import io.ktor.server.application.*
import io.ktor.server.auth.*
import io.ktor.server.auth.jwt.*
import io.ktor.server.engine.*
import io.ktor.server.metrics.micrometer.*
import io.ktor.server.netty.*
import io.ktor.server.plugins.contentnegotiation.*
import io.ktor.server.plugins.statuspages.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import no.nav.lydia.appstatus.Metrics
import no.nav.lydia.appstatus.healthChecks
import no.nav.lydia.appstatus.metrics
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.api.IASak_Rådgiver
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.integrasjoner.brreg.BrregDownloader
import no.nav.lydia.integrasjoner.brreg.virksomhetsImport
import no.nav.lydia.integrasjoner.ssb.NæringsDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsRepository
import no.nav.lydia.integrasjoner.ssb.næringsImport
import no.nav.lydia.sykefraversstatistikk.SykefraversstatistikkRepository
import no.nav.lydia.sykefraversstatistikk.api.geografi.GeografiService
import no.nav.lydia.sykefraversstatistikk.api.sykefraversstatistikk
import no.nav.lydia.sykefraversstatistikk.import.StatistikkConsumer
import no.nav.lydia.virksomhet.VirksomhetRepository
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
        sykefraversstatistikkRepository = SykefraversstatistikkRepository(dataSource = dataSource)
    )

    embeddedServer(Netty, port = 8080) {
        lydiaRestApi(naisEnvironment = naisEnv, dataSource = dataSource)
    }.also {
        // https://doc.nais.io/nais-application/good-practices/#handles-termination-gracefully
        it.addShutdownHook {
            it.stop(3, 5, TimeUnit.SECONDS)
        }
    }.start(wait = true)
}

fun Application.lydiaRestApi(naisEnvironment: NaisEnvironment, dataSource: DataSource) {
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
            call.application.log.error("Det har skjedd en feil bro!", cause)
            call.respond(HttpStatusCode.InternalServerError)
        }
    }

    val næringsRepository = NæringsRepository(dataSource = dataSource)
    val virksomhetRepository = VirksomhetRepository(dataSource)

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
                næringsRepository = næringsRepository)
        )
        authenticate {
            sykefraversstatistikk(
                geografiService = GeografiService(),
                sykefraversstatistikkRepository = SykefraversstatistikkRepository(dataSource = dataSource),
                næringsRepository = næringsRepository)
            IASak_Rådgiver(
                iaSakService = IASakService(
                    iaSakRepository = IASakRepository(dataSource = dataSource),
                    iaSakshendelseRepository = IASakshendelseRepository(dataSource = dataSource)
                ), fiaRoller = naisEnvironment.security.fiaRoller
            )
            virksomhet(virksomhetRepository = virksomhetRepository)
        }
    }
}

fun statistikkConsumer(kafka: Kafka, sykefraversstatistikkRepository: SykefraversstatistikkRepository) =
    StatistikkConsumer.apply {
        create(kafka = kafka, sykefraversstatistikkRepository = sykefraversstatistikkRepository)
        run()
    }

