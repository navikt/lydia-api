package no.nav.lydia

import arrow.core.Either
import io.ktor.http.HttpHeaders
import io.ktor.http.HttpStatusCode
import io.ktor.serialization.kotlinx.json.json
import io.ktor.server.application.Application
import io.ktor.server.application.install
import io.ktor.server.application.log
import io.ktor.server.auth.authenticate
import io.ktor.server.engine.addShutdownHook
import io.ktor.server.engine.embeddedServer
import io.ktor.server.metrics.micrometer.MicrometerMetrics
import io.ktor.server.netty.Netty
import io.ktor.server.plugins.callid.CallId
import io.ktor.server.plugins.callid.callIdMdc
import io.ktor.server.plugins.calllogging.CallLogging
import io.ktor.server.plugins.contentnegotiation.ContentNegotiation
import io.ktor.server.plugins.statuspages.StatusPages
import io.ktor.server.request.path
import io.ktor.server.response.respond
import io.ktor.server.routing.IgnoreTrailingSlash
import io.ktor.server.routing.routing
import no.nav.lydia.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.api.SYKEFRAVÆRSSTATISTIKK_PATH
import no.nav.lydia.api.VIRKSOMHET_PATH
import no.nav.lydia.api.dokumentPublisering
import no.nav.lydia.api.iaSakPlan
import no.nav.lydia.api.iaSakRådgiver
import no.nav.lydia.api.iaSakSpørreundersøkelse
import no.nav.lydia.api.iaSakTeam
import no.nav.lydia.api.iaSamarbeid
import no.nav.lydia.api.nyFlyt
import no.nav.lydia.api.nyFlytKartlegging
import no.nav.lydia.api.nyFlytSamarbeidsplan
import no.nav.lydia.api.nyFlytVirksomhet
import no.nav.lydia.api.samarbeid
import no.nav.lydia.api.statusoversikt
import no.nav.lydia.api.sykefraværsstatistikk
import no.nav.lydia.api.virksomhet
import no.nav.lydia.appstatus.DatabaseHelsesjekk
import no.nav.lydia.appstatus.HelseMonitor
import no.nav.lydia.appstatus.Metrics
import no.nav.lydia.appstatus.healthChecks
import no.nav.lydia.appstatus.metrics
import no.nav.lydia.dokumentpublisering.DokumentPubliseringProdusent
import no.nav.lydia.dokumentpublisering.DokumentPubliseringRepository
import no.nav.lydia.dokumentpublisering.DokumentPubliseringService
import no.nav.lydia.integrasjoner.azure.AzureService
import no.nav.lydia.integrasjoner.azure.AzureTokenFetcher
import no.nav.lydia.integrasjoner.brreg.BrregAlleVirksomheterConsumer
import no.nav.lydia.integrasjoner.brreg.BrregOppdateringConsumer
import no.nav.lydia.integrasjoner.jobblytter.Jobblytter
import no.nav.lydia.integrasjoner.journalpost.JournalpostService
import no.nav.lydia.integrasjoner.kartlegging.KartleggingSvarConsumer
import no.nav.lydia.integrasjoner.kartlegging.SpørreundersøkelseHendelseConsumer
import no.nav.lydia.integrasjoner.kvittering.KvitteringConsumer
import no.nav.lydia.integrasjoner.pdfgen.PiaPdfgenService
import no.nav.lydia.integrasjoner.salesforce.aktiviteter.SalesforceAktivitetConsumer
import no.nav.lydia.integrasjoner.salesforce.aktiviteter.SalesforceAktivitetRepository
import no.nav.lydia.integrasjoner.salesforce.aktiviteter.SalesforceAktivitetService
import no.nav.lydia.integrasjoner.salesforce.http.SalesforceClient
import no.nav.lydia.integrasjoner.ssb.NæringsDownloader
import no.nav.lydia.integrasjoner.ssb.NæringsRepository
import no.nav.lydia.kartlegging.FullførtBehovsvurderingProdusent
import no.nav.lydia.kartlegging.SpørreundersøkelseBigqueryEksporterer
import no.nav.lydia.kartlegging.SpørreundersøkelseBigqueryProdusent
import no.nav.lydia.kartlegging.SpørreundersøkelseMetrikkObserver
import no.nav.lydia.kartlegging.SpørreundersøkelseOppdateringProdusent
import no.nav.lydia.kartlegging.SpørreundersøkelseProdusent
import no.nav.lydia.kartlegging.SpørreundersøkelseRepository
import no.nav.lydia.kartlegging.SpørreundersøkelseService
import no.nav.lydia.prioritering.StatistikkViewOppdaterer
import no.nav.lydia.prioritering.sykefraværsstatistikk.api.geografi.GeografiService
import no.nav.lydia.prioritering.sykefraværsstatistikk.import.StatistikkMetadataVirksomhetConsumer
import no.nav.lydia.prioritering.sykefraværsstatistikk.import.StatistikkVirksomhetGraderingConsumer
import no.nav.lydia.prioritering.virksomhet.VirksomhetRepository
import no.nav.lydia.prioritering.virksomhet.VirksomhetService
import no.nav.lydia.samarbeid.IASamarbeidRepository
import no.nav.lydia.samarbeid.IASamarbeidService
import no.nav.lydia.samarbeid.SamarbeidBigqueryEksporterer
import no.nav.lydia.samarbeid.SamarbeidBigqueryProdusent
import no.nav.lydia.samarbeid.SamarbeidKafkaEksporterer
import no.nav.lydia.samarbeid.SamarbeidProdusent
import no.nav.lydia.samarbeid.SendSamarbeidPåKafkaObserver
import no.nav.lydia.samarbeidsperiode.IASakDtoProdusent
import no.nav.lydia.samarbeidsperiode.IASakDtoStatistikkProdusent
import no.nav.lydia.samarbeidsperiode.IASakEksporterer
import no.nav.lydia.samarbeidsperiode.IASakLeveranseRepository
import no.nav.lydia.samarbeidsperiode.IASakRepository
import no.nav.lydia.samarbeidsperiode.IASakService
import no.nav.lydia.samarbeidsperiode.IASakStatusOppdaterer
import no.nav.lydia.samarbeidsperiode.IASakshendelseRepository
import no.nav.lydia.samarbeidsplan.OppdaterSistEndretPlanObserver
import no.nav.lydia.samarbeidsplan.PlanRepository
import no.nav.lydia.samarbeidsplan.PlanService
import no.nav.lydia.samarbeidsplan.SamarbeidplanMetrikkObserver
import no.nav.lydia.samarbeidsplan.SamarbeidsplanBigqueryEksporterer
import no.nav.lydia.samarbeidsplan.SamarbeidsplanBigqueryProdusent
import no.nav.lydia.samarbeidsplan.SamarbeidsplanKafkaEksporterer
import no.nav.lydia.samarbeidsplan.SamarbeidsplanProdusent
import no.nav.lydia.samarbeidsplan.SendPlanPåKafkaObserver
import no.nav.lydia.statusoversikt.StatusoversiktRepository
import no.nav.lydia.statusoversikt.StatusoversiktService
import no.nav.lydia.team.IATeamRepository
import no.nav.lydia.team.IATeamService
import no.nav.lydia.tilgangskontroll.obo.OboTokenUtveksler
import no.nav.lydia.tilstandsmaskin.NyFlytService
import no.nav.lydia.tilstandsmaskin.TilstandVirksomhetOppdaterer
import no.nav.lydia.tilstandsmaskin.TilstandVirksomhetRepository
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

    val virksomhetRepository = VirksomhetRepository(dataSource = dataSource)
    val næringsRepository = NæringsRepository(dataSource = dataSource)
    val iaSakRepository = IASakRepository(dataSource = dataSource)
    val iaTeamRepository = IATeamRepository(dataSource = dataSource)
    val spørreundersøkelseRepository = SpørreundersøkelseRepository(dataSource = dataSource)
    val samarbeidRepository = IASamarbeidRepository(dataSource = dataSource)
    val planRepository = PlanRepository(dataSource = dataSource)
    val samarbeidsplanProdusent = SamarbeidsplanProdusent(kafka = naisEnv.kafka)
    val samarbeidProdusent = SamarbeidProdusent(kafka = naisEnv.kafka)

    val sykefraværsstatistikkService = _root_ide_package_.no.nav.lydia.prioritering.sykefraværsstatistikk.SykefraværsstatistikkService(
        sykefraværsstatistikkRepository = _root_ide_package_.no.nav.lydia.prioritering.sykefraværsstatistikk.SykefraværsstatistikkRepository(
            dataSource = dataSource,
        ),
        virksomhetsinformasjonRepository = _root_ide_package_.no.nav.lydia.prioritering.sykefraværsstatistikk.VirksomhetsinformasjonRepository(
            dataSource = dataSource,
        ),
        sistePubliseringService = _root_ide_package_.no.nav.lydia.prioritering.sykefraværsstatistikk.SistePubliseringService(
            _root_ide_package_.no.nav.lydia.prioritering.sykefraværsstatistikk.SistePubliseringRepository(
                dataSource = dataSource,
            ),
        ),
        virksomhetRepository = virksomhetRepository,
    )
    val auditLog = AuditLog(naisEnv.miljø)
    val sistePubliseringService = _root_ide_package_.no.nav.lydia.prioritering.sykefraværsstatistikk.SistePubliseringService(
        _root_ide_package_.no.nav.lydia.prioritering.sykefraværsstatistikk.SistePubliseringRepository(dataSource = dataSource),
    )
    val iaSakDtoProdusent = IASakDtoProdusent(kafka = naisEnv.kafka)
    val iaSakDtoStatistikkProdusent = IASakDtoStatistikkProdusent(
        kafka = naisEnv.kafka,
        virksomhetRepository = virksomhetRepository,
        sykefraværsstatistikkService = sykefraværsstatistikkService,
        iaSakshendelseRepository = IASakshendelseRepository(dataSource = dataSource),
        geografiService = GeografiService(),
        sistePubliseringService = sistePubliseringService,
    )
    val spørreundersøkelseBigqueryProdusent = SpørreundersøkelseBigqueryProdusent(
        kafka = naisEnv.kafka,
    )
    val samarbeidsplanBigqueryProdusent = SamarbeidsplanBigqueryProdusent(kafka = naisEnv.kafka)
    val samarbeidBigqueryProdusent = SamarbeidBigqueryProdusent(kafka = naisEnv.kafka)
    val azureService = AzureService(
        tokenFetcher = AzureTokenFetcher(naisEnvironment = naisEnv),
        security = naisEnv.security,
    )
    val sendPlanPåKafkaObserver = SendPlanPåKafkaObserver(
        planRepository = planRepository,
        samarbeidsplanProdusent = samarbeidsplanProdusent,
    )
    val sendSamarbeidPåKafkaObserver = SendSamarbeidPåKafkaObserver(
        samarbeidKafkaEksporterer = SamarbeidKafkaEksporterer(
            samarbeidRepository = samarbeidRepository,
            samarbeidProdusent = samarbeidProdusent,
        ),
    )

    val oppdaterSistEndretPlanObserver = OppdaterSistEndretPlanObserver(
        planRepository = planRepository,
    )

    val samarbeidService = IASamarbeidService(
        iaSakRepository = iaSakRepository,
        samarbeidRepository = samarbeidRepository,
        spørreundersøkelseRepository = spørreundersøkelseRepository,
        planRepository = planRepository,
    )

    val iaTeamService = IATeamService(iaTeamRepository = iaTeamRepository)
    val spørreundersøkelseMetrikkObserver = SpørreundersøkelseMetrikkObserver()
    val spørreundersøkelseProdusent = SpørreundersøkelseProdusent(
        kafka = naisEnv.kafka,
        samarbeidRepository = samarbeidRepository,
        planRepository = planRepository,
    )
    val fullførtBehovsvurderingProdusent = FullførtBehovsvurderingProdusent(kafka = naisEnv.kafka)
    val iaSakService = IASakService(
        iaSakRepository = iaSakRepository,
        iaSakshendelseRepository = IASakshendelseRepository(dataSource = dataSource),
        iaSakLeveranseRepository = IASakLeveranseRepository(dataSource = dataSource),
        samarbeidService = samarbeidService,
        planRepository = planRepository,
        spørreundersøkelseRepository = spørreundersøkelseRepository,
    )

    val samarbeidplanMetrikkObserver = SamarbeidplanMetrikkObserver()

    val planService = PlanService(
        planRepository = planRepository,
        planObservers = listOf(
            oppdaterSistEndretPlanObserver,
            samarbeidplanMetrikkObserver,
            sendPlanPåKafkaObserver,
            samarbeidsplanBigqueryProdusent,
        ),
    )

    val spørreundersøkelseOppdateringProdusent = SpørreundersøkelseOppdateringProdusent(kafka = naisEnv.kafka)
    val virksomhetService = VirksomhetService(virksomhetRepository = virksomhetRepository, iaSakService = iaSakService)
    val dokumentPubliseringRepository = DokumentPubliseringRepository(dataSource = dataSource)
    val tilstandVirksomhetRepository = TilstandVirksomhetRepository(dataSource = dataSource)
    val spørreundersøkelseService = SpørreundersøkelseService(
        spørreundersøkelseRepository = spørreundersøkelseRepository,
        iaSakService = iaSakService,
        samarbeidService = samarbeidService,
        planService = planService,
        spørreundersøkelseObservers = listOf(
            spørreundersøkelseProdusent,
            spørreundersøkelseMetrikkObserver,
            fullførtBehovsvurderingProdusent,
            spørreundersøkelseBigqueryProdusent,
        ),
        spørreundersøkelseOppdateringProdusent = spørreundersøkelseOppdateringProdusent,
        dokumentPubliseringRepository = dokumentPubliseringRepository,
    )
    val dokumentPubliseringService = DokumentPubliseringService(
        dokumentPubliseringRepository = dokumentPubliseringRepository,
        spørreundersøkelseService = spørreundersøkelseService,
        samarbeidService = samarbeidService,
        dokumentPubliseringProdusent = DokumentPubliseringProdusent(kafka = naisEnv.kafka, topic = Topic.DOKUMENT_PUBLISERING_TOPIC),
        planRepository = planRepository,
    )

    val nyFlytService = NyFlytService(
        dataSource = dataSource,
        tilstandVirksomhetRepository = tilstandVirksomhetRepository,
        iaSakRepository = iaSakRepository,
        iaSamarbeidService = samarbeidService,
        iaSamarbeidRepository = samarbeidRepository,
        iaTeamService = iaTeamService,
        spørreundersøkelseService = spørreundersøkelseService,
        planService = planService,
        dokumentPubliseringService = dokumentPubliseringService,
        iaSakObservers = listOf(iaSakDtoProdusent, iaSakDtoStatistikkProdusent),
        iaSamarbeidObservers = listOf(samarbeidBigqueryProdusent, sendSamarbeidPåKafkaObserver),
    )

    HelseMonitor.leggTilHelsesjekk(DatabaseHelsesjekk(dataSource))

    brregConsumer(naisEnv = naisEnv, virksomhetService)

    brregAlleVirksomheterConsumer(naisEnv = naisEnv, dataSource = dataSource)

    val tilstandVirksomhetOppdaterer = TilstandVirksomhetOppdaterer(
        nyFlytService = nyFlytService,
        iaSakService = iaSakService,
        iASamarbeidService = samarbeidService,
        dokumentPubliseringService = dokumentPubliseringService,
        planService = planService,
        tilstandVirksomhetRepository = tilstandVirksomhetRepository,
    )

    jobblytter(
        naisEnv = naisEnv,
        iaSakStatusOppdaterer = IASakStatusOppdaterer(iaSakService = iaSakService),
        iaSakEksporterer = IASakEksporterer(
            iaSakRepository = iaSakRepository,
            iaSakDtoProdusent = iaSakDtoProdusent,
        ),
        næringsDownloader = NæringsDownloader(
            url = naisEnv.integrasjoner.ssbNæringsUrl,
            næringsRepository = næringsRepository,
        ),
        statistikkViewOppdaterer = StatistikkViewOppdaterer(
            dataSource = dataSource,
        ),
        samarbeidsplanKafkaEksporterer = SamarbeidsplanKafkaEksporterer(
            samarbeidsplanProdusent = samarbeidsplanProdusent,
            planRepository = planRepository,
        ),
        samarbeidBigqueryEksporterer = SamarbeidBigqueryEksporterer(
            samarbeidBigqueryProdusent = samarbeidBigqueryProdusent,
            samarbeidRepository = samarbeidRepository,
        ),
        spørreundersøkelseBigqueryEksporterer = SpørreundersøkelseBigqueryEksporterer(
            spørreundersøkelseBigqueryProdusent = spørreundersøkelseBigqueryProdusent,
            spørreundersøkelseRepository = spørreundersøkelseRepository,
        ),
        samarbeidsplanBigqueryEksporterer = SamarbeidsplanBigqueryEksporterer(
            samarbeidsplanBigqueryProdusent = samarbeidsplanBigqueryProdusent,
            planRepository = planRepository,
        ),
        samarbeidKafkaEksporterer = SamarbeidKafkaEksporterer(
            samarbeidRepository = samarbeidRepository,
            samarbeidProdusent = samarbeidProdusent,
        ),
        virksomhetService = virksomhetService,
        iaSakService = iaSakService,
        tilstandVirksomhetOppdaterer = tilstandVirksomhetOppdaterer,
    )

    listOf(
        Topic.STATISTIKK_LAND_TOPIC,
        Topic.STATISTIKK_SEKTOR_TOPIC,
        Topic.STATISTIKK_BRANSJE_TOPIC,
        Topic.STATISTIKK_NARING_TOPIC,
        Topic.STATISTIKK_NARINGSKODE_TOPIC,
        Topic.STATISTIKK_VIRKSOMHET_TOPIC,
    ).forEach { topic ->
        _root_ide_package_.no.nav.lydia.prioritering.sykefraværsstatistikk.import.StatistikkPerKategoriConsumer(topic = topic).apply {
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
        create(kafka = naisEnv.kafka, spørreundersøkelseService = spørreundersøkelseService)
        run()
    }.also { HelseMonitor.leggTilHelsesjekk(it) }

    SpørreundersøkelseHendelseConsumer().apply {
        create(kafka = naisEnv.kafka, spørreundersøkelseService = spørreundersøkelseService)
        run()
    }.also { HelseMonitor.leggTilHelsesjekk(it) }

    SalesforceAktivitetConsumer().apply {
        create(
            kafka = naisEnv.kafka,
            salesforceAktivitetService = SalesforceAktivitetService(
                salesforceAktivitetRepository = SalesforceAktivitetRepository(dataSource = dataSource),
                iaSakRepository = iaSakRepository,
                samarbeidRepository = samarbeidRepository,
                planRepository = planRepository,
            ),
        )
        run()
    }.also { HelseMonitor.leggTilHelsesjekk(it) }

    KvitteringConsumer().apply {
        create(kafka = naisEnv.kafka, dokumentPubliseringService = dokumentPubliseringService)
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
            virksomhetService = virksomhetService,
            iaSakService = iaSakService,
            iaTeamService = iaTeamService,
            samarbeidService = samarbeidService,
            spørreundersøkelseService = spørreundersøkelseService,
            planService = planService,
            dokumentPubliseringService = dokumentPubliseringService,
            nyFlytService = nyFlytService,
            tilstandVirksomhetRepository = tilstandVirksomhetRepository,
        )
    }.also {
        // https://doc.nais.io/nais-application/good-practices/#handles-termination-gracefully
        it.addShutdownHook {
            it.stop(3, 5, TimeUnit.SECONDS)
        }
    }.start(wait = true)
}

private fun brregConsumer(
    naisEnv: NaisEnvironment,
    virksomhetService: VirksomhetService,
) {
    BrregOppdateringConsumer.apply {
        create(
            kafka = naisEnv.kafka,
            virksomhetService = virksomhetService,
        )
        run()
    }
}

private fun brregAlleVirksomheterConsumer(
    naisEnv: NaisEnvironment,
    dataSource: DataSource,
) {
    BrregAlleVirksomheterConsumer.apply {
        create(
            kafka = naisEnv.kafka,
            repository = VirksomhetRepository(dataSource),
        )
        run()
    }
}

private fun jobblytter(
    naisEnv: NaisEnvironment,
    iaSakStatusOppdaterer: IASakStatusOppdaterer,
    iaSakEksporterer: IASakEksporterer,
    næringsDownloader: NæringsDownloader,
    statistikkViewOppdaterer: StatistikkViewOppdaterer,
    samarbeidsplanKafkaEksporterer: SamarbeidsplanKafkaEksporterer,
    samarbeidBigqueryEksporterer: SamarbeidBigqueryEksporterer,
    samarbeidsplanBigqueryEksporterer: SamarbeidsplanBigqueryEksporterer,
    spørreundersøkelseBigqueryEksporterer: SpørreundersøkelseBigqueryEksporterer,
    samarbeidKafkaEksporterer: SamarbeidKafkaEksporterer,
    virksomhetService: VirksomhetService,
    iaSakService: IASakService,
    tilstandVirksomhetOppdaterer: TilstandVirksomhetOppdaterer,
) {
    Jobblytter.apply {
        create(
            kafka = naisEnv.kafka,
            iaSakStatusOppdaterer = iaSakStatusOppdaterer,
            iaSakEksporterer = iaSakEksporterer,
            næringsDownloader = næringsDownloader,
            statistikkViewOppdaterer = statistikkViewOppdaterer,
            samarbeidsplanKafkaEksporterer = samarbeidsplanKafkaEksporterer,
            samarbeidBigqueryEksporterer = samarbeidBigqueryEksporterer,
            spørreundersøkelseBigqueryEksporterer = spørreundersøkelseBigqueryEksporterer,
            samarbeidsplanBigqueryEksporterer = samarbeidsplanBigqueryEksporterer,
            samarbeidKafkaEksporterer = samarbeidKafkaEksporterer,
            virksomhetService = virksomhetService,
            iaSakService = iaSakService,
            tilstandVirksomhetOppdaterer = tilstandVirksomhetOppdaterer,
        )
        run()
    }
}

private fun Application.lydiaRestApi(
    naisEnv: NaisEnvironment,
    dataSource: DataSource,
    næringsRepository: NæringsRepository,
    sykefraværsstatistikkService: no.nav.lydia.prioritering.sykefraværsstatistikk.SykefraværsstatistikkService,
    auditLog: AuditLog,
    azureService: AzureService,
    sistePubliseringService: no.nav.lydia.prioritering.sykefraværsstatistikk.SistePubliseringService,
    virksomhetService: VirksomhetService,
    iaSakService: IASakService,
    samarbeidService: IASamarbeidService,
    spørreundersøkelseService: SpørreundersøkelseService,
    iaTeamService: IATeamService,
    planService: PlanService,
    dokumentPubliseringService: DokumentPubliseringService,
    nyFlytService: NyFlytService,
    tilstandVirksomhetRepository: TilstandVirksomhetRepository,
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

    configureSecurity(naisEnv)

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
        metrics(dokumentPubliseringRepository = DokumentPubliseringRepository(dataSource))

        authenticate("tokenx") {
            samarbeid(
                samarbeidService = samarbeidService,
            )
        }

        authenticate("azure") {
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
                samarbeidService = samarbeidService,
                adGrupper = naisEnv.security.adGrupper,
                auditLog = auditLog,
            )
            nyFlyt(
                iaSakService = iaSakService,
                iASamarbeidService = samarbeidService,
                nyFlytService = nyFlytService,
                dokumentPubliseringService = dokumentPubliseringService,
                planService = planService,
                tilstandVirksomhetRepository = tilstandVirksomhetRepository,
                virksomhetService = virksomhetService,
                adGrupper = naisEnv.security.adGrupper,
                auditLog = auditLog,
                azureService = azureService,
            )
            nyFlytVirksomhet(
                iaSakService = iaSakService,
                iASamarbeidService = samarbeidService,
                nyFlytService = nyFlytService,
                dokumentPubliseringService = dokumentPubliseringService,
                planService = planService,
                tilstandVirksomhetRepository = tilstandVirksomhetRepository,
                adGrupper = naisEnv.security.adGrupper,
                auditLog = auditLog,
                azureService = azureService,
            )
            nyFlytSamarbeidsplan(
                iaSakService = iaSakService,
                iASamarbeidService = samarbeidService,
                iaTeamService = iaTeamService,
                nyFlytService = nyFlytService,
                dokumentPubliseringService = dokumentPubliseringService,
                planService = planService,
                tilstandVirksomhetRepository = tilstandVirksomhetRepository,
                adGrupper = naisEnv.security.adGrupper,
                auditLog = auditLog,
                azureService = azureService,
            )
            nyFlytKartlegging(
                iaSakService = iaSakService,
                iASamarbeidService = samarbeidService,
                iaTeamService = iaTeamService,
                nyFlytService = nyFlytService,
                dokumentPubliseringService = dokumentPubliseringService,
                planService = planService,
                tilstandVirksomhetRepository = tilstandVirksomhetRepository,
                adGrupper = naisEnv.security.adGrupper,
                auditLog = auditLog,
                azureService = azureService,
            )
            iaSakTeam(
                iaTeamService = iaTeamService,
                iaSakService = iaSakService,
                adGrupper = naisEnv.security.adGrupper,
                auditLog = auditLog,
            )
            iaSamarbeid(
                adGrupper = naisEnv.security.adGrupper,
                samarbeidService = samarbeidService,
                iaSakService = iaSakService,
                auditLog = auditLog,
            )
            val pdfgenService = PiaPdfgenService(samarbeidService, naisEnv)
            iaSakSpørreundersøkelse(
                iaSakService = iaSakService,
                adGrupper = naisEnv.security.adGrupper,
                auditLog = auditLog,
                spørreundersøkelseService = spørreundersøkelseService,
                dokumentPubliseringService = dokumentPubliseringService,
                iaTeamService = iaTeamService,
                pdfgenService = pdfgenService,
                journalpostService = JournalpostService(naisEnv, pdfgenService, OboTokenUtveksler(naisEnv)),
                azureService = azureService,
            )
            iaSakPlan(
                adGrupper = naisEnv.security.adGrupper,
                auditLog = auditLog,
                planService = planService,
                iaSakService = iaSakService,
                dokumentPubliseringService = dokumentPubliseringService,
            )
            virksomhet(
                virksomhetService = virksomhetService,
                salesforceClient = SalesforceClient(),
                auditLog = auditLog,
                adGrupper = naisEnv.security.adGrupper,
                iaSakService = iaSakService,
            )
            dokumentPublisering(
                adGrupper = naisEnv.security.adGrupper,
                dokumentPubliseringService = dokumentPubliseringService,
                azureService = azureService,
            )
            statusoversikt(
                geografiService = GeografiService(),
                statusoversiktService = StatusoversiktService(
                    statusoversiktRepository = StatusoversiktRepository(dataSource = dataSource),
                ),
                auditLog = auditLog,
                naisEnvironment = naisEnv,
            )
        }
    }
}
