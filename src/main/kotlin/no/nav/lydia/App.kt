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
import no.nav.lydia.appstatus.DatabaseHelsesjekk
import no.nav.lydia.appstatus.HelseMonitor
import no.nav.lydia.appstatus.Metrics
import no.nav.lydia.appstatus.healthChecks
import no.nav.lydia.appstatus.metrics
import no.nav.lydia.exceptions.UautorisertException
import no.nav.lydia.ia.eksport.IASakEksporterer
import no.nav.lydia.ia.eksport.SpørreundersøkelseProdusent
import no.nav.lydia.ia.eksport.IASakLeveranseEksportør
import no.nav.lydia.ia.eksport.IASakLeveranseProdusent
import no.nav.lydia.ia.eksport.IASakProdusent
import no.nav.lydia.ia.eksport.IASakStatistikkEksporterer
import no.nav.lydia.ia.eksport.IASakStatistikkProdusent
import no.nav.lydia.ia.eksport.IASakStatusEksportør
import no.nav.lydia.ia.eksport.IASakStatusProdusent
import no.nav.lydia.ia.eksport.KafkaProdusent
import no.nav.lydia.ia.eksport.SpørreundersøkelseAntallSvarProdusent
import no.nav.lydia.ia.sak.IASakLeveranseObserver
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.api.iaSakRådgiver
import no.nav.lydia.ia.sak.api.kartlegging.iaSakKartlegging
import no.nav.lydia.ia.sak.db.IASakLeveranseRepository
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.årsak.db.ÅrsakRepository
import no.nav.lydia.ia.årsak.ÅrsakService
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.integrasjoner.azure.AzureTokenFetcher
import no.nav.lydia.integrasjoner.brreg.BrregAlleVirksomheterConsumer
import no.nav.lydia.integrasjoner.brreg.BrregOppdateringConsumer
import no.nav.lydia.integrasjoner.jobblytter.Jobblytter
import no.nav.lydia.integrasjoner.salesforce.SalesforceClient
import no.nav.lydia.integrasjoner.ssb.NæringsDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsRepository
import no.nav.lydia.iatjenesteoversikt.IATjenesteoversiktRepository
import no.nav.lydia.iatjenesteoversikt.IATjenesteoversiktService
import no.nav.lydia.iatjenesteoversikt.api.iaTjenesteoversikt
import no.nav.lydia.statusoversikt.StatusoversiktRepository
import no.nav.lydia.statusoversikt.StatusoversiktService
import no.nav.lydia.statusoversikt.api.statusoversikt
import no.nav.lydia.sykefraværsstatistikk.SistePubliseringRepository
import no.nav.lydia.sykefraværsstatistikk.SistePubliseringService
import no.nav.lydia.sykefraværsstatistikk.SykefraværsstatistikkRepository
import no.nav.lydia.sykefraværsstatistikk.SykefraværsstatistikkService
import no.nav.lydia.sykefraværsstatistikk.VirksomhetsinformasjonRepository
import no.nav.lydia.sykefraværsstatistikk.api.SYKEFRAVÆRSSTATISTIKK_PATH
import no.nav.lydia.sykefraværsstatistikk.api.geografi.GeografiService
import no.nav.lydia.sykefraværsstatistikk.api.sykefraværsstatistikk
import no.nav.lydia.sykefraværsstatistikk.import.StatistikkMetadataVirksomhetConsumer
import no.nav.lydia.sykefraværsstatistikk.import.StatistikkPerKategoriConsumer
import no.nav.lydia.sykefraværsstatistikk.import.StatistikkVirksomhetGraderingConsumer
import no.nav.lydia.vedlikehold.IASakStatusOppdaterer
import no.nav.lydia.vedlikehold.StatistikkViewOppdaterer
import no.nav.lydia.virksomhet.VirksomhetRepository
import no.nav.lydia.virksomhet.VirksomhetService
import no.nav.lydia.virksomhet.api.VIRKSOMHET_PATH
import no.nav.lydia.virksomhet.api.virksomhet
import java.util.*
import java.util.concurrent.TimeUnit
import javax.sql.DataSource
import no.nav.lydia.integrasjoner.kartlegging.KartleggingRepository
import no.nav.lydia.integrasjoner.kartlegging.KartleggingService
import no.nav.lydia.integrasjoner.kartlegging.KartleggingSvarConsumer

fun main() {
    startLydiaBackend()
}

fun startLydiaBackend() {
    val naisEnv = NaisEnvironment()

    val dataSource = createDataSource(database = naisEnv.database)
    runMigration(dataSource = dataSource)

    val virksomhetRepository = VirksomhetRepository(dataSource = dataSource)
    val næringsRepository = NæringsRepository(dataSource = dataSource)
    val iaSakRepository = IASakRepository(dataSource = dataSource)
    val kartleggingRepository = KartleggingRepository(dataSource = dataSource)

    val virksomhetService = VirksomhetService(virksomhetRepository = virksomhetRepository)
    val sykefraværsstatistikkService =
        SykefraværsstatistikkService(
            sykefraværsstatistikkRepository = SykefraværsstatistikkRepository(dataSource = dataSource),
            virksomhetsinformasjonRepository = VirksomhetsinformasjonRepository(dataSource = dataSource),
            sistePubliseringService = SistePubliseringService(SistePubliseringRepository(dataSource = dataSource)),
            virksomhetRepository = virksomhetRepository,
        )
    val årsakRepository = ÅrsakRepository(dataSource = dataSource)
    val auditLog = AuditLog(naisEnv.miljø)
    val sistePubliseringService = SistePubliseringService(SistePubliseringRepository(dataSource = dataSource))
    val kafkaProdusent = KafkaProdusent(naisEnv.kafka)
    val iaSakProdusent = IASakProdusent(produsent = kafkaProdusent)
    val iaSakStatistikkProdusent = IASakStatistikkProdusent(
        produsent = kafkaProdusent,
        virksomhetService = virksomhetService,
        sykefraværsstatistikkService = sykefraværsstatistikkService,
        iaSakshendelseRepository = IASakshendelseRepository(dataSource = dataSource),
        geografiService = GeografiService(),
        sistePubliseringService = sistePubliseringService,
    )
    val iaSakStatusProdusent = IASakStatusProdusent(
        produsent = kafkaProdusent,
        iaSakRepository = iaSakRepository,
    )
    val azureService = AzureService(
        tokenFetcher = AzureTokenFetcher(naisEnvironment = naisEnv),
        security = naisEnv.security
    )
    val iaSakLeveranseProdusent = IASakLeveranseProdusent(
        produsent = kafkaProdusent,
        azureService = azureService
    )
    val iaSakLeveranseObserver = IASakLeveranseObserver(iaSakRepository)

    val iaSakService = IASakService(
        iaSakRepository = iaSakRepository,
        iaSakshendelseRepository = IASakshendelseRepository(dataSource = dataSource),
        iaSakLeveranseRepository = IASakLeveranseRepository(dataSource = dataSource),
        årsakService = ÅrsakService(årsakRepository = årsakRepository),
    ).apply {
        leggTilIASakObservers(iaSakProdusent, iaSakStatistikkProdusent, iaSakStatusProdusent)
        leggTilIASakLeveranseObservers(iaSakLeveranseProdusent, iaSakLeveranseObserver)
    }

    val kartleggingService = KartleggingService(
        kartleggingRepository = kartleggingRepository,
        spørreundersøkelseProdusent = SpørreundersøkelseProdusent(
            produsent = kafkaProdusent,
        ),
        spørreundersøkelseAntallSvarProdusent = SpørreundersøkelseAntallSvarProdusent(
            produsent = kafkaProdusent
        ),
    )

    HelseMonitor.leggTilHelsesjekk(DatabaseHelsesjekk(dataSource))

    brregConsumer(naisEnv = naisEnv, dataSource = dataSource)
    brregAlleVirksomheterConsumer(naisEnv = naisEnv, dataSource = dataSource)

    jobblytter(
        naisEnv = naisEnv,
        iaSakStatusOppdaterer = IASakStatusOppdaterer(iaSakService = iaSakService),
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
        ),
        næringsDownloader = NæringsDownloader(
            url = naisEnv.integrasjoner.ssbNæringsUrl,
            næringsRepository = næringsRepository
        ),
        statistikkViewOppdaterer = StatistikkViewOppdaterer(
            dataSource = dataSource
        ),
    )

    listOf(
        Topic.STATISTIKK_LAND_TOPIC,
        Topic.STATISTIKK_SEKTOR_TOPIC,
        Topic.STATISTIKK_BRANSJE_TOPIC,
        Topic.STATISTIKK_NARING_TOPIC,
        Topic.STATISTIKK_NARINGSKODE_TOPIC,
        Topic.STATISTIKK_VIRKSOMHET_TOPIC,
    ).forEach { topic ->
        StatistikkPerKategoriConsumer(topic = topic).apply {
            create(kafka = naisEnv.kafka, sykefraværsstatistikkService = sykefraværsstatistikkService)
            run()
        }.also { HelseMonitor.leggTilHelsesjekk(it) }
    }

    StatistikkVirksomhetGraderingConsumer.apply {
        create(kafka = naisEnv.kafka, sykefraværsstatistikkService = sykefraværsstatistikkService)
        run()
    }.also { HelseMonitor.leggTilHelsesjekk(it) }

    StatistikkMetadataVirksomhetConsumer.apply {
        create(kafka = naisEnv.kafka, sykefraværsstatistikkService = sykefraværsstatistikkService)
        run()
    }.also { HelseMonitor.leggTilHelsesjekk(it) }

    KartleggingSvarConsumer().apply {
        create(kafka = naisEnv.kafka, kartleggingService = kartleggingService)
        run()
    }.also { HelseMonitor.leggTilHelsesjekk(it) }

    embeddedServer(Netty, port = 8080) {
        lydiaRestApi(
            naisEnv = naisEnv,
            dataSource = dataSource,
            næringsRepository = næringsRepository,
            sykefraværsstatistikkService = sykefraværsstatistikkService,
            auditLog = auditLog,
            azureService = azureService,
            sistePubliseringService = sistePubliseringService,
            virksomhetRepository = virksomhetRepository,
            iaSakService = iaSakService,
            kartleggingService = kartleggingService
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

private fun brregAlleVirksomheterConsumer(naisEnv: NaisEnvironment, dataSource: DataSource) {
    BrregAlleVirksomheterConsumer.apply {
        create(
            kafka = naisEnv.kafka,
            repository = VirksomhetRepository(dataSource)
        )
        run()
    }
}

private fun jobblytter(
    naisEnv: NaisEnvironment,
    iaSakStatusOppdaterer: IASakStatusOppdaterer,
    iaSakEksporterer: IASakEksporterer,
    iaSakStatistikkEksporterer: IASakStatistikkEksporterer,
    iaSakLeveranseEksportør: IASakLeveranseEksportør,
    iaSakStatusExportør: IASakStatusEksportør,
    næringsDownloader: NæringsDownloader,
    statistikkViewOppdaterer: StatistikkViewOppdaterer,
) {
    Jobblytter.apply {
        create(
            kafka = naisEnv.kafka,
            iaSakStatusOppdaterer = iaSakStatusOppdaterer,
            iaSakEksporterer = iaSakEksporterer,
            iaSakStatistikkEksporterer = iaSakStatistikkEksporterer,
            iaSakLeveranseEksportør = iaSakLeveranseEksportør,
            iaSakStatusExportør = iaSakStatusExportør,
            næringsDownloader = næringsDownloader,
            statistikkViewOppdaterer = statistikkViewOppdaterer
        )
        run()
    }
}

private fun Application.lydiaRestApi(
    naisEnv: NaisEnvironment,
    dataSource: DataSource,
    næringsRepository: NæringsRepository,
    sykefraværsstatistikkService: SykefraværsstatistikkService,
    auditLog: AuditLog,
    azureService: AzureService,
    sistePubliseringService: SistePubliseringService,
    virksomhetRepository: VirksomhetRepository,
    iaSakService: IASakService,
    kartleggingService: KartleggingService
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
            listOf(SYKEFRAVÆRSSTATISTIKK_PATH, IA_SAK_RADGIVER_PATH, VIRKSOMHET_PATH).any {
                call.request.path().startsWith(it)
            }
        }
    }
    install(IgnoreTrailingSlash)

    install(MicrometerMetrics) {
        registry = Metrics.appMicrometerRegistry
    }

    val jwkProvider = JwkProviderBuilder(naisEnv.security.azureConfig.jwksUri)
        .cached(10, 24, TimeUnit.HOURS)
        .rateLimited(10, 1, TimeUnit.MINUTES)
        .build()
    install(Authentication) {
        jwt {
            verifier(jwkProvider, naisEnv.security.azureConfig.issuer)
            validate { credentials ->
                try {
                    requireNotNull(credentials.payload.audience) {
                        "Auth: Missing audience in token"
                    }
                    require(credentials.payload.audience.contains(naisEnv.security.azureConfig.clientId)) {
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

        authenticate {
            sykefraværsstatistikk(
                geografiService = GeografiService(),
                sykefraværsstatistikkService = sykefraværsstatistikkService,
                næringsRepository = næringsRepository,
                auditLog = auditLog,
                naisEnvironment = naisEnv,
                azureService = azureService,
                sistePubliseringService = sistePubliseringService,
            )
            iaSakRådgiver(
                iaSakService = iaSakService,
                adGrupper = naisEnv.security.adGrupper,
                auditLog = auditLog,
                azureService = azureService,
            )
            iaSakKartlegging(
                iaSakService = iaSakService,
                adGrupper = naisEnv.security.adGrupper,
                auditLog = auditLog,
                kartleggingService = kartleggingService
            )
            virksomhet(
                virksomhetService = VirksomhetService(virksomhetRepository = virksomhetRepository),
                salesforceClient = SalesforceClient(salesforce = naisEnv.integrasjoner.salesforce),
                auditLog = auditLog,
                adGrupper = naisEnv.security.adGrupper,
            )
            iaTjenesteoversikt(
                iaTjenesteoversiktService = IATjenesteoversiktService(
                    iaTjenesteoversiktRepository = IATjenesteoversiktRepository(dataSource)
                ),
                auditLog = auditLog,
                naisEnvironment = naisEnv,
            )
            statusoversikt(
                geografiService = GeografiService(),
                statusoversiktService = StatusoversiktService(
                    statusoversiktRepository = StatusoversiktRepository(dataSource = dataSource)
                ),
                auditLog = auditLog,
                naisEnvironment = naisEnv
            )
        }
    }
}
