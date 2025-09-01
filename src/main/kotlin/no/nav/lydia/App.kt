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
import no.nav.lydia.appstatus.DatabaseHelsesjekk
import no.nav.lydia.appstatus.HelseMonitor
import no.nav.lydia.appstatus.Metrics
import no.nav.lydia.appstatus.healthChecks
import no.nav.lydia.appstatus.metrics
import no.nav.lydia.arbeidsgiver.samarbeid
import no.nav.lydia.exceptions.UautorisertException
import no.nav.lydia.ia.eksport.FullførtBehovsvurderingProdusent
import no.nav.lydia.ia.eksport.IASakEksporterer
import no.nav.lydia.ia.eksport.IASakLeveranseEksportør
import no.nav.lydia.ia.eksport.IASakLeveranseProdusent
import no.nav.lydia.ia.eksport.IASakProdusent
import no.nav.lydia.ia.eksport.IASakStatistikkEksporterer
import no.nav.lydia.ia.eksport.IASakStatistikkProdusent
import no.nav.lydia.ia.eksport.IASakStatusEksportør
import no.nav.lydia.ia.eksport.IASakStatusProdusent
import no.nav.lydia.ia.eksport.SamarbeidBigqueryEksporterer
import no.nav.lydia.ia.eksport.SamarbeidBigqueryProdusent
import no.nav.lydia.ia.eksport.SamarbeidKafkaEksporterer
import no.nav.lydia.ia.eksport.SamarbeidProdusent
import no.nav.lydia.ia.eksport.SamarbeidsplanBigqueryEksporterer
import no.nav.lydia.ia.eksport.SamarbeidsplanBigqueryProdusent
import no.nav.lydia.ia.eksport.SamarbeidsplanKafkaEksporterer
import no.nav.lydia.ia.eksport.SamarbeidsplanProdusent
import no.nav.lydia.ia.eksport.SpørreundersøkelseBigqueryEksporterer
import no.nav.lydia.ia.eksport.SpørreundersøkelseBigqueryProdusent
import no.nav.lydia.ia.eksport.SpørreundersøkelseOppdateringProdusent
import no.nav.lydia.ia.eksport.SpørreundersøkelseProdusent
import no.nav.lydia.ia.sak.EierskapsendringObserver
import no.nav.lydia.ia.sak.IASakLeveranseObserver
import no.nav.lydia.ia.sak.IASakService
import no.nav.lydia.ia.sak.IASamarbeidService
import no.nav.lydia.ia.sak.OppdaterSistEndretPlanObserver
import no.nav.lydia.ia.sak.PlanService
import no.nav.lydia.ia.sak.SamarbeidplanMetrikkObserver
import no.nav.lydia.ia.sak.SendPlanPåKafkaObserver
import no.nav.lydia.ia.sak.SendSamarbeidPåKafkaObserver
import no.nav.lydia.ia.sak.SpørreundersøkelseMetrikkObserver
import no.nav.lydia.ia.sak.SpørreundersøkelseService
import no.nav.lydia.ia.sak.api.IA_SAK_RADGIVER_PATH
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringProdusent
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringRepository
import no.nav.lydia.ia.sak.api.dokument.DokumentPubliseringService
import no.nav.lydia.ia.sak.api.dokument.dokumentPublisering
import no.nav.lydia.ia.sak.api.iaSakRådgiver
import no.nav.lydia.ia.sak.api.plan.iaSakPlan
import no.nav.lydia.ia.sak.api.samarbeid.iaSamarbeid
import no.nav.lydia.ia.sak.api.spørreundersøkelse.iaSakSpørreundersøkelse
import no.nav.lydia.ia.sak.db.IASakLeveranseRepository
import no.nav.lydia.ia.sak.db.IASakRepository
import no.nav.lydia.ia.sak.db.IASakshendelseRepository
import no.nav.lydia.ia.sak.db.IASamarbeidRepository
import no.nav.lydia.ia.sak.db.PlanRepository
import no.nav.lydia.ia.sak.db.SpørreundersøkelseRepository
import no.nav.lydia.ia.team.IATeamRepository
import no.nav.lydia.ia.team.IATeamService
import no.nav.lydia.ia.team.iaSakTeam
import no.nav.lydia.ia.årsak.db.ÅrsakRepository
import no.nav.lydia.ia.årsak.ÅrsakService
import no.nav.lydia.iatjenesteoversikt.IATjenesteoversiktRepository
import no.nav.lydia.iatjenesteoversikt.IATjenesteoversiktService
import no.nav.lydia.iatjenesteoversikt.api.iaTjenesteoversikt
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
import no.nav.lydia.konfigurasjon.configureSecurity
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
import no.nav.lydia.tilgangskontroll.obo.OboTokenUtveksler
import no.nav.lydia.vedlikehold.IASakSamarbeidOppdaterer
import no.nav.lydia.vedlikehold.IASakStatusOppdaterer
import no.nav.lydia.vedlikehold.IaSakhendelseStatusJobb
import no.nav.lydia.vedlikehold.LukkAlleÅpneIaTjenester
import no.nav.lydia.vedlikehold.StatistikkViewOppdaterer
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

    val virksomhetRepository = VirksomhetRepository(dataSource = dataSource)
    val næringsRepository = NæringsRepository(dataSource = dataSource)
    val iaSakRepository = IASakRepository(dataSource = dataSource)
    val iaTeamRepository = IATeamRepository(dataSource = dataSource)
    val spørreundersøkelseRepository = SpørreundersøkelseRepository(dataSource = dataSource)
    val samarbeidRepository = IASamarbeidRepository(dataSource = dataSource)
    val planRepository = PlanRepository(dataSource = dataSource)
    val samarbeidsplanProdusent = SamarbeidsplanProdusent(kafka = naisEnv.kafka)
    val samarbeidProdusent = SamarbeidProdusent(kafka = naisEnv.kafka)

    val sykefraværsstatistikkService = SykefraværsstatistikkService(
        sykefraværsstatistikkRepository = SykefraværsstatistikkRepository(dataSource = dataSource),
        virksomhetsinformasjonRepository = VirksomhetsinformasjonRepository(dataSource = dataSource),
        sistePubliseringService = SistePubliseringService(SistePubliseringRepository(dataSource = dataSource)),
        virksomhetRepository = virksomhetRepository,
    )
    val årsakRepository = ÅrsakRepository(dataSource = dataSource)
    val auditLog = AuditLog(naisEnv.miljø)
    val sistePubliseringService = SistePubliseringService(SistePubliseringRepository(dataSource = dataSource))
    val iaSakProdusent = IASakProdusent(kafka = naisEnv.kafka)
    val iaSakStatistikkProdusent = IASakStatistikkProdusent(
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
    val iaSakStatusProdusent = IASakStatusProdusent(
        kafka = naisEnv.kafka,
        iaSakRepository = iaSakRepository,
    )
    val azureService = AzureService(
        tokenFetcher = AzureTokenFetcher(naisEnvironment = naisEnv),
        security = naisEnv.security,
    )
    val iaSakLeveranseProdusent = IASakLeveranseProdusent(
        kafka = naisEnv.kafka,
        azureService = azureService,
    )
    val iaSakLeveranseObserver = IASakLeveranseObserver(iaSakRepository)
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
        samarbeidRepository = samarbeidRepository,
        spørreundersøkelseRepository = spørreundersøkelseRepository,
        planRepository = planRepository,
        samarbeidObservers = listOf(samarbeidBigqueryProdusent, sendSamarbeidPåKafkaObserver),
        planObservers = listOf(oppdaterSistEndretPlanObserver, sendPlanPåKafkaObserver),
    )

    val iaTeamService = IATeamService(iaTeamRepository = iaTeamRepository)
    val eierskapsendringObserver = EierskapsendringObserver(
        iaTeamService = iaTeamService,
    )

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
        årsakService = ÅrsakService(årsakRepository = årsakRepository),
        journalpostService = JournalpostService(
            naisEnvironment = naisEnv,
            pdfgenService = PiaPdfgenService(naisEnvironment = naisEnv),
            oboTokenUtveksler = OboTokenUtveksler(naisEnvironment = naisEnv),
            virksomhetRepository = virksomhetRepository,
        ),
        iaSakObservers = listOf(iaSakProdusent, iaSakStatistikkProdusent, iaSakStatusProdusent),
        iaSaksLeveranseObservers = listOf(iaSakLeveranseProdusent, iaSakLeveranseObserver),
        samarbeidService = samarbeidService,
        planRepository = planRepository,
        endringsObservers = listOf(eierskapsendringObserver),
        spørreundersøkelseRepository = spørreundersøkelseRepository,
        spørreundersøkelseObservers = listOf(
            spørreundersøkelseProdusent,
            spørreundersøkelseMetrikkObserver,
            fullførtBehovsvurderingProdusent,
            spørreundersøkelseBigqueryProdusent,
        ),
        iaTeamService = iaTeamService,
    )

    val samarbeidplanMetrikkObserver = SamarbeidplanMetrikkObserver()

    val planService = PlanService(
        samarbeidService = samarbeidService,
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
    )
    val dokumentPubliseringService = DokumentPubliseringService(
        dokumentPubliseringRepository = DokumentPubliseringRepository(dataSource),
        spørreundersøkelseService = spørreundersøkelseService,
        samarbeidService = samarbeidService,
        dokumentPubliseringProdusent = DokumentPubliseringProdusent(kafka = naisEnv.kafka, topic = Topic.DOKUMENT_PUBLISERING_TOPIC),
    )

    HelseMonitor.leggTilHelsesjekk(DatabaseHelsesjekk(dataSource))

    brregConsumer(naisEnv = naisEnv, virksomhetService)

    brregAlleVirksomheterConsumer(naisEnv = naisEnv, dataSource = dataSource)

    val iaSakshendelseRepository = IASakshendelseRepository(dataSource = dataSource)

    jobblytter(
        naisEnv = naisEnv,
        iaSakStatusOppdaterer = IASakStatusOppdaterer(iaSakService = iaSakService),
        iaSakEksporterer = IASakEksporterer(
            iaSakRepository = iaSakRepository,
            iaSakProdusent = iaSakProdusent,
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
            næringsRepository = næringsRepository,
        ),
        statistikkViewOppdaterer = StatistikkViewOppdaterer(
            dataSource = dataSource,
        ),
        iaSakhendelseStatusJobb = IaSakhendelseStatusJobb(
            iaSakRepository = iaSakRepository,
            iaSakshendelseRepository = iaSakshendelseRepository,
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
        lukkAlleÅpneIaTjenester = LukkAlleÅpneIaTjenester(
            iaSakLeveranseRepository = IASakLeveranseRepository(dataSource),
            iaSakLeveranseProdusent = iaSakLeveranseProdusent,
        ),
        samarbeidKafkaEksporterer = SamarbeidKafkaEksporterer(
            samarbeidRepository = samarbeidRepository,
            samarbeidProdusent = samarbeidProdusent,
        ),
        iaSakSamarbeidOppdaterer = IASakSamarbeidOppdaterer(
            iaSakService = iaSakService,
        ),
        virksomhetService = virksomhetService,
        iaSakService = iaSakService,
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
    iaSakStatistikkEksporterer: IASakStatistikkEksporterer,
    iaSakLeveranseEksportør: IASakLeveranseEksportør,
    iaSakStatusExportør: IASakStatusEksportør,
    næringsDownloader: NæringsDownloader,
    statistikkViewOppdaterer: StatistikkViewOppdaterer,
    iaSakhendelseStatusJobb: IaSakhendelseStatusJobb,
    samarbeidsplanKafkaEksporterer: SamarbeidsplanKafkaEksporterer,
    samarbeidBigqueryEksporterer: SamarbeidBigqueryEksporterer,
    samarbeidsplanBigqueryEksporterer: SamarbeidsplanBigqueryEksporterer,
    spørreundersøkelseBigqueryEksporterer: SpørreundersøkelseBigqueryEksporterer,
    lukkAlleÅpneIaTjenester: LukkAlleÅpneIaTjenester,
    samarbeidKafkaEksporterer: SamarbeidKafkaEksporterer,
    iaSakSamarbeidOppdaterer: IASakSamarbeidOppdaterer,
    virksomhetService: VirksomhetService,
    iaSakService: IASakService,
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
            statistikkViewOppdaterer = statistikkViewOppdaterer,
            iaSakhendelseStatusJobb = iaSakhendelseStatusJobb,
            samarbeidsplanKafkaEksporterer = samarbeidsplanKafkaEksporterer,
            samarbeidBigqueryEksporterer = samarbeidBigqueryEksporterer,
            spørreundersøkelseBigqueryEksporterer = spørreundersøkelseBigqueryEksporterer,
            lukkAlleÅpneIaTjenester = lukkAlleÅpneIaTjenester,
            samarbeidsplanBigqueryEksporterer = samarbeidsplanBigqueryEksporterer,
            samarbeidKafkaEksporterer = samarbeidKafkaEksporterer,
            iaSakSamarbeidOppdaterer = iaSakSamarbeidOppdaterer,
            virksomhetService = virksomhetService,
            iaSakService = iaSakService,
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
    virksomhetService: VirksomhetService,
    iaSakService: IASakService,
    samarbeidService: IASamarbeidService,
    spørreundersøkelseService: SpørreundersøkelseService,
    iaTeamService: IATeamService,
    planService: PlanService,
    dokumentPubliseringService: DokumentPubliseringService,
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
        metrics()

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
            iaSakSpørreundersøkelse(
                iaSakService = iaSakService,
                adGrupper = naisEnv.security.adGrupper,
                auditLog = auditLog,
                spørreundersøkelseService = spørreundersøkelseService,
                iaTeamService = iaTeamService,
            )
            iaSakPlan(
                adGrupper = naisEnv.security.adGrupper,
                auditLog = auditLog,
                planService = planService,
                iaSakService = iaSakService,
                iaTeamService = iaTeamService,
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
            iaTjenesteoversikt(
                iaTjenesteoversiktService = IATjenesteoversiktService(
                    iaTjenesteoversiktRepository = IATjenesteoversiktRepository(dataSource),
                ),
                auditLog = auditLog,
                naisEnvironment = naisEnv,
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
